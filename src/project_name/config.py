"""Typed configuration using dataclasses.

Define your project's configuration here. Dataclasses provide type safety,
default values, and easy serialization without external dependencies.

Usage:
    from project_name.config import Config

    config = Config()
    config = Config(seed=42, data_dir="data/processed")
"""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path


@dataclass
class Config:
    """Project configuration."""

    # Paths
    data_dir: Path = Path("data")
    output_dir: Path = Path("output")

    # Reproducibility
    seed: int = 42

    # Training (uncomment and customize as needed)
    # learning_rate: float = 1e-3
    # batch_size: int = 32
    # epochs: int = 10
    # device: str = "auto"

    # Experiment tracking (uncomment for your tracker)
    # Note: tags needs `from dataclasses import field`
    # experiment_name: str = "default"
    # run_name: str | None = None
    # tags: list[str] = field(default_factory=list)

    def __post_init__(self) -> None:
        self.data_dir = Path(self.data_dir)
        self.output_dir = Path(self.output_dir)
