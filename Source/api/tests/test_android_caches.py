import pytest
from core.caches_to_delete.android_caches import remove_android_caches

def test_android_caches(cache_path):
    assert remove_android_caches(cache_path)
    
