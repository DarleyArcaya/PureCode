import os
from fastapi import FastAPI
from Source.api.core import gradle_caches

app = FastAPI()

@app.get("/")
def main_function():
    return "PureCode app is running its api"

@app.get('/scan')
def return_removing():

    result = gradle_caches.removing('~/.gradle/caches/')
    return 'cache removed', result
