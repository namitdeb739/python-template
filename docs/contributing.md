# Contributing

## Development setup

1. Fork and clone the repository
2. Run the setup recipe:

    ```bash
    just setup
    ```

    This installs all dev dependencies and configures pre-commit hooks.

## Workflow

1. Create a branch from `main`
2. Make your changes
3. Run `just check` to verify lint, type checking, and tests all pass
4. Commit — pre-commit hooks will auto-fix formatting and catch lint issues
5. Open a pull request against `main`

## Code style

- **Formatting**: handled by [ruff](https://docs.astral.sh/ruff/) (88 char line length, black-compatible)
- **Linting**: ruff with pycodestyle, pyflakes, isort, bugbear, and more (see `pyproject.toml`)
- **Type checking**: [mypy](https://mypy.readthedocs.io/) in strict mode — all functions must have type annotations
- **Auto-fix**: run `just fix` to auto-fix lint and formatting issues

## Testing

- Tests live in `tests/` and are run with [pytest](https://docs.pytest.org/)
- Run `just test` to execute the full suite
- Run `just test -k test_name` to run specific tests
- Run `just coverage` for a coverage report

## Commit messages

Use clear, descriptive commit messages. Prefer the imperative mood:

- "Add user authentication endpoint"
- "Fix off-by-one error in pagination"
- "Remove deprecated config loader"
