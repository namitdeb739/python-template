# Project Guidelines

## Build And Test

- Use `just` recipes as the default interface for local development tasks.
- Use `just setup` after cloning to install dependencies and pre-commit hooks.
- Use `just check` before submitting changes; it mirrors CI (`lint`, `typecheck`, `test`).
- Use `just fix` to apply lint and formatting fixes.
- Use `just test` for tests and `just coverage` when coverage details are needed.
- Use `just docs` for local documentation preview and `just docs-build` for docs build validation.

## Code Style And Types

- Keep all Python code compatible with Python 3.11+.
- Follow Ruff formatting and linting rules configured in `pyproject.toml` (line length 88, import sorting via Ruff).
- Mypy runs in strict mode; add full type annotations for new/changed functions.
- Keep tests under `tests/` with filenames matching `test_*.py`.

## Architecture

- Main application code lives in `src/project_name/`.
- Keep reusable production logic in `src/project_name/`, not in notebooks.
- Use `src/project_name/config.py` as the reference pattern for typed configuration.
- Keep exploratory work in `notebooks/` and standalone utilities in `scripts/`.
- Treat `data/` as gitignored/DVC-ready data storage.

## Conventions

- Use `uv` for dependency and environment management; do not switch to ad-hoc `pip` workflows.
- Follow Conventional Commits for commit messages.
- Use `just release patch|minor|major` for version bumps and tagging instead of manual edits.
- If this repository is newly created from template, run `just init` once before other tasks.

## Docs Links

- Project overview and command quickstart: `README.md`
- Development workflow and coding expectations: `docs/getting-started.md`, `docs/contributing.md`
- CI/CD and security workflow details: `docs/ci-cd.md`
- Container workflows: `docs/docker.md`
- ML and data workflow details: `docs/ml-setup.md`
- Release process and versioning details: `docs/releasing.md`
