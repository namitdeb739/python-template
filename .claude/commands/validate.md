Validate the Copier template by rendering it and running checks on the output.

Steps:
1. Run `just validate-standard` to render the default variant and verify ruff + mypy + pytest pass
2. If that passes and you want full coverage, run `just validate-all` (tests all 8 variants — takes a few minutes)
3. Report any failures with the specific variant name and the failing check
4. Clean up is automatic (just recipes use a temp dir with `trap ... EXIT`)
