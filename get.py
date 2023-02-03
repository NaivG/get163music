import os
from selenium import webdriver
from selenium.webdriver.common.by import By

music_url = os.environ.get('MUSIC_URL', "")
wd=webdriver.Chrome(r'D:\chromedriver.exe')
wd.get(music_url)
wd.switch_to.frame(0)
elements=wd.find_elements(By.XPATH,'//a[contains(@href,"/song?id")]')
name=[]
t=0
with open('.\output.txt', 'w', encoding='UTF8') as f:
    for i in elements:
        print(i.get_attribute('href')[30:], file=f)
        print(wd.find_elements(By.XPATH,'//b[@title]')[t].get_attribute('title'), file=f)
        t=t+1
