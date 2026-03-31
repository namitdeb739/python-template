# python-template

[![CI](https://github.com/namitdeb739/python-template/actions/workflows/ci.yml/badge.svg)](https://github.com/namitdeb739/python-template/actions/workflows/ci.yml)
[![Docs](https://github.com/namitdeb739/python-template/actions/workflows/docs.yml/badge.svg)](https://namitdeb739.github.io/python-template/)
[![CodeQL](https://github.com/namitdeb739/python-template/actions/workflows/codeql.yml/badge.svg)](https://github.com/namitdeb739/python-template/actions/workflows/codeql.yml)
[![Python 3.11+](https://img.shields.io/badge/python-3.11%2B-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)
[![uv](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/uv/main/assets/badge/v0.json)](https://github.com/astral-sh/uv)

A modern, batteries-included Python project template with [uv](https://docs.astral.sh/uv/), [ruff](https://docs.astral.sh/ruff/), and ML-ready structure. Click **"Use this template"** on GitHub to create a new repository from this template.

## Features

- **[uv](https://docs.astral.sh/uv/)** for fast, reliable package and project management
- **[ruff](https://docs.astral.sh/ruff/)** for linting and formatting (replaces flake8, black, and isort)
- **[pytest](https://docs.pytest.org/)** for testing
- **[mypy](https://mypy.readthedocs.io/)** for static type checking (strict mode)
- **[pre-commit](https://pre-commit.com/)** hooks for local code quality enforcement
- **[just](https://github.com/casey/just)** task runner for one-command workflows (`just check`, `just fix`, `just docs`)
- **GitHub Actions CI** with lint, type-check, test, coverage, and dependency audit jobs
- **[CodeQL](https://codeql.github.com/)** security scanning and **[pip-audit](https://github.com/pypa/pip-audit)** dependency vulnerability checks
- **[Dependabot](https://docs.github.com/en/code-security/dependabot)** for automated dependency updates
- **[MkDocs Material](https://squidfunk.github.io/mkdocs-material/)** for documentation with GitHub Pages auto-deploy
- **[Codecov](https://codecov.io/)** coverage reporting on PRs
- **Docker** support with multi-stage build using uv (CPU and GPU variants)
- **[Dev Containers](https://containers.dev/)** for GitHub Codespaces and VS Code one-click setup
- **PyPI publishing** workflow with trusted publishers on GitHub Release
- **Version bumping** via `just release` with [bump-my-version](https://github.com/callowayproject/bump-my-version)
- **ML-ready** with optional dependency group, config pattern, notebooks, data, scripts, and DVC support
- **Issue templates** (bug report + feature request YAML forms) and **PR template** with checklist

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

1. Click **"Use this template"** on GitHub to create your repo
2. Clone it and run the interactive setup:

```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
just init
```

This prompts for your project name, description, author, and GitHub username, then automatically:
- Renames the package directory and all references
- Updates badges, CODEOWNERS, LICENSE, and docs config
- Locks and installs dependencies
- Sets up pre-commit hooks
- Optionally initializes DVC and `.env`

Already set up? Use `just setup` to reinstall deps and hooks.

### Run

```bash
uv run project-name
```

### Task runner (`just`)

The `justfile` provides shortcuts for all common workflows. Run `just` to see all available recipes:

| Recipe | Description |
|---|---|
| `just init` | **Interactive project setup** (run once after cloning from template) |
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
| `just audit` | Audit dependencies for vulnerabilities |
| `just build` | Build package for distribution |
| `just release patch` | Bump version, tag, and push (patch/minor/major) |
| `just docker-build` | Build Docker image |
| `just docker-build-gpu` | Build GPU Docker image |
| `just docker-run` | Run in Docker |
| `just dvc-init` | Initialize DVC for data versioning |
| `just clean` | Remove build artifacts |

All recipes also work with plain `uv run` commands if you don't have `just` installed.

## Project structure

```
.
├── src/
│   └── project_name/          # Source package (src layout)
│       ├── __init__.py
│       ├── main.py            # Entry point
│       ├── config.py          # Typed dataclass configuration
│       └── py.typed           # PEP 561 type marker
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
├── scripts/                   # Standalone scripts (data processing, training)
├── .devcontainer/
│   └── devcontainer.json      # GitHub Codespaces / VS Code dev container
├── .github/
│   ├── ISSUE_TEMPLATE/        # Bug report + feature request YAML forms
│   ├── workflows/
│   │   ├── ci.yml             # CI: lint, typecheck, test, coverage, audit
│   │   ├── docs.yml           # Docs build and deploy to GitHub Pages
│   │   ├── publish.yml        # Publish to PyPI on GitHub Release
│   │   └── codeql.yml         # CodeQL security analysis
│   ├── CODEOWNERS             # Default PR reviewers
│   ├── dependabot.yml         # Dependency update config
│   └── pull_request_template.md
├── .vscode/
│   ├── settings.json          # Editor config for ruff, mypy, pytest
│   └── extensions.json        # Recommended extensions
├── justfile                   # Task runner recipes
├── mkdocs.yml                 # MkDocs configuration
├── .pre-commit-config.yaml    # Pre-commit hook config
├── .editorconfig              # Cross-IDE formatting defaults
├── .dvcignore                 # DVC exclusion patterns
├── .env.example               # Template environment variables
├── pyproject.toml             # Project metadata, dependencies, tool config
├── Dockerfile                 # Multi-stage container build (CPU)
├── Dockerfile.gpu             # CUDA-based container build (GPU)
├── docker-compose.yml         # Container orchestration
├── .python-version            # Pin Python version (3.11)
├── .gitignore                 # Python, data, IDE, OS ignores
├── SECURITY.md                # Vulnerability disclosure policy
├── CONTRIBUTING.md            # Contributor quick-start
├── CHANGELOG.md               # Release history
├── LICENSE                    # MIT
└── README.md
```

### Why src layout?

The `src/` layout prevents accidental imports of the uninstalled package during development and is the [recommended layout](https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/) for publishable Python projects. The package is configured in `pyproject.toml` under `[tool.hatch.build.targets.wheel]`.

## CI/CD

### CI (`ci.yml`)

The CI pipeline runs on every push to `main` and on pull requests targeting `main`. It consists of four parallel jobs:

| Job | What it does |
|---|---|
| **lint** | Runs `ruff check` and `ruff format --check` to enforce code style |
| **type-check** | Runs `mypy` in strict mode against `src/` |
| **test** | Runs `pytest` with coverage across Python 3.11, 3.12, and 3.13. Uploads coverage to Codecov on 3.12 |
| **audit** | Runs `pip-audit` to check for known vulnerabilities in dependencies |

All jobs use [`astral-sh/setup-uv`](https://github.com/astral-sh/setup-uv) to install uv with dependency caching.

### Docs deploy (`docs.yml`)

On every push to `main`, the docs workflow builds the MkDocs site and deploys it to GitHub Pages. To enable this:

1. Go to **Settings > Pages** in your GitHub repo
2. Under **Source**, select **GitHub Actions**

The docs site will be available at `https://your-username.github.io/your-repo/`.

### Security scanning

Two layers of security scanning are built in:

- **CodeQL** (`codeql.yml`) — GitHub's semantic code analysis runs on push, PR, and weekly schedule. Catches injection vulnerabilities, hardcoded credentials, and other security anti-patterns.
- **pip-audit** (`ci.yml` audit job) — checks all installed dependencies against the [Python Packaging Advisory Database](https://github.com/pypa/advisory-database) for known CVEs.

### Publishing to PyPI (`publish.yml`)

The publish workflow triggers on GitHub Releases and uses [trusted publishers](https://docs.pypi.org/trusted-publishers/) (no API tokens needed). To set up:

1. Go to [pypi.org](https://pypi.org) → your project → Publishing → Add a new publisher
2. Enter: GitHub repo `your-username/your-repo`, workflow `publish.yml`, environment `pypi`
3. Create a GitHub Release — the workflow builds with `uv build` and publishes automatically

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
| `docs/api.md` | API reference (auto-generated from docstrings) |
| `docs/contributing.md` | Full contributor guide |
| `docs/changelog.md` | Release history |

### Adding pages

1. Create a new `.md` file in `docs/`
2. Add it to the `nav` section in `mkdocs.yml`
3. Push to `main` — the docs deploy workflow publishes automatically

### Enabled extensions

The template enables several useful MkDocs Material extensions out of the box:

- **[mkdocstrings](https://mkdocstrings.github.io/)** — auto-generate API docs from Google-style docstrings
- **Admonitions** — callout boxes (`!!! note`, `!!! warning`, etc.)
- **Code highlighting** — syntax highlighting with line numbers and copy button
- **Tabbed content** — tabbed code examples for multi-language/multi-platform docs
- **Table of contents** — auto-generated with permalink anchors

### Docstring convention

Use **[Google-style docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)** — they render automatically as API documentation via mkdocstrings. See `docs/api.md` and the [Contributing guide](docs/contributing.md) for examples.

## Docker

### Build and run

```bash
docker compose up --build
```

### How it works

The `Dockerfile` uses a multi-stage build optimized for fast rebuilds:

1. Copies `uv` binary from the official image (`ghcr.io/astral-sh/uv`)
2. Installs dependencies first (`uv sync --no-dev --no-install-project`) — this layer is cached unless `pyproject.toml` or `uv.lock` change
3. Copies source code and installs the project
4. Runs via `uv run project-name`

The `docker-compose.yml` mounts the `data/` directory as a volume and sets `PYTHONUNBUFFERED=1` for real-time log output.

### GPU support

A separate `Dockerfile.gpu` is included for ML workloads requiring CUDA:

```bash
just docker-build-gpu    # or: docker build -f Dockerfile.gpu -t project-name-gpu .
```

This uses `nvidia/cuda:12.4.1-runtime-ubuntu22.04` as the base image and installs the `[ml]` extras automatically.

## Dev Containers

The `.devcontainer/devcontainer.json` provides a one-click development environment for [GitHub Codespaces](https://github.com/features/codespaces) and [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers).

**What's included:**
- Python 3.12 base image
- uv, just, and GitHub CLI pre-installed
- All dev dependencies synced automatically
- Pre-commit hooks installed
- VS Code extensions auto-installed (ruff, mypy, Python, Jupyter, TOML, EditorConfig)
- Port 8000 forwarded for MkDocs preview

**To use:** Click "Open in GitHub Codespaces" on the repo page, or open the repo in VS Code and select "Reopen in Container".

## VS Code

The `.vscode/` directory includes recommended settings and extensions:

- **Format on save** with ruff
- **Organize imports** on save
- **Pytest** as the test runner
- **88-char ruler** matching the ruff line length
- **Recommended extensions**: Python, mypy, ruff, Jupyter, TOML, EditorConfig

VS Code will prompt to install recommended extensions when you first open the repo.

## Releasing

### Version bumping

The template uses [bump-my-version](https://github.com/callowayproject/bump-my-version) to keep version numbers in sync across `pyproject.toml` and `src/project_name/__init__.py`:

```bash
just release patch    # 0.1.0 → 0.1.1
just release minor    # 0.1.0 → 0.2.0
just release major    # 0.1.0 → 1.0.0
```

This runs all checks first, bumps the version, creates a git commit and tag, and pushes. Create a GitHub Release from the tag to trigger the PyPI publish workflow.

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
    # "dvc>=3.50",
]
```

Uncomment the ones you need, then install:

```bash
uv sync --extra ml
```

### Project layout for ML

| Directory | Purpose |
|---|---|
| `notebooks/` | Jupyter notebooks for exploration and prototyping |
| `data/` | Datasets (gitignored by default — use DVC for versioning) |
| `scripts/` | Standalone scripts for data processing, training, evaluation |
| `src/project_name/config.py` | Typed dataclass configuration (see below) |

### Configuration

`src/project_name/config.py` provides a typed, dataclass-based config pattern:

```python
from project_name.config import Config

config = Config(seed=42, data_dir="data/processed")
```

This is intentionally tracker-agnostic — works with W&B, MLflow, or plain Python. Commented fields for learning rate, batch size, epochs, and experiment tracking are included as starting points.

### Environment variables

Copy `.env.example` to `.env` and fill in your API keys:

```bash
cp .env.example .env
```

Template includes placeholders for W&B, MLflow, HuggingFace, AWS, GCS, and DVC remotes.

### Data versioning (DVC)

To initialize [DVC](https://dvc.org/) for data versioning:

```bash
just dvc-init    # or: uv run dvc init && uv run dvc config core.autostage true
```

A `.dvcignore` file is included to exclude build artifacts from DVC tracking. Data files (`.csv`, `.parquet`, `.pkl`, `.h5`, `.pt`, `.onnx`, `.safetensors`) are gitignored by default.

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
| mkdocstrings[python] | >= 0.25 | Auto-generate API docs from docstrings |
| pip-audit | >= 2.7 | Dependency vulnerability scanner |

### Build system

Uses [Hatchling](https://hatch.pypa.io/) as the build backend, configured to package from the `src/` directory.

## Customizing the template

### Automated (recommended)

Run `just init` after cloning — it handles steps 1–6 interactively:

```bash
just init
```

### Manual steps (after `just init` or if you prefer manual setup)

1. **Add dependencies**: Add your runtime dependencies to `[project] dependencies` in `pyproject.toml`
2. **Enable ML extras**: Uncomment libraries in `[project.optional-dependencies.ml]` as needed
3. **Enable GitHub Pages**: Go to Settings > Pages > Source > GitHub Actions
4. **Set up Codecov**: Connect your repo at [codecov.io](https://codecov.io/) (free for public repos)
5. **Set up PyPI publishing**: Add trusted publisher at [pypi.org](https://pypi.org/) (see [Releasing](#releasing))

## License

[MIT](LICENSE)
