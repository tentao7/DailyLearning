
### 과제 : 쇼핑몰자사제품경쟁사데이터수집
저는 작은 쇼핑몰을 운영하고 있는 대표입니다. 경쟁업체의가방목록과리
스트를수집하려고합니다. 옥션 등의 쇼핑몰에서 bag이라는 단어로 검색
후, 리스트와 목록을 수집해 주세요. 이 제품 리스트와 기타 정보를 MySQL에 넣어, 이에 대한 데이터 검증까
지 수행하는 절차를 수행해 주세요.

###  데이터 수집


```python
import requests as rq
from bs4 import BeautifulSoup
#%% utf-8로 인코딩
## url = "http://browse.auction.co.kr/search?keyword=%EC%97%AC%EC%84%B1%EC%9D%98%EB%A5%98&itemno=&nickname=&encKeyword=%25EC%2597%25AC%25EC%2584%25B1%25EC%259D%2598%25EB%25A5%2598&arraycategory=&frm=&dom=auction&isSuggestion=No&retry="
url = "http://browse.auction.co.kr/search?keyword={}&itemno=&nickname=&encKeyword={}&arraycategory=&frm=&dom=auction&isSuggestion=No&retry=".format("bag", "bag")
url
```




    'http://browse.auction.co.kr/search?keyword=bag&itemno=&nickname=&encKeyword=bag&arraycategory=&frm=&dom=auction&isSuggestion=No&retry='




```python


res = rq.get(url)
res.url
html = res.content
soup = BeautifulSoup(html, 'lxml')

#%% 타이틀 가져오기 
soup_item = soup.find_all("div", class_="section--itemcard")
soup_item[1]
num = len(soup_item)
num
```




    88




