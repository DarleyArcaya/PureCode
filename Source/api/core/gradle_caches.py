import os
import shutil


def remove_gradle_cashes(cache_path):
    full_path_cache = os.path.expanduser(cache_path) #This line helps to access to the full path of the caches.
    
    if os.path.exists(full_path_cache):
        shutil.rmtree(full_path_cache)
        print('cache removed')
    else:
        print('no cache found')



