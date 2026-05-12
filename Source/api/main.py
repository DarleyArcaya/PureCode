from fastapi import FastAPI
from core import gradle_caches, android_caches

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

