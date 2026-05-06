import os
from fastapi import FastAPI
from core import scanner

app = FastAPI()

@app.get("/")
def main_function():
    return "PureCode app is running its api"

@app.get('/scan')
def return_scan():

    result = scanner.scan_file()
    return 'success', result



