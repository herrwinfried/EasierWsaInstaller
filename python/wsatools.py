import requests
from bs4 import BeautifulSoup
import re
import wget
res = requests.post("https://store.rg-adguard.net/api/GetFiles", "type=CategoryId&url=7d949c6e-f0df-4325-b022-9e031ff18885&ring=WIS&lang=en-US", headers={
    "content-type": "application/x-www-form-urlencoded"
})
html = BeautifulSoup(res.content, "lxml")

a = html.find("a", string=re.compile(
    "54406Simizfo\.WSATools(.)*\.msixbundle"))
link = a["href"]
def bar_custom(current, total, width=80):
    print("WSATools Downloading: %d%% [%d / %d] bytes" % (current / total * 100, current, total))
wget.download(link, a.string, bar=bar_custom)