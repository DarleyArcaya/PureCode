import os
import shutil

def remove_android_caches(cache_path):
    full_path_cache = os.path.expanduser(cache_path)


    try:
        if os.path.exists(full_path_cache):
            shutil.rmtree(full_path_cache)
            print('Android caches removed successfully')
            return 'Android caches removed successfully'
        else:
            print('No cache found')
            return 'No cache found'
    except Exception:
        print('An error occurred while trying to remove android caches')
        return 'An error occurred while trying to remove android caches'