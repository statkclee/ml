# xwMOOC 기계학습
 


> ### 학습 목표 {.getready}
>
> * 한글 소설을 단어 구름을 활용하여 요약한다.

## 1. [태그 또는 단어 구름](https://ko.wikipedia.org/wiki/태그_구름)


### 1.1. 한글 소설 데이터 불러오기

황순원 소나기 소설 텍스트 파일을 불러온다.


~~~{.r}
sonagi.text.v <- scan("data/sonagi.txt", what="character", sep="\n", encoding = "UTF-8")
~~~

### 1.2. 한글 소설 텍스트 데이터 전처리

불러온 한글소설 소나기 텍스트 벡터를 공백과 구두점으로 쪼개고, 빈 공백을 솎아 낸다.


~~~{.r}
sonagi.words.l <- strsplit(sonagi.text.v, "\\W")
sonagi.word.v <- unlist(sonagi.words.l)
sonagi.word.v <- sonagi.word.v[which(sonagi.word.v != "")]
~~~

### 1.3. 명사 추출

`KoNLP` 팩키지, 세종사전을 사용해서 명사를 추출해 내고, 이를 `table` 함수로 
빈도를 계산해서 단어 구름에 넣을 사전준비를 한다.



~~~{.r}
suppressMessages(library(KoNLP))
~~~



~~~{.output}
Warning: package 'KoNLP' was built under R version 3.2.5

~~~



~~~{.output}
Warning: package 'hash' was built under R version 3.2.5

~~~



~~~{.r}
suppressMessages(library(RColorBrewer))

useSejongDic()
~~~



~~~{.output}
Backup was just finished!
87007 words were added to dic_user.txt.

~~~



~~~{.r}
sonagi.nouns.l <- sapply(sonagi.word.v, extractNoun, USE.NAMES=F)

sonagi.wc.t <- table(unlist(sonagi.nouns.l))
~~~

### 1.4. 단어구름 시각화

`brewer.pal.info`에서 최대 가능 색상과 범주 및 색맹지원여부를 확인하고,
색맹과 가장 많은 색상을 지원하는 팔레트를 선정하고 `wordcloud`에 넣어 시각화한다.


~~~{.r}
suppressMessages(library(wordcloud))
wordcloud(names(sonagi.wc.t), freq=sonagi.wc.t, scale=c(6, 0.3), min.freq=10,
          random.order=T, rot.per=.1, colors=brewer.pal(12,"Paired"))
~~~

<img src="fig/ml-text-sonagi-wordcloud-1.png" title="" alt="" style="display: block; margin: auto;" />