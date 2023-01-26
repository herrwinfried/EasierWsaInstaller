import requests
import json
import wget
import sys

armvg = "arm"
amd64vg = "x86_64"
amd64vg2 = "x64"

gappsvariant = "pico"
gappsandroid = "11.0"

import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-a", "--arch", nargs='?', const=amd64vg, default=amd64vg, choices=[armvg, amd64vg, amd64vg2])
parser.add_argument("-va", "--variant", nargs='?', const=gappsvariant, default=gappsvariant, choices=["super", "stock", "full", "mini", "micro", "nano", "pico"])
args = parser.parse_args()

if args.arch == armvg:
        gappsarch = armvg
elif args.arch == amd64vg or args.arch == "x64":
        gappsarch = amd64vg
else:
        print("ERROR !!!")

if args.variant == "pico":
         gappsvariant == "pico"
else:
        gappsvariant == args.variant


res = requests.get(f"https://api.opengapps.org/list")
j = json.loads(res.content)
link = {i["name"]: i for i in j["archs"][gappsarch]["apis"]
        [gappsandroid]["variants"]}[gappsvariant]["zip"]
def bar_custom(current, total, width=80):
    print("OpenGapps Downloading: %d%% [%d / %d] bytes" %
          (current / total * 100, current, total))

print("Arch: "+ gappsarch)
print("Android: " + gappsandroid)
print("Variant: " + gappsvariant)
print("\n=============================OpenGapps Download====================================================")
wget.download(link)
print("\n=====================================================================================================")