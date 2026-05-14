import os
import shutil

def remove_android_caches(cache_path):
    full_path_cache = os.path.expanduser(cache_path)


    try:
        if os.path.exists(full_path_cache):
            shutil.rmtree(full_path_cache)
            return 'Android caches removed successfully'
        else:
            return 'No cache found'
    except Exception:
        return 'An error occurred while trying to remove android caches'