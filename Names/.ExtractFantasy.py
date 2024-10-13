#!/usr/bin/env python3
from bs4 import BeautifulSoup
import requests

# url = input('URL ')
url = 'https://www.fantasynamegenerators.com/dnd-duergar-names.php'
page = requests.get(url)

# Parse the HTML with BeautifulSoup
soup = BeautifulSoup(page.text, 'lxml')
soup.find(id="result")

# Print the body tag's content
print(soup.prettify())
input()