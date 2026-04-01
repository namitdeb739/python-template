# ML Setup

## Optional dependencies

The `[ml]` extras group in `pyproject.toml` contains common ML libraries (commented out by default):

```toml
[project.optional-dependencies]
ml = [
    # "numpy>=1.26",
    # "pandas>=2.2",
    # "scikit-learn>=1.5",
    # "matplotlib>=3.9",
    # "torch>=2.3",
    # "transformers>=4.40",
    # "dvc>=3.50",
]
```

Uncomment what you need, then install:

```bash
uv sync --extra ml
```

## Project layout

| Directory | Purpose |
|---|---|
| `notebooks/` | Jupyter notebooks for exploration and prototyping |
| `data/` | Datasets (gitignored by default: use DVC for versioning) |
| `scripts/` | Standalone scripts for data processing, training, evaluation |
| `src/project_name/config.py` | Typed dataclass configuration |

## Configuration

`config.py` provides a typed, dataclass-based config pattern:

```python
from project_name.config import Config

config = Config(seed=42, data_dir="data/processed")
```

Intentionally tracker-agnostic: works with W&B, MLflow, or plain Python. Commented fields for learning rate, batch size, epochs, and experiment tracking are included as starting points.

## Environment variables

Copy `.env.example` to `.env` and fill in your API keys:

```bash
cp .env.example .env
```

Includes placeholders for W&B, MLflow, HuggingFace, AWS, GCS, and DVC remotes.

## Data versioning (DVC)

To initialize [DVC](https://dvc.org/):

```bash
just dvc-init    # or: uv run dvc init && uv run dvc config core.autostage true
```

Data files (`.csv`, `.parquet`, `.pkl`, `.h5`, `.pt`, `.onnx`, `.safetensors`) are gitignored by default.

## GPU Docker

See the [Docker guide](docker.md#gpu-build) for the CUDA-based `Dockerfile.gpu`.
