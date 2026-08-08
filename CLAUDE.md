# python-template

Copier template that generates opinionated Python projects with uv, ruff, mypy, pytest, pre-commit, and GitHub Actions.

## Architecture

- `copier.yaml` — template variables, feature toggles, and `_tasks` post-copy steps
- `template/` — all source files; `_subdirectory: template` makes this the output root
- Files with `.jinja` extension are rendered by Copier; all others are copied verbatim
- Copier variable syntax: `{{ variable_name }}` in `.jinja` files
- Conditional blocks: `{% if use_docker != 'none' %}…{% endif %}`
- `_tasks` in copier.yaml run sequentially after copy: remove unused features → git init → uv sync → pre-commit install
- The package dir is `template/src/{{ package_name }}/` — Copier renders path names too. Never rename paths in `_tasks`; that breaks `copier update`, which renders to the template's literal path

## Commands

The template has no root Python package; it is tested by rendering variants
(`just validate-*`), which is exactly what CI runs. Each variant renders the
template and runs `ruff` + `mypy` + `pytest` against the generated project.

```bash
just validate-all             # render + test all 10 variants — this IS the test suite (mirrors CI)
just validate-standard        # render the default variant and check it
just validate-full            # kitchen-sink: all features on
just release [patch|minor|major]  # tag and push a release
```

To render locally without checks: `uvx copier copy --defaults . /tmp/test-output`

## Template conventions

- Feature toggles are vars in copier.yaml — default to opt-in (false / none / minimal)
- Adding a feature toggle requires updating: copier.yaml, affected `.jinja` files, the `_tasks` removal step, the justfile validate recipe, and the CI matrix in `.github/workflows/validate-template.yml`
- Escape Jinja syntax that must survive into generated projects: `{% raw %}{{ raw_jinja }}{% endraw %}`
- Never add `.jinja` to files that have no template variables (`.gitignore`, static YAML, etc.)
- `_subdirectory: template` and `_exclude` in copier.yaml control what Copier sees — do not move template root files outside `template/`

## All 11 variants must pass before merging

`validate-standard`, `validate-minimal`, `validate-cli`, `validate-api`, `validate-db`, `validate-ml`, `validate-webapp`, `validate-iot`, `validate-gpu-ml`, `validate-full`, `validate-update`

Note: `use_ml` and `use_webapp` are multi-choice (`none`/tiers), so gate on `use_ml != 'none'`, `use_ml in ['standard', 'full']`, `use_webapp == 'streamlit'`, etc. — not truthiness.
