---
layout: page
title: xwMOOC 기계학습
subtitle: 신용평점모형 개발
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 
``` {r, include=FALSE}
source("tools/chunk-options.R")
```

> ### 신용평가모형 목표 {.getready}
>
> * **수익을 극대화** 하고, **신용위험을 최소화** 하는 신용평점모형을 개발한다.
> * 랜딩클럽 데이터를 분석하여 실제 데이터를 가지고 신용평점모형을 개발한다.

### 1. 신용평점모형 [^ml-credit-scoring-sharma]

[^ml-credit-scoring-sharma]: [Guide to Credit Scoring in R](https://cran.r-project.org/doc/contrib/Sharma-CreditScoring.pdf)

대한민국에서 이영애 누님께서 IMF를 극복하고 2000년대 초반에 신용카드로 행복한 삶을 사는 모습을 러닝머신을 타면서 
보여주면서 신용카드의 전성기가 도래했지만, 
소수의 사람을 빼고 신용카드가 결국 미래 소비를 현재로 앞당겨서 돈을 쓰는 것에 불과하다는 것은 
그로부터 몇년 뒤에 명확해졌고, 이를 신용대란이라고 불렀다. 
이후 기업금융과 마찬가지로 소매금융도 위험관리가 중요해졌으며, 
소매금융에 있어 위험관리 기법으로 신용평점에 따라 엄격하게 관리하는 것이 필요해졌고, 
이에 [신용평점모형(Credit Scoring Model)](https://ko.wikipedia.org/wiki/신용_위험)과 더불어 이를 자동화한 금융시스템이 각광을 받기 시작했다. 

파이썬은 과학컴퓨팅에 많은 경험과 라이브러리가 구축되어 있는 반면, 
R은 상대적으로 통계학기반이라 통계학이 많이 사용되는 금융위험관리 분야에 구축된 
블로그, 논문, 기고문, 라이브러리가 많다. 
현실과 밀접한 신용할당문제를 기계학습에서 대규모 적용할 경우 풀어가는 방식을 R로 살펴보고, 
추후 파이썬으로 확장도 고려해 본다. [^credit-scoring-101] [^credit-scoring-woe] [^credit-scoring-binning]

[^credit-scoring-101]: [Credit Scoring in R 101](http://www.r-bloggers.com/credit-scoring-in-r-101/)
[^credit-scoring-woe]: [R Credit Scoring – WoE & Information Value in woe Package](http://www.r-bloggers.com/r-credit-scoring-woe-information-value-in-woe-package/)
[^credit-scoring-binning]: [R Package 'smbinning': Optimal Binning for Scoring Modeling](http://www.r-bloggers.com/r-package-smbinning-optimal-binning-for-scoring-modeling/)

#### 1.1. 신용평점 개요

기본적으로 금융기관에서는 한국은행을 비롯한 다양한 곳에서 자금을 조달하여 이를 관리하고 있다가 자금을 필요로 하는 곳에 
자금을 빌려주고 이에 상응하는 이자를 받아 수익을 얻는 것으로 볼 수 있다. 근본적으로 많은 금액을 빌려주고 
이를 나누어서 자금을 사용한 곳에서 갚아 나가는 구조다.

<img src="fig/ml-credit-biz.png" alt="금융 사업 개요" width="70%" />

물론 다수의 고객에게 자금을 빌려주다보니 제때 돈을 갚지 못하거나, 불의의 사고, 실직 등 다양한 이유로 인해서 돈을 갖지 못하는 
위험이 발생된다.
이때 기대손실(Expected Loss)을 다음 구성요소를 가지고 정량화한다.

* 채무 불이행 위험 : Probability of default
* 채무 불이행 노출 : Exposure at default
* 채무 불이행에 대한 손실 : Loss given default

$\text{기대손실} = \text{채무 불이행 위험} \times \text{채무 불이행 노출} \times \text{채무 불이행에 대한 손실}$

따라서 금융기관에서 자금을 빌려주기 전에 다양한 정보를 활용하여 채무 불이행 위험이 적은 고객을 선별하여 가능한 많은 
금액을 빌려주어 매출과 수익을 극대화한다.

* Application 정보: 나이, 결혼여부, 소득, 자가/전세 등
* Behaviour 정보: 현재 은행잔고, 연체금액 등

### 2. 랜딩클럽 데이터

[LendingClub](https://www.lendingclub.com/info/download-data.action) 사이트에서 데이터를 다운로드해도 되고,
[캐글 대출 데이터(Kaggle Loan Data)](https://www.kaggle.com/wendykan/lending-club-loan-data)를 통해서 데이터를 구해도 좋다.

2007-2015까지 [LendingClub](https://www.lendingclub.com/) 대출자료가 파일에 담겨있다. 다운로드 받아 
압축을 풀면, 다음 파일 세개가 담겨있다.

* database.sqlite (134.64 MB) : sqlite 데이터베이스 파일 형식 대출 데이터 전체
* LCDataDictionary.xlsx (20.5 KB) : 데이터 사전 (변수 설명)
* loan.csv (105.01 MB) : csv 파일 형식 대출 데이터 전체

``` {r lendingclub-import, tidy=FALSE, warning=FALSE}

##=====================================================================
## 01. 렌딩클럽 데이터 가져오기
##=====================================================================

library(readr)
library(dplyr)
setwd("D:/")
loan.dat <- read_csv("lending-club-loan-data/loan.csv", col_names = TRUE)
dim(loan.dat)
names(loan.dat)

glimpse(loan.dat)
summary(loan.dat)
``` 

``` {r lendingclub-recon, tidy=FALSE, warning=FALSE}

##=====================================================================
## 02. 렌딩클럽 데이터와 문서 대조작업
##=====================================================================

library(readxl)
dataDictionary <- read_excel("lending-club-loan-data/LCDataDictionary.xlsx")

dd.names <- as.character(na.omit(dataDictionary$LoanStatNew))
loandata.names <- names(loan.dat)

setdiff(dd.names, loandata.names)
```

렌딩클럽 데이터(csv 혹은 sqlite)와 데이터 사전에 문서화된 것 사이에 차이가 남을 알 수 있다.
즉, "fico_range_high", "fico_range_low", "is_inc_v", "last_fico_range_high", "last_fico_range_low", "verified_status_joint", "total_rev_hi_lim"
변수는 데이터 사전에 등재되어 있지만, 실제 렌딩클럽 데이터에는 없다.
사실 이런 경우는 흔하게 발생되고 있는 문제로 나중에 심각한 문제가 될 수 있다. 즉, 이런 유산 비용이 쌓이게 되면
정말 되돌이킬 수 없는 시스템이 되어 재앙이 될 수 있다. 
   

#### 2.1. 탐색적 데이터 분석

``` {r lendingclub-eda-continuous, tidy=FALSE, warning=FALSE}
##=====================================================================
## 03. 렌딩클럽 데이터 탐색적 데이터 분석
##=====================================================================
# 02.01. 대출금액 분포
library(DescTools)
Desc(loan.dat$loan_amnt, main = "대출금액 분포", plotit = TRUE)


# 02.02. 대출금액 증가 현황
library(ggplot2)
library(lubridate)

loan.dat$issue_d <- parse_date_time(gsub("^", "01-", loan.dat$issue_d), orders = c("d-m-y", "d-B-Y", "m/d/y"))

amnt_df <- loan.dat %>% 
  select(issue_d, loan_amnt) %>% 
  group_by(issue_d) %>% 
  summarise(Amount = sum(loan_amnt))

ts_amnt <- ggplot(amnt_df, aes(x = issue_d, y = Amount))
ts_amnt + geom_line() + xlab("대출금 발생일") + ylab("대출금")
```

``` {r lendingclub-eda-loan-status, tidy=FALSE, warning=FALSE}
# 03.03. 대출 상태

Desc(loan.dat$loan_status, plotit = T)

# 03.04. 대출 상태별 대출금

box_status <- ggplot(loan.dat, aes(loan_status, loan_amnt))
box_status + geom_boxplot(aes(fill = loan_status)) +
  theme(axis.text.x = element_blank()) +
  labs(list(
    title = "대출 상태별 대출금",
    x = "대출상태",
    y = "대출금"))  

# 03.05. 대출 등급별 대출금 추이

amnt_df_grade <- loan.dat %>% 
  select(issue_d, loan_amnt, grade) %>% 
  group_by(issue_d, grade) %>% 
  summarise(Amount = sum(loan_amnt))

ts_amnt_grade <- ggplot(amnt_df_grade, 
                        aes(x = issue_d, y = Amount))
ts_amnt_grade + geom_area(aes(fill=grade)) + xlab("대출일")  
```


#### 2.2. 지리정보 분석

``` {r lendingclub-geo, tidy=FALSE, warning=FALSE}
##=====================================================================
## 04. 렌딩클럽 데이터 지리정보 분석
##=====================================================================

state.df <- "State, Abbreviation, region
Alabama, Ala., AL
Alaska, Alaska, AK
American Samoa,  , AS
Arizona, Ariz., AZ
Arkansas, Ark., AR
California, Calif., CA
Colorado, Colo., CO
Connecticut, Conn., CT
Delaware, Del., DE
Dist. of Columbia, D.C., DC
Florida, Fla., FL
Georgia, Ga., GA
Guam, Guam, GU
Hawaii, Hawaii, HI
Idaho, Idaho, ID
Illinois, Ill., IL
Indiana, Ind., IN
Iowa, Iowa, IA
Kansas, Kans., KS
Kentucky, Ky., KY
Louisiana, La., LA
Maine, Maine, ME
Maryland, Md., MD
Marshall Islands,  , MH
Massachusetts, Mass., MA
Michigan, Mich., MI
Micronesia,  , FM
Minnesota, Minn., MN
Mississippi, Miss., MS
Missouri, Mo., MO
Montana, Mont., MT
Nebraska, Nebr., NE
Nevada, Nev., NV
New Hampshire, N.H., NH
New Jersey, N.J., NJ
New Mexico, N.M., NM
New York, N.Y., NY
North Carolina, N.C., NC
North Dakota, N.D., ND
Northern Marianas,  , MP
Ohio, Ohio, OH
Oklahoma, Okla., OK
Oregon, Ore., OR
Palau,  , PW
Pennsylvania, Pa., PA
Puerto Rico, P.R., PR
Rhode Island, R.I., RI
South Carolina, S.C., SC
South Dakota, S.D., SD
Tennessee, Tenn., TN
Texas, Tex., TX
Utah, Utah, UT
Vermont, Vt., VT
Virginia, Va., VA
Virgin Islands, V.I., VI
Washington, Wash., WA
West Virginia, W.Va., WV
Wisconsin, Wis., WI
Wyoming, Wyo., WY"

state.df <- read_csv(state.df)

library(zipcode)
data(zipcode.civicspace)
zipcode.civicspace$zip_code <- substr(zipcode.civicspace$zip,1,3)
zipcode.dic <- zipcode.civicspace  %>%  group_by(zip_code)  %>% 
  select(zip_code, region=state) %>% unique 

loan.dat$zip_code <- substr(loan.dat$zip_code,1,3)
loan.dat <- left_join(loan.dat, zipcode.dic, by="zip_code")

loan.dat$region <- as.factor(loan.dat$region)

## 주별 대출금액

state_by_value <- loan.dat %>% group_by(region) %>% 
  dplyr::summarise(value = sum(loan_amnt, na.rm=TRUE)) %>% ungroup

state_by_value <- tapply(loan.dat$loan_amnt, loan.dat$region, sum)/10^8

#install.packages("RCurl")
#install.packages("choroplethrMaps")
library(choroplethr)
state_choropleth(state_by_value, title = "Value by State")

## 주별 대출 횟수

loan.dat$region <- tolower(loan.dat$region)
loan.dat <- left_join(loan.dat, state.df, by="region")

state_by_volume <-
  loan.dat %>% group_by(state.y) %>% dplyr::summarise(value = n()) %>%  ungroup

state_choropleth(na.omit(state_by_volume$state.y), title = "Volume by State")
```


#### 2.3. 대출 목적과 단어 구름

``` {r lendingclub-purpose-wordcloud, tidy=FALSE, warning=FALSE}}

##=====================================================================
## 05. 렌딩클럽 대출 목적와 단어구름
##=====================================================================

# 대출 목적
Desc(loan.dat$purpose, main = "대출 목적", plotit = TRUE)

# 단어 구름
library(tm)
library(RColorBrewer)
library(wordcloud)

loan_descriptions.corpus <- Corpus(DataframeSource(data.frame(head(loan.dat[,"title"], n=10000))))
loan_descriptions.corpus <- tm_map(loan_descriptions.corpus, removePunctuation)
loan_descriptions.corpus <- tm_map(loan_descriptions.corpus, content_transformer(tolower))

wordcloud(loan_descriptions.corpus,
          max.words = 100,
          random.order=FALSE, 
          rot.per=0.30, 
          use.r.layout=FALSE, 
          colors=brewer.pal(8, "Paired"))
```          

#### 2.4. 대출 등급과 이자율

``` {r}
##=====================================================================
## 06. 대출 등급과 이자율
##=====================================================================

Desc(loan.dat$grade, main = "대출 등급", plotit = TRUE)

Desc(int_rate ~ grade, loan.dat, digits = 1, main = "Interest rate by grade", plotit = TRUE)
```





