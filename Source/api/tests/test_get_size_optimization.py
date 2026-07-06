import pytest
from core.get_size.get_size_optimization import get_size, show_gb

def test_get_size():
    # Test with a known directory
    test_path = "test_directory"  # Replace with an actual test directory path
    expected_size = 1024  # Replace with the expected size in bytes for the test directory
    assert get_size(test_path) == expected_size

def test_show_gb():
    # Test with a known directory
    test_path = "test_directory"  # Replace with an actual test directory path
    expected_size = 1024  # Replace with the expected size in bytes for the test directory
    assert show_gb(test_path) == expected_size

