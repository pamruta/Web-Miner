# importing libraries
from bs4 import BeautifulSoup
import urllib2

# fetch html page from url
html_text = urllib2.urlopen("https://en.wikipedia.org/wiki/Jennifer_Aniston").read()

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

# handling of UTF-8 encoded characters
import sys
reload(sys)
sys.setdefaultencoding("UTF8")

# writing text to file
output_file = open("Aniston.txt", "w")
output_file.write(text)
