# coding=UTF-8
import sys
from subprocess import call
import os
import requests
import json

fold_address = os.environ.get('batpath',"")
bat_name = os.environ.get('downloadmodule',"")

downmode = os.environ.get('downmode', "")
if downmode == 'false':
    id = os.environ.get('ID', "")
    dlyric = os.environ.get('dlyric', "")
    runmode = os.environ.get('runmode', "")
    artist = os.environ.get('artist', "")
else:
    id = sys.argv[1]
    dlyric = sys.argv[2]
    runmode = sys.argv[3]
    artist = sys.argv[4]
    downmode = 'true'

print("downloadmodule:"+fold_address+bat_name)


res_music = requests.get('https://api.injahow.cn/meting/?type=song&id='+id)
json_music = res_music.json()
json_str = json.dumps(json_music,indent=2,ensure_ascii=False)
temp_dict = json.loads(json_str)

name=temp_dict[0]['name'] + ' - ' + temp_dict[0]['artist']
name=name.replace("/","、")
name=name.replace("|","、")

cmdline = [fold_address+'bin/'+bat_name,id,name,dlyric,runmode,artist,downmode]

rc = call(cmdline, cwd=fold_address)