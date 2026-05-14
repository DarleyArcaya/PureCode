from fastapi import FastAPI
from core import gradle_caches, android_caches, flutter_caches

app = FastAPI()

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