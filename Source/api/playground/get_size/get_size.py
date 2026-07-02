import os 

def get_size(path):
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

def show_gb(path):
    bytes_size = get_size(path)
    gb_size = bytes_size / (1024 ** 3)
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
print("\nCleaning...")
