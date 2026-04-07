# python-template

[![Validate Template](https://github.com/namitdeb739/python-template/actions/workflows/validate-template.yml/badge.svg)](https://github.com/namitdeb739/python-template/actions/workflows/validate-template.yml)
[![Python 3.11+](https://img.shields.io/badge/python-3.11%2B-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

A batteries-included Python project template powered by [Copier](https://copier.readthedocs.io/). Pick the features you need, skip the ones you don't.

## Quickstart

**Requires:** [uv](https://docs.astral.sh/uv/getting-started/installation/) and [just](https://github.com/casey/just#installation)

```bash
uvx copier copy gh:namitdeb739/python-template my-project
cd my-project
```

Copier prompts for your project name, author details, and feature choices. Answer the questions (or hit Enter for defaults) and you're done.

## Features

All features are opt-in or opt-out at generation time:

| Option | Default | What it adds |
|---|---|---|
| `ci_github` | `true` | GitHub Actions workflows: lint, type-check, test (3.11–3.13), audit |
| `security` | `basic` | `none` · `basic` (pre-commit, ruff) · `full` (+ CodeQL, pip-audit, Dependabot) |
| `use_docker` | `cpu` | `none` · `cpu` (Dockerfile + Compose) · `gpu` (+ GPU variant) |
| `use_docs` | `true` | MkDocs Material site with GitHub Pages auto-deploy |
| `testing` | `standard` | `minimal` (pytest) · `standard` (+ coverage + fixtures) · `full` (+ 80% threshold) |
| `use_ml` | `false` | Notebooks dir, data dir, optional ML deps, DVC, `.env` template |
| `use_typecheck` | `true` | mypy strict type checking |
| `use_devcontainer` | `false` | VS Code / Codespaces dev container |
| `use_iot` | `false` | IoT/embedded setup: serial, GPIO, MQTT drivers, device config, mock fixtures |

To skip all prompts and get the standard setup:

```bash
uvx copier copy --defaults gh:namitdeb739/python-template my-project
```

## What's included

**Tooling:** [uv](https://docs.astral.sh/uv/) · [ruff](https://docs.astral.sh/ruff/) · [mypy](https://mypy.readthedocs.io/) · [pytest](https://docs.pytest.org/) · [pre-commit](https://pre-commit.com/) · [just](https://github.com/casey/just)

**CI/CD:** lint, type-check, test matrix, dependency audit, [Conventional Commits](https://www.conventionalcommits.org/) enforced on commits and PR titles, trusted-publisher PyPI release

**Optional:** [CodeQL](https://codeql.github.com/) · [Dependabot](https://docs.github.com/en/code-security/dependabot) · [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) · Docker (CPU + GPU) · [DVC](https://dvc.org/)

## After scaffolding

```bash
just check          # verify lint + type-check + tests all pass

# Push to GitHub and configure branch protection + Pages:
gh repo create --public your-username/my-project
git remote add origin https://github.com/your-username/my-project.git
git push -u origin main
just init-remote    # requires gh CLI authenticated
```

## Keeping up to date

Pull in improvements from this template at any time:

```bash
uvx copier update
```

## License

[MIT](LICENSE)
