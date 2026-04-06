# CI/CD & Infrastructure

## CI pipeline (`ci.yml`)

Runs on every push to `main` and on pull requests. Four parallel jobs:

| Job | What it does |
| --- | --- |
| **lint** | `ruff check` + `ruff format --check` |
| **type-check** | `mypy` in strict mode |
| **test** | `pytest` with coverage across Python 3.11, 3.12, 3.13. Uploads to Codecov on 3.12 |
| **audit** | `pip-audit` for known dependency vulnerabilities |

All jobs use [`astral-sh/setup-uv`](https://github.com/astral-sh/setup-uv) with dependency caching.

Workflows pin third-party and first-party GitHub Actions to immutable commit SHAs, and set an explicit `uv` version for reproducibility.

## Docs deploy (`docs.yml`)

On push to `main`, builds the MkDocs site and deploys to GitHub Pages. `just init-remote` enables Pages automatically.

## Standards enforcement

Commit messages and PR titles follow [Conventional Commits](https://www.conventionalcommits.org/):

```text
feat: add user authentication
fix: resolve timeout in data loader
docs: update API reference
refactor: simplify config parsing
```

| Layer | Tool | Where |
| --- | --- | --- |
| **Commit messages** (local) | [commitizen](https://commitizen-tools.github.io/commitizen/) pre-commit hook | Validates on `git commit` |
| **Commit messages** (CI) | `cz check` in `commit-lint.yml` | Validates all commits in a PR |
| **PR titles** | [`action-semantic-pull-request`](https://github.com/amannn/action-semantic-pull-request) in `pr-title.yml` | Blocks merge if invalid |
| **Issues** | YAML form templates | Required fields, dropdowns |

Valid types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.

## Branch protection

`just init-remote` automatically configures branch protection on `main`:

- **Required status checks**: lint, type-check, test (3.11/3.12/3.13), audit, validate
- **Require up-to-date branches** before merge
- **Block force pushes** and branch deletion

## Security scanning

- **CodeQL** (`codeql.yml`): static analysis on push, PR, and weekly. Catches injection, hardcoded credentials, etc.
- **pip-audit** (`ci.yml`): checks dependencies against the [Python Packaging Advisory Database](https://github.com/pypa/advisory-database).

## Publishing to PyPI (`publish.yml`)

Triggers on GitHub Releases using [trusted publishers](https://docs.pypi.org/trusted-publishers/) (no API tokens):

1. Go to [pypi.org](https://pypi.org) → your project → Publishing → Add a new publisher
2. Enter: repo `{{ github_user }}/{{ project_name }}`, workflow `publish.yml`, environment `pypi`
3. Create a GitHub Release: builds with `uv build` and publishes automatically

## Dependabot (`dependabot.yml`)

Opens weekly PRs for two ecosystems:

- **pip**: Python dependencies (dev deps grouped into a single PR)
- **github-actions**: action version bumps

All Dependabot PRs use conventional commit prefixes (`chore(deps):`, `ci(deps):`) to pass PR title validation.
