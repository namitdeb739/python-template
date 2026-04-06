# python-template

[![Validate Template](https://github.com/namitdeb739/python-template/actions/workflows/validate-template.yml/badge.svg)](https://github.com/namitdeb739/python-template/actions/workflows/validate-template.yml)
[![Python 3.11+](https://img.shields.io/badge/python-3.11%2B-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

A configurable Python project template powered by [Copier](https://copier.readthedocs.io/). Choose exactly which features you need.

## Quickstart

**Prerequisites:** [uv](https://docs.astral.sh/uv/getting-started/installation/) and [just](https://github.com/casey/just#installation)

```bash
uvx copier copy gh:namitdeb739/python-template my-project
cd my-project
```

Copier prompts for project name, author, and feature choices, then scaffolds a project with only what you selected.

## Configuration options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `ci_github` | bool | `true` | GitHub Actions CI/CD workflows |
| `security` | choice | `basic` | `none` / `basic` (pre-commit, ruff) / `full` (+ CodeQL, pip-audit, Dependabot) |
| `use_docker` | choice | `cpu` | `none` / `cpu` (Dockerfile + Compose) / `gpu` (+ GPU Dockerfile) |
| `use_docs` | bool | `true` | MkDocs Material documentation + GitHub Pages deploy |
| `testing` | choice | `standard` | `minimal` (pytest) / `standard` (+ coverage, fixtures) / `full` (+ 80% threshold) |
| `use_ml` | bool | `false` | ML extras: notebooks, data dir, optional deps, DVC, .env template |
| `use_typecheck` | bool | `true` | mypy strict type checking |
| `use_devcontainer` | bool | `false` | VS Code / GitHub Codespaces dev container |

Use `--defaults` to skip prompts and get the standard setup (CI, basic security, CPU docker, docs, standard testing, typecheck).

## What you get (standard defaults)

### Development
- [uv](https://docs.astral.sh/uv/) package management | [ruff](https://docs.astral.sh/ruff/) linting & formatting | [mypy](https://mypy.readthedocs.io/) strict type checking
- [pytest](https://docs.pytest.org/) + coverage | [pre-commit](https://pre-commit.com/) hooks | [just](https://github.com/casey/just) task runner

### CI/CD & Security
- GitHub Actions CI: lint, typecheck, test matrix (3.11-3.13), dependency audit
- [Conventional Commits](https://www.conventionalcommits.org/) enforced on commits and PR titles
- Optional: [CodeQL](https://codeql.github.com/) | [Dependabot](https://docs.github.com/en/code-security/dependabot) | [Codecov](https://codecov.io/)

### Documentation & Publishing
- [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) with auto-deploy to GitHub Pages
- PyPI publishing via trusted publishers | version bumping via [bump-my-version](https://github.com/callowayproject/bump-my-version)

### ML-Ready (opt-in)
- Optional ML dependency group | typed dataclass `Config` | notebooks, data, scripts directories
- Docker support (CPU + GPU variants) | DVC data versioning | `.env` template

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

## License

[MIT](LICENSE)
