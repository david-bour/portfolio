import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from firebase_db import gcp_firebase

app = FastAPI()

origins = [
    'https://davidbour.com',
    'https://www.davidbour.com',
    'https://api.davidbour.com'
]
if os.environ.get('DEV', None):
    origins.append('http://localhost')

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def main():
    return {"Hello": "World"}

@app.get("/info")
def info():
    return os.environ.get('GITSHA', 'NONE')

@app.get("/visitor")
def get_visitor():
    return {"visitorCount": gcp_firebase.get_visitor_count()}

@app.post("/visitor")
def set_visitor():
    gcp_firebase.increment_visitor_count()

    