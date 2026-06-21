import ctypes, sys, os, shutil, platform

# Function to check if the current user is an administrator on Windows
#Esa función verifica si el proceso actual tiene permisos de administrador en Windows.

def is_admin():
    try:
        return bool(ctypes.windll.shell32.IsUserAnAdmin())
    except:
        return False

# Function to ensure the current process is running with administrative privileges on Windows
# Funcion para asegurarse que el actual proceso corre con permisos de administrador en Windows
def ensure_admin():
    system = platform.system()
    
    if system == 'Windows':
        if not is_admin():
            print("ERROR: Run VS Code as administrator.")
            sys.exit()
        else:
            print("Running as admin.")
    
    elif system == 'Darwin':
        if os.geteuid() != 0:  # This is for get admin permisson on MacOS
            print("ERROR: Run with sudo on Mac.")
            sys.exit()
        else:
            print("Running as admin.")

def clear_folder(path):
    if not path or not os.path.exists(path):
        print("Path does not exist or is empty.")
        return
    for item in os.scandir(path):
        try:
            if item.is_dir():
                shutil.rmtree(item.path)
            else:
                os.remove(item.path)
        except Exception as e:
            print(f"Ignoring {item.path}: {e}")
    print(f"Folder {path} cleaned.")

def optimization_system():
    system = platform.system()

    if system == 'Windows':
        paths = [
            os.environ.get('TEMP'),
            r"C:\Windows\Temp",
            r"C:\Windows\Prefetch"
        ]
    elif system == 'Darwin':
        paths = [
            os.path.expanduser('~/Library/Caches'),
            os.path.expanduser('~/Library/Logs'),
            "/Library/Caches",
            "/Library/Logs",
        ]
    else:
        print('Unsupported operating system')
        return
    
    for path in paths:
        print(f'Cleaning: {path}')
        clear_folder(path)

if __name__ == "__main__":

    ensure_admin()

            


