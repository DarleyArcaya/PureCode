import os
import shutil

def clear_pip_caches():

    pip_caches_windows = os.path.join(os.environ.get('LOCALAPPDATA', ''), 'pip', 'cache')

    pip_caches_linix_macos = os.path.expanduser('~/Library/Caches/pip') 

    try:
        if os.path.exists(pip_caches_windows):
            shutil.rmtree(pip_caches_windows)
            print('Pip caches removed successfully')
            return 'Pip caches removed successfully'
        elif os.path.exists(pip_caches_linix_macos):
            shutil.rmtree(pip_caches_linix_macos)
            print('Pip caches removed successfully')
            return 'Pip caches removed successfully'
        else:
            print('Path not found')
    except Exception:
        print('An error occurred while trying to remove pip caches')

