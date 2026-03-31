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

### Formatting and linting

[Ruff](https://docs.astral.sh/ruff/) handles both formatting and linting. It enforces:

- **88-character line length** (black-compatible)
- **isort-compatible import ordering**
- **pycodestyle, pyflakes, bugbear, and more** (see `pyproject.toml` for the full rule set)

Run `just fix` to auto-fix issues, or let pre-commit handle it on commit.

### Type annotations

[Mypy](https://mypy.readthedocs.io/) runs in **strict mode**. All functions must have complete type annotations:

```python
# Good
def process(items: list[str], *, verbose: bool = False) -> int: ...

# Bad — mypy strict will reject this
def process(items, verbose=False): ...
```

### Docstrings

Use **[Google-style docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)**. These are auto-rendered as API docs by [mkdocstrings](https://mkdocstrings.github.io/).

```python
def fetch_data(url: str, timeout: float = 30.0) -> bytes:
    """Fetch raw data from a URL.

    Args:
        url: The URL to fetch from.
        timeout: Request timeout in seconds.

    Returns:
        The response body as bytes.

    Raises:
        ConnectionError: If the request fails.
    """
```

## Testing

- Tests live in `tests/` and are run with [pytest](https://docs.pytest.org/)
- Shared fixtures go in `tests/conftest.py`
- Run `just test` to execute the full suite
- Run `just test -k test_name` to run specific tests
- Run `just coverage` for a coverage report
- CI runs tests across Python 3.11, 3.12, and 3.13

## Documentation

Docs are built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) and auto-deploy to GitHub Pages on merge to `main`.

```bash
just docs    # preview locally at http://127.0.0.1:8000/
```

- Prose documentation goes in `docs/`
- API reference is auto-generated from docstrings (see `docs/api.md`)
- Add new pages to the `nav` section in `mkdocs.yml`

## Commit messages

This project uses [Conventional Commits](https://www.conventionalcommits.org/). Every commit message must follow this format:

```
type: short description
```

Valid types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

Examples:

- `feat: add user authentication endpoint`
- `fix: resolve off-by-one error in pagination`
- `docs: update API reference for greet module`
- `refactor: simplify config parsing logic`

The commitizen pre-commit hook validates this locally on every commit. CI also validates all commits in a PR branch.

## Pull request process

1. Fill out the PR template (summary, changes, checklist)
2. Ensure `just check` passes (CI will verify)
3. Request review from a CODEOWNERS member
4. Squash-merge once approved
