import os
import shutil
import stat

def remove_readonly(func, path, excinfo):
    os.chmod(path, stat.S_IWRITE)
    func(path)

def clear_flutter_cache():
    
    # getting flutter cache path for windows
    windows_cache_path = os.path.join(os.environ.get('LOCALAPPDATA', ''), 'Pub', 'Cache')

    # getting flutter cache path for linux and macos
    linux_mac_cache_path = os.path.expanduser('~/.pub-cache')

    try:
        if os.path.exists(windows_cache_path):
            shutil.rmtree(windows_cache_path, onexc=remove_readonly) # using onexc parameter to intercept errors and fix file permissions during deletion
            return 'Flutter caches removed successfully'
        elif os.path.exists(linux_mac_cache_path):
            shutil.rmtree(linux_mac_cache_path, onexc=remove_readonly)
            return 'Flutter caches removed successfully'
        else:
            return 'No cache found'
    except Exception:
        return 'An error occurred while trying to remove flutter caches'