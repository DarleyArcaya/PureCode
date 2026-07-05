import sys
import os
import requests
import platform
# =====================================================================
# PASO 0: PARCHE CRÍTICO DE INICIALIZACIÓN (Milisegundo Cero) 
# STEP 0: CRITICAL INITIALIZATION PATCH (Zero Millisecond)
# =====================================================================

if getattr(sys, 'frozen', False):
    # En modo --onefile, todos los archivos se descomprimen en _MEIPASS temporalmente
    # in --onefile mode, all files are unpacked into _MEIPASS temporarily
    base_dir = sys._MEIPASS

    # Registramos las rutas internas temporales de las librerías
    # We register the temporary internal paths of the libraries
    sys.path.append(base_dir)
    sys.path.append(os.path.join(base_dir, "pydantic_core"))

    # Importamos de forma dinámica el archivo actual y lo registramos en el sistema de módulos
    # We dynamically import the current file and register it in the module system
    import main
    sys.modules['main'] = main

# =====================================================================
# PASO 1: IMPORTS NORMALES DE LA APLICACIÓN (Ahora sí están seguros)
# STEP 1: NORMAL APP IMPORTS (Now you are sure)
# =====================================================================

from fastapi import FastAPI
from core.caches_to_delete import android_caches, flutter_caches, gradle_caches, pip_caches
from core.optimosys import optimosys
from core.get_time import get_time_optimization
from core.get_size.get_size_optimization import show_gb
import uvicorn


app = FastAPI()


CURRENT_VERSION = "0.9.0"
VERSION_URL = "https://raw.githubusercontent.com/DarleyArcaya/PureCode/refs/heads/main/Source/api/updates/check_update.json"

@app.get('/check_updates')
def download_new_version():
    try:
        response = requests.get(VERSION_URL, timeout=5)
        response.raise_for_status() # Esto es para que no se ejecute si hay un error en la petición / This is for that the code doesn't run if there is an error in the request
        
        data = response.json() # Esto es para convertir el JSON en un diccionario / This is for convert the JSON to a dictionary

        remote_version = data.get('latest_version', "0.0.0")

        has_update = remote_version > CURRENT_VERSION

        return {
            "has_update": has_update,
            "current_version": CURRENT_VERSION,
            "latest_version": remote_version,
            "download_url": data.get("url_download", ""),
            "requiered": data.get("requiered_update", False)
        }
    
    except requests.RequestException as e:

        return {
            "has_update": False,
            "error": "No se pudo verificar la actualizacion"
        }
# =====================================================================
# PASO 2: TUS ENDPOINTS (Se quedan exactamente como los tenías)
# STEP 2: YOUR ENDPOINTS (They stay exactly as you had them)
# =====================================================================

# This endpoint will call all the cache cleaning functions and return their results in a single response
@app.get('/clean_all_caches')
def clean_all_caches():
    gradle_result = gradle_caches.remove_gradle_cashes('~/.gradle/caches/')
    android_result = android_caches.remove_android_caches('~/.android/cache')
    flutter_result = flutter_caches.clear_flutter_cache() # Cleans packages from pub.dev to save GBs, independent of Flutter version
    pip_result = pip_caches.clear_pip_caches()
    
    return {
        'message': 'All cache cleaning functions are working correctly',
        'gradle_result': gradle_result,
        'android_result': android_result,
        'flutter_result': flutter_result,
        'pip_result': pip_result
    }

@app.get("/")
def main_function():
    return "PureCode app is running its api"

@app.get('/gradle_caches')
def return_gradle_caches():
    result = gradle_caches.remove_gradle_cashes('~/.gradle/caches/')
    return 'Function is working correctly [removing gradle caches]', result

@app.get('/android_caches')
def return_android_caches():
    result = android_caches.remove_android_caches('~/.android/cache')
    return 'Function is working correctly [remove android caches]', result

@app.get('/flutter_caches')
def return_flutter_caches():
    result = flutter_caches.clear_flutter_cache() # Cleans packages from pub.dev to save GBs, independent of Flutter version
    return 'Function is working correctly [remove flutter caches]', result

@app.get('/pip_caches')
def return_pip_caches():
    result = pip_caches.clear_pip_caches()
    return 'Function is working correctly [remove pip caches]', result

@app.get('/optimization')
def return_optimization_system():
    result = optimosys.optimization_system()
    return 'Function is working correctly [remove optimization system]', result

@app.get('/last_optimization')
def return_last_optimization_date():
    result = get_time_optimization.last_optimization_date()
    return result

@app.get('/get_size')
def return_get_size():
    system = platform.system()

    data = {
        "temp_folder_size": 0.0,
        "windows_temp_size": 0.0,
        "windows_prefetch_size": 0.0,
        "library_caches_size": 0.0,
        "library_logs_size": 0.0,
        "system_caches_size": 0.0,
        "system_logs_size": 0.0
    }

    if platform == "Windows":
        data["temp_folder_size"] = show_gb.get_temp_folder_size()
        data["windows_temp_size"] = show_gb.get_windows_temp_size()
        data["windows_prefetch_size"] = show_gb.get_windows_prefetch_size()
    elif system == "Darwin":
        data["library_caches_size"] = show_gb.get_library_caches_size()
        data["library_logs_size"] = show_gb.get_library_logs_size()
        data["system_caches_size"] = show_gb.get_system_caches_size()
        data["system_logs_size"] = show_gb.get_system_logs_size()

    return data



# Define a custom logging configuration to disable uvicorn's default logging
# We created an empty log configuration to trick Uvicorn
# definimos una configuración de logging personalizada para desactivar el logging predeterminado de uvicorn
# Creamos una configuración de log vacía para engañar a Uvicorn
LOGGING_CONFIG = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {},
    "handlers": {},
    "loggers": {}
}



# =====================================================================
# PASO 3: ARRANQUE DEL SERVIDOR (Limpio y directo)
# STEP 3: SERVER BOOT (Clean and direct)
# =====================================================================
if __name__ == "__main__":
    
    # 2. SEGUNDO: Ahora que las rutas están perfectas, encendemos el servidor de Uvicorn
    # run the FastAPI app using uvicorn in a local way
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=False, log_config=LOGGING_CONFIG) 
    
    # To create an executable file using PyInstaller, you can use the following command in your terminal:
    # pyinstaller --onedir --noconsole --collect-all pydantic_core main.py
    # --onedir: Creates a single folder containing the executable and all dependencies.
    # --noconsole: Hides the console window when running the executable (useful).
    # --collect-all pydantic_core: Ensures that all necessary files from the pydantic_core package are included in the build, 
    # which is crucial for the FastAPI application to function correctly.

    # # 1. Limpieza rápida preventiva
    # Remove-Item -Recurse -Force build, dist
    # 2. Compilación forzada total: 
    # pyinstaller --onedir --noconsole --collect-all pydantic_core --collect-all pydantic --collect-all fastapi main.py
    # 3 Super Compilacion forzazda (si la anterior no funciona):
    # pyinstaller --onedir --noconsole --collect-all pydantic_core --collect-all pydantic --collect-all fastapi main.py
    # 4: Este es el comando definitivo
    # pyinstaller --onefile --noconsole --collect-all pydantic_core --collect-all pydantic --collect-all fastapi main.py