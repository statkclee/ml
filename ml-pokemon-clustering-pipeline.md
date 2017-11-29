---
layout: page
title: xwMOOC 기계학습
subtitle: 군집분석(Clustering) - 포켓몬
output:
  html_document: 
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 
> ## 학습목표 {.objectives}
>
> * 초딩에게 인기가 많은 포켓몬 캐릭터를 군집으로 묶어낸다.
> * 주성분 분석을 통해 전처리하고 나서 계층적 군집화 및 k-평균 군집화 통계분석을 수행한다.
> * 계층적 군집화와 평균 군집화 결과를 비교한다.




## 1. 포켓몬 데이터 [^prcatical-guide-to-cluster-analaysis-in-r] {#pokemon-data-unsupervised}

[^prcatical-guide-to-cluster-analaysis-in-r]: [Mr Alboukadel Kassambara (2017), Practical Guide to Cluster Analysis in R: Unsupervised Machine Learning, Amazon Digital Services LLC](https://www.amazon.com/Practical-Guide-Cluster-Analysis-Unsupervised-ebook/dp/B077KQBXTN/ref=la_B076JDHZC8_1_1?s=books&ie=UTF8&qid=1511857119&sr=1-1)

[캐글 포켓몬](https://www.kaggle.com/abcsds/pokemon) 데이터가 공개되어 721종류 포켓몬에 대한 데이터와 포켓몬 유형에 대한 정보가 담겨있다.

각 포켓몬에 대한 데이터 원본은 [http://pokemondb.net/pokedex](http://pokemondb.net/pokedex)에서 확인한다.

### 1.1 포켓몬 데이터 불러오기 {#import-pokemon-data}

포켓몬 데이터를 캐글에서 다운로드 받아 불러온다. 
"Shuckle" 포켓몬은 이상점에 해당되니 대상에서 제거하고, 주성분분석과 군집분석을 위해 필요한 칼럼만 뽑아낸다.


~~~{.r}
# 0. 환경설정 --------------------------------------------
#library(tidyverse)

#1. 포켓몬 데이터 ---------------------------------------
pkmon_dat <- read_csv("data/Pokemon.csv") %>% dplyr::filter(Name != "Shuckle")
~~~



~~~{.output}
Parsed with column specification:
cols(
  `#` = col_integer(),
  Name = col_character(),
  `Type 1` = col_character(),
  `Type 2` = col_character(),
  Total = col_integer(),
  HP = col_integer(),
  Attack = col_integer(),
  Defense = col_integer(),
  `Sp. Atk` = col_integer(),
  `Sp. Def` = col_integer(),
  Speed = col_integer(),
  Generation = col_integer(),
  Legendary = col_character()
)

~~~



~~~{.r}
pkmon_dat <- column_to_rownames(pkmon_dat, 'Name')

pkmon_df <- pkmon_dat %>%  
    dplyr::select(attack = Attack, defense = Defense, sp_attack = `Sp. Atk`, sp_defense =`Sp. Def`, speed = Speed) 

pkmon_legend <- ifelse(pkmon_dat$Legendary =="True", TRUE, FALSE)
~~~

<img src="fig/pokemon-eda-clustering.png" alt="포켓몬 캐릭터 군집분석" width="77%" />

<img src="fig/pokemon-clustering-pipeline.png" alt="포켓몬 군집분석 파이프라인" width="77%" />


