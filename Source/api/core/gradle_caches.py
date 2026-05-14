import os
import shutil


def remove_gradle_cashes(cache_path):
    full_path_cache = os.path.expanduser(cache_path) #This line helps to access to the full path of the caches.
    
    # Check if the directory exists
    try:
        if os.path.exists(full_path_cache):
            shutil.rmtree(full_path_cache)
            print('Gradle caches removed successfully')
            return 'Gradle caches removed successfully'
        else:
            print('No cache found')
            return 'No cache found'
    except Exception:
        print('An error occurred while trying to remove gradle caches')
        return 'An error occurred while trying to remove gradle caches'


