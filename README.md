# python-template

[![CI](https://github.com/namitdeb739/python-template/actions/workflows/ci.yml/badge.svg)](https://github.com/namitdeb739/python-template/actions/workflows/ci.yml)
[![Docs](https://github.com/namitdeb739/python-template/actions/workflows/docs.yml/badge.svg)](https://namitdeb739.github.io/python-template/)
[![Python 3.11+](https://img.shields.io/badge/python-3.11%2B-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

A modern, batteries-included Python project template powered by [Copier](https://copier.readthedocs.io/).

## Quickstart

**Prerequisites:** [uv](https://docs.astral.sh/uv/getting-started/installation/) and [just](https://github.com/casey/just#installation)

```bash
uvx copier copy gh:namitdeb739/python-template my-project
cd my-project
```

That's it. Copier prompts for project name, description, and author, then scaffolds a complete Python project with git history, dependencies installed, and pre-commit hooks active.

## What you get

### Development
- [uv](https://docs.astral.sh/uv/) package management | [ruff](https://docs.astral.sh/ruff/) linting & formatting | [mypy](https://mypy.readthedocs.io/) strict type checking
- [pytest](https://docs.pytest.org/) + coverage (80% threshold) | [pre-commit](https://pre-commit.com/) hooks | [just](https://github.com/casey/just) task runner

### CI/CD & Security
- GitHub Actions CI: lint, typecheck, test matrix (3.11–3.13), dependency audit
- [CodeQL](https://codeql.github.com/) scanning | [pip-audit](https://github.com/pypa/pip-audit) | [Dependabot](https://docs.github.com/en/code-security/dependabot) | [Codecov](https://codecov.io/)
- [Conventional Commits](https://www.conventionalcommits.org/) enforced on commits and PR titles

### Documentation & Publishing
- [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) with auto-deploy to GitHub Pages
- [mkdocstrings](https://mkdocstrings.github.io/) for API docs from docstrings
- PyPI publishing via trusted publishers | version bumping via [bump-my-version](https://github.com/callowayproject/bump-my-version)

### ML-Ready
- Optional ML dependency group | typed dataclass `Config` | notebooks, data, scripts directories
- Docker support (CPU + GPU variants) | DVC data versioning | `.env` template for API keys

### Developer Experience
- [Dev Containers](https://containers.dev/) for GitHub Codespaces / VS Code
- VS Code settings + recommended extensions | `.editorconfig`
- [Copilot instructions](https://docs.github.com/en/copilot) pre-configured | issue templates | PR template

## After scaffolding

```bash
just check                     # verify everything passes

# Push to GitHub and enable branch protection + Pages:
gh repo create --public your-username/your-project
git remote add origin https://github.com/your-username/your-project.git
git push -u origin main
just init-remote               # requires gh CLI authenticated
```

## Pull in template improvements

```bash
uvx copier update              # re-run from within an existing project
```

## Project structure

```text
my-project/
├── src/my_package/        Source package (src layout)
├── tests/                 pytest test suite
├── docs/                  MkDocs documentation source
├── notebooks/             Jupyter notebooks
├── data/                  Datasets (gitignored, DVC-ready)
├── docker/                CPU + GPU Dockerfiles, docker-compose
├── scripts/               Standalone utility scripts
├── .github/               CI workflows, issue templates, CODEOWNERS
└── .devcontainer/         GitHub Codespaces / VS Code dev container
```

## Template docs

Full documentation: [namitdeb739.github.io/python-template](https://namitdeb739.github.io/python-template/)

## License

[MIT](LICENSE)
