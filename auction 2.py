# -*- coding: utf-8 -*-
"""
Created on Thu Dec  6 12:27:08 2018

@author: ktm
"""

import requests as rq
from bs4 import BeautifulSoup 
import lxml
url = "http://browse.auction.co.kr/search?keyword={}&itemno=&nickname=&encKeyword={}&arraycategory=&frm=&dom=auction&isSuggestion=No&retry=".format("bag", "bag")
url

res = rq.get(url)
res.url
html = res.content
soup = BeautifulSoup(html, 'lxml')

#%% 타이틀 가져오기 
soup_item = soup.find_all("div", class_="section--itemcard")
soup_item[1]
num = len(soup_item)
num
#%%
title = []
price_sales = []
price_ori = []
company = []
for i in range(0, num):
    # 상품명
    soup_title = soup_item[i].find("span", class_="text--title")
    print(soup_title)
    if soup_title is not None:
        title_txt = soup_title.text
        title.append(title_txt)
    else:
        title.append("")
    
    # 상품가격(할인적용금액)
    soup_price = soup_item[i].find("strong", class_="text--price_seller")
    print(soup_price)
    if soup_price is not None:
        price_txt = soup_price.text
        price_sales.append(price_txt)
    else:
        price_sales.append("")
    
    # 상품가격(원래 금액)
    soup_price_ori = soup_item[i].find("strong", class_="text--price_original")
    print(soup_price_ori)
    if soup_price_ori is not None:
        price_ori_txt = soup_price_ori.text
        price_ori.append(price_ori_txt)   
    else:
        price_ori.append("")

    # 회사
    soup_company = soup_item[i].find("span", class_="text")
    print(soup_company)
    if soup_company is not None:
        soup_company_txt = soup_company.text
        company.append(soup_company_txt)   
    else:
        company.append("스마일배송")

 # 사업자 상호 
#%%
import pandas as pd

print(title, len(title))
print(price_sales, len(price_sales))
print(price_ori, len(price_ori))
print(company, len(company))

title1 = pd.Series(title)
price_sales1 = pd.Series(price_sales)
price_ori1 = pd.Series(price_ori)
company_name = pd.Series(company)
#%% 
dat = pd.DataFrame({ "title" : title , 
                   "price_sales" : price_sales, 
                   "price_origin" : price_ori,
                   "company_name" : company }, columns=['title','price_sales','price_origin', "company_name"] )
dat

#dat.to_csv("company_info.csv", index=False, encoding="utf-8")  # MAC 유저
dat.to_csv("company_info.csv", index=False, encoding="EUCKR")  # Window EXCEL 한글 볼 때


# ===================
import mysql.connector

#%%
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="qwer1234",
  database="mydatabase"
)

mycursor = mydb.cursor()

# DB데이터 넣기
for row in dat.values.tolist():
    line = row
    mycursor.execute("INSERT INTO Auction_Bag_A (title, price_sales, price_origin, company_name) VALUES(%s, %s, %s, %s)", line)
    print(row)

mydb.commit()

# 롿확인

mycursor.execute("SELECT * FROM Auction_Bag_A")
myresult = mycursor.fetchall()
for x in myresult:
    print(x)

## 수행 절차 
    # 
