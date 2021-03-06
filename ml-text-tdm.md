---
layout: page
title: xwMOOC 기계학습
subtitle: 단어문서행렬 -- 단어 빈도
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 


> ### 텍스트 데이터 분석 목표 {.getready}
>
> * 트위터에서 트윗을 불러와서 단어문서행렬로 변환한다.
> * 전처리 과정을 거쳐 단어 빈도수를 단어문서행렬을 통해 산출한다.
> * 막대그래프로 빈도수 높은 단어를 시각화한다.

### 1. 트위터 인증 

`text_processing_fun.R` 함수내에 `twitter_auth()` 인증함수로 저장하여 인증과정을 캡슐화하여 숨겨놓는다.


~~~{.r}
##======================================================================================================
## 01. 트위터 인증
##======================================================================================================
rm(list=ls())

source("text_processing_fun.R")
# twitter_auth(): 트위터 계정 인증
# twitter_clean_text(): 트위터 텍스트 전처리 
# twitter_word_cloud(): 단어구름 시각

twitter_auth()
~~~



~~~{.output}
[1] "Using direct authentication"

~~~

### 2. 트위터 데이터 불러오기

`twitter_auth()`를 통해 인증을 거친 뒤에 `searchTwitter` 함수를 통해 `#rstats` 해쉬태그를 갖는 트윗을 
불러온다. 원활한 데이터 작업을 위해 `twListToDF` 함수로 트윗 리스트를 데이터프레임으로 변환한다.


~~~{.r}
##======================================================================================================
## 02. 트위터 데이터 가져오기
##======================================================================================================

tw <- searchTwitter('#rstats', n = 100, lang="en", since = '2016-04-01')
tw_rd_df <- twListToDF(tw)
~~~

### 3. 트위터 데이터 전처리

`twitter_clean_text` 함수를 통해 텍스트 트윗 메시지를 전처리한다. 전처리 과정에는 
소문자 변환, 구두점 제거, 불용어 처리 등등이 포함된다.


~~~{.r}
##======================================================================================================
## 03. 트위터 데이터 전처리
##======================================================================================================
tw_df <- twitter_clean_text(tw_rd_df$text)
~~~

### 4. 단어문서행렬 

단어분석행렬을 통한 방법이 일반적으로 많이 사용된다. 이를 위해 입력값이 데이터프레임인 경우 `DataframeSource`,
벡터인 경우 `VectorSource`를 사용하여 말뭉치(Corpus)로 변환하고, 이를 `TermDocumentMatrix` 함수에 넣어 
단어문서행렬을 생성한다.

물론 텍스트를 바로 넣어 `wfm` 단어빈도행렬(Word Frequency Matrix)을 생성시켜 분석을 하기도 하지만 일반적인 방식은 아니다. 


~~~{.r}
##======================================================================================================
## 04. TDM, DTM
##======================================================================================================
suppressMessages(library(tm))
suppressMessages(library(qdap))
~~~



~~~{.output}
Warning: package 'qdap' was built under R version 3.2.5

~~~



~~~{.r}
#tw_corpus <- VCorpus(DataframeSource(tw_rd_df[,1:2]))
tw_corpus <- Corpus(VectorSource(tw_df))

# tdm
tw_tdm <- TermDocumentMatrix(tw_corpus)

# dtm
tw_dtm <- DocumentTermMatrix(tw_corpus)

# wfm
library(qdap)
suppressMessages(library(dplyr))
~~~



~~~{.output}
Warning: package 'dplyr' was built under R version 3.2.5

~~~



~~~{.r}
tw_wfm <- data.frame(wfm(tw_df))
tw_wfm$term <- rownames(tw_wfm)
tw_wfm %>% arrange(desc(all)) %>% head(10)
~~~



~~~{.output}
   all    term
1   50  rstats
2   37     for
3   36       r
4   27      in
5   25     the
6   25    with
7   20      to
8   16       a
9   15     new
10  15 package

~~~


### 5. 빈도수 분석 및 시각화

단어문서행렬이 생성되면 이를 행렬로 변환하여 행방향으로 합을 구하면 단어빈도수가 계산되고,
열방향으로 합을 구하면 문서빈도수가 계산된다. 단어 빈도수를 내림차순으로 계산하고 나서,
가장 많이 사용되는 단여 10개를 골라 막대그래프로 시각화한다.


~~~{.r}
# 단어주머니 빈도 분석
tw_tdm_m <- as.matrix(tw_tdm)
term_freq <- rowSums(tw_tdm_m)
term_freq <- sort(term_freq, decreasing = TRUE)

barplot(term_freq[1:10], col = "tan", las=2)
~~~

<img src="fig/twitter-freq-1.png" title="plot of chunk twitter-freq" alt="plot of chunk twitter-freq" style="display: block; margin: auto;" />





