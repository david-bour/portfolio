import requests
import random
import re
from bs4 import BeautifulSoup
from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")

templates = Jinja2Templates(directory="templates")

def randomizer():
    identifier = random.randrange(1, 2000)
    response = requests.get(f"https://xkcd.com/{identifier}/")
    soup = BeautifulSoup(response.text, 'html.parser')
    comic_url = "https://imgs.xkcd.com/comics/barrel_cropped_(1).jpg"
    result = soup.find(string=re.compile("hotlinking")).findNext('a')
    if result:
        comic_url = result.get('href')
    return comic_url, identifier

@app.get("/", response_class=HTMLResponse)
async def main(request: Request):
    url, identifier = randomizer()
    return templates.TemplateResponse(
        "main.html", {"request": request, "img": url, "number": identifier})
