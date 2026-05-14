import os
import shutil

def clear_flutter_cache():
    
    # getting flutter cache path for windows
    windows_cache_path = os.path.join(os.environ.get('LOCALAPPDATA', ''), 'Pub', 'Cache')

    # getting flutter cache path for linux and macos
    linux_mac_cache_path = os.path.expanduser('~/.pub-cache')

    if os.path.exists(windows_cache_path):
        shutil.rmtree(windows_cache_path)
        return 'Flutter caches removed successfully'
    elif os.path.exists(linux_mac_cache_path):
        shutil.rmtree(linux_mac_cache_path)
        return 'Flutter caches removed successfully'
    else:
        return 'No cache found'
    