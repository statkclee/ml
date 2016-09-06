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
> * 단어 빈도수를 분석한다.



~~~{.r}
##======================================================================================================
## 01. 트위터 인증
##======================================================================================================
rm(list=ls())

source("02. code/text_processing_fun.R")
~~~



~~~{.output}
Warning in file(filename, "r", encoding = encoding): 파일 '02. code/
text_processing_fun.R'를 여는데 실패했습니다: No such file or directory

~~~



~~~{.output}
Error in file(filename, "r", encoding = encoding): 커넥션을 열 수 없습니다

~~~



~~~{.r}
# twitter_auth(): 트위터 계정 인증
# twitter_clean_text(): 트위터 텍스트 전처리 
# twitter_word_cloud(): 단어구름 시각

twitter_auth()
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "twitter_auth"를 찾을 수 없습니다

~~~



~~~{.r}
##======================================================================================================
## 02. 트위터 데이터 가져오기
##======================================================================================================

tw <- searchTwitter('#rstats', n = 100, lang="en", since = '2016-04-01')
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "searchTwitter"를 찾을 수 없습니다

~~~



~~~{.r}
tw_rd_df <- twListToDF(tw)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "twListToDF"를 찾을 수 없습니다

~~~



~~~{.r}
##======================================================================================================
## 03. 트위터 데이터 전처리
##======================================================================================================

tw_df <- twitter_clean_text(tw_rd_df$text)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "twitter_clean_text"를 찾을 수 없습니다

~~~



~~~{.r}
##======================================================================================================
## 04. TDM, DTM
##======================================================================================================

#tw_corpus <- VCorpus(DataframeSource(tw_rd_df[,1:2]))
tw_corpus <- Corpus(VectorSource(tw_df))
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "Corpus"를 찾을 수 없습니다

~~~



~~~{.r}
# tdm
tw_tdm <- TermDocumentMatrix(tw_corpus)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "TermDocumentMatrix"를 찾을 수 없습니다

~~~



~~~{.r}
# dtm
tw_dtm <- DocumentTermMatrix(tw_corpus)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "DocumentTermMatrix"를 찾을 수 없습니다

~~~



~~~{.r}
# wfm
library(qdap)
~~~



~~~{.output}
Error in library(qdap): there is no package called 'qdap'

~~~



~~~{.r}
library(dplyr)
~~~



~~~{.output}
Warning: package 'dplyr' was built under R version 3.2.5

~~~



~~~{.output}

Attaching package: 'dplyr'

~~~



~~~{.output}
The following objects are masked from 'package:stats':

    filter, lag

~~~



~~~{.output}
The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union

~~~



~~~{.r}
tw_wfm <- data.frame(wfm(tw_df))
~~~



~~~{.output}
Error in data.frame(wfm(tw_df)): 함수 "wfm"를 찾을 수 없습니다

~~~



~~~{.r}
tw_wfm$term <- rownames(tw_wfm)
~~~



~~~{.output}
Error in rownames(tw_wfm): 객체 'tw_wfm'를 찾을 수 없습니다

~~~



~~~{.r}
tw_wfm %>% arrange(desc(all)) %>% head(10)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'tw_wfm'를 찾을 수 없습니다

~~~



~~~{.r}
# 단어주머니 빈도 분석
tw_tdm_m <- as.matrix(tw_tdm)
~~~



~~~{.output}
Error in as.matrix(tw_tdm): 객체 'tw_tdm'를 찾을 수 없습니다

~~~



~~~{.r}
term_freq <- rowSums(tw_tdm_m)
~~~



~~~{.output}
Error in is.data.frame(x): 객체 'tw_tdm_m'를 찾을 수 없습니다

~~~



~~~{.r}
term_freq <- sort(term_freq, decreasing = TRUE)
~~~



~~~{.output}
Error in sort(term_freq, decreasing = TRUE): 객체 'term_freq'를 찾을 수 없습니다

~~~



~~~{.r}
barplot(term_freq[1:10], col = "tan", las=2)
~~~



~~~{.output}
Error in barplot(term_freq[1:10], col = "tan", las = 2): 객체 'term_freq'를 찾을 수 없습니다

~~~





