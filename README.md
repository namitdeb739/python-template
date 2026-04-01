# python-template

[![CI](https://github.com/namitdeb739/python-template/actions/workflows/ci.yml/badge.svg)](https://github.com/namitdeb739/python-template/actions/workflows/ci.yml)
[![Docs](https://github.com/namitdeb739/python-template/actions/workflows/docs.yml/badge.svg)](https://namitdeb739.github.io/python-template/)
[![CodeQL](https://github.com/namitdeb739/python-template/actions/workflows/codeql.yml/badge.svg)](https://github.com/namitdeb739/python-template/actions/workflows/codeql.yml)
[![Python 3.11+](https://img.shields.io/badge/python-3.11%2B-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)
[![uv](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/uv/main/assets/badge/v0.json)](https://github.com/astral-sh/uv)

A modern, batteries-included Python project template with [uv](https://docs.astral.sh/uv/), [ruff](https://docs.astral.sh/ruff/), and ML-ready structure. Click **"Use this template"** on GitHub to create a new repository.

## Features

**Development**
- [uv](https://docs.astral.sh/uv/) package management | [ruff](https://docs.astral.sh/ruff/) linting & formatting | [mypy](https://mypy.readthedocs.io/) strict type checking
- [pytest](https://docs.pytest.org/) + coverage | [pre-commit](https://pre-commit.com/) hooks | [just](https://github.com/casey/just) task runner

**CI/CD & Security**
- GitHub Actions CI (lint, typecheck, test matrix, dependency audit)
- [CodeQL](https://codeql.github.com/) scanning | [pip-audit](https://github.com/pypa/pip-audit) | [Dependabot](https://docs.github.com/en/code-security/dependabot) | [Codecov](https://codecov.io/)
- [Conventional Commits](https://www.conventionalcommits.org/) enforced on commits and PR titles
- Branch protection with required status checks (auto-configured)

**Documentation & Publishing**
- [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) with auto-deploy to GitHub Pages
- [mkdocstrings](https://mkdocstrings.github.io/) for API docs from docstrings
- PyPI publishing via trusted publishers | version bumping via [bump-my-version](https://github.com/callowayproject/bump-my-version)

**ML-Ready**
- Optional ML dependency group | typed dataclass config | notebooks, data, scripts directories
- Docker support (CPU + GPU variants) | DVC data versioning | `.env` template for API keys

**Developer Experience**
- [Dev Containers](https://containers.dev/) for GitHub Codespaces / VS Code
- VS Code settings + recommended extensions | `.editorconfig`
- Issue templates (YAML forms) | PR template with checklist

## Quickstart

**Prerequisites:** [uv](https://docs.astral.sh/uv/getting-started/installation/) and optionally [just](https://github.com/casey/just#installation)

```bash
# 1. Create repo from template (click "Use this template" on GitHub)
# 2. Clone and run interactive setup:
git clone https://github.com/your-username/your-repo.git
cd your-repo
just init
```

The setup script prompts for project name, description, author, and GitHub username, then automatically renames all references, installs dependencies, configures pre-commit hooks, enables branch protection, and enables GitHub Pages.

## Common commands

```bash
just check       # run lint + typecheck + test (mirrors CI)
just fix         # auto-fix lint and formatting
just test        # run tests (just test -k foo for specific)
just docs        # preview docs at http://127.0.0.1:8000/
just release X   # bump version (patch/minor/major), tag, push
just             # list all available recipes
```

## Project structure

```
src/project_name/       Source package (src layout)
tests/                  Test suite (pytest)
docs/                   Documentation (MkDocs Material)
notebooks/              Jupyter notebooks
data/                   Datasets (gitignored, DVC-ready)
scripts/                Standalone scripts
docker/                 Dockerfile (CPU), Dockerfile.gpu, docker-compose
.github/                Workflows, issue/PR templates, CODEOWNERS, Dependabot
.devcontainer/          GitHub Codespaces / VS Code dev container
.vscode/                Editor settings + recommended extensions
```

## Documentation

Full documentation is available at the [docs site](https://your-username.github.io/your-repo/):

- [Getting Started](docs/getting-started.md): setup, development workflow, adding dependencies
- [CI/CD & Infrastructure](docs/ci-cd.md): pipelines, security scanning, publishing, Dependabot
- [Docker](docs/docker.md): CPU/GPU builds, docker-compose
- [ML Setup](docs/ml-setup.md): config pattern, DVC, environment variables, GPU support
- [Releasing](docs/releasing.md): version bumping, PyPI publishing
- [API Reference](docs/api.md): auto-generated from docstrings
- [Contributing](docs/contributing.md): code style, testing, commit conventions
- [Changelog](docs/changelog.md)

## License

[MIT](LICENSE)
