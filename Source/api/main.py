from fastapi import FastAPI
from core import gradle_caches, android_caches, flutter_caches, pip_caches

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