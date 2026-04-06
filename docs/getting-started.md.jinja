# Getting Started

## Prerequisites

- **Python 3.11+**: check with `python --version`
- **[uv](https://docs.astral.sh/uv/getting-started/installation/)**: fast Python package manager
- **[just](https://github.com/casey/just#installation)**: task runner (optional but recommended)

## Project layout

```text
src/{{ package_name }}/   # Your source code goes here
tests/                    # Tests (pytest)
notebooks/                # Jupyter notebooks for exploration
data/                     # Datasets (gitignored, use DVC for versioning)
scripts/                  # Standalone scripts (data processing, training, etc.)
docs/                     # Documentation source (MkDocs)
```

## Development workflow

### Setup

```bash
just setup    # install deps + pre-commit hooks
```

### Daily commands

```bash
just check     # run lint + typecheck + test (same as CI)
just fix       # auto-fix lint and formatting issues
just test      # run tests only
just docs      # preview docs locally at http://127.0.0.1:8000/
```

### Adding dependencies

```bash
# Runtime dependency
uv add requests

# Dev dependency
uv add --group dev httpx

# ML optional dependency
uv add --optional ml numpy
```

After adding dependencies, `uv.lock` is updated automatically. Commit it for reproducible builds.

### Writing tests

Tests live in `tests/` and use [pytest](https://docs.pytest.org/). Shared fixtures go in `tests/conftest.py`.

```python
def test_my_feature() -> None:
    result = my_function(42)
    assert result == expected
```

Run specific tests:

```bash
just test -k test_my_feature    # by name
just test tests/test_main.py    # by file
just coverage                   # with coverage report
```

### Type annotations

All code must have type annotations: mypy runs in strict mode. Use [Google-style docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings) for documentation:

```python
def process_data(path: Path, *, normalize: bool = True) -> pd.DataFrame:
    """Load and process data from a file.

    Args:
        path: Path to the input data file.
        normalize: Whether to normalize values to [0, 1].

    Returns:
        Processed DataFrame ready for analysis.

    Raises:
        FileNotFoundError: If the input file doesn't exist.
    """
```

Docstrings are auto-rendered as [API documentation](api.md) by mkdocstrings.

## Next steps

- Add your runtime dependencies to `pyproject.toml`
- Enable [GitHub Pages](https://docs.github.com/en/pages) for documentation hosting
- Connect [Codecov](https://codecov.io/) for PR coverage reports
- See [Contributing](contributing.md) for the full development guide
