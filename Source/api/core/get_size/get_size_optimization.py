import os 
import json
import pathlib
import platform
import sys


if getattr(sys, 'frozen', False):
    BASE_DIR = pathlib.Path(sys.executable).parent # This is for create the .json when backend is .exe
else:
    BASE_DIR = pathlib.Path(__file__).parent  # This is for create in the same folder when we are working on backend.


FILE = BASE_DIR / 'data_size.json' # This is the file that will be created.

system = platform.system()

def get_size(path): # This function calculates the total size of files in a given directory and its subdirectories.
                    # Esta función calcula el tamaño total de los archivos en un directorio dado y sus subdirectorios.
    bytes_size = 0

    for root, dirs, files in os.walk(path):
        for file in files:
            file_path = os.path.join(root, file)
            try:
                size = os.stat(file_path).st_size
                bytes_size += size
            except FileNotFoundError:
                print(f"File not found: {file_path}")
    return bytes_size

def show_gb(path): # This function converts the size from bytes to gigabytes and returns it. 
                # Esta función convierte el tamaño de bytes a gigabytes y lo devuelve.
    bytes_size = get_size(path)
    gb_size = round(bytes_size / (1024 ** 3), 2) #We use round to limit the number of decimal places to 2.
    return gb_size

folder_to_clean = [
    os.environ.get('TEMP'),
    r"C:\Windows\Temp",
    r"C:\Windows\Prefetch"
]

print("Folder sizes before cleaning:")
for folder in folder_to_clean:
    if folder and os.path.exists(folder):
        size_gb = show_gb(folder)
        print(f"{folder}: {size_gb:.2f} GB")
    else: 
        print(f"{folder}: Path does not exist or is empty.")


if system == 'Windows':

    data = {
        "temp_folder_size": show_gb(os.environ.get('TEMP')),
        "windows_temp_size": show_gb(r"C:\Windows\Temp"),
        "windows_prefetch_size": show_gb(r"C:\Windows\Prefetch")
    }

elif system == 'Darwin':
    data = {
        "library_caches_size": show_gb(os.path.expanduser('~/Library/Caches')),
        "library_logs_size": show_gb(os.path.expanduser('~/Library/Logs')),
        "system_caches_size": show_gb("/Library/Caches"),
        "system_logs_size": show_gb("/Library/Logs")
    }
    
    
with open(FILE, 'w') as f:
    json.dump(data, f, indent=4)
    print("Data written to data.json successfully.")

