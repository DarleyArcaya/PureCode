import ctypes, sys, os, shutil, platform

# Function to check if the current user is an administrator on Windows
#Esa función verifica si el proceso actual tiene permisos de administrador en Windows.

def is_admin():
    try:
        system = platform.system()
        if system == 'Windows':
            return bool(ctypes.windll.shell32.IsUserAnAdmin())
        elif system == 'Darwin':
            return os.geteuid() == 0
        return False
    except:
        return False

# Function to relaunch the current process requesting elevated privileges.
# En Windows dispara el UAC (ventana "¿Permitir que esta app haga cambios?").
# En Mac dispara el diálogo nativo de "Introduce tu contraseña", vía osascript,
# porque una app GUI no tiene una terminal donde 'sudo' pueda pedir la contraseña por teclado.
# Funcion que relanza el proceso actual pidiendo permisos elevados.
def relaunch_as_admin():
    system = platform.system()
    try:
        if system == 'Windows':
            executable = sys.executable
            params = " ".join(f'"{arg}"' for arg in sys.argv)
            result = ctypes.windll.shell32.ShellExecuteW(
                None, "runas", executable, params, None, 1
            )
            return result > 32  # ShellExecuteW devuelve >32 si tuvo éxito

        elif system == 'Darwin':
            # sys.executable ya apunta al binario correcto tanto en desarrollo (python3)
            # como compilado con PyInstaller (el propio .app)
            executable = sys.executable
            args = " ".join(f'"{arg}"' for arg in sys.argv[1:])
            command = f'"{executable}" {args}'.strip()

            # osascript muestra el diálogo nativo de macOS pidiendo la contraseña de admin
            apple_script = f'do shell script "{command}" with administrator privileges'
            result = os.system(f"osascript -e '{apple_script}'")
            return result == 0

        return False
    except Exception as e:
        print(f"No se pudo solicitar elevación: {e}")
        return False

# Function to ensure the current process is running with administrative privileges on Windows
# Funcion para asegurarse que el actual proceso corre con permisos de administrador en Windows
def ensure_admin():
    system = platform.system()

    if system in ('Windows', 'Darwin'):
        if not is_admin():
            print(f"No se detectaron permisos de administrador en {system}. Solicitando elevación...")
            success = relaunch_as_admin()
            if success:
                # La nueva instancia elevada ya se está abriendo; cerramos esta sin permisos.
                sys.exit(0)
            else:
                print("El usuario canceló la elevación o falló. Continuando sin permisos de administrador.")
                # Seguimos corriendo: algunas carpetas de sistema simplemente se saltarán al limpiar.
        else:
            print(f"Running as admin on {system}.")

# Function to clear a folder by removing all its contents
# Function para limpiar una carpeta para remover todo su contenido
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
    optimization_system()