# project-name

A short description of your project.

## Quickstart

```bash
# Install uv (if not already installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Clone and setup
git clone https://github.com/your-username/your-repo.git
cd your-repo
uv sync --dev

# Run
uv run project-name

# Test
uv run pytest -v

# Lint & format
uv run ruff check src/ tests/
uv run ruff format src/ tests/

# Type check
uv run mypy src/
```

## Setup pre-commit hooks

```bash
uv run pre-commit install
```

## Project structure

```
src/project_name/    # Source code
tests/               # Test suite
notebooks/           # Jupyter notebooks
data/                # Data files (gitignored by default)
```

## Docker

```bash
docker compose up --build
```

## Optional: ML dependencies

Install the ML extras group:

```bash
uv sync --extra ml
```

Edit the `[project.optional-dependencies.ml]` section in `pyproject.toml` to uncomment the libraries you need.
