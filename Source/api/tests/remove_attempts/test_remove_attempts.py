import os
import shutil

def test_removing(cache_path):
    full_path_cache = os.path.expanduser(cache_path)

    if os.path.exists(full_path_cache):
        shutil.rmtree(full_path_cache)
        print('cache removed')
    else:
        print('no cache to remove')

test_removing('~/.gradle/caches/')


