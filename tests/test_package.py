from __future__ import annotations

import sys

if sys.version_info < (3, 8):
    from importlib_metadata import version
else:
    from importlib.metadata import version

import cppcheck as m


def test_version():
    assert version("cppcheck") == m.__version__
