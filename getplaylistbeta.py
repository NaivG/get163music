import os
import requests
import json

playlist_id = os.environ.get('PLAYLIST_ID', "")
res_music = requests.get('https://api.injahow.cn/meting/?type=playlist&id='+playlist_id)

json_music = res_music.json()
with open('output.txt',"w",encoding="utf-8") as f:
    for i in json_music:
        print(i['url'][58:],file=f)
        print(i['name']+' - '+i['artist'],file=f)
