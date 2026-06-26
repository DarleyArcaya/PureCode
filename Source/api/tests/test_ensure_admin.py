# import pytest
# use asstert once I call function from core

import pytest
from core.optimosys.optimosys import ensure_admin

def test_ensure_admin():
    assert ensure_admin()