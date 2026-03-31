# Contributing

See the full [Contributing Guide](docs/contributing.md) for detailed instructions.

## Quick start

```bash
# Fork and clone, then:
just setup          # install deps + pre-commit hooks
just check          # run lint + typecheck + test
just fix            # auto-fix lint/formatting
```

## Pull request process

1. Create a branch from `main`
2. Make your changes
3. Run `just check` to verify everything passes
4. Open a pull request against `main`
