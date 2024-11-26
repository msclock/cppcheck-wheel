from __future__ import annotations

import re
import subprocess

import pytest
from importlib_metadata import version

import cppcheck as m


def test_version():
    assert version("cppcheck") == m.__version__


def test_cppcheck_dir():
    output = subprocess.run(
        [m.get_cppcheck_dir() / "cppcheck", "--version"],
        capture_output=True,
        text=True,
        check=False,
    )
    assert re.match(r"Cppcheck \d+.\d+.\d+", output.stdout.rstrip())


@pytest.mark.parametrize("testcase", [("--version", f"{m.__version__}")])
def test_cppcheck(testcase):
    test_input, test_output = testcase
    output = subprocess.run(["cppcheck", test_input], capture_output=True, check=True)
    assert test_output in str(output.stdout.rstrip())