```python
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
        
        
```

    <span class="text--title">미스터보울러 여행용 캐리어/여행가방/19900원부터<!-- --> </span>
    <strong class="text--price_seller">29,900</strong>
    <strong class="text--price_original">99,000</strong>
    <span class="text">미스터보울러</span>
    <span class="text--title">DELSEY 델시 VAVIN 바뱅 캐리어 3종 세트 (21+28형)<!-- --> </span>
    <strong class="text--price_seller">240,000</strong>
    <strong class="text--price_original">327,600</strong>
    <span class="text">DelseyKor</span>
    <span class="text--title">여행가방 보스턴백 캠핑가방 보조가방 여행용 가방 백<!-- --> </span>
    <strong class="text--price_seller">12,800</strong>
    <strong class="text--price_original">42,500</strong>
    <span class="text">트렌다</span>
    <span class="text--title">(비버리힐즈폴로) 정품 남녀공용 백팩/기저귀가방<!-- --> </span>
    <strong class="text--price_seller">36,900</strong>
    None
    <span class="text">폴로클럽백</span>
    <span class="text--title">남성 서류 가방 모음 직장인 고급 가벼운 토트 20 30<!-- --> </span>
    <strong class="text--price_seller">92,940</strong>
    None
    <span class="text">지오스토어</span>
    <span class="text--title">여행 보조가방 여행용가방 멀티백 허리가방 힙색 가방<!-- --> </span>
    <strong class="text--price_seller">5,840</strong>
    <strong class="text--price_original">5,900</strong>
    <span class="text">베스트100스토어</span>
    <span class="text--title">탑킹 백팩 TKGMB-02 Backpack 가방 스포츠백 격투기<!-- --> </span>
    <strong class="text--price_seller">140,580</strong>
    <strong class="text--price_original">142,000</strong>
    <span class="text">아이노스11</span>
    <span class="text--title">크로스백 슬링백 백팩 가방 엘레모 국산캐주얼백 블랙<!-- --> </span>
    <strong class="text--price_seller">29,800</strong>
    None
    <span class="text">나비몰</span>
    <span class="text--title">패션펫 가방-요키(25cm)/행사사은품 완구점판매<!-- --> </span>
    <strong class="text--price_seller">28,900</strong>
    None
    <span class="text">세븐굿즈닷컴</span>
    <span class="text--title">리퍼 가방끈 어깨끈 패드/밸크로/메모리폼쿠션/스트랩<!-- --> </span>
    <strong class="text--price_seller">8,000</strong>
    None
    <span class="text">제이디텍</span>
    <span class="text--title">리퍼 가방끈 어깨끈 패드/메모리폼쿠션 스트랩/파우치<!-- --> </span>
    <strong class="text--price_seller">2,800</strong>
    None
    <span class="text">제이디텍</span>
    <span class="text--title">울프베이스 크로스백 자전거 가방 레저 취미 스포츠<!-- --> </span>
    <strong class="text--price_seller">17,100</strong>
    None
    <span class="text">매트릭스클럽</span>
    <span class="text--title">캐리어 여행용 28인치 가방/미트롤리 프리미엄 2세대<!-- --> </span>
    <strong class="text--price_seller">119,000</strong>
    <strong class="text--price_original">126,600</strong>
    None
    <span class="text--title">캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대<!-- --> </span>
    <strong class="text--price_seller">99,000</strong>
    <strong class="text--price_original">105,320</strong>
    None
    <span class="text--title">샤오미 인텔리 백팩/남성 여성 남자 여자 여행용 가방<!-- --> </span>
    <strong class="text--price_seller">69,510</strong>
    <strong class="text--price_original">73,950</strong>
    None
    <span class="text--title">메신저백 크로스백 힙색 슬링백 미니 여행 보조 가방<!-- --> </span>
    <strong class="text--price_seller">16,550</strong>
    <strong class="text--price_original">17,610</strong>
    None
    <span class="text--title">캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대<!-- --> </span>
    <strong class="text--price_seller">99,000</strong>
    <strong class="text--price_original">105,320</strong>
    None
    <span class="text--title">캐리어 여행용 20인치 가방/미트롤리 프리미엄 2세대<!-- --> </span>
    <strong class="text--price_seller">79,900</strong>
    <strong class="text--price_original">85,000</strong>
    None
    <span class="text--title">연말찬스 인기브랜드 캐리어 여행용캐리어 여행가방<!-- --> </span>
    <strong class="text--price_seller">29,800</strong>
    <strong class="text--price_original">99,000</strong>
    <span class="text">브라이튼몰</span>
    <span class="text--title">미스터보울러 여행용 캐리어/여행가방/19900원부터<!-- --> </span>
    <strong class="text--price_seller">29,900</strong>
    <strong class="text--price_original">99,000</strong>
    <span class="text">미스터보울러</span>
    <span class="text--title">덕다운 오리털 롱패딩 PYB-2 남녀공용/빅사이즈/남여<!-- --> </span>
    <strong class="text--price_seller">84,900</strong>
    <strong class="text--price_original">283,000</strong>
    <span class="text">마틴콕스공식몰</span>
    <span class="text--title">락앤락 별자리 텀블러 400ml+선물가방 보온병 물병<!-- --> </span>
    <strong class="text--price_seller">11,700</strong>
    <strong class="text--price_original">15,170</strong>
    <span class="text">리빙코디</span>
    <span class="text--title">천연소가죽 슬링백/크로스백/핸드폰가방 득템기회<!-- --> </span>
    <strong class="text--price_seller">13,900</strong>
    <strong class="text--price_original">46,300</strong>
    <span class="text">블루캣츠TM</span>
    <span class="text--title">겨울여행준비 인기 여행용캐리어 확장형 여행가방<!-- --> </span>
    <strong class="text--price_seller">39,800</strong>
    <strong class="text--price_original">131,800</strong>
    <span class="text">말렘</span>
    <span class="text--title">여행용 캐리어 20/24 인기상품 특별 할인가 여행가방<!-- --> </span>
    <strong class="text--price_seller">32,800</strong>
    <strong class="text--price_original">36,800</strong>
    <span class="text">에다스</span>
    <span class="text--title">/추가금없음/모두19800원/여성백팩/책가방/학생가방/<!-- --> </span>
    <strong class="text--price_seller">19,800</strong>
    None
    <span class="text">유니크클럽</span>
    <span class="text--title">익사이티드 3포켓 캐주얼 숄더백/크로스백<!-- --> </span>
    <strong class="text--price_seller">12,900</strong>
    None
    <span class="text">마마즈홈</span>
    <span class="text--title">여행용캐리어 케리어 기내용 20인치24인치28인치 가방<!-- --> </span>
    <strong class="text--price_seller">49,000</strong>
    None
    <span class="text">페더스</span>
    <span class="text--title">/균일가/최고급퀄리티/품질보장/백팩/학생가방/책가방<!-- --> </span>
    <strong class="text--price_seller">19,800</strong>
    None
    <span class="text">유니크클럽</span>
    <span class="text--title">쇼퍼백 숄더백 크로스백 빅백 여성 가방 여자 가죽 양<!-- --> </span>
    <strong class="text--price_seller">25,700</strong>
    None
    <span class="text">아띠꼴로</span>
    <span class="text--title">한정특가캐리어28인치케리어여행가방<!-- --> </span>
    <strong class="text--price_seller">49,900</strong>
    None
    <span class="text">tratag</span>
    <span class="text--title">신상디자인/여성가방/숄더백/미니백/크로스백/핸드백/<!-- --> </span>
    <strong class="text--price_seller">17,800</strong>
    None
    <span class="text">유니크클럽</span>
    <span class="text--title">2018년형 헨즈 통돌이 오븐 HT-2000 가방 집게 증정<!-- --> </span>
    <strong class="text--price_seller">139,500</strong>
    None
    <span class="text">미래가전5395</span>
    <span class="text--title">/브랜드정품/백팩/책가방/학생가방/남성여성학생백팩/<!-- --> </span>
    <strong class="text--price_seller">19,800</strong>
    None
    <span class="text">유니크클럽</span>
    <span class="text--title">/정품/나염가방/기저귀가방/여성백팩/크로스백/숄더백<!-- --> </span>
    <strong class="text--price_seller">19,800</strong>
    None
    <span class="text">유니크클럽</span>
    <span class="text--title">/고급서류가방/크로스백/남성가방/남자가방/메신저백/<!-- --> </span>
    <strong class="text--price_seller">17,800</strong>
    None
    <span class="text">유니크클럽</span>
    <span class="text--title">국산명품퀄리티/여성가방/숄더백핸드백쇼퍼백크로스백<!-- --> </span>
    <strong class="text--price_seller">17,800</strong>
    None
    <span class="text">유니크클럽</span>
    <span class="text--title">남자 여행용 노트북 백팩 책가방 학생가방 신학기<!-- --> </span>
    <strong class="text--price_seller">26,500</strong>
    <strong class="text--price_original">26,600</strong>
    <span class="text">휠코</span>
    <span class="text--title">프리미엄 다운 공용 롱패딩 벤치코트<!-- --> </span>
    <strong class="text--price_seller">65,900</strong>
    <strong class="text--price_original">66,000</strong>
    <span class="text">가나안커머스</span>
    <span class="text--title">접이식욕조/반신욕조/족욕기/이동식욕조/가방증정<!-- --> </span>
    <strong class="text--price_seller">99,190</strong>
    <strong class="text--price_original">109,000</strong>
    <span class="text">최우수판매자</span>
    <span class="text--title">캐리어 여행용 28인치 가방/미트롤리 프리미엄 2세대<!-- --> </span>
    <strong class="text--price_seller">119,000</strong>
    <strong class="text--price_original">126,600</strong>
    None
    <span class="text--title">크로스백/서류가방/메신저백/학생가방/책가방남성가방<!-- --> </span>
    <strong class="text--price_seller">17,800</strong>
    None
    <span class="text">유니크클럽</span>
    <span class="text--title">역대급할인~ 인기 여행용캐리어 확장형 여행가방<!-- --> </span>
    <strong class="text--price_seller">29,800</strong>
    <strong class="text--price_original">99,000</strong>
    <span class="text">백토리스트</span>
    <span class="text--title">쿠폰가 11만원대~ 닥스/헤지스키즈 신상 책가방SET<!-- --> </span>
    <strong class="text--price_seller">122,550</strong>
    <strong class="text--price_original">200,000</strong>
    <span class="text">pastelworld</span>
    <span class="text--title">BG-37 AXE 정품 여성 사계절 트렌디 백팩 여자 가방<!-- --> </span>
    <strong class="text--price_seller">87,800</strong>
    None
    <span class="text">G3글로벌</span>
    <span class="text--title">무료배송 캐주얼백팩 남자 여성 백팩 학생가방<!-- --> </span>
    <strong class="text--price_seller">16,900</strong>
    <strong class="text--price_original">17,900</strong>
    <span class="text">애드에딧</span>
    <span class="text--title">오리발+가방+핀서포트 마레스 아반티엑셀SET-WHT<!-- --> </span>
    <strong class="text--price_seller">93,060</strong>
    <strong class="text--price_original">99,000</strong>
    <span class="text">롯데닷컴</span>
    <span class="text--title">3일특가 쿠잉 캐리어/여행가방/여행용/케리어/기내용<!-- --> </span>
    <strong class="text--price_seller">34,900</strong>
    <strong class="text--price_original">39,800</strong>
    <span class="text">씨엔마켓</span>
    <span class="text--title">Ella(엘라)_PH8BSPELA301BLK<!-- --> </span>
    <strong class="text--price_seller">169,000</strong>
    None
    <span class="text">롯데닷컴</span>
    <span class="text--title">홈쇼핑 방송상품 아메리칸투어리스터 캐리어 5종세트<!-- --> </span>
    <strong class="text--price_seller">198,000</strong>
    None
    <span class="text">롯데닷컴</span>
    <span class="text--title">브런스윅 뉴 퀼트 쓰리 in ONE 롤러백/볼링가방/4볼백<!-- --> </span>
    <strong class="text--price_seller">193,050</strong>
    <strong class="text--price_original">195,000</strong>
    <span class="text">최우수판매자</span>
    <span class="text--title">노메이커특가 여성가방 미니백/클러치백/크로스백<!-- --> </span>
    <strong class="text--price_seller">15,900</strong>
    None
    <span class="text">직공닷컴</span>
    <span class="text--title">미국직수입 토리버치 미니토트/크로스백 5종 모음<!-- --> </span>
    <strong class="text--price_seller">390,000</strong>
    None
    <span class="text">슈슈퀸즈</span>
    <span class="text--title">디지털키보드/전자피아노 가방+받침대+의자풀세트 5종<!-- --> </span>
    <strong class="text--price_seller">69,900</strong>
    <strong class="text--price_original">107,600</strong>
    <span class="text">하이코스</span>
    <span class="text--title">남여공용 크로스백/가방/남성/남자/여성/학생가방<!-- --> </span>
    <strong class="text--price_seller">15,900</strong>
    <strong class="text--price_original">16,000</strong>
    <span class="text">YJCOMMERCE</span>
    <span class="text--title">균일가 신상품백팩 남성 여성 여행 학생백팩 책가방<!-- --> </span>
    <strong class="text--price_seller">17,900</strong>
    <strong class="text--price_original">59,600</strong>
    <span class="text">케이프리</span>
    <span class="text--title">2019 새해맞이 캐리온 여행가방 세트구성 + 사은품<!-- --> </span>
    <strong class="text--price_seller">32,900</strong>
    <strong class="text--price_original">109,500</strong>
    <span class="text">트래블메이트</span>
    <span class="text--title">내셔널지오그래픽 캐리어 세트 N6604P4 스페이스 캐리어 24형 20형<!-- --> </span>
    <strong class="text--price_seller">258,390</strong>
    <strong class="text--price_original">287,100</strong>
    <span class="text">신세계몰</span>
    <span class="text--title">프리미엄 백화점동일 브랜드 PC여행용캐리어 여행가방<!-- --> </span>
    <strong class="text--price_seller">97,000</strong>
    <strong class="text--price_original">224,000</strong>
    <span class="text">브라이튼몰</span>
    <span class="text--title">썸덱스 모아레 여행가방 8종<!-- --> </span>
    <strong class="text--price_seller">83,550</strong>
    <strong class="text--price_original">89,000</strong>
    <span class="text">K쇼핑</span>
    <span class="text--title">파세코 심지식 석유난로 PKH-5100/가방포함<!-- --> </span>
    <strong class="text--price_seller">161,200</strong>
    None
    <span class="text">예스전자</span>
    <span class="text--title">BEANPOLE KIDS  라이트 핑크 러블리 빙키 책가방 보조가방 SET (PS00113137Y)<!-- --> </span>
    <strong class="text--price_seller">168,890</strong>
    <strong class="text--price_original">200,000</strong>
    <span class="text">신세계몰</span>
    <span class="text--title">2019신제품 초등학생책가방 책가방세트 신학기책가방<!-- --> </span>
    <strong class="text--price_seller">49,410</strong>
    <strong class="text--price_original">54,900</strong>
    <span class="text">아이백몰</span>
    <span class="text--title">캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대<!-- --> </span>
    <strong class="text--price_seller">99,000</strong>
    <strong class="text--price_original">105,320</strong>
    None
    <span class="text--title">오후5시 이전 결제시 당일출고 남자백팩 남자가방<!-- --> </span>
    <strong class="text--price_seller">59,000</strong>
    None
    <span class="text">로예스</span>
    <span class="text--title">남자 여행용 노트북 백팩 책가방 학생가방 신학기<!-- --> </span>
    <strong class="text--price_seller">26,500</strong>
    <strong class="text--price_original">26,600</strong>
    <span class="text">휠코</span>
    <span class="text--title">인기 여행용 캐리어 TSA확장형 여행가방<!-- --> </span>
    <strong class="text--price_seller">29,800</strong>
    <strong class="text--price_original">98,800</strong>
    <span class="text">말렘</span>
    <span class="text--title">2종세트 특별할인 20+24형세트 여행가방 여행용캐리어<!-- --> </span>
    <strong class="text--price_seller">64,900</strong>
    <strong class="text--price_original">69,000</strong>
    <span class="text">브라이튼몰</span>
    <span class="text--title">새해맞이 캠브리지 캐리어/여행가방 17종+사은품<!-- --> </span>
    <strong class="text--price_seller">26,900</strong>
    <strong class="text--price_original">89,500</strong>
    <span class="text">트래블메이트</span>
    <span class="text--title">천연가죽크로스백50종/메신저백/슬링백/남성가방/벨라<!-- --> </span>
    <strong class="text--price_seller">15,900</strong>
    <strong class="text--price_original">30,000</strong>
    <span class="text">벨라(BELLA)</span>
    <span class="text--title">2018년형 헨즈 통돌이 오븐 HT-2000 가방 집게 증정<!-- --> </span>
    <strong class="text--price_seller">144,500</strong>
    None
    <span class="text">미래가전5395</span>
    <span class="text--title">HB-03 여성용 로퍼 토트백 여자 캐주얼 숄더백 가방<!-- --> </span>
    <strong class="text--price_seller">63,700</strong>
    None
    <span class="text">G3글로벌</span>
    <span class="text--title">anello 아넬로 여성백팩 패션백팩 남여공용 방수백<!-- --> </span>
    <strong class="text--price_seller">15,900</strong>
    <strong class="text--price_original">19,900</strong>
    <span class="text">HK골든브리지</span>
    <span class="text--title">버터플라이 신형 탁구라켓 펜홀더 쉐이크 탁구채 가방<!-- --> </span>
    <strong class="text--price_seller">44,900</strong>
    <strong class="text--price_original">45,000</strong>
    <span class="text">Goodsgym</span>
    <span class="text--title">인기 여행가방 캐리어 외 여행용품 특별할인 균일가<!-- --> </span>
    <strong class="text--price_seller">29,800</strong>
    None
    <span class="text">씨앤티스토리</span>
    <span class="text--title">남자가방 미니 슬링백 크로스백 힙색 메신저백 숄더백<!-- --> </span>
    <strong class="text--price_seller">37,500</strong>
    <strong class="text--price_original">40,000</strong>
    <span class="text">티오코리아</span>
    <span class="text--title"> 2019 초등학생 경량방수 책가방2종세트 호핑백 Earth_디자인선택친환경물통+동전지갑<!-- --> </span>
    <strong class="text--price_seller">118,730</strong>
    None
    <span class="text">롯데닷컴</span>
    <span class="text--title">뉴콕 캐리어 여행 가방 케리어 TSA락 확장형 20인치<!-- --> </span>
    <strong class="text--price_seller">21,900</strong>
    None
    <span class="text">newcoc2030</span>
    <span class="text--title">마젤란어스/메신저백 크로스백 힙색 학생 여행용 가방<!-- --> </span>
    <strong class="text--price_seller">15,800</strong>
    <strong class="text--price_original">17,800</strong>
    <span class="text">더블유팝</span>
    <span class="text--title">토요토미 옴니230SE+가방+상단망+주유기/캠핑난로<!-- --> </span>
    <strong class="text--price_seller">420,000</strong>
    None
    <span class="text">디지털</span>
    <span class="text--title">오늘하루초특가 신상 백팩/책가방/여행백팩/학생가방<!-- --> </span>
    <strong class="text--price_seller">17,900</strong>
    <strong class="text--price_original">30,000</strong>
    <span class="text">BAGBOSS1</span>
    <span class="text--title">트래블프로 이그제큐티브 쵸이스 17 비즈니스 캐리어<!-- --> </span>
    <strong class="text--price_seller">196,000</strong>
    <strong class="text--price_original">245,000</strong>
    <span class="text">(주)비박</span>
    <span class="text--title">천연소가죽 여성백팩47종/신상출시40%세일/가방/벨라<!-- --> </span>
    <strong class="text--price_seller">29,900</strong>
    None
    <span class="text">벨라(BELLA)</span>
    <span class="text--title">나이키 아디다스 언더아머 가방 팀백 백팩 더플백<!-- --> </span>
    <strong class="text--price_seller">22,500</strong>
    <strong class="text--price_original">74,600</strong>
    <span class="text">싸커누리</span>
    <span class="text--title">라이트 핑크 러블리 빙키 책가방보조가방 SET (PS00113137Y)<!-- --> </span>
    <strong class="text--price_seller">190,000</strong>
    <strong class="text--price_original">200,000</strong>
    <span class="text">롯데닷컴</span>
    <span class="text--title">항공커버+하드 캐리어 가방 24인치 여행용 S6504FP<!-- --> </span>
    <strong class="text--price_seller">175,420</strong>
    <strong class="text--price_original">179,000</strong>
    <span class="text">블랭블랭</span>
    <span class="text--title">서류가방/15.6인치 노트북가방/남성서류/남성가방<!-- --> </span>
    <strong class="text--price_seller">19,900</strong>
    <strong class="text--price_original">20,000</strong>
    <span class="text">YJCOMMERCE</span>
    <span class="text--title">2018 확장식 여행용백팩 17인치노트북수납 USB포트개선<!-- --> </span>
    <strong class="text--price_seller">74,900</strong>
    None
    <span class="text">가온나라</span>
    


