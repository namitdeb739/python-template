import pytest

from project_name.main import main


def test_main(capsys: pytest.CaptureFixture[str]) -> None:
    main()
    captured = capsys.readouterr()
    assert "Hello from project-name!" in captured.out
