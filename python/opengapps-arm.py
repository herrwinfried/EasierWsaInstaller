import requests
import json
import wget

gappsarch = "arm64"
gappsandroid = "11.0"
gappsvariant = "pico"

res = requests.get(f"https://api.opengapps.org/list")
j = json.loads(res.content)
link = {i["name"]: i for i in j["archs"][gappsarch]["apis"]
        [gappsandroid]["variants"]}[gappsvariant]["zip"]
print(f"downloading link: {link}", flush=True)


def bar_custom(current, total, width=80):
    print("OpenGapps Downloading: %d%% [%d / %d] bytes" %
          (current / total * 100, current, total))


wget.download(link, bar=bar_custom)
