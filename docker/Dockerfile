FROM python:3.11.11-slim AS base

WORKDIR /app

RUN addgroup --system app && adduser --system --ingroup app --home /app app

COPY --from=ghcr.io/astral-sh/uv:0.11.3 /uv /uvx /bin/

COPY pyproject.toml uv.lock* ./
RUN uv sync --no-dev --no-install-project

COPY README.md ./
COPY src/ src/
RUN uv sync --no-dev

RUN chown -R app:app /app
USER app

CMD ["uv", "run", "project-name"]
