import os
import shutil
import platform

def get_pip_size():
    system = platform.system()

    if system == "Windows":
        windows_cache_flutter_path = os.path.join(os.environ.get('LOCALAPPDATA', ''), 'pip', 'cache')
        
        # Check if directory exists
        if not os.path.exists(windows_cache_flutter_path):
            return f"Flutter cache directory does not exist at: {windows_cache_flutter_path}"
            
        du_results = shutil.disk_usage(windows_cache_flutter_path)
        available_space = du_results

        size_megabytes = (available_space.total / 1024) - (available_space.used / 1024)
        size_gigabytes = size_megabytes / 1024
        
        if size_gigabytes > 0:
            print(f"Flutter cache occupies approximately {size_gigabytes:.2f} GB.")
        else:
            print("Flutter cache does not occupy any space in this directory.")
        
    elif system == "Darwin":
        macos_cache_flutter_path = os.path.expanduser('~/Library/Caches/pip')
        
        # Check if directory exists
        if not os.path.exists(macos_cache_flutter_path):
            return f"Flutter cache directory does not exist at: {macos_cache_flutter_path}"
            
        du_results = shutil.disk_usage(macos_cache_flutter_path)
        available_space = du_results

        size_megabytes = (available_space.total / 1024) - (available_space.used / 1024)
        size_gigabytes = size_megabytes / 1024
        
        if size_gigabytes > 0:
            print(f"Flutter cache occupies approximately {size_gigabytes:.2f} GB.")
        else:
            print("Flutter cache does not occupy any space in this directory.")

    return f"Flutter cache directory checked. Path: {os.path.realpath(windows_cache_flutter_path) if system == 'Windows' else os.path.realpath(macos_cache_flutter_path)}"

print(get_pip_size())
