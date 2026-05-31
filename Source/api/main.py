from fastapi import FastAPI
from core import gradle_caches, android_caches, flutter_caches, pip_caches
import uvicorn
import sys

app = FastAPI()

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

# Define a custom logging configuration to disable uvicorn's default logging
# We created an empty log configuration to trick Uvicorn
LOGGING_CONFIG = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {},
    "handlers": {},
    "loggers": {}
}

if __name__ == "__main__":
    # 1. PRIMERO: Si está empaquetado, arreglamos las rutas y registramos el módulo 'main'
    if getattr(sys, 'frozen', False):
        sys.path.append(sys._MEIPASS)
        # Importamos de forma dinámica el archivo actual y lo registramos en el sistema de módulos
        import main
        sys.modules['main'] = main

    # 2. SEGUNDO: Ahora que las rutas están perfectas, encendemos el servidor de Uvicorn
    # run the FastAPI app using uvicorn in a local way
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=False, log_config=LOGGING_CONFIG) 
    
    # To create an executable file using PyInstaller, you can use the following command in your terminal:
    # pyinstaller --onedir --noconsole --collect-all pydantic_core main.py
    # --onedir: Creates a single folder containing the executable and all dependencies.
    # --noconsole: Hides the console window when running the executable (useful).
    # --collect-all pydantic_core: Ensures that all necessary files from the pydantic_core package are included in the build, 
    # which is crucial for the FastAPI application to function correctly.