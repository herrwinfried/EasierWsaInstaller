
import requests
from bs4 import BeautifulSoup
import re
import wget

wsarelease = "retail"

wsar1 = "fast"
wsar2 = "slow"
wsar3 = "rp"
wsar4 = "retail"

arch = "x64"
arch1 = "x64"
arch2 = "arm64"
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("-r", "--release", nargs='?', const=wsarelease, default=wsarelease, choices=[wsar1, wsar2, wsar3, wsar4])
parser.add_argument("-a", "--arch", nargs='?', const=arch, default=arch, choices=[arch1, arch2])
args = parser.parse_args()

#if args.arch == armvg:
res = requests.post("https://store.rg-adguard.net/api/GetFiles", "type=CategoryId&url=858014f3-3934-4abe-8078-4aa193e74ca8&ring="+args.release+"&lang=en-US", headers={
    "content-type": "application/x-www-form-urlencoded"
})
html = BeautifulSoup(res.content, "lxml")
outfile = "vclibs.appx"
a = html.find("a", string=re.compile(
    f"Microsoft\.VCLibs\..*_{args.arch}_.*\.appx"))
link = a["href"]
def bar_custom(current, total, width=80):
    print("WSA Downloading: %d%% [%d / %d] bytes" % (current / total * 100, current, total))
print("\n=============================VCLIBS Download====================================================")
wget.download(link, outfile)
print("\n=====================================================================================================")