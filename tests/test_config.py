from pathlib import Path

from project_name.config import Config


def test_config_normalizes_path_fields() -> None:
    config = Config(data_dir=Path("data/raw"), output_dir=Path("artifacts"))

    assert isinstance(config.data_dir, Path)
    assert isinstance(config.output_dir, Path)
    assert config.data_dir == Path("data/raw")
    assert config.output_dir == Path("artifacts")


def test_config_default_values_are_stable() -> None:
    config = Config()

    assert config.data_dir == Path("data")
    assert config.output_dir == Path("output")
    assert config.seed == 42
