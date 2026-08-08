# List available recipes
default:
    @just --list

# Render and validate a template variant, then clean up
# Usage: just _validate <name> [extra copier --data flags...]
[private]
_validate name *data_flags:
    #!/usr/bin/env bash
    set -euo pipefail
    OUT=$(mktemp -d)
    trap 'chmod -R +w "$OUT" 2>/dev/null; rm -rf "$OUT"' EXIT
    echo "▶ Validating '{{ name }}' → $OUT"
    # The description is deliberately long enough that a one-line
    # typer.Typer(...) would breach E501 — a two-word description hid that bug
    # for the life of this template.
    uvx copier copy . "$OUT/project" \
        --trust --defaults --overwrite --vcs-ref=HEAD \
        --data project_name={{ name }}-project \
        --data description="Validate the {{ name }} template variant" \
        --data author_name="Test" \
        --data author_email="test@example.com" \
        --data github_user=test-user \
        {{ data_flags }}
    cd "$OUT/project"
    uv run ruff check src/ tests/
    uv run ruff format --check src/ tests/
    if [ -f pyproject.toml ] && grep -q 'mypy' pyproject.toml; then
        uv run mypy src/ tests/
    fi
    uv run pytest -v
    # A generated project must survive its own first commit, so run the hooks
    # exactly as that commit would. --show-diff-on-failure surfaces what the
    # whitespace fixers would have rewritten.
    if [ -f .pre-commit-config.yaml ]; then
        uv run pre-commit run --all-files --show-diff-on-failure
    fi
    echo "✓ {{ name }} passed"

# Render a project, then run `copier update` against the same ref and assert the
# update is a no-op. Guards the two ways updates have broken: a rename in _tasks
# nests a fresh package inside the real one, and one-time tasks (git init/commit,
# dvc init, cp .env) re-run and either fail or clobber.
validate-update:
    #!/usr/bin/env bash
    set -euo pipefail
    OUT=$(mktemp -d)
    trap 'chmod -R +w "$OUT" 2>/dev/null; rm -rf "$OUT"' EXIT
    echo "▶ Validating 'update' → $OUT"
    # Copier records _commit as `git describe` output, which is only checkoutable
    # when it names a real ref. Clone and tag so the test does not depend on the
    # working repo being on a release tag.
    git clone --quiet . "$OUT/tmpl"
    git -C "$OUT/tmpl" tag validate-update-ref
    uvx copier copy "$OUT/tmpl" "$OUT/project" \
        --trust --defaults --overwrite --vcs-ref=validate-update-ref \
        --data project_name=update-project \
        --data description="Validate the update path" \
        --data author_name="Test" \
        --data author_email="test@example.com" \
        --data github_user=test-user \
        --data use_cli=true --data use_ml=standard --data init_env=true
    cd "$OUT/project"
    echo "secret" > .env
    uvx copier update . --trust --defaults --vcs-ref=validate-update-ref
    if [ -e src/project_name ]; then
        echo "✗ update created src/project_name — a _tasks rename has been reintroduced" >&2
        exit 1
    fi
    if [ "$(cat .env)" != "secret" ]; then
        echo "✗ update overwrote .env" >&2
        exit 1
    fi
    if [ -n "$(git status --porcelain)" ]; then
        echo "✗ update against the same ref was not a no-op:" >&2
        git status --porcelain >&2
        exit 1
    fi
    echo "✓ update passed"

# Validate with standard defaults
validate-standard: (_validate "standard")

# Alias for validate-standard
validate: validate-standard

# Validate minimal config (everything off)
validate-minimal: (_validate "minimal" "--data ci_github=false --data security=none --data use_docker=none --data use_docs=false --data testing=minimal --data use_ml=none --data use_typecheck=false --data use_devcontainer=false")

# Validate CLI feature
validate-cli: (_validate "cli" "--data use_cli=true")

# Validate API feature
validate-api: (_validate "api" "--data use_api=true")

# Validate DB feature
validate-db: (_validate "db" "--data use_db=true")

# Validate IoT feature
validate-iot: (_validate "iot" "--data use_iot=true")

# Validate ML feature (full tier: pandas + scikit-learn + pipeline)
validate-ml: (_validate "ml" "--data use_ml=full")

# Validate web app feature (Streamlit)
validate-webapp: (_validate "webapp" "--data use_webapp=streamlit")

# Validate GPU + ML combo (catches cross-feature bugs)
validate-gpu-ml: (_validate "gpu-ml" "--data use_docker=gpu --data use_ml=standard")

# Validate kitchen-sink (all features on)
validate-full: (_validate "full" "--data security=full --data testing=full --data use_docker=gpu --data use_devcontainer=true --data use_ml=full --data use_webapp=streamlit --data use_iot=true --data use_cli=true --data use_api=true --data use_db=true")

# Run all validation variants
validate-all: validate validate-minimal validate-cli validate-api validate-db validate-ml validate-webapp validate-iot validate-gpu-ml validate-full validate-update

# Tag a release and push (usage: just release [patch|minor|major])
release bump="patch":
    #!/usr/bin/env bash
    set -euo pipefail
    LATEST=$(git tag --sort=-v:refname | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | head -1)
    if [ -z "$LATEST" ]; then
        NEXT="v0.1.0"
    else
        IFS='.' read -r MAJOR MINOR PATCH <<< "${LATEST#v}"
        case "{{ bump }}" in
            major) NEXT="v$((MAJOR+1)).0.0" ;;
            minor) NEXT="v${MAJOR}.$((MINOR+1)).0" ;;
            patch) NEXT="v${MAJOR}.${MINOR}.$((PATCH+1))" ;;
            *) echo "Error: bump must be patch, minor, or major"; exit 1 ;;
        esac
    fi
    echo "▶ ${LATEST:-none} → $NEXT"
    echo "Run 'just validate-all' first if you haven't already."
    read -rp "Tag $NEXT and push? [y/N] " confirm
    [[ "$confirm" =~ ^[Yy]$ ]] || exit 0
    git tag "$NEXT"
    git push origin "$NEXT"
    echo "✓ Released $NEXT"
