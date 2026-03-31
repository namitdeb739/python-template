# List available recipes
default:
    @just --list

# Install dependencies and set up dev environment
setup:
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

# Clean build artifacts
clean:
    rm -rf dist/ build/ site/ .pytest_cache/ .mypy_cache/ .ruff_cache/ htmlcov/
    find . -type d -name __pycache__ -exec rm -rf {} +
