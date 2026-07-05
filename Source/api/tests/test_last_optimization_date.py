import pytest
from core.get_time.get_time_optimization import last_optimization_date

def test_last_optimization_date():
    result = last_optimization_date()
    assert "last_optimization_date" in result
    assert "last_optimization_time" in result
    assert "last_optimization_status" in result
    assert result["last_optimization_status"] == "Optimized"
