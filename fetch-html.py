# fetches html page from a given web-url
# and converts it to plain-text

# Usage: python fetch-html.py WEB_URL

# Author: Amruta Purandare
# Last Updated: Apr 1, 2017

# importing libraries
from bs4 import BeautifulSoup
import urllib2

import sys
web_url = sys.argv[1]

# fetch html page from url
html_text = urllib2.urlopen(web_url).read()

soup = BeautifulSoup(html_text, "html.parser")
text = ""

# stripping <script> tags from html
for script in soup.find_all("script"):
  soup.script.extract()

# extracting text from html paragraphs
for para in soup.find_all("p"):
  if text == "":
    text = para.get_text()
  else:
    text = text + "\n\n" + para.get_text()

# removing wiki-references
import re
text = re.sub(r'\[\d+\]', "", text)

# handling UTF-8 encoded characters
reload(sys)
sys.setdefaultencoding("UTF-8")

# printing text to std-out
print text
