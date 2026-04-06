"""Shared test fixtures.

Fixtures defined here are automatically available to all tests without
importing. Use these as starting points and add project-specific fixtures
as the codebase grows.
"""

from __future__ import annotations

from pathlib import Path

import pytest

from project_name.config import Config


@pytest.fixture
def sample_config(tmp_path: Path) -> Config:
    """A Config instance with temp directories for isolated tests."""
    return Config(
        data_dir=tmp_path / "data",
        output_dir=tmp_path / "output",
        seed=42,
    )


@pytest.fixture
def data_dir(tmp_path: Path) -> Path:
    """A temporary data directory that exists on disk."""
    d = tmp_path / "data"
    d.mkdir()
    return d
