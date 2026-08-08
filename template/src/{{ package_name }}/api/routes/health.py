"""Health check routes."""

from fastapi import APIRouter

router = APIRouter()


@router.get("/")
def health_check() -> dict[str, str]:
    """Return service health status."""
    return {"status": "ok"}
