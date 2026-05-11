import os


def removing(file_path):
    try:
        if os.path.exists(file_path):
            os.rmdir(file_path)
            print(f'{file_path} has been removed successfully')
        else:
            print('file does not exist')
    except PermissionError:
        print("Permission denied")
    except Exception as e:
        print(e)
        
removing('~/.gradle/caches/')


