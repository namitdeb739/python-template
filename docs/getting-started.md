# Getting Started

## Prerequisites

- Python 3.11+
- [uv](https://docs.astral.sh/uv/getting-started/installation/)
- [just](https://github.com/casey/just#installation) (optional, for task running)

## Installation

```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
just setup    # or: uv sync --dev && uv run pre-commit install
```

## Usage

```bash
uv run project-name
```

## Running tests

```bash
just test           # or: uv run pytest -v
just test -k foo    # run specific tests
just coverage       # with coverage report
```

## Running all checks

```bash
just check    # runs lint + typecheck + test (mirrors CI)
```
