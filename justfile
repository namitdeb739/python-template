# List available recipes
default:
    @just --list

# Interactive project setup (run once after cloning from template)
init:
    bash scripts/init.sh

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
    uv run pytest -v {{ args }}

# Run tests with coverage
coverage:
    uv run pytest --cov=project_name --cov-report=term-missing

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
    docker compose build

# Run in Docker
docker-run:
    docker compose up

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
    uvx bump-my-version bump {{ bump }}
    git push --follow-tags

# Build GPU Docker image
docker-build-gpu:
    docker build -f Dockerfile.gpu -t project-name-gpu .

# Initialize DVC (run once)
dvc-init:
    uv run dvc init
    uv run dvc config core.autostage true

# Clean build artifacts
clean:
    rm -rf dist/ build/ site/ .pytest_cache/ .mypy_cache/ .ruff_cache/ htmlcov/
    find . -type d -name __pycache__ -exec rm -rf {} +
