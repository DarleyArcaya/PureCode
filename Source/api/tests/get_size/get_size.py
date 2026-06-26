import os 

def getting_size(file):
    for file in os.listdir():
        print(os.path.getsize(file))
        print('The file size is {path}')

getting_size('~/.gradle/caches/')
    
