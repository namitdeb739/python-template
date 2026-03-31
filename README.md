# python-template

A modern, batteries-included Python project template with [uv](https://docs.astral.sh/uv/), [ruff](https://docs.astral.sh/ruff/), and ML-ready structure. Click **"Use this template"** on GitHub to create a new repository from this template.

## Features

- **[uv](https://docs.astral.sh/uv/)** for fast, reliable package and project management
- **[ruff](https://docs.astral.sh/ruff/)** for linting and formatting (replaces flake8, black, and isort)
- **[pytest](https://docs.pytest.org/)** for testing
- **[mypy](https://mypy.readthedocs.io/)** for static type checking (strict mode)
- **[pre-commit](https://pre-commit.com/)** hooks for local code quality enforcement
- **[just](https://github.com/casey/just)** task runner for one-command workflows (`just check`, `just fix`, `just docs`)
- **GitHub Actions CI** with lint, type-check, and test jobs across Python 3.11–3.13
- **[Dependabot](https://docs.github.com/en/code-security/dependabot)** for automated dependency updates
- **[MkDocs Material](https://squidfunk.github.io/mkdocs-material/)** for documentation with GitHub Pages auto-deploy
- **Docker** support with multi-stage build using uv
- **ML-ready** with optional dependency group, notebooks directory, and data directory

## Quickstart

### Prerequisites

- [uv](https://docs.astral.sh/uv/getting-started/installation/) — package manager
- [just](https://github.com/casey/just#installation) — task runner (optional but recommended)

```bash
# macOS / Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

### Setup

```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
just setup    # or: uv sync --dev && uv run pre-commit install
```

This creates a virtual environment in `.venv/`, installs all dev dependencies, and configures pre-commit hooks.

### Run

```bash
uv run project-name
```

### Task runner (`just`)

The `justfile` provides shortcuts for all common workflows. Run `just` to see all available recipes:

| Recipe | Description |
|---|---|
| `just setup` | Install deps and set up pre-commit hooks |
| `just check` | Run all checks — lint, typecheck, test (mirrors CI) |
| `just lint` | Check linting and formatting |
| `just fix` | Auto-fix lint and formatting issues |
| `just typecheck` | Run mypy type checking |
| `just test` | Run tests (`just test -k foo` for specific tests) |
| `just coverage` | Run tests with coverage report |
| `just notebook` | Launch Jupyter notebook server |
| `just docs` | Serve documentation locally |
| `just docs-build` | Build documentation site |
| `just docker-build` | Build Docker image |
| `just docker-run` | Run in Docker |
| `just clean` | Remove build artifacts |

All recipes also work with plain `uv run` commands if you don't have `just` installed.

## Project structure

```
.
├── src/
│   └── project_name/          # Source package (src layout)
│       ├── __init__.py
│       └── main.py            # Entry point
├── tests/
│   ├── __init__.py
│   └── test_main.py           # Example test
├── docs/                      # MkDocs documentation source
│   ├── index.md
│   ├── getting-started.md
│   ├── contributing.md
│   └── changelog.md
├── notebooks/                 # Jupyter notebooks
├── data/                      # Data files (gitignored except .gitkeep)
├── .github/
│   ├── workflows/
│   │   ├── ci.yml             # CI pipeline (lint, typecheck, test)
│   │   └── docs.yml           # Docs build and deploy to GitHub Pages
│   └── dependabot.yml         # Dependency update config
├── justfile                   # Task runner recipes
├── mkdocs.yml                 # MkDocs configuration
├── .pre-commit-config.yaml    # Pre-commit hook config
├── pyproject.toml             # Project metadata, dependencies, tool config
├── Dockerfile                 # Multi-stage container build
├── docker-compose.yml         # Container orchestration
├── .python-version            # Pin Python version (3.11)
├── .gitignore                 # Python, data, IDE, OS ignores
├── CONTRIBUTING.md            # Contributor quick-start
├── CHANGELOG.md               # Release history
├── LICENSE                    # MIT
└── README.md
```

### Why src layout?

The `src/` layout prevents accidental imports of the uninstalled package during development and is the [recommended layout](https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/) for publishable Python projects. The package is configured in `pyproject.toml` under `[tool.hatch.build.targets.wheel]`.

## CI/CD

### CI (`ci.yml`)

The CI pipeline runs on every push to `main` and on pull requests targeting `main`. It consists of three parallel jobs:

| Job | What it does |
|---|---|
| **lint** | Runs `ruff check` and `ruff format --check` to enforce code style |
| **type-check** | Runs `mypy` in strict mode against `src/` |
| **test** | Runs `pytest` across a matrix of Python 3.11, 3.12, and 3.13 |

All jobs use [`astral-sh/setup-uv`](https://github.com/astral-sh/setup-uv) to install uv with dependency caching.

### Docs deploy (`docs.yml`)

On every push to `main`, the docs workflow builds the MkDocs site and deploys it to GitHub Pages. To enable this:

1. Go to **Settings > Pages** in your GitHub repo
2. Under **Source**, select **GitHub Actions**

The docs site will be available at `https://your-username.github.io/your-repo/`.

### Dependabot (`dependabot.yml`)

Dependabot is configured to open weekly PRs for two ecosystems:

- **pip** — updates Python dependencies in `pyproject.toml`. Dev dependencies (pytest, mypy, ruff, pre-commit) are grouped into a single PR to reduce noise.
- **github-actions** — updates action versions in CI workflows (e.g., `actions/checkout`, `astral-sh/setup-uv`).

## Pre-commit hooks

Pre-commit runs ruff and mypy automatically before each commit to catch issues locally before they reach CI.

### Setup

```bash
uv run pre-commit install
```

### What runs

| Hook | Description |
|---|---|
| `ruff` | Lints and auto-fixes code |
| `ruff-format` | Formats code |
| `mypy` | Type checks `src/` in strict mode |

To run hooks manually against all files:

```bash
uv run pre-commit run --all-files
```

## Linting and formatting

Ruff is configured in `pyproject.toml` under `[tool.ruff]` with the following rule sets enabled:

| Rule set | What it catches |
|---|---|
| `E` / `W` | pycodestyle errors and warnings |
| `F` | pyflakes (unused imports, undefined names) |
| `I` | isort (import ordering) |
| `N` | PEP 8 naming conventions |
| `UP` | pyupgrade (modernize syntax for target Python version) |
| `B` | flake8-bugbear (common bugs and design problems) |
| `SIM` | flake8-simplify (simplifiable code) |
| `TCH` | flake8-type-checking (move type-only imports behind `TYPE_CHECKING`) |
| `RUF` | ruff-specific rules |

Line length is set to 88 (black-compatible). Target Python version is 3.11.

## Type checking

Mypy is configured in strict mode (`pyproject.toml` under `[tool.mypy]`), which enables all optional strictness flags including:

- Disallowed untyped defs
- No implicit optional
- Warn on return any / unused configs

The `mypy_path` is set to `src` so imports resolve correctly with the src layout.

## Documentation

Documentation is built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) and lives in the `docs/` directory.

### Local preview

```bash
just docs    # or: uv run mkdocs serve
```

This starts a local server at `http://127.0.0.1:8000/` with live reload — edits to `docs/` are reflected immediately.

### Structure

| File | Purpose |
|---|---|
| `mkdocs.yml` | Site config — theme, navigation, extensions |
| `docs/index.md` | Home page |
| `docs/getting-started.md` | Installation and usage guide |
| `docs/contributing.md` | Full contributor guide |
| `docs/changelog.md` | Release history |

### Adding pages

1. Create a new `.md` file in `docs/`
2. Add it to the `nav` section in `mkdocs.yml`
3. Push to `main` — the docs deploy workflow publishes automatically

### Enabled extensions

The template enables several useful MkDocs Material extensions out of the box:

- **Admonitions** — callout boxes (`!!! note`, `!!! warning`, etc.)
- **Code highlighting** — syntax highlighting with line numbers and copy button
- **Tabbed content** — tabbed code examples for multi-language/multi-platform docs
- **Table of contents** — auto-generated with permalink anchors

## Docker

### Build and run

```bash
docker compose up --build
```

### How it works

The `Dockerfile` uses a multi-stage build optimized for fast rebuilds:

1. Copies `uv` binary from the official image (`ghcr.io/astral-sh/uv`)
2. Installs dependencies first (`uv sync --frozen --no-dev --no-install-project`) — this layer is cached unless `pyproject.toml` or `uv.lock` change
3. Copies source code and installs the project
4. Runs via `uv run project-name`

The `docker-compose.yml` mounts the `data/` directory as a volume and sets `PYTHONUNBUFFERED=1` for real-time log output.

## ML dependencies

The template includes an optional `[ml]` dependency group in `pyproject.toml` with common ML libraries commented out:

```toml
[project.optional-dependencies]
ml = [
    # "numpy>=1.26",
    # "pandas>=2.2",
    # "scikit-learn>=1.5",
    # "matplotlib>=3.9",
    # "torch>=2.3",
    # "transformers>=4.40",
]
```

Uncomment the ones you need, then install:

```bash
uv sync --extra ml
```

The `notebooks/` directory is included for Jupyter notebooks, and `data/` is for datasets. Data files (`.csv`, `.parquet`, `.pkl`, `.h5`, `.pt`, `.onnx`, `.safetensors`) are gitignored by default to prevent accidentally committing large files.

## Dependencies

### Dev dependencies (`[dependency-groups]`)

Installed automatically with `uv sync --dev`:

| Package | Version | Purpose |
|---|---|---|
| pytest | >= 8.0 | Test runner |
| pytest-cov | >= 5.0 | Coverage reporting |
| mypy | >= 1.10 | Static type checker |
| ruff | >= 0.5 | Linter and formatter |
| pre-commit | >= 3.7 | Git hook framework |
| jupyter | >= 1.0 | Notebook environment |
| mkdocs-material | >= 9.5 | Documentation site generator |

### Build system

Uses [Hatchling](https://hatch.pypa.io/) as the build backend, configured to package from the `src/` directory.

## Customizing the template

After creating a new repo from this template:

1. **Rename the package**: Replace `project_name` (directory under `src/`) and `project-name` (in `pyproject.toml`) with your actual project name
2. **Update metadata**: Edit `[project]` in `pyproject.toml` — name, version, description, license
3. **Update the README**: Replace this content with your project's documentation
4. **Update the LICENSE**: Change the copyright holder
5. **Add dependencies**: Add your runtime dependencies to `[project] dependencies` in `pyproject.toml`
6. **Enable ML extras**: Uncomment libraries in `[project.optional-dependencies.ml]` as needed
7. **Update docs config**: Edit `mkdocs.yml` — `site_name`, `repo_url`, `repo_name`
8. **Update CONTRIBUTING.md**: Replace the GitHub Pages URL with your actual docs URL
9. **Enable GitHub Pages**: Go to Settings > Pages > Source > GitHub Actions
10. **Generate lockfile**: Run `uv lock` to create `uv.lock` (committed to the repo for reproducible builds)

## License

[MIT](LICENSE)
