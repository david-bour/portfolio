from fastapi import FastAPI
from firebase_db import gcp_firebase

app = FastAPI()

@app.get("/")
def main():
    return {"Hello": "World"}

@app.get("/visitor")
def get_visitor():
    return {"visitorCount": gcp_firebase.get_visitor_count()}

@app.post("/visitor")
def set_visitor():
    gcp_firebase.increment_visitor_count()

    