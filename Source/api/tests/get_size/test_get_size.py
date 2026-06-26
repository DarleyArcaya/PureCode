import os 

def test_getting_size(file):
    for file in os.listdir():
        print(os.path.getsize(file))
        print('The file size is {path}')

test_getting_size('~/.gradle/caches/')
    
