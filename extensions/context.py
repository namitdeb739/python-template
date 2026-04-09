"""Copier context hook — auto-detect author info from git/gh CLI."""

from __future__ import annotations

import subprocess

from copier_template_extensions import ContextHook


class GitDefaults(ContextHook):
    """Populate git_user_name, git_user_email, github_username from local tools."""

    def hook(self, context: dict) -> dict:  # type: ignore[override]
        return {
            "git_user_name": _git_config("user.name"),
            "git_user_email": _git_config("user.email"),
            "github_username": _gh_username(),
        }


def _run(cmd: list[str]) -> str:
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=5)
        return result.stdout.strip() if result.returncode == 0 else ""
    except Exception:
        return ""


def _git_config(key: str) -> str:
    return _run(["git", "config", "--global", key])


def _gh_username() -> str:
    return _run(["gh", "api", "user", "--jq", ".login"])
