import pytest

from project_name.main import main


def test_main(capsys: pytest.CaptureFixture[str]) -> None:
    main()
    captured = capsys.readouterr()
    assert captured.out == "Hello from project-name!\n"
