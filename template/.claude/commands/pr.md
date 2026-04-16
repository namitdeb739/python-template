Create a pull request for the current branch.

Steps:
1. Check current branch: `git branch --show-current` — abort if on main
2. Verify CI would pass: `just check`
3. Show what will be in the PR: `git log main..HEAD --oneline`
4. Create the PR: `gh pr create --fill`
   - Title must follow Conventional Commits format: `type(scope): description`
   - Body should summarise what changed and why
5. Output the PR URL
