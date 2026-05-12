import os
import shutil

def remove_android_caches(cache_path):
    full_path_cache = os.path.expanduser(cache_path)

    if os.path.exists(full_path_cache):
        shutil.rmtree(full_path_cache)
        print('caches removed')
    else:
        print('No cache found')