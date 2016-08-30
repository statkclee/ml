---
layout: page
title: xwMOOC 기계학습
subtitle: 텍스트 데이터 수집 -- 트위터
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 
> ## 학습목표 {.objectives}
>
> * 텍스트 문자 데이터 분석을 위해 텍스트 데이터를 가져온다.
> * 트위터 서비스를 통해 텍스트 문자 데이터를 R로 불러온다. 




### 1. 트위터 서비스

"트윗(tweet)"이란 말은 작은 새가 지저귀는 소리를 나타내는 영어 낱말로, 
[트위터(영어: Twitter)](https://www.twitter.com/)는 **소셜 네트워크 서비스(SNS)**이자 **마이크로블로그** 서비스로 볼 수 있다.

단문 메시지 서비스(SMS), 인스턴트 메신저, 전자 우편(e-mail) 등을 통해 "트윗(tweet)"를 전송할 수 있고, 글 한 편에 해당하는 단위는 트윗으로 140자가 한도가 된다. 
한글이든 영문이든, 공백과 기호를 포함해 한 번에 140 까지 글자를 올릴 수 있다.

#### 1.1. 트위터 계정과 핸드폰 번호 등록

텍스트 문자 데이터를 R로 받아오기 위해서는 먼저 트위터 계정을 생성하고 핸드폰 번호를 등록하고 인증과정을 거쳐야 된다.

`Settings` &rarr; `Mobile` 로 들어가서 핸드폰 번호 인증을 받는다.

인증된 핸드폰 번호가 있어야 [트위터 개발자 페이지](https://dev.twitter.com/)에서 앱개발에 대한 키값을 받을 수 있다.

#### 1.2. 트위터 개발자 페이지

트위터 계정을 생성하고, 핸드폰 인증을 마친 뒤에 [트위터 개발자 페이지](https://dev.twitter.com/)에서 **TOOLS** 메뉴를 찾아 
[Manage Your Apps](https://apps.twitter.com/)로 들어간다. 이유는 트위터 데이터를 통해 부가적인 가치를 창출하는 응용프로그램을 개발해야 되기 때문이다.

1. **Create New App** 을 클릭하여 신규 응용프로그램을 개발한다.
    * 굳이 응용프로그램 개발하는 경우가 아니고, 향후 응용프로그램을 개발하는 것을 대비해서 기본적인 정보를 적어 놓는다. 
    * 모든 정보를 다 넣을 필요는 없다. `Name`, `Description`, `Website`는 필수 값으로 기재를 하고, `Website`는 정확한 주소 정보가 아니더라도 상관없다.
1. **Create your Twitter application** 을 클릭하면 트위터 응용프로그램이 생성된다.
    * 핸드폰 번호를 등록하지 않는 경우 다음으로 넘어가지 않아서 상기 "트위터 계정과 핸드폰 번호 등록"을 통해 필히 핸드폰을 등록한다.

#### 1.3. 키값과 접속 토큰

응용프로그램이 생성되었으면 다음으로 남은 단계는 **고객 키(Consumer Key)** 와 **비밀번호(Consumer Secret)** 와 더불어 **접속 토큰(Access Token)** 과
**접속 토큰 비밀번호(Access Secret)** 를 확인한다. 만약 의심스러운 경우 지체없이 `Regenerate` 버튼을 눌러 재생성한다.

* consumer_key   
* consumer_secret
* access_token   
* access_secret  

### 2. `twitteR` 트위터 데이터 긁어오기

오랜기간동안 트위터가 서비스 되었고, R을 활용한 데이터 분석이 인기를 끌어 쉽게 텍스트 문자정보를 긁어와서 분석을 수월하게 진행할 수 있다.
`twitteR`과 `ROAuth` 팩키지를 설치하고 트위터 개발자 페이지, 앱 개발 페이지에서 수집한 고객키값과 접속토큰값을 `twitterOAuth.R` 파일에
저장한다. 

그리고, `source` 명령어로 파일을 불러와서 메모리에 올리고 `setup_twitter_oauth` 명령어를 통해 트위터 인증을 한다.

`searchTwitter` 명령어로 검색어를 넣고 **@HQ_sohn** 넣고, 한글로 언어를 설정하고, `lang='ko'`, 긁어올 트윗 갯수를 `n=100`으로 지정한다.
긁어온 데이터는 리스트 정보라 이를 `twListToDF` 명령어를 통해 데이터프레임으로 변환한다.

`head(hq_tweets_df$text)` 명령어를 통해 트위터를 잘 긁어왔는지 확인한다.



~~~{.r}
##======================================================================================================
## 01. 트위터 데이터 가져오기
##======================================================================================================

rm(list=ls())

library(twitteR)
library(ROAuth)

source("twitterOAuth.R")

# twitterOAuth.R 파일에 담겨있는 정보
#
# consumer_key    <- "..............."
# consumer_secret <- "..............."
# access_token    <- "..............."
# access_secret   <- "..............."

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
~~~



~~~{.output}
[1] "Using direct authentication"

~~~



~~~{.r}
hq_tweets <- searchTwitter("@HQ_sohn", lang='ko', n=100)
hq_tweets_df <- twListToDF(hq_tweets)
head(hq_tweets_df$text)
~~~



~~~{.output}
[1] "RT @justice7200: 손학규 @HQ_Sohn  고문님 역할 기대돼요. 정권교체 주역도, 킹메이커도 가능한 분. 다만 국민의 당은 잊으세요. https://t.co/ff8mXcopfg"                                                                                
[2] "RT @justice7200: 손학규@HQ_Sohn 고문님. 정치활동 멋 있게 잘 하셔서 경선하여 승리하시면 정권교체도 가능합니다. 아름다운 경선이 조건. 보이콧 마시고 문재인 전 대표님과 손잡고 아름다운 경선하세요. 문대표님은 그럴맘이 준비된 분.…"
[3] "RT @justice7200: 손학규@HQ_Sohn 고문님. 정치활동 멋 있게 잘 하셔서 경선하여 승리하시면 정권교체도 가능합니다. 아름다운 경선이 조건. 보이콧 마시고 문재인 전 대표님과 손잡고 아름다운 경선하세요. 문대표님은 그럴맘이 준비된 분.…"
[4] "RT @justice7200: 손학규 @HQ_Sohn  고문님 역할 기대돼요. 정권교체 주역도, 킹메이커도 가능한 분. 다만 국민의 당은 잊으세요. https://t.co/ff8mXcopfg"                                                                                
[5] "RT @justice7200: 손학규@HQ_Sohn 고문님. 정치활동 멋 있게 잘 하셔서 경선하여 승리하시면 정권교체도 가능합니다. 아름다운 경선이 조건. 보이콧 마시고 문재인 전 대표님과 손잡고 아름다운 경선하세요. 문대표님은 그럴맘이 준비된 분.…"
[6] "안철수, 1박2일 호남행…박지원은 손학규와 회동&lt;=손학규(@HQ_Sohn)님,모바일 부정의혹으로 대선후보 앗아간 문재인에게 미련갖지 마시길,공정경선하고,여의치 않으면 길을 돌아 가는 것도 생각해 보셨으면^^ https://t.co/CuIJ0NDnDt"     

~~~




