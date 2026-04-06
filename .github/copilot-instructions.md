# Copilot Instructions

## Project Overview

This is a Python project using **uv** for dependency management and **just** as a task runner. Source lives under `src/project_name/` (src layout). Configuration is via typed dataclasses in `src/project_name/config.py`.

## Key Commands

```bash
just setup       # Install deps + pre-commit hooks
just check       # lint + typecheck + test (full CI mirror)
just lint        # ruff check + format check
just fix         # auto-fix lint and formatting
just typecheck   # mypy strict
just test        # pytest
just coverage    # pytest with coverage report (80% threshold)
just docs        # mkdocs serve (local preview)
just release patch|minor|major  # bump version, tag, push
```

## Code Style

- **Formatter/linter**: ruff (line length 88, pyupgrade, bugbear, simplify rules enforced)
- **Types**: mypy strict — all public functions must be fully annotated
- **Imports**: isort via ruff; stdlib → third-party → first-party order
- **Commits**: conventional commits enforced (`feat:`, `fix:`, `chore:`, `refactor:`, `docs:`, `test:`, `ci:`)

## Architecture Patterns

- **Config**: `dataclasses.dataclass` in `config.py` — no Pydantic, no env parsing at import time. `__post_init__` converts `Path` fields.
- **Entry point**: `src/project_name/main.py` — CLI wired via `[project.scripts]` in `pyproject.toml`
- **Tests**: pytest, fixtures in `tests/conftest.py`, parametrize for data-driven cases
- **Docs**: MkDocs Material + mkdocstrings — docstrings drive the API reference page
- Keep reusable production logic in `src/project_name/`, not in notebooks
- Keep exploratory work in `notebooks/` and standalone utilities in `scripts/`
- Treat `data/` as gitignored/DVC-ready data storage

## Adding Dependencies

```bash
uv add <package>           # runtime dependency
uv add --dev <package>     # dev/test dependency
uv add --optional ml <package>  # optional ML extras
```

Always commit `uv.lock` after adding dependencies.

## Testing Conventions

- Fixtures go in `conftest.py` — never import them explicitly in test files
- Use `tmp_path` (built-in) for temporary file/directory fixtures
- Parametrize data-driven tests with `@pytest.mark.parametrize`
- Coverage threshold: 80% minimum (enforced in `just coverage`)

## CI Workflows

| Workflow | Trigger | Checks |
|----------|---------|--------|
| `ci.yml` | push/PR to main | lint, typecheck, test (3.11–3.13), audit |
| `codeql.yml` | push/PR + weekly | static security analysis |
| `commit-lint.yml` | PR | conventional commit format |
| `docs.yml` | push to main | build and deploy MkDocs to GitHub Pages |
| `publish.yml` | version tag push | build + publish to PyPI |

## Docs Links

- Project overview and command quickstart: `README.md`
- Development workflow and coding expectations: `docs/getting-started.md`, `docs/contributing.md`
- CI/CD and security workflow details: `docs/ci-cd.md`
- Container workflows: `docs/docker.md`
- ML and data workflow details: `docs/ml-setup.md`
- Release process and versioning details: `docs/releasing.md`

## What NOT to Do

- Do not bypass `uv` with `pip install` — always use `uv add` or `uv run`
- Do not add `print()` debug statements to library code — use `logging`
- Do not commit `.env` files — use `.env.example` as the template
- Do not add secrets or credentials to any tracked file
