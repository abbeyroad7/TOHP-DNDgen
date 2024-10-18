#!/usr/bin/env python3
from bs4 import BeautifulSoup
import requests

url = input('URL ')
page = requests.get(url)

# Scrape webpage
soup = BeautifulSoup(page.content, 'lxml')
list_items = soup.select('.mw-parser-output > ul > li')
for list_item in list_items:
    print(list_item.text)

input()