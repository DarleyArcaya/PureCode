import platform
import os
import shutil
def optimization_system():

    # This is what we are deleting for optimize windows
    windows_optimization_1 = os.environ.get('TEMP')
    windows_optimization_2 = r"C:\Windows\Temp"
    windows_optimization_3 = r"C:\Windows\Prefetch"
    

    # This is what we are deleting for optimize macos
    macos_optimization_1 = os.path.expanduser('~/Library/Caches')
    macos_optimization_2 = os.path.expanduser('~/Library/Logs')
    macos_optimization_3 = "/Library/Caches"
    macos_optimization_4 = "/Library/Logs"
    




    system = platform.system()
    if system == "Windows":
        
        if os.path.exists(windows_optimization_1):

            try:
                shutil.rmtree(windows_optimization_1) # delete this folder
                os.makedirs(windows_optimization_1) # create the same folder but empty
            except Exception:
                pass
        
        if os.path.exists(windows_optimization_2):
            try:
                shutil.rmtree(windows_optimization_2)
                os.makedirs(windows_optimization_2)
            except Exception:
                pass
        
        if os.path.exists(windows_optimization_3):
            try:
                shutil.rmtree(windows_optimization_3)
                os.makedirs(windows_optimization_3)
            except Exception:
                pass
        
        print("Windows Optimization completed successfully.")

    elif system == "Darwin":
        
        if os.path.exists(macos_optimization_1):

            try:
                shutil.rmtree(macos_optimization_1) # delete this folder
                os.makedirs(macos_optimization_1) # create the same 
            except Exception:
                pass

        if os.path.exists(macos_optimization_2):
            try:
                shutil.rmtree(macos_optimization_2)
                os.makedirs(macos_optimization_2)
            except Exception:
                pass
        
        if os.path.exists(macos_optimization_3):
            try:
                shutil.rmtree(macos_optimization_3)
                os.makedirs(macos_optimization_3)
            except Exception:
                pass
        
        if os.path.exists(macos_optimization_4):
            try:
                shutil.rmtree(macos_optimization_4)
                os.makedirs(macos_optimization_4)
            except Exception:
                pass
        
        print("MacOs Optimization completed succesfully")