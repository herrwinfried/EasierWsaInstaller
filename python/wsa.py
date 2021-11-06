import requests
from bs4 import BeautifulSoup
import re
import wget
res = requests.post("https://store.rg-adguard.net/api/GetFiles", "type=CategoryId&url=858014f3-3934-4abe-8078-4aa193e74ca8&ring=WIS&lang=en-US", headers={
    "content-type": "application/x-www-form-urlencoded"
})
html = BeautifulSoup(res.content, "lxml")
a = html.find("a", string=re.compile(
    "MicrosoftCorporationII\.WindowsSubsystemForAndroid_.*\.msixbundle"))
link = a["href"]
def bar_custom(current, total, width=80):
    print("WSA Downloading: %d%% [%d / %d] bytes" % (current / total * 100, current, total))
wget.download(link, bar=bar_custom)