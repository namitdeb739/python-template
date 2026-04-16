Fix GitHub issue $ARGUMENTS.

Steps:
1. Read the issue: `gh issue view $ARGUMENTS`
2. Create a branch: `git checkout -b fix/$ARGUMENTS-<short-slug>`
3. Implement the fix — read CLAUDE.md for architecture and conventions
4. If template files changed, validate: `just validate-standard`
5. Run: `uv run ruff check . && uv run pytest`
6. Commit with conventional format: `fix: <description> (closes #$ARGUMENTS)`
7. Push and open a PR: `gh pr create --fill`
