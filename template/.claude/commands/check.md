Run the full local CI suite and report results.

Steps:
1. Run `just check` — this mirrors the full CI pipeline (lint + typecheck + test)
2. If any step fails, show the exact error and suggest a fix
3. If all pass, confirm with the passing commands and output summary
