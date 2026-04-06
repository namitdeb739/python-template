# Releasing

## Version bumping

The template uses [bump-my-version](https://github.com/callowayproject/bump-my-version) to keep version numbers in sync across `pyproject.toml`, `src/{{ package_name }}/__init__.py`, and `[tool.commitizen]`:

```bash
just release patch    # 0.1.0 → 0.1.1
just release minor    # 0.1.0 → 0.2.0
just release major    # 0.1.0 → 1.0.0
```

This:

1. Runs `just check` (lint + typecheck + test)
2. Bumps version in all configured files
3. Creates a commit with message `chore(release): bump version X → Y`
4. Creates a git tag `vX.Y.Z`
5. Pushes commit and tag to origin

## Publishing to PyPI

Create a [GitHub Release](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository) from the tag. The `publish.yml` workflow automatically builds with `uv build` and publishes to PyPI using [trusted publishers](https://docs.pypi.org/trusted-publishers/).

### One-time PyPI setup

1. Go to [pypi.org](https://pypi.org) → your project → Publishing → Add a new publisher
2. Enter: repo `{{ github_user }}/{{ project_name }}`, workflow `publish.yml`, environment `pypi`

No API tokens needed: trusted publishers use OIDC for authentication.

## Build system

Uses [Hatchling](https://hatch.pypa.io/) as the build backend, configured to package from the `src/` directory.
