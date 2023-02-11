# coding=utf-8
import os
import requests
import json

Sheaders = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/109.0"
}

lyric_url = os.environ.get('LYRIC_URL', "")
lyric_name = os.environ.get('LYRIC_NAME', "")

print("从 " + lyric_url + " 中获取歌词信息")
req = requests.get(lyric_url, timeout=30, headers = Sheaders)
lyric_json = req.json()
json_str = json.dumps(lyric_json,indent=2,ensure_ascii=False)
temp_dict = json.loads(json_str)
print("获取成功，正在转码...")
with open('./music/' + lyric_name, "w", encoding="utf-8") as f:
    print(temp_dict["lyric"],file=f)
print("保存至" + lyric_name)
