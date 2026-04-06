# List available recipes
default:
    @just --list

# Set up branch protection and GitHub Pages (run once after pushing to GitHub)
init-remote:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v gh &>/dev/null || ! gh auth status &>/dev/null 2>&1; then
        echo "gh CLI not found or not authenticated — set up branch protection and GitHub Pages manually"
        exit 0
    fi
    REPO=$(git remote get-url origin 2>/dev/null | sed 's|.*github.com[:/]||;s|\.git$||')
    BP_JSON=$(mktemp)
    cat > "$BP_JSON" <<'BPEOF'
    {
      "required_status_checks": {
        "strict": true,
        "contexts": ["validate-template", "audit"]
      },
      "enforce_admins": false,
      "required_pull_request_reviews": null,
      "restrictions": null,
      "allow_force_pushes": false,
      "allow_deletions": false
    }
    BPEOF
    if gh api "repos/${REPO}/branches/main/protection" -X PUT --silent --input "$BP_JSON" 2>/dev/null; then
        echo "✓ Branch protection enabled on main"
    else
        echo "⚠ Could not set branch protection (check gh auth permissions)"
    fi
    rm -f "$BP_JSON"
    if gh api "repos/${REPO}/pages" -X POST -f build_type=workflow --silent 2>/dev/null; then
        echo "✓ GitHub Pages enabled (Actions source)"
    else
        echo "⚠ Could not enable GitHub Pages (may already be enabled, or enable manually in Settings > Pages)"
    fi

# Install dependencies and set up dev environment
setup:
    git config core.longpaths true
    uv sync --dev
    uv run pre-commit install

# Run all checks (mirrors CI)
check: lint typecheck test

# Lint and check formatting
lint:
    uv run ruff check src/ tests/
    uv run ruff format --check src/ tests/

# Auto-fix lint and formatting issues
fix:
    uv run ruff check --fix src/ tests/
    uv run ruff format src/ tests/

# Type check
typecheck:
    uv run mypy src/

# Run tests
test *args:
    uv run pytest -v {% raw %}{{ args }}{% endraw %}

# Run tests with coverage (fails if below 80%)
coverage:
    uv run pytest --cov=src --cov-report=term-missing --cov-fail-under=80

# Launch Jupyter notebook server
notebook:
    uv run jupyter notebook notebooks/

# Serve documentation locally
docs:
    uv run mkdocs serve

# Build documentation
docs-build:
    uv run mkdocs build

# Build Docker image
docker-build:
    docker compose -f docker/docker-compose.yml build

# Run in Docker
docker-run:
    docker compose -f docker/docker-compose.yml up

# Audit dependencies for vulnerabilities
audit:
    uv run pip-audit

# Build package
build:
    uv build

# Bump version, create git tag, and push (usage: just release patch|minor|major)
release bump:
    #!/usr/bin/env bash
    set -euo pipefail
    just check
    uvx bump-my-version bump {% raw %}{{ bump }}{% endraw %}
    git push --follow-tags

# Build GPU Docker image
docker-build-gpu:
    docker build -f docker/Dockerfile.gpu -t {{ project_name }}-gpu .

# Initialize DVC (run once)
dvc-init:
    uv run dvc init
    uv run dvc config core.autostage true

# Clean build artifacts
clean:
    rm -rf dist/ build/ site/ .pytest_cache/ .mypy_cache/ .ruff_cache/ htmlcov/
    find . -type d -name __pycache__ -exec rm -rf {} +
