# python-template

Copier template that generates opinionated Python projects with uv, ruff, mypy, pytest, pre-commit, and GitHub Actions.

## Architecture

- `copier.yaml` — template variables, feature toggles, and `_tasks` post-copy steps
- `template/` — all source files; `_subdirectory: template` makes this the output root
- Files with `.jinja` extension are rendered by Copier; all others are copied verbatim
- Copier variable syntax: `{{ variable_name }}` in `.jinja` files
- Conditional blocks: `{% if use_docker != 'none' %}…{% endif %}`
- `_tasks` in copier.yaml run sequentially after copy: rename package dir → remove unused features → git init → uv sync → pre-commit install

## Commands

```bash
just validate-standard        # render default variant and run ruff + mypy + pytest
just validate-all             # run all 8 variants (mirrors CI matrix)
just validate-full            # kitchen-sink: all features on
just release [patch|minor|major]  # tag and push a release
uv run pytest                 # test template rendering helpers only
uv run ruff check .           # lint template helpers (src/, tests/)
```

To test locally: `uvx copier copy --defaults . /tmp/test-output`

## Template conventions

- Feature toggles are vars in copier.yaml — default to opt-in (false / none / minimal)
- Adding a feature toggle requires updating: copier.yaml, affected `.jinja` files, the `_tasks` removal step, the justfile validate recipe, and the CI matrix in `.github/workflows/validate-template.yml`
- Escape Jinja syntax that must survive into generated projects: `{% raw %}{{ raw_jinja }}{% endraw %}`
- Never add `.jinja` to files that have no template variables (`.gitignore`, static YAML, etc.)
- `_subdirectory: template` and `_exclude` in copier.yaml control what Copier sees — do not move template root files outside `template/`

## All 8 variants must pass before merging

`validate-standard`, `validate-minimal`, `validate-cli`, `validate-api`, `validate-db`, `validate-iot`, `validate-gpu-ml`, `validate-full`
