import os
import shutil


def remove_gradle_cashes(cache_path):
    full_path_cache = os.path.expanduser(cache_path) #This line helps to access to the full path of the caches.
    
    # Check if the directory exists
    try:
        if os.path.exists(full_path_cache):
            shutil.rmtree(full_path_cache)
            return 'Gradle caches removed successfully'
        else:
            return 'No cache found'
    except Exception:
        return 'An error occurred while trying to remove gradle caches'


