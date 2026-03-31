FROM python:3.11-slim AS base

WORKDIR /app

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY pyproject.toml uv.lock* ./
RUN uv sync --no-dev --no-install-project

COPY src/ src/
RUN uv sync --no-dev

CMD ["uv", "run", "project-name"]