```python
print(title, len(title))
print(price_sales, len(price_sales))
print(price_ori, len(price_ori))
print(company, len(company))
```

    ['미스터보울러 여행용 캐리어/여행가방/19900원부터 ', 'DELSEY 델시 VAVIN 바뱅 캐리어 3종 세트 (21+28형) ', '여행가방 보스턴백 캠핑가방 보조가방 여행용 가방 백 ', '(비버리힐즈폴로) 정품 남녀공용 백팩/기저귀가방 ', '남성 서류 가방 모음 직장인 고급 가벼운 토트 20 30 ', '여행 보조가방 여행용가방 멀티백 허리가방 힙색 가방 ', '탑킹 백팩 TKGMB-02 Backpack 가방 스포츠백 격투기 ', '크로스백 슬링백 백팩 가방 엘레모 국산캐주얼백 블랙 ', '패션펫 가방-요키(25cm)/행사사은품 완구점판매 ', '리퍼 가방끈 어깨끈 패드/밸크로/메모리폼쿠션/스트랩 ', '리퍼 가방끈 어깨끈 패드/메모리폼쿠션 스트랩/파우치 ', '울프베이스 크로스백 자전거 가방 레저 취미 스포츠 ', '캐리어 여행용 28인치 가방/미트롤리 프리미엄 2세대 ', '캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '샤오미 인텔리 백팩/남성 여성 남자 여자 여행용 가방 ', '메신저백 크로스백 힙색 슬링백 미니 여행 보조 가방 ', '캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '캐리어 여행용 20인치 가방/미트롤리 프리미엄 2세대 ', '연말찬스 인기브랜드 캐리어 여행용캐리어 여행가방 ', '미스터보울러 여행용 캐리어/여행가방/19900원부터 ', '덕다운 오리털 롱패딩 PYB-2 남녀공용/빅사이즈/남여 ', '락앤락 별자리 텀블러 400ml+선물가방 보온병 물병 ', '천연소가죽 슬링백/크로스백/핸드폰가방 득템기회 ', '겨울여행준비 인기 여행용캐리어 확장형 여행가방 ', '여행용 캐리어 20/24 인기상품 특별 할인가 여행가방 ', '/추가금없음/모두19800원/여성백팩/책가방/학생가방/ ', '익사이티드 3포켓 캐주얼 숄더백/크로스백 ', '여행용캐리어 케리어 기내용 20인치24인치28인치 가방 ', '/균일가/최고급퀄리티/품질보장/백팩/학생가방/책가방 ', '쇼퍼백 숄더백 크로스백 빅백 여성 가방 여자 가죽 양 ', '한정특가캐리어28인치케리어여행가방 ', '신상디자인/여성가방/숄더백/미니백/크로스백/핸드백/ ', '2018년형 헨즈 통돌이 오븐 HT-2000 가방 집게 증정 ', '/브랜드정품/백팩/책가방/학생가방/남성여성학생백팩/ ', '/정품/나염가방/기저귀가방/여성백팩/크로스백/숄더백 ', '/고급서류가방/크로스백/남성가방/남자가방/메신저백/ ', '국산명품퀄리티/여성가방/숄더백핸드백쇼퍼백크로스백 ', '남자 여행용 노트북 백팩 책가방 학생가방 신학기 ', '프리미엄 다운 공용 롱패딩 벤치코트 ', '접이식욕조/반신욕조/족욕기/이동식욕조/가방증정 ', '캐리어 여행용 28인치 가방/미트롤리 프리미엄 2세대 ', '크로스백/서류가방/메신저백/학생가방/책가방남성가방 ', '역대급할인~ 인기 여행용캐리어 확장형 여행가방 ', '쿠폰가 11만원대~ 닥스/헤지스키즈 신상 책가방SET ', 'BG-37 AXE 정품 여성 사계절 트렌디 백팩 여자 가방 ', '무료배송 캐주얼백팩 남자 여성 백팩 학생가방 ', '오리발+가방+핀서포트 마레스 아반티엑셀SET-WHT ', '3일특가 쿠잉 캐리어/여행가방/여행용/케리어/기내용 ', 'Ella(엘라)_PH8BSPELA301BLK ', '홈쇼핑 방송상품 아메리칸투어리스터 캐리어 5종세트 ', '브런스윅 뉴 퀼트 쓰리 in ONE 롤러백/볼링가방/4볼백 ', '노메이커특가 여성가방 미니백/클러치백/크로스백 ', '미국직수입 토리버치 미니토트/크로스백 5종 모음 ', '디지털키보드/전자피아노 가방+받침대+의자풀세트 5종 ', '남여공용 크로스백/가방/남성/남자/여성/학생가방 ', '균일가 신상품백팩 남성 여성 여행 학생백팩 책가방 ', '2019 새해맞이 캐리온 여행가방 세트구성 + 사은품 ', '내셔널지오그래픽 캐리어 세트 N6604P4 스페이스 캐리어 24형 20형 ', '프리미엄 백화점동일 브랜드 PC여행용캐리어 여행가방 ', '썸덱스 모아레 여행가방 8종 ', '파세코 심지식 석유난로 PKH-5100/가방포함 ', 'BEANPOLE KIDS  라이트 핑크 러블리 빙키 책가방 보조가방 SET (PS00113137Y) ', '2019신제품 초등학생책가방 책가방세트 신학기책가방 ', '캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '오후5시 이전 결제시 당일출고 남자백팩 남자가방 ', '남자 여행용 노트북 백팩 책가방 학생가방 신학기 ', '인기 여행용 캐리어 TSA확장형 여행가방 ', '2종세트 특별할인 20+24형세트 여행가방 여행용캐리어 ', '새해맞이 캠브리지 캐리어/여행가방 17종+사은품 ', '천연가죽크로스백50종/메신저백/슬링백/남성가방/벨라 ', '2018년형 헨즈 통돌이 오븐 HT-2000 가방 집게 증정 ', 'HB-03 여성용 로퍼 토트백 여자 캐주얼 숄더백 가방 ', 'anello 아넬로 여성백팩 패션백팩 남여공용 방수백 ', '버터플라이 신형 탁구라켓 펜홀더 쉐이크 탁구채 가방 ', '인기 여행가방 캐리어 외 여행용품 특별할인 균일가 ', '남자가방 미니 슬링백 크로스백 힙색 메신저백 숄더백 ', ' 2019 초등학생 경량방수 책가방2종세트 호핑백 Earth_디자인선택친환경물통+동전지갑 ', '뉴콕 캐리어 여행 가방 케리어 TSA락 확장형 20인치 ', '마젤란어스/메신저백 크로스백 힙색 학생 여행용 가방 ', '토요토미 옴니230SE+가방+상단망+주유기/캠핑난로 ', '오늘하루초특가 신상 백팩/책가방/여행백팩/학생가방 ', '트래블프로 이그제큐티브 쵸이스 17 비즈니스 캐리어 ', '천연소가죽 여성백팩47종/신상출시40%세일/가방/벨라 ', '나이키 아디다스 언더아머 가방 팀백 백팩 더플백 ', '라이트 핑크 러블리 빙키 책가방보조가방 SET (PS00113137Y) ', '항공커버+하드 캐리어 가방 24인치 여행용 S6504FP ', '서류가방/15.6인치 노트북가방/남성서류/남성가방 ', '2018 확장식 여행용백팩 17인치노트북수납 USB포트개선 '] 88
    ['29,900', '240,000', '12,800', '36,900', '92,940', '5,840', '140,580', '29,800', '28,900', '8,000', '2,800', '17,100', '119,000', '99,000', '69,510', '16,550', '99,000', '79,900', '29,800', '29,900', '84,900', '11,700', '13,900', '39,800', '32,800', '19,800', '12,900', '49,000', '19,800', '25,700', '49,900', '17,800', '139,500', '19,800', '19,800', '17,800', '17,800', '26,500', '65,900', '99,190', '119,000', '17,800', '29,800', '122,550', '87,800', '16,900', '93,060', '34,900', '169,000', '198,000', '193,050', '15,900', '390,000', '69,900', '15,900', '17,900', '32,900', '258,390', '97,000', '83,550', '161,200', '168,890', '49,410', '99,000', '59,000', '26,500', '29,800', '64,900', '26,900', '15,900', '144,500', '63,700', '15,900', '44,900', '29,800', '37,500', '118,730', '21,900', '15,800', '420,000', '17,900', '196,000', '29,900', '22,500', '190,000', '175,420', '19,900', '74,900'] 88
    ['99,000', '327,600', '42,500', '', '', '5,900', '142,000', '', '', '', '', '', '126,600', '105,320', '73,950', '17,610', '105,320', '85,000', '99,000', '99,000', '283,000', '15,170', '46,300', '131,800', '36,800', '', '', '', '', '', '', '', '', '', '', '', '', '26,600', '66,000', '109,000', '126,600', '', '99,000', '200,000', '', '17,900', '99,000', '39,800', '', '', '195,000', '', '', '107,600', '16,000', '59,600', '109,500', '287,100', '224,000', '89,000', '', '200,000', '54,900', '105,320', '', '26,600', '98,800', '69,000', '89,500', '30,000', '', '', '19,900', '45,000', '', '40,000', '', '', '17,800', '', '30,000', '245,000', '', '74,600', '200,000', '179,000', '20,000', ''] 88
    ['미스터보울러', 'DelseyKor', '트렌다', '폴로클럽백', '지오스토어', '베스트100스토어', '아이노스11', '나비몰', '세븐굿즈닷컴', '제이디텍', '제이디텍', '매트릭스클럽', '스마일배송', '스마일배송', '스마일배송', '스마일배송', '스마일배송', '스마일배송', '브라이튼몰', '미스터보울러', '마틴콕스공식몰', '리빙코디', '블루캣츠TM', '말렘', '에다스', '유니크클럽', '마마즈홈', '페더스', '유니크클럽', '아띠꼴로', 'tratag', '유니크클럽', '미래가전5395', '유니크클럽', '유니크클럽', '유니크클럽', '유니크클럽', '휠코', '가나안커머스', '최우수판매자', '스마일배송', '유니크클럽', '백토리스트', 'pastelworld', 'G3글로벌', '애드에딧', '롯데닷컴', '씨엔마켓', '롯데닷컴', '롯데닷컴', '최우수판매자', '직공닷컴', '슈슈퀸즈', '하이코스', 'YJCOMMERCE', '케이프리', '트래블메이트', '신세계몰', '브라이튼몰', 'K쇼핑', '예스전자', '신세계몰', '아이백몰', '스마일배송', '로예스', '휠코', '말렘', '브라이튼몰', '트래블메이트', '벨라(BELLA)', '미래가전5395', 'G3글로벌', 'HK골든브리지', 'Goodsgym', '씨앤티스토리', '티오코리아', '롯데닷컴', 'newcoc2030', '더블유팝', '디지털', 'BAGBOSS1', '(주)비박', '벨라(BELLA)', '싸커누리', '롯데닷컴', '블랭블랭', 'YJCOMMERCE', '가온나라'] 88
    


```python
import pandas as pd
```


```python
dat = pd.DataFrame({ "title" : title , 
                   "price_sales" : price_sales, 
                   "price_origin" : price_ori,
                   "company_name" : company }, columns=['title','price_sales','price_origin', "company_name"] )
dat

# dat.to_csv("company_info.csv", index=False, encoding="utf-8")  # MAC 유저
dat.to_csv("company_info.csv", index=False, encoding="EUCKR")  # Window EXCEL 한글 볼 때

```

## (수행준거1-1~1-5)
(1) 데이터 수집 계획서를 작성해 주세요.(1-1~1-5)(25점)<br>
(가) 데이터의 종류, 크기, 보관방식, 수집주기를 기입해 주세요.<br>
(나) 작업을 위한 예상기간, 데이터 저장 계획, 그리고 수집 가능한 사이
트를 기입해 주세요.<br>
(다) 수집한 데이터가 정확성을 검증하는 것에 대한 세부 계획서에 기입
해주세요.<br>
(라) 수집할 데이터에 대한 정보보안 및 수집허가에 대한 내용을 검토후, 계획이 적절한지 기입해 주세요.(robots.txt등)<br>

## (수행준거4-1~4-3)(15점)
(가) 옥션 등의 쇼핑몰에서 수집한 데이터를 위한 데이터베이스를 설계하고 데이터를 넣어서 확인해보자.<br>
(나) 옥션 등의 다른 쇼핑몰 데이터를 수집한 후, 같은 DB에 데이터베이
스의 설계를 변환한 후, 통합DB와 테이블을 만들어보자.(4-2,4-3)

### (가) 옥션 등의 쇼핑몰에서 수집한 데이터를 위한 데이터베이스를 설계하고 데이터를 넣어서 확인해보자.

```
(base) C:\Users\ktm>mysql -hlocalhost -uroot -p
Enter password: ******** [qwer1234]
...
mysql> show databases;           # <- db리스트 보기
mysql> use mydatabase;           # <- db사용
Database changed
mysql> show tables;              # 테이블 명 확인

# DB에 테이블 만들기
CREATE TABLE Auction_Bag_A (
    id  INT AUTO_INCREMENT PRIMARY KEY,  
    title   VARCHAR(150), 
    price_sales VARCHAR(30),
    price_origin VARCHAR(30),
    company_name VARCHAR(150) );

    
# 데이터 수집을 한 이후에 데이터 넣기
# python 코드에서 실행

```

### DB에 데이터 넣기
* DB 연결


```python
import mysql.connector

#%%
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="qwer1234"
)

mycursor = mydb.cursor()
```


```python
#%% mydatabase
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="qwer1234",
  database="mydatabase"
)

mycursor = mydb.cursor()

```


```python
dat.columns
```




    Index(['title', 'price_sales', 'price_origin', 'company_name'], dtype='object')




```python
for row in dat.values.tolist():
    line = row
    mycursor.execute("INSERT INTO Auction_Bag_A  (title, price_sales, price_origin, company_name) VALUES(%s, %s, %s, %s)", line)
    print(row)
```

    ['미스터보울러 여행용 캐리어/여행가방/19900원부터 ', '29,900', '99,000', '미스터보울러']
    ['DELSEY 델시 VAVIN 바뱅 캐리어 3종 세트 (21+28형) ', '240,000', '327,600', 'DelseyKor']
    ['여행가방 보스턴백 캠핑가방 보조가방 여행용 가방 백 ', '12,800', '42,500', '트렌다']
    ['(비버리힐즈폴로) 정품 남녀공용 백팩/기저귀가방 ', '36,900', '', '폴로클럽백']
    ['남성 서류 가방 모음 직장인 고급 가벼운 토트 20 30 ', '92,940', '', '지오스토어']
    ['여행 보조가방 여행용가방 멀티백 허리가방 힙색 가방 ', '5,840', '5,900', '베스트100스토어']
    ['탑킹 백팩 TKGMB-02 Backpack 가방 스포츠백 격투기 ', '140,580', '142,000', '아이노스11']
    ['크로스백 슬링백 백팩 가방 엘레모 국산캐주얼백 블랙 ', '29,800', '', '나비몰']
    ['패션펫 가방-요키(25cm)/행사사은품 완구점판매 ', '28,900', '', '세븐굿즈닷컴']
    ['리퍼 가방끈 어깨끈 패드/밸크로/메모리폼쿠션/스트랩 ', '8,000', '', '제이디텍']
    ['리퍼 가방끈 어깨끈 패드/메모리폼쿠션 스트랩/파우치 ', '2,800', '', '제이디텍']
    ['울프베이스 크로스백 자전거 가방 레저 취미 스포츠 ', '17,100', '', '매트릭스클럽']
    ['캐리어 여행용 28인치 가방/미트롤리 프리미엄 2세대 ', '119,000', '126,600', '스마일배송']
    ['캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '99,000', '105,320', '스마일배송']
    ['샤오미 인텔리 백팩/남성 여성 남자 여자 여행용 가방 ', '69,510', '73,950', '스마일배송']
    ['메신저백 크로스백 힙색 슬링백 미니 여행 보조 가방 ', '16,550', '17,610', '스마일배송']
    ['캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '99,000', '105,320', '스마일배송']
    ['캐리어 여행용 20인치 가방/미트롤리 프리미엄 2세대 ', '79,900', '85,000', '스마일배송']
    ['연말찬스 인기브랜드 캐리어 여행용캐리어 여행가방 ', '29,800', '99,000', '브라이튼몰']
    ['미스터보울러 여행용 캐리어/여행가방/19900원부터 ', '29,900', '99,000', '미스터보울러']
    ['덕다운 오리털 롱패딩 PYB-2 남녀공용/빅사이즈/남여 ', '84,900', '283,000', '마틴콕스공식몰']
    ['락앤락 별자리 텀블러 400ml+선물가방 보온병 물병 ', '11,700', '15,170', '리빙코디']
    ['천연소가죽 슬링백/크로스백/핸드폰가방 득템기회 ', '13,900', '46,300', '블루캣츠TM']
    ['겨울여행준비 인기 여행용캐리어 확장형 여행가방 ', '39,800', '131,800', '말렘']
    ['여행용 캐리어 20/24 인기상품 특별 할인가 여행가방 ', '32,800', '36,800', '에다스']
    ['/추가금없음/모두19800원/여성백팩/책가방/학생가방/ ', '19,800', '', '유니크클럽']
    ['익사이티드 3포켓 캐주얼 숄더백/크로스백 ', '12,900', '', '마마즈홈']
    ['여행용캐리어 케리어 기내용 20인치24인치28인치 가방 ', '49,000', '', '페더스']
    ['/균일가/최고급퀄리티/품질보장/백팩/학생가방/책가방 ', '19,800', '', '유니크클럽']
    ['쇼퍼백 숄더백 크로스백 빅백 여성 가방 여자 가죽 양 ', '25,700', '', '아띠꼴로']
    ['한정특가캐리어28인치케리어여행가방 ', '49,900', '', 'tratag']
    ['신상디자인/여성가방/숄더백/미니백/크로스백/핸드백/ ', '17,800', '', '유니크클럽']
    ['2018년형 헨즈 통돌이 오븐 HT-2000 가방 집게 증정 ', '139,500', '', '미래가전5395']
    ['/브랜드정품/백팩/책가방/학생가방/남성여성학생백팩/ ', '19,800', '', '유니크클럽']
    ['/정품/나염가방/기저귀가방/여성백팩/크로스백/숄더백 ', '19,800', '', '유니크클럽']
    ['/고급서류가방/크로스백/남성가방/남자가방/메신저백/ ', '17,800', '', '유니크클럽']
    ['국산명품퀄리티/여성가방/숄더백핸드백쇼퍼백크로스백 ', '17,800', '', '유니크클럽']
    ['남자 여행용 노트북 백팩 책가방 학생가방 신학기 ', '26,500', '26,600', '휠코']
    ['프리미엄 다운 공용 롱패딩 벤치코트 ', '65,900', '66,000', '가나안커머스']
    ['접이식욕조/반신욕조/족욕기/이동식욕조/가방증정 ', '99,190', '109,000', '최우수판매자']
    ['캐리어 여행용 28인치 가방/미트롤리 프리미엄 2세대 ', '119,000', '126,600', '스마일배송']
    ['크로스백/서류가방/메신저백/학생가방/책가방남성가방 ', '17,800', '', '유니크클럽']
    ['역대급할인~ 인기 여행용캐리어 확장형 여행가방 ', '29,800', '99,000', '백토리스트']
    ['쿠폰가 11만원대~ 닥스/헤지스키즈 신상 책가방SET ', '122,550', '200,000', 'pastelworld']
    ['BG-37 AXE 정품 여성 사계절 트렌디 백팩 여자 가방 ', '87,800', '', 'G3글로벌']
    ['무료배송 캐주얼백팩 남자 여성 백팩 학생가방 ', '16,900', '17,900', '애드에딧']
    ['오리발+가방+핀서포트 마레스 아반티엑셀SET-WHT ', '93,060', '99,000', '롯데닷컴']
    ['3일특가 쿠잉 캐리어/여행가방/여행용/케리어/기내용 ', '34,900', '39,800', '씨엔마켓']
    ['Ella(엘라)_PH8BSPELA301BLK ', '169,000', '', '롯데닷컴']
    ['홈쇼핑 방송상품 아메리칸투어리스터 캐리어 5종세트 ', '198,000', '', '롯데닷컴']
    ['브런스윅 뉴 퀼트 쓰리 in ONE 롤러백/볼링가방/4볼백 ', '193,050', '195,000', '최우수판매자']
    ['노메이커특가 여성가방 미니백/클러치백/크로스백 ', '15,900', '', '직공닷컴']
    ['미국직수입 토리버치 미니토트/크로스백 5종 모음 ', '390,000', '', '슈슈퀸즈']
    ['디지털키보드/전자피아노 가방+받침대+의자풀세트 5종 ', '69,900', '107,600', '하이코스']
    ['남여공용 크로스백/가방/남성/남자/여성/학생가방 ', '15,900', '16,000', 'YJCOMMERCE']
    ['균일가 신상품백팩 남성 여성 여행 학생백팩 책가방 ', '17,900', '59,600', '케이프리']
    ['2019 새해맞이 캐리온 여행가방 세트구성 + 사은품 ', '32,900', '109,500', '트래블메이트']
    ['내셔널지오그래픽 캐리어 세트 N6604P4 스페이스 캐리어 24형 20형 ', '258,390', '287,100', '신세계몰']
    ['프리미엄 백화점동일 브랜드 PC여행용캐리어 여행가방 ', '97,000', '224,000', '브라이튼몰']
    ['썸덱스 모아레 여행가방 8종 ', '83,550', '89,000', 'K쇼핑']
    ['파세코 심지식 석유난로 PKH-5100/가방포함 ', '161,200', '', '예스전자']
    ['BEANPOLE KIDS  라이트 핑크 러블리 빙키 책가방 보조가방 SET (PS00113137Y) ', '168,890', '200,000', '신세계몰']
    ['2019신제품 초등학생책가방 책가방세트 신학기책가방 ', '49,410', '54,900', '아이백몰']
    ['캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '99,000', '105,320', '스마일배송']
    ['오후5시 이전 결제시 당일출고 남자백팩 남자가방 ', '59,000', '', '로예스']
    ['남자 여행용 노트북 백팩 책가방 학생가방 신학기 ', '26,500', '26,600', '휠코']
    ['인기 여행용 캐리어 TSA확장형 여행가방 ', '29,800', '98,800', '말렘']
    ['2종세트 특별할인 20+24형세트 여행가방 여행용캐리어 ', '64,900', '69,000', '브라이튼몰']
    ['새해맞이 캠브리지 캐리어/여행가방 17종+사은품 ', '26,900', '89,500', '트래블메이트']
    ['천연가죽크로스백50종/메신저백/슬링백/남성가방/벨라 ', '15,900', '30,000', '벨라(BELLA)']
    ['2018년형 헨즈 통돌이 오븐 HT-2000 가방 집게 증정 ', '144,500', '', '미래가전5395']
    ['HB-03 여성용 로퍼 토트백 여자 캐주얼 숄더백 가방 ', '63,700', '', 'G3글로벌']
    ['anello 아넬로 여성백팩 패션백팩 남여공용 방수백 ', '15,900', '19,900', 'HK골든브리지']
    ['버터플라이 신형 탁구라켓 펜홀더 쉐이크 탁구채 가방 ', '44,900', '45,000', 'Goodsgym']
    ['인기 여행가방 캐리어 외 여행용품 특별할인 균일가 ', '29,800', '', '씨앤티스토리']
    ['남자가방 미니 슬링백 크로스백 힙색 메신저백 숄더백 ', '37,500', '40,000', '티오코리아']
    [' 2019 초등학생 경량방수 책가방2종세트 호핑백 Earth_디자인선택친환경물통+동전지갑 ', '118,730', '', '롯데닷컴']
    ['뉴콕 캐리어 여행 가방 케리어 TSA락 확장형 20인치 ', '21,900', '', 'newcoc2030']
    ['마젤란어스/메신저백 크로스백 힙색 학생 여행용 가방 ', '15,800', '17,800', '더블유팝']
    ['토요토미 옴니230SE+가방+상단망+주유기/캠핑난로 ', '420,000', '', '디지털']
    ['오늘하루초특가 신상 백팩/책가방/여행백팩/학생가방 ', '17,900', '30,000', 'BAGBOSS1']
    ['트래블프로 이그제큐티브 쵸이스 17 비즈니스 캐리어 ', '196,000', '245,000', '(주)비박']
    ['천연소가죽 여성백팩47종/신상출시40%세일/가방/벨라 ', '29,900', '', '벨라(BELLA)']
    ['나이키 아디다스 언더아머 가방 팀백 백팩 더플백 ', '22,500', '74,600', '싸커누리']
    ['라이트 핑크 러블리 빙키 책가방보조가방 SET (PS00113137Y) ', '190,000', '200,000', '롯데닷컴']
    ['항공커버+하드 캐리어 가방 24인치 여행용 S6504FP ', '175,420', '179,000', '블랭블랭']
    ['서류가방/15.6인치 노트북가방/남성서류/남성가방 ', '19,900', '20,000', 'YJCOMMERCE']
    ['2018 확장식 여행용백팩 17인치노트북수납 USB포트개선 ', '74,900', '', '가온나라']
    


```python
mydb.commit()
```


```python
mycursor.execute("SELECT * FROM Auction_Bag_A")
myresult = mycursor.fetchall()
for x in myresult:
    print(x)
```

    (1, '미스터보울러 여행용 캐리어/여행가방/19900원부터 ', '29,900', '99,000', '미스터보울러')
    (2, 'DELSEY 델시 VAVIN 바뱅 캐리어 3종 세트 (21+28형) ', '240,000', '327,600', 'DelseyKor')
    (3, '여행가방 보스턴백 캠핑가방 보조가방 여행용 가방 백 ', '12,800', '42,500', '트렌다')
    (4, '(비버리힐즈폴로) 정품 남녀공용 백팩/기저귀가방 ', '36,900', '', '폴로클럽백')
    (5, '남성 서류 가방 모음 직장인 고급 가벼운 토트 20 30 ', '92,940', '', '지오스토어')
    (6, '여행 보조가방 여행용가방 멀티백 허리가방 힙색 가방 ', '5,840', '5,900', '베스트100스토어')
    (7, '탑킹 백팩 TKGMB-02 Backpack 가방 스포츠백 격투기 ', '140,580', '142,000', '아이노스11')
    (8, '크로스백 슬링백 백팩 가방 엘레모 국산캐주얼백 블랙 ', '29,800', '', '나비몰')
    (9, '패션펫 가방-요키(25cm)/행사사은품 완구점판매 ', '28,900', '', '세븐굿즈닷컴')
    (10, '리퍼 가방끈 어깨끈 패드/밸크로/메모리폼쿠션/스트랩 ', '8,000', '', '제이디텍')
    (11, '리퍼 가방끈 어깨끈 패드/메모리폼쿠션 스트랩/파우치 ', '2,800', '', '제이디텍')
    (12, '울프베이스 크로스백 자전거 가방 레저 취미 스포츠 ', '17,100', '', '매트릭스클럽')
    (13, '캐리어 여행용 28인치 가방/미트롤리 프리미엄 2세대 ', '119,000', '126,600', '스마일배송')
    (14, '캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '99,000', '105,320', '스마일배송')
    (15, '샤오미 인텔리 백팩/남성 여성 남자 여자 여행용 가방 ', '69,510', '73,950', '스마일배송')
    (16, '메신저백 크로스백 힙색 슬링백 미니 여행 보조 가방 ', '16,550', '17,610', '스마일배송')
    (17, '캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '99,000', '105,320', '스마일배송')
    (18, '캐리어 여행용 20인치 가방/미트롤리 프리미엄 2세대 ', '79,900', '85,000', '스마일배송')
    (19, '연말찬스 인기브랜드 캐리어 여행용캐리어 여행가방 ', '29,800', '99,000', '브라이튼몰')
    (20, '미스터보울러 여행용 캐리어/여행가방/19900원부터 ', '29,900', '99,000', '미스터보울러')
    (21, '덕다운 오리털 롱패딩 PYB-2 남녀공용/빅사이즈/남여 ', '84,900', '283,000', '마틴콕스공식몰')
    (22, '락앤락 별자리 텀블러 400ml+선물가방 보온병 물병 ', '11,700', '15,170', '리빙코디')
    (23, '천연소가죽 슬링백/크로스백/핸드폰가방 득템기회 ', '13,900', '46,300', '블루캣츠TM')
    (24, '겨울여행준비 인기 여행용캐리어 확장형 여행가방 ', '39,800', '131,800', '말렘')
    (25, '여행용 캐리어 20/24 인기상품 특별 할인가 여행가방 ', '32,800', '36,800', '에다스')
    (26, '/추가금없음/모두19800원/여성백팩/책가방/학생가방/ ', '19,800', '', '유니크클럽')
    (27, '익사이티드 3포켓 캐주얼 숄더백/크로스백 ', '12,900', '', '마마즈홈')
    (28, '여행용캐리어 케리어 기내용 20인치24인치28인치 가방 ', '49,000', '', '페더스')
    (29, '/균일가/최고급퀄리티/품질보장/백팩/학생가방/책가방 ', '19,800', '', '유니크클럽')
    (30, '쇼퍼백 숄더백 크로스백 빅백 여성 가방 여자 가죽 양 ', '25,700', '', '아띠꼴로')
    (31, '한정특가캐리어28인치케리어여행가방 ', '49,900', '', 'tratag')
    (32, '신상디자인/여성가방/숄더백/미니백/크로스백/핸드백/ ', '17,800', '', '유니크클럽')
    (33, '2018년형 헨즈 통돌이 오븐 HT-2000 가방 집게 증정 ', '139,500', '', '미래가전5395')
    (34, '/브랜드정품/백팩/책가방/학생가방/남성여성학생백팩/ ', '19,800', '', '유니크클럽')
    (35, '/정품/나염가방/기저귀가방/여성백팩/크로스백/숄더백 ', '19,800', '', '유니크클럽')
    (36, '/고급서류가방/크로스백/남성가방/남자가방/메신저백/ ', '17,800', '', '유니크클럽')
    (37, '국산명품퀄리티/여성가방/숄더백핸드백쇼퍼백크로스백 ', '17,800', '', '유니크클럽')
    (38, '남자 여행용 노트북 백팩 책가방 학생가방 신학기 ', '26,500', '26,600', '휠코')
    (39, '프리미엄 다운 공용 롱패딩 벤치코트 ', '65,900', '66,000', '가나안커머스')
    (40, '접이식욕조/반신욕조/족욕기/이동식욕조/가방증정 ', '99,190', '109,000', '최우수판매자')
    (41, '캐리어 여행용 28인치 가방/미트롤리 프리미엄 2세대 ', '119,000', '126,600', '스마일배송')
    (42, '크로스백/서류가방/메신저백/학생가방/책가방남성가방 ', '17,800', '', '유니크클럽')
    (43, '역대급할인~ 인기 여행용캐리어 확장형 여행가방 ', '29,800', '99,000', '백토리스트')
    (44, '쿠폰가 11만원대~ 닥스/헤지스키즈 신상 책가방SET ', '122,550', '200,000', 'pastelworld')
    (45, 'BG-37 AXE 정품 여성 사계절 트렌디 백팩 여자 가방 ', '87,800', '', 'G3글로벌')
    (46, '무료배송 캐주얼백팩 남자 여성 백팩 학생가방 ', '16,900', '17,900', '애드에딧')
    (47, '오리발+가방+핀서포트 마레스 아반티엑셀SET-WHT ', '93,060', '99,000', '롯데닷컴')
    (48, '3일특가 쿠잉 캐리어/여행가방/여행용/케리어/기내용 ', '34,900', '39,800', '씨엔마켓')
    (49, 'Ella(엘라)_PH8BSPELA301BLK ', '169,000', '', '롯데닷컴')
    (50, '홈쇼핑 방송상품 아메리칸투어리스터 캐리어 5종세트 ', '198,000', '', '롯데닷컴')
    (51, '브런스윅 뉴 퀼트 쓰리 in ONE 롤러백/볼링가방/4볼백 ', '193,050', '195,000', '최우수판매자')
    (52, '노메이커특가 여성가방 미니백/클러치백/크로스백 ', '15,900', '', '직공닷컴')
    (53, '미국직수입 토리버치 미니토트/크로스백 5종 모음 ', '390,000', '', '슈슈퀸즈')
    (54, '디지털키보드/전자피아노 가방+받침대+의자풀세트 5종 ', '69,900', '107,600', '하이코스')
    (55, '남여공용 크로스백/가방/남성/남자/여성/학생가방 ', '15,900', '16,000', 'YJCOMMERCE')
    (56, '균일가 신상품백팩 남성 여성 여행 학생백팩 책가방 ', '17,900', '59,600', '케이프리')
    (57, '2019 새해맞이 캐리온 여행가방 세트구성 + 사은품 ', '32,900', '109,500', '트래블메이트')
    (58, '내셔널지오그래픽 캐리어 세트 N6604P4 스페이스 캐리어 24형 20형 ', '258,390', '287,100', '신세계몰')
    (59, '프리미엄 백화점동일 브랜드 PC여행용캐리어 여행가방 ', '97,000', '224,000', '브라이튼몰')
    (60, '썸덱스 모아레 여행가방 8종 ', '83,550', '89,000', 'K쇼핑')
    (61, '파세코 심지식 석유난로 PKH-5100/가방포함 ', '161,200', '', '예스전자')
    (62, 'BEANPOLE KIDS  라이트 핑크 러블리 빙키 책가방 보조가방 SET (PS00113137Y) ', '168,890', '200,000', '신세계몰')
    (63, '2019신제품 초등학생책가방 책가방세트 신학기책가방 ', '49,410', '54,900', '아이백몰')
    (64, '캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '99,000', '105,320', '스마일배송')
    (65, '오후5시 이전 결제시 당일출고 남자백팩 남자가방 ', '59,000', '', '로예스')
    (66, '남자 여행용 노트북 백팩 책가방 학생가방 신학기 ', '26,500', '26,600', '휠코')
    (67, '인기 여행용 캐리어 TSA확장형 여행가방 ', '29,800', '98,800', '말렘')
    (68, '2종세트 특별할인 20+24형세트 여행가방 여행용캐리어 ', '64,900', '69,000', '브라이튼몰')
    (69, '새해맞이 캠브리지 캐리어/여행가방 17종+사은품 ', '26,900', '89,500', '트래블메이트')
    (70, '천연가죽크로스백50종/메신저백/슬링백/남성가방/벨라 ', '15,900', '30,000', '벨라(BELLA)')
    (71, '2018년형 헨즈 통돌이 오븐 HT-2000 가방 집게 증정 ', '144,500', '', '미래가전5395')
    (72, 'HB-03 여성용 로퍼 토트백 여자 캐주얼 숄더백 가방 ', '63,700', '', 'G3글로벌')
    (73, 'anello 아넬로 여성백팩 패션백팩 남여공용 방수백 ', '15,900', '19,900', 'HK골든브리지')
    (74, '버터플라이 신형 탁구라켓 펜홀더 쉐이크 탁구채 가방 ', '44,900', '45,000', 'Goodsgym')
    (75, '인기 여행가방 캐리어 외 여행용품 특별할인 균일가 ', '29,800', '', '씨앤티스토리')
    (76, '남자가방 미니 슬링백 크로스백 힙색 메신저백 숄더백 ', '37,500', '40,000', '티오코리아')
    (77, ' 2019 초등학생 경량방수 책가방2종세트 호핑백 Earth_디자인선택친환경물통+동전지갑 ', '118,730', '', '롯데닷컴')
    (78, '뉴콕 캐리어 여행 가방 케리어 TSA락 확장형 20인치 ', '21,900', '', 'newcoc2030')
    (79, '마젤란어스/메신저백 크로스백 힙색 학생 여행용 가방 ', '15,800', '17,800', '더블유팝')
    (80, '토요토미 옴니230SE+가방+상단망+주유기/캠핑난로 ', '420,000', '', '디지털')
    (81, '오늘하루초특가 신상 백팩/책가방/여행백팩/학생가방 ', '17,900', '30,000', 'BAGBOSS1')
    (82, '트래블프로 이그제큐티브 쵸이스 17 비즈니스 캐리어 ', '196,000', '245,000', '(주)비박')
    (83, '천연소가죽 여성백팩47종/신상출시40%세일/가방/벨라 ', '29,900', '', '벨라(BELLA)')
    (84, '나이키 아디다스 언더아머 가방 팀백 백팩 더플백 ', '22,500', '74,600', '싸커누리')
    (85, '라이트 핑크 러블리 빙키 책가방보조가방 SET (PS00113137Y) ', '190,000', '200,000', '롯데닷컴')
    (86, '항공커버+하드 캐리어 가방 24인치 여행용 S6504FP ', '175,420', '179,000', '블랭블랭')
    (87, '서류가방/15.6인치 노트북가방/남성서류/남성가방 ', '19,900', '20,000', 'YJCOMMERCE')
    (88, '2018 확장식 여행용백팩 17인치노트북수납 USB포트개선 ', '74,900', '', '가온나라')
    

## (수행준거5-1~5-4)10점
(가) 내 외부 수집된 데이터에 대해서 실제 사이트의 데이터와 같은지에
대한 확인을 위한자료를 작성해 주세요.<br>
(나) 테스트 후, 오류 발견 시, 수정한 내용을 기입하는 내용에 대해 자료
에 반영해 주세요. 테스트 후, 테스트 완료 결과를 간단하게 정리해주세요.<br>

<img src='test/02.png'>

## (수행준거3-4,3-5) 10점
데이터 수집 자유 주제 프로젝트(데이터 수집 세부계획서, 데이터 수집)
하나의 주제를 정해 위의절차에 따라 데이터 수집 세부 계획을 세우고
이를 수집하는 내용의 프로젝트를 수행해주세요<br>

## 웹 데이터 수집 프로젝트 개요
* 수집 대상 사이트 : 옥션
* 데이터 검색어 : bag으로 검색
* 데이터 총 개수 : 88개
* 대상 url : 


## 수행절차 예제
* 01. Auction에서 bag으로 url 확인 후, 
* 02. 데이터 수집
* 03. 데이터 설계
* 04. 데이터 넣기
* 05. 최종 확인
* Summary : ......몇개의 데이터를 어떻게 넣어고, 그리고 이상이 없음을 확인.


## 실습과제2

### (수행준거 3-1, 3-2, 3-6) 15점
내부 DB 환경인 MYSQL에서 데이터를 가져올 수 있는지에 대한 실습입니다. 
(가) Python과 MySQL DB의 Session을 연결을 수행해 주세요.  <br>
(나) 테이블을 확인 후, 수집하고자 하는 TABLE를 정한 후, 데이터를 수집을 수행해 주세요.  <br>(다) 내부에서 수집한 데이터와 Python에서 수집한 데이터의 건수가 맞는지 확인해 주세요. <br>


```python
#%% mydatabase
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="qwer1234",
  database="mydatabase"
)

mycursor = mydb.cursor()
```


```python
mycursor.execute("SELECT * FROM Auction_Bag_A")
myresult = mycursor.fetchall()
for x in myresult:
    print(x)
```

    (1, '미스터보울러 여행용 캐리어/여행가방/19900원부터 ', '29,900', '99,000', '미스터보울러')
    (2, 'DELSEY 델시 VAVIN 바뱅 캐리어 3종 세트 (21+28형) ', '240,000', '327,600', 'DelseyKor')
    (3, '여행가방 보스턴백 캠핑가방 보조가방 여행용 가방 백 ', '12,800', '42,500', '트렌다')
    (4, '(비버리힐즈폴로) 정품 남녀공용 백팩/기저귀가방 ', '36,900', '', '폴로클럽백')
    (5, '남성 서류 가방 모음 직장인 고급 가벼운 토트 20 30 ', '92,940', '', '지오스토어')
    (6, '여행 보조가방 여행용가방 멀티백 허리가방 힙색 가방 ', '5,840', '5,900', '베스트100스토어')
    (7, '탑킹 백팩 TKGMB-02 Backpack 가방 스포츠백 격투기 ', '140,580', '142,000', '아이노스11')
    (8, '크로스백 슬링백 백팩 가방 엘레모 국산캐주얼백 블랙 ', '29,800', '', '나비몰')
    (9, '패션펫 가방-요키(25cm)/행사사은품 완구점판매 ', '28,900', '', '세븐굿즈닷컴')
    (10, '리퍼 가방끈 어깨끈 패드/밸크로/메모리폼쿠션/스트랩 ', '8,000', '', '제이디텍')
    (11, '리퍼 가방끈 어깨끈 패드/메모리폼쿠션 스트랩/파우치 ', '2,800', '', '제이디텍')
    (12, '울프베이스 크로스백 자전거 가방 레저 취미 스포츠 ', '17,100', '', '매트릭스클럽')
    (13, '캐리어 여행용 28인치 가방/미트롤리 프리미엄 2세대 ', '119,000', '126,600', '스마일배송')
    (14, '캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '99,000', '105,320', '스마일배송')
    (15, '샤오미 인텔리 백팩/남성 여성 남자 여자 여행용 가방 ', '69,510', '73,950', '스마일배송')
    (16, '메신저백 크로스백 힙색 슬링백 미니 여행 보조 가방 ', '16,550', '17,610', '스마일배송')
    (17, '캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '99,000', '105,320', '스마일배송')
    (18, '캐리어 여행용 20인치 가방/미트롤리 프리미엄 2세대 ', '79,900', '85,000', '스마일배송')
    (19, '연말찬스 인기브랜드 캐리어 여행용캐리어 여행가방 ', '29,800', '99,000', '브라이튼몰')
    (20, '미스터보울러 여행용 캐리어/여행가방/19900원부터 ', '29,900', '99,000', '미스터보울러')
    (21, '덕다운 오리털 롱패딩 PYB-2 남녀공용/빅사이즈/남여 ', '84,900', '283,000', '마틴콕스공식몰')
    (22, '락앤락 별자리 텀블러 400ml+선물가방 보온병 물병 ', '11,700', '15,170', '리빙코디')
    (23, '천연소가죽 슬링백/크로스백/핸드폰가방 득템기회 ', '13,900', '46,300', '블루캣츠TM')
    (24, '겨울여행준비 인기 여행용캐리어 확장형 여행가방 ', '39,800', '131,800', '말렘')
    (25, '여행용 캐리어 20/24 인기상품 특별 할인가 여행가방 ', '32,800', '36,800', '에다스')
    (26, '/추가금없음/모두19800원/여성백팩/책가방/학생가방/ ', '19,800', '', '유니크클럽')
    (27, '익사이티드 3포켓 캐주얼 숄더백/크로스백 ', '12,900', '', '마마즈홈')
    (28, '여행용캐리어 케리어 기내용 20인치24인치28인치 가방 ', '49,000', '', '페더스')
    (29, '/균일가/최고급퀄리티/품질보장/백팩/학생가방/책가방 ', '19,800', '', '유니크클럽')
    (30, '쇼퍼백 숄더백 크로스백 빅백 여성 가방 여자 가죽 양 ', '25,700', '', '아띠꼴로')
    (31, '한정특가캐리어28인치케리어여행가방 ', '49,900', '', 'tratag')
    (32, '신상디자인/여성가방/숄더백/미니백/크로스백/핸드백/ ', '17,800', '', '유니크클럽')
    (33, '2018년형 헨즈 통돌이 오븐 HT-2000 가방 집게 증정 ', '139,500', '', '미래가전5395')
    (34, '/브랜드정품/백팩/책가방/학생가방/남성여성학생백팩/ ', '19,800', '', '유니크클럽')
    (35, '/정품/나염가방/기저귀가방/여성백팩/크로스백/숄더백 ', '19,800', '', '유니크클럽')
    (36, '/고급서류가방/크로스백/남성가방/남자가방/메신저백/ ', '17,800', '', '유니크클럽')
    (37, '국산명품퀄리티/여성가방/숄더백핸드백쇼퍼백크로스백 ', '17,800', '', '유니크클럽')
    (38, '남자 여행용 노트북 백팩 책가방 학생가방 신학기 ', '26,500', '26,600', '휠코')
    (39, '프리미엄 다운 공용 롱패딩 벤치코트 ', '65,900', '66,000', '가나안커머스')
    (40, '접이식욕조/반신욕조/족욕기/이동식욕조/가방증정 ', '99,190', '109,000', '최우수판매자')
    (41, '캐리어 여행용 28인치 가방/미트롤리 프리미엄 2세대 ', '119,000', '126,600', '스마일배송')
    (42, '크로스백/서류가방/메신저백/학생가방/책가방남성가방 ', '17,800', '', '유니크클럽')
    (43, '역대급할인~ 인기 여행용캐리어 확장형 여행가방 ', '29,800', '99,000', '백토리스트')
    (44, '쿠폰가 11만원대~ 닥스/헤지스키즈 신상 책가방SET ', '122,550', '200,000', 'pastelworld')
    (45, 'BG-37 AXE 정품 여성 사계절 트렌디 백팩 여자 가방 ', '87,800', '', 'G3글로벌')
    (46, '무료배송 캐주얼백팩 남자 여성 백팩 학생가방 ', '16,900', '17,900', '애드에딧')
    (47, '오리발+가방+핀서포트 마레스 아반티엑셀SET-WHT ', '93,060', '99,000', '롯데닷컴')
    (48, '3일특가 쿠잉 캐리어/여행가방/여행용/케리어/기내용 ', '34,900', '39,800', '씨엔마켓')
    (49, 'Ella(엘라)_PH8BSPELA301BLK ', '169,000', '', '롯데닷컴')
    (50, '홈쇼핑 방송상품 아메리칸투어리스터 캐리어 5종세트 ', '198,000', '', '롯데닷컴')
    (51, '브런스윅 뉴 퀼트 쓰리 in ONE 롤러백/볼링가방/4볼백 ', '193,050', '195,000', '최우수판매자')
    (52, '노메이커특가 여성가방 미니백/클러치백/크로스백 ', '15,900', '', '직공닷컴')
    (53, '미국직수입 토리버치 미니토트/크로스백 5종 모음 ', '390,000', '', '슈슈퀸즈')
    (54, '디지털키보드/전자피아노 가방+받침대+의자풀세트 5종 ', '69,900', '107,600', '하이코스')
    (55, '남여공용 크로스백/가방/남성/남자/여성/학생가방 ', '15,900', '16,000', 'YJCOMMERCE')
    (56, '균일가 신상품백팩 남성 여성 여행 학생백팩 책가방 ', '17,900', '59,600', '케이프리')
    (57, '2019 새해맞이 캐리온 여행가방 세트구성 + 사은품 ', '32,900', '109,500', '트래블메이트')
    (58, '내셔널지오그래픽 캐리어 세트 N6604P4 스페이스 캐리어 24형 20형 ', '258,390', '287,100', '신세계몰')
    (59, '프리미엄 백화점동일 브랜드 PC여행용캐리어 여행가방 ', '97,000', '224,000', '브라이튼몰')
    (60, '썸덱스 모아레 여행가방 8종 ', '83,550', '89,000', 'K쇼핑')
    (61, '파세코 심지식 석유난로 PKH-5100/가방포함 ', '161,200', '', '예스전자')
    (62, 'BEANPOLE KIDS  라이트 핑크 러블리 빙키 책가방 보조가방 SET (PS00113137Y) ', '168,890', '200,000', '신세계몰')
    (63, '2019신제품 초등학생책가방 책가방세트 신학기책가방 ', '49,410', '54,900', '아이백몰')
    (64, '캐리어 여행용 24인치 가방/미트롤리 프리미엄 2세대 ', '99,000', '105,320', '스마일배송')
    (65, '오후5시 이전 결제시 당일출고 남자백팩 남자가방 ', '59,000', '', '로예스')
    (66, '남자 여행용 노트북 백팩 책가방 학생가방 신학기 ', '26,500', '26,600', '휠코')
    (67, '인기 여행용 캐리어 TSA확장형 여행가방 ', '29,800', '98,800', '말렘')
    (68, '2종세트 특별할인 20+24형세트 여행가방 여행용캐리어 ', '64,900', '69,000', '브라이튼몰')
    (69, '새해맞이 캠브리지 캐리어/여행가방 17종+사은품 ', '26,900', '89,500', '트래블메이트')
    (70, '천연가죽크로스백50종/메신저백/슬링백/남성가방/벨라 ', '15,900', '30,000', '벨라(BELLA)')
    (71, '2018년형 헨즈 통돌이 오븐 HT-2000 가방 집게 증정 ', '144,500', '', '미래가전5395')
    (72, 'HB-03 여성용 로퍼 토트백 여자 캐주얼 숄더백 가방 ', '63,700', '', 'G3글로벌')
    (73, 'anello 아넬로 여성백팩 패션백팩 남여공용 방수백 ', '15,900', '19,900', 'HK골든브리지')
    (74, '버터플라이 신형 탁구라켓 펜홀더 쉐이크 탁구채 가방 ', '44,900', '45,000', 'Goodsgym')
    (75, '인기 여행가방 캐리어 외 여행용품 특별할인 균일가 ', '29,800', '', '씨앤티스토리')
    (76, '남자가방 미니 슬링백 크로스백 힙색 메신저백 숄더백 ', '37,500', '40,000', '티오코리아')
    (77, ' 2019 초등학생 경량방수 책가방2종세트 호핑백 Earth_디자인선택친환경물통+동전지갑 ', '118,730', '', '롯데닷컴')
    (78, '뉴콕 캐리어 여행 가방 케리어 TSA락 확장형 20인치 ', '21,900', '', 'newcoc2030')
    (79, '마젤란어스/메신저백 크로스백 힙색 학생 여행용 가방 ', '15,800', '17,800', '더블유팝')
    (80, '토요토미 옴니230SE+가방+상단망+주유기/캠핑난로 ', '420,000', '', '디지털')
    (81, '오늘하루초특가 신상 백팩/책가방/여행백팩/학생가방 ', '17,900', '30,000', 'BAGBOSS1')
    (82, '트래블프로 이그제큐티브 쵸이스 17 비즈니스 캐리어 ', '196,000', '245,000', '(주)비박')
    (83, '천연소가죽 여성백팩47종/신상출시40%세일/가방/벨라 ', '29,900', '', '벨라(BELLA)')
    (84, '나이키 아디다스 언더아머 가방 팀백 백팩 더플백 ', '22,500', '74,600', '싸커누리')
    (85, '라이트 핑크 러블리 빙키 책가방보조가방 SET (PS00113137Y) ', '190,000', '200,000', '롯데닷컴')
    (86, '항공커버+하드 캐리어 가방 24인치 여행용 S6504FP ', '175,420', '179,000', '블랭블랭')
    (87, '서류가방/15.6인치 노트북가방/남성서류/남성가방 ', '19,900', '20,000', 'YJCOMMERCE')
    (88, '2018 확장식 여행용백팩 17인치노트북수납 USB포트개선 ', '74,900', '', '가온나라')
    

## (수행준거 3-3, 3-7, 4-4) 15점
이번 수행 과제는 앞의 데이터 수집 실습 과제을 활용하여 수행해도 됩니다. 

(가) 웹에서의 데이터를 실시간으로 수집하기 위해 cron 명령을 이용하여 python 프로그램을
10분 단위로 주기적으로 실행해 주세요.

### 01. 터미널 열기를 선택한다.
### 02. ls  -ltr로 목록을 확인한다.
### 03. vi hello.py를 입력 후, 프로그램을 입력한다.
### 04. 'i'모드 선택 후, print("Hello")를 입력한다. ESC선택 후, SHITF+':'을 선택
### 05. wq! 입력 후, Enter
### 06. chmod 755 hello.py
### 07. crontab -e 입력 후, 선택
### 08. * * * * * /usr/bin/python3 /home/bigdata3/hello.py >>echo.log
### 09. 계속 로그가 쌓이고 있는지 확인.

<img src='test/03.png'><br>
<img src='test/04.png'><br>
<img src='test/05.png'><br>
<img src='test/06.png'><br>
<img src='test/07.png'><br>
