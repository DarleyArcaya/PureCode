from fastapi import FastAPI
import os

app = FastAPI()

@app.get('/scan')
def scan_file():
 
