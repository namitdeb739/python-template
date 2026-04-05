# Docker

Docker files live in the `docker/` directory.

## CPU build

```bash
just docker-build    # or: docker compose -f docker/docker-compose.yml build
just docker-run      # or: docker compose -f docker/docker-compose.yml up
```

The `Dockerfile` is structured for fast rebuilds and safer runtime defaults:

1. Copies `uv` and `uvx` from the official image (`ghcr.io/astral-sh/uv`)
2. Installs dependencies first (`uv sync --no-dev --no-install-project`): cached unless `pyproject.toml` or `uv.lock` change
3. Copies `README.md` and source, then installs the project
4. Drops privileges to a non-root `app` user before runtime
5. Runs via `uv run project-name`

The `docker-compose.yml` uses the repo root as build context and mounts `data/` as a volume with `PYTHONUNBUFFERED=1`. A root-level `.dockerignore` excludes docs, test artifacts, and local environment files from the build context.

## GPU build

A separate `docker/Dockerfile.gpu` is included for ML workloads requiring CUDA:

```bash
just docker-build-gpu    # or: docker build -f docker/Dockerfile.gpu -t project-name-gpu .
```

Uses `nvidia/cuda:12.4.1-runtime-ubuntu22.04` with Python 3.11 from the deadsnakes PPA. Installs `[ml]` extras automatically.

## Dev Containers

The `.devcontainer/devcontainer.json` provides a one-click environment for [GitHub Codespaces](https://github.com/features/codespaces) and [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers):

- Python 3.11 base image
- uv, just, and GitHub CLI pre-installed
- All dev dependencies synced, pre-commit hooks installed
- VS Code extensions auto-installed (ruff, mypy, Python, Jupyter, TOML, EditorConfig)
- Port 8000 forwarded for MkDocs preview

Click "Open in GitHub Codespaces" on the repo page, or "Reopen in Container" in VS Code.
