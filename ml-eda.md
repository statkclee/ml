---
layout: page
title: xwMOOC 기계학습
subtitle: 탐색적 데이터 분석 (EDA)
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 
> ## 학습목표 {.objectives}
>
> * 기계학습 모형구축에 적용될 데이터를 이해한다.
> * 탐색적 데이터 분석(EDA)을 적용한다.



## 1. [탐색적 데이터 분석](https://en.wikipedia.org/wiki/Exploratory_data_analysis) [^r-marketing]

[^r-marketing]: [ Chapman, Christopher N., McDonnell Feit, Elea (2005), R for Marketing Research and Analytics, Springer Press](http://www.springer.com/us/book/9783319144351)

기계학습 알고리즘이 학습을 얼마나 잘 하느냐는 전적으로 데이터의 품질과 데이터에 담긴 정보량에 달려있다. 
따라서, 가능하면 정보를 잃지 않으면서 기계학습 알고리즘이 학습할 환경을 구비하는 것이 매우 중요하다.

데이터 과학 프로세스는 현실세계에서 데이터를 수집하고, 데이터를 전처리하고, 정제된 데이터셋을 만든 뒤에 모형과 
알고리듬을 개발하여 데이터 과학 결과물을 사람을 위한 의사결정에 사용하는 것이 하나고, 
데이터제품을 통해 알고리듬으로 현실세계에 영향을 주는 것이 또 하나다.
특히, 정제된 데이터셋과 모형, 알고리즘을 개발하는 과정에서 탐색적 자료분석 과정이 꼭 수반된다.

탐색적 자료 분석과정은 미국의 튜키박사에 의해 창안되었고, 
가설검증이나 모형을 적용하기 전에 데이터가 스스로에 대해 사람에게 정보를 전달하도록 만드는 방법으로 
시각적인 기법을 사용도 하고 5-숫자요약(5-number summary) 등 다양한 방법을 적용한다.

<img src="fig/ml-data-science-process.png" width="57%" alt="데이터 과학 프로세스">

## 2. 데이터 탐색과정

수십년에 걸쳐 개발된 R언어는 수많은 통계학자를 비롯한 다양한 연구자와 실무담당자가 만들어 낸 팩키지와 
그들만의 사용법이 존재한다는 사실을 인정하고, 나름대로 효율적이고 효과적인 나만의 방법론을 만들어 나갈 것을 추천한다. 
다음에 제시되는 데이터 탐색과정은 그 과정 중 하나일 뿐이니 참고로 활용한다.

1. `readr` 팩키지의 `read_csv` 함수를 사용해서 데이터를 불러오고, 이는 자동으로 `tlb_df` 데이터프레임으로 가져온다. 
1. `tlb_df` 자료형은 기존 전통적인 R을 활용한 자료분석과정을 많이 단축할 수 있다.
    * `dim()` 함수를 사용하여 차원정보, 즉 행과 열 정보를 불러온다.
    * `head()`, `tail()` 함수를 사용해서 데이터프레임 처음과 끝을 살펴본다.
    * `car` 팩키지의 `some()` 함수를 사용해서 임의 행을 추출하여 살펴볼 수 있다.
    * `str()` 함수를 사용해서 데이터프레임 자료구조를 파악한다. 특히, `factor` 요인 범주형 자료를 문자열 자료구조대신 필요하면 변환한다.
1. `summary()` 함수를 사용해서 전체적으로 데이터프레임에 들어있는 데이터셋에 대한 정보를 한번에 확인한다.
    * 동일한 기능이지만, `psych` 라이브러리에 있는 `describe()` 함수를 사용해 기초통계량을 한번에 뽑아낸다.

`store.df` 데이터는 "R for Marketing Research and Analytics" 책에 소개된 데이터를 예제로 사용한다.


~~~{.r}
# tbl_df 자료구조를 데이터프레임 대신 사용한 사례 
library(readr)
store.df <- read_csv("http://r-marketing.r-forge.r-project.org/data/rintro-chapter3.csv")
~~~



~~~{.output}
Parsed with column specification:
cols(
  storeNum = col_integer(),
  Year = col_integer(),
  Week = col_integer(),
  p1sales = col_integer(),
  p2sales = col_integer(),
  p1price = col_double(),
  p2price = col_double(),
  p1prom = col_integer(),
  p2prom = col_integer(),
  country = col_character()
)

~~~



~~~{.r}
head(store.df)
~~~



~~~{.output}
# A tibble: 6 x 10
  storeNum  Year  Week p1sales p2sales p1price p2price p1prom p2prom
     <int> <int> <int>   <int>   <int>   <dbl>   <dbl>  <int>  <int>
1      101     1     1     127     106    2.29    2.29      0      0
2      101     1     2     137     105    2.49    2.49      0      0
3      101     1     3     156      97    2.99    2.99      1      0
4      101     1     4     117     106    2.99    3.19      0      0
5      101     1     5     138     100    2.49    2.59      0      1
6      101     1     6     115     127    2.79    2.49      0      0
# ... with 1 more variables: country <chr>

~~~



~~~{.r}
# 전체적인 데이터프레임 자료 이해
library("psych")
psych::describe(store.df)
~~~



~~~{.output}
         vars    n   mean    sd median trimmed   mad    min    max range
storeNum    1 2080 110.50  5.77 110.50  110.50  7.41 101.00 120.00  19.0
Year        2 2080   1.50  0.50   1.50    1.50  0.74   1.00   2.00   1.0
Week        3 2080  26.50 15.01  26.50   26.50 19.27   1.00  52.00  51.0
p1sales     4 2080 133.05 28.37 129.00  131.08 26.69  73.00 263.00 190.0
p2sales     5 2080 100.16 24.42  96.00   98.05 22.24  51.00 225.00 174.0
p1price     6 2080   2.54  0.29   2.49    2.53  0.44   2.19   2.99   0.8
p2price     7 2080   2.70  0.33   2.59    2.69  0.44   2.29   3.19   0.9
p1prom      8 2080   0.10  0.30   0.00    0.00  0.00   0.00   1.00   1.0
p2prom      9 2080   0.14  0.35   0.00    0.05  0.00   0.00   1.00   1.0
country*   10 2080    NaN    NA     NA     NaN    NA    Inf   -Inf  -Inf
         skew kurtosis   se
storeNum 0.00    -1.21 0.13
Year     0.00    -2.00 0.01
Week     0.00    -1.20 0.33
p1sales  0.74     0.66 0.62
p2sales  0.99     1.51 0.54
p1price  0.28    -1.44 0.01
p2price  0.32    -1.40 0.01
p1prom   2.66     5.10 0.01
p2prom   2.09     2.38 0.01
country*   NA       NA   NA

~~~


> ### 마케팅에서 활용되는 일반적인 변환 {.callout}
> 
> 박스-코스 변환(Box-Cox transformation)을 통해 $\lambda$ 변수에 값을 설정해서 정규분포에 대한
> 최적변환을 파악할 수 있는데, `car` 팩키지 `powerTransform()`와 짝궁 함수 `bcPower()`를 사용해도 되지만,
> 일반적으로 마케팅에서 자주 목도되는 일반적인 변환은 다음과 같다.
> 
> |   변수   | 일반적인 변환 |
> |-----------------|--------------------|
> | 매출, 판매수량, 가격, 가구소득 | $log(x)$  |
> | 지리적 거리 | $\frac{1}{x}$, $\frac{1}{x^2}$, $log(x)$ |
> | 효용에 근거한 시장점유율, 선호점유율 | $\frac {e^x}{1+e^x}$ |
> | 우측으로 꼬리가 긴 분포 | $\sqrt{x}, log(x)$ |
> | 좌측으로 꼬리가 긴 분포 | $x^2$ |


