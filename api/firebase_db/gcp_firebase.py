import os
import logging
from firebase_admin import db, initialize_app

logger = logging.getLogger(__name__)

database = initialize_app(
    None, {'databaseURL': 'https://cloudresume-380001-default-rtdb.firebaseio.com/'})
database_ref = db.reference('/')

def seed(reset=False):
    visitor_count = database_ref.get()
    if visitor_count is None:
        database_ref.set({"visitorCount": 0})
    else:
        count = visitor_count.get("visitorCount")
        if count > 0 and reset is False:
            raise Exception("There's already data here!")
        else:
            database_ref.set({"visitorCount": 0})

def get_visitor_count() -> int:
    return database_ref.get()["visitorCount"]

def increment_visitor_count():
    prev_count = database_ref.get()["visitorCount"]
    database_ref.update({"visitorCount": prev_count + 1})

if __name__ == '__main__':
    print("Running GCP Firebase Module")
    seed_flag = os.environ.get("RESET_DB", None)
    if seed_flag is not None and seed_flag.lower() == "true":
        print("Resetting database to 0")
        seed(True)
