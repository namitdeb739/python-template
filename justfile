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
    uvx copier copy . "$OUT/project" \
        --trust --defaults --overwrite --vcs-ref=HEAD \
        --data project_name={{ name }}-project \
        --data description="Validate {{ name }}" \
        --data author_name="Test" \
        --data author_email="test@example.com" \
        --data github_user=test-user \
        {{ data_flags }}
    cd "$OUT/project"
    uv run ruff check src/ tests/
    uv run ruff format --check src/ tests/
    if [ -f pyproject.toml ] && grep -q 'mypy' pyproject.toml; then
        uv run mypy src/
    fi
    uv run pytest -v
    echo "✓ {{ name }} passed"

# Validate with standard defaults
validate-standard: (_validate "standard")

# Alias for validate-standard
validate: validate-standard

# Validate minimal config (everything off)
validate-minimal: (_validate "minimal" "--data ci_github=false --data security=none --data use_docker=none --data use_docs=false --data testing=minimal --data use_ml=false --data use_typecheck=false --data use_devcontainer=false")

# Validate CLI feature
validate-cli: (_validate "cli" "--data use_cli=true")

# Validate API feature
validate-api: (_validate "api" "--data use_api=true")

# Validate DB feature
validate-db: (_validate "db" "--data use_db=true")

# Validate IoT feature
validate-iot: (_validate "iot" "--data use_iot=true")

# Validate GPU + ML combo (catches cross-feature bugs)
validate-gpu-ml: (_validate "gpu-ml" "--data use_docker=gpu --data use_ml=true")

# Validate kitchen-sink (all features on)
validate-full: (_validate "full" "--data security=full --data testing=full --data use_docker=gpu --data use_devcontainer=true --data use_ml=true --data use_iot=true --data use_cli=true --data use_api=true --data use_db=true")

# Run all validation variants
validate-all: validate validate-minimal validate-cli validate-api validate-db validate-iot validate-gpu-ml validate-full

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
