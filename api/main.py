import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from firebase_db import gcp_firebase

app = FastAPI()

origins = [
    'https://visitor-api-demnfidg2a-uc.a.run.app'
]
if os.environ.get('DEV', None):
    origins.append('http://localhost')

@app.get("/")
def main():
    return {"Hello": "World"}

@app.get("/visitor")
def get_visitor():
    return {"visitorCount": gcp_firebase.get_visitor_count()}

@app.post("/visitor")
def set_visitor():
    gcp_firebase.increment_visitor_count()

    