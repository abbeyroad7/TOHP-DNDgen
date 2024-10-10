#!/usr/bin/env python3
import requests
from bs4 import BeautifulSoup

BASE_URL = "https://en.wikipedia.org"
URL = "https://en.wikipedia.org/wiki/List_of_animal_names"

soup = BeautifulSoup(requests.get(URL).content, "html.parser")

# The following will find all `a` tags under the fifth `td` of it's type, which is the fifth column
for tag in soup.select("td:nth-of-type(1) a"):
   print(BASE_URL + tag["href"])

input()