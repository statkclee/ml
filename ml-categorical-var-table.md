---
layout: page
title: xwMOOC 기계학습
subtitle: 범주형 변수와 표
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 
> ## 학습목표 {.objectives}
>
> * 범주형 변수와 짝꿍인 표를 생성하는 작업흐름을 이해한다.
> * 표를 생성하는 3가지 자료구조를 이해한다.
> * 표를 생성하고, 표현하고, 시각화 과정을 실습한다.



## 1. R로 표 작성 [^DescTools-table]

[^DescTools-table]: [Tables in R - A quick practical overview](https://cran.r-project.org/web/packages/DescTools/vignettes/TablesInR.pdf)

데이터를 표로 생성하는 것은 상황에 따라서 별것 아니기도 하지만, 매우 복잡한 작업이 되기도 한다.
종국에는 데이터를 계수하는 것으로 종결된다. 하지만, 2차원 이상일 경우, 
R로 표현되는 데이터 자료형이 다양하고, 기술적으로도 추상화 개념을 도입할 필요가 있다.
따라서, 데이터를 요구되는 표로 나타내고 처리하는데 경우에 따라서 매우 많은 함수를 취사선택하게 된다.

범주형 데이터분석은 표를 작성하면서 시작한다고 해도 과언은 아니다. R에는 2차원 혹은 다차원 표를 
가지고 작업하는데 필요한 도구가 상당히 많이 존재하지만 완벽하지는 않는다. `DescTools` 팩키지에는 
실무적인 측면에서 이런 간극을 매울 수 있는 도구를 일부 제공한다.

## 2. 표 생성

분할표(Contingency Table) 데이터를 R에 입력하는 방법은 다수 있다. 
다음 표는 Agresti (2007) p.39, 정당과 성별를 표로 작성한 교차표다. 
이를 R 데이터로 저장한다.

|       |   |         |   Party     |            |
|-------|---|---------|-------------|------------|
|       | 	| Democrat| Independent | Republican |
| Gender| M	| 762     | 327         | 468	     |
|       | F	| 484     | 239         | 477	     |

1. `TextToTable()` 함수 활용 : `DescTools` 팩키지에서 지원되는 함수.


~~~{.r}
txt <- "
  Democrat, Independent, Republican
M, 762, 327, 468
F, 484, 239, 477"
TextToTable(txt, sep=",", dimnames=c("gender", "party")) 
~~~



~~~{.output}
      party
gender Democrat Independent Republican
     M      762         327        468
     F      484         239        477

~~~

2. `as.table()` 함수와 `rbind()` 함수 사용

`rbind()` 함수와 `as.table()` 함수를 사용해서 입력 데이터를 `table` 자료형으로 변환시키고 나서,
`dimnames()` 함수로 표에 사용되는 라벨을 부여하여 분할표를 완성시킨다.


~~~{.r}
tab <- as.table(rbind(c(762, 327, 468), c(484, 239, 477))) 

dimnames(tab) <- list(gender = c("M", "F"),
                      party = c("Democrat", "Independent", "Republican"))
tab
~~~



~~~{.output}
      party
gender Democrat Independent Republican
     M      762         327        468
     F      484         239        477

~~~

3. `matrix()` 함수를 사용

`matrix()` 함수를 사용하여 동일하게 표를 구성할 수도 있다. 이 경우 `byrow=TRUE`로 설정해서
행렬이 행으로 쌓이게 한다.


~~~{.r}
as.table(matrix(c(762, 327, 468, 484, 239, 477), nrow=2, byrow=TRUE,
                dimnames=list(gender= c("M", "F"),
                              party = c("Democrat", "Independent", "Republican")))) 
~~~



~~~{.output}
      party
gender Democrat Independent Republican
     M      762         327        468
     F      484         239        477

~~~

4. 다차원 표

다차원 표, 예를 들어 $2 \times 2 \times 2$ 표를 생성할 경우 배열을 사용한다.
이럴 경우 첫번째 차원은 행, 두번째 차원은 열, 세번째 차원은 깊이 순으로 저장된다.


~~~{.r}
salary <- array(
          c(38, 12, 102, 141, 12, 9, 136, 383),
          dim=c(2, 2, 2),
          dimnames=list(exposure = c("exposed", "not"),
                        disease = c("case", "control"),
                        salary = c("<1000", ">=1000"))
 ) 
~~~

`read.ftable()` 함수를 사용해서 고차원 표를 텍스트 파일로 표현된 정보를 표로 표현할 수도 있다.


~~~{.r}
txt <-
"      Sex Male                   Female
       Eye Brown Blue Hazel Green Brown Blue Hazel Green
Hair
Black       32    11   10   3    36     9    5      2
Brown       53    50   25   15   66     34   29    14
Red         10    10   7    7    16     7    7      7
Blond       3     30   5    8    4      64   5      8
"
tab <- as.table(read.ftable(textConnection(txt))) 
~~~

### 2.1. 숫자형 변수에서 범주형 자료 생성

`DescTools` 팩키지의 `Freq()` 함수를 활용해서 숫자형 변수를 범주형으로 표현하기 수월하다.
`Freq()` 함수는 `hist()`함수의 기본설정을 그대로 사용하여 숫자형 변수를 범주형으로 변경시킨다.


~~~{.r}
Freq(d.pizza$temperature) 
~~~



~~~{.output}
      level   freq   perc  cumfreq  cumperc
1   [15,20]  3e+00   0.3%    3e+00     0.3%
2   (20,25]  3e+01   2.6%    3e+01     2.8%
3   (25,30]  6e+01   5.0%    9e+01     7.8%
4   (30,35]  5e+01   4.1%    1e+02    11.9%
5   (35,40]  1e+02   8.5%    2e+02    20.4%
6   (40,45]  1e+02  11.1%    4e+02    31.5%
7   (45,50]  2e+02  18.7%    6e+02    50.3%
8   (50,55]  3e+02  22.9%    9e+02    73.2%
9   (55,60]  2e+02  20.6%    1e+03    93.8%
10  (60,65]  7e+01   6.2%    1e+03   100.0%

~~~

### 2.2. expand 기능 활용

빈도수가 크지 않는 표를 작성하는 경우 `expand.grid()` 함수를 활용하여 빈도수를 입력하는 것이 여러모로 편리하다.
요인을 expand.grid() 함수로 처리하고, 벡터로 빈도수를 `c()` 함수로 작성한다.
`expand.grid()` 함수로 요인사이 가능한 모든 조합을 표현하고, `count` 변수로 조합하여 데이터프레임으로 생성시킨다.
그리고 나서 `xtabs` 함수를 사용해서 표로 변환시킨다.


~~~{.r}
tab <- data.frame(expand.grid(
  Hair = c("Black", "Brown", "Red", "Blond"),
  Eye = c("Brown", "Blue", "Hazel", "Green"),
  Sex = c("Male", "Female")),
  count = c(32,53,10,3,11,50,10,30,10,25,7,5,3,15,7,8,
            36,66,16,4,9,34,7,64,5,29,7,5,2,14,7,8) )

tab %>% head
~~~



~~~{.output}
   Hair   Eye  Sex count
1 Black Brown Male    32
2 Brown Brown Male    53
3   Red Brown Male    10
4 Blond Brown Male     3
5 Black  Blue Male    11
6 Brown  Blue Male    50

~~~

## 3. 범주형 데이터 구성

표를 작성하는데 있어 가장 먼저 확인해야 되는 사항은 범주형 자료구조를 확인하는데 있다.

1. **관측점 하나에 빈도수 하나인 경우(Case-by-Case)**: `data.frame` 혹은 행렬에 원자료에 각행에 사례 한가지만 기록되어 
저장되어 있는 경우.

`Untable()` 함수는 데이터프레임을 입력받아 관측점 하나에 빈도수 하나인 데이터프레임으로 변환시킨다.


~~~{.r}
Untable(UCBAdmissions) %>% head
~~~



~~~{.output}
     Admit Gender Dept
1 Admitted   Male    A
2 Admitted   Male    A
3 Admitted   Male    A
4 Admitted   Male    A
5 Admitted   Male    A
6 Admitted   Male    A

~~~

2. **빈도수(Frequency)**

각 요인별 조합을 유일무이한 값으로 계수하여 각 행에 저장함. 흔히 가중치(weights)라고도 하고,
`Freq` 칼럼이 이에 해당함.


~~~{.r}
data.frame(UCBAdmissions) %>% head
~~~



~~~{.output}
     Admit Gender Dept Freq
1 Admitted   Male    A  512
2 Rejected   Male    A  313
3 Admitted Female    A   89
4 Rejected Female    A   19
5 Admitted   Male    B  353
6 Rejected   Male    B  207

~~~

3. **표(Table)**

다차원 표, 배열, 행렬이 이에 해당.


~~~{.r}
UCBAdmissions[,,Dept=c("A", "B")]
~~~



~~~{.output}
, , Dept = A

          Gender
Admit      Male Female
  Admitted  512     89
  Rejected  313     19

, , Dept = B

          Gender
Admit      Male Female
  Admitted  353     17
  Rejected  207      8

~~~

세가지 범주형 데이터 표현방식은 각기 다른 사용도와 의미가 내포되어 있다. 예를 들어 2번 표현은 1번 표현보다 
훨씬 적은 저장공간을 차지하게 되고, 1번 표현방식은 즉각적으로 데이터를 표로 작성하는데 용이하다.


## 4. 표 만들기(Tabulate)

`DescTools` 팩키지에 포함된 `HairEyeColor`객체는 `table` 자료형을 갖고 있다. 
이를 `Untable` 명령어를 통해 한 행에 빈도수 하나만 갖는 데이터로 변환을 시킨다.
그리고 이를 바탕으로 다양한 표를 생성시켜 보자.

### 4.1. 단변량 범주형 변수


~~~{.r}
d.col <- Untable(HairEyeColor)
d.col %>% dplyr::filter(Sex=="Male", Hair=="Blond", Eye=="Brown")
~~~



~~~{.output}
   Hair   Eye  Sex
1 Blond Brown Male
2 Blond Brown Male
3 Blond Brown Male

~~~

요인형 자료를 갖고 표를 생성시키는 방법은 `table` 함수로 빈도수, `prop.table` 함수로 백분율을 표로 표현한다.


~~~{.r}
table(d.col$Hair)
~~~



~~~{.output}

Black Brown   Red Blond 
  108   286    71   127 

~~~



~~~{.r}
prop.table(table(d.col$Hair))
~~~



~~~{.output}

    Black     Brown       Red     Blond 
0.1824324 0.4831081 0.1199324 0.2145270 

~~~

`Freq` 함수를 사용해서 단변량 범주형 변수의 경우 빈도수와 백분율을 간단히 표로 표현한다.


~~~{.r}
Freq(d.col$Hair, ord="desc")
~~~



~~~{.output}
   level   freq   perc  cumfreq  cumperc
1  Brown  3e+02  48.3%    3e+02    48.3%
2  Blond  1e+02  21.5%    4e+02    69.8%
3  Black  1e+02  18.2%    5e+02    88.0%
4    Red  7e+01  12.0%    6e+02   100.0%

~~~

### 4.2. 이변량 범주형 변수

이변량 범주형 변수를 표로 표현하는 전통적인 방식은 `table`과 `prop.table` 함수를 사용하는 것은 동일하다.
하지만, 행 백분율/열 백분율/전체 백분율을 표현하여야 하기 때문에 `margin=` 인수를 넣어 제어한다.

- `margin=1` : 행 백분율
- `margin=2` : 열 백분율
- `margin=NULL` : 전체 백분율


~~~{.r}
with(d.col, table(Hair, Sex))
~~~



~~~{.output}
       Sex
Hair    Male Female
  Black   56     52
  Brown  143    143
  Red     34     37
  Blond   46     81

~~~

혹은 `plyr`, `dplyr` 팩키지의 `count()` 함수를 사용하면 `table`, `as.data.frame` 단계를 거치지 않고 일관된 방식으로 
표생성에 필요한 데이터를 만들어 낼 수 있다. 이를 `xtabs` 함수와 결합하여 표 


~~~{.r}
dplyr_tbl <- d.col %>% count(Hair, Sex)
xtabs(n~Hair+Sex, dplyr_tbl)
~~~



~~~{.output}
       Sex
Hair    Male Female
  Black   56     52
  Brown  143    143
  Red     34     37
  Blond   46     81

~~~


~~~{.r}
with(d.col, prop.table(table(Hair, Eye), 1)) # 행기준
~~~



~~~{.output}
       Eye
Hair         Brown       Blue      Hazel      Green
  Black 0.62962963 0.18518519 0.13888889 0.04629630
  Brown 0.41608392 0.29370629 0.18881119 0.10139860
  Red   0.36619718 0.23943662 0.19718310 0.19718310
  Blond 0.05511811 0.74015748 0.07874016 0.12598425

~~~



~~~{.r}
with(d.col, prop.table(table(Hair, Eye), 2)) # 열기준  
~~~



~~~{.output}
       Eye
Hair         Brown       Blue      Hazel      Green
  Black 0.30909091 0.09302326 0.16129032 0.07812500
  Brown 0.54090909 0.39069767 0.58064516 0.45312500
  Red   0.11818182 0.07906977 0.15053763 0.21875000
  Blond 0.03181818 0.43720930 0.10752688 0.25000000

~~~



~~~{.r}
with(d.col, prop.table(table(Hair, Eye), margin=NULL)) # 전체
~~~



~~~{.output}
       Eye
Hair          Brown        Blue       Hazel       Green
  Black 0.114864865 0.033783784 0.025337838 0.008445946
  Brown 0.201013514 0.141891892 0.091216216 0.048986486
  Red   0.043918919 0.028716216 0.023648649 0.023648649
  Blond 0.011824324 0.158783784 0.016891892 0.027027027

~~~

`PercTable()` 함수를 `rfrq=` 인자를 상대빈도수를 제어한다. 
`011`은 행과 열 백분율만 출력한다.

- rfrq 첫번째 : 전체 백분율
- rfrq 두번째 : 행 백분율
- rfrq 세번째 : 열 백분율



~~~{.r}
PercTable(Hair ~ Eye, data=d.col, rfrq="111", margins=c(1,2))
~~~



~~~{.output}
             Eye
              Brown   Blue  Hazel  Green    Sum
Hair                                           

Black freq    7e+01  2e+01  2e+01  5e+00  1e+02
      perc    11.5%   3.4%   2.5%   0.8%  18.2%
      p.row   63.0%  18.5%  13.9%   4.6%      .
      p.col   30.9%   9.3%  16.1%   7.8%      .

Brown freq    1e+02  8e+01  5e+01  3e+01  3e+02
      perc    20.1%  14.2%   9.1%   4.9%  48.3%
      p.row   41.6%  29.4%  18.9%  10.1%      .
      p.col   54.1%  39.1%  58.1%  45.3%      .

Red   freq    3e+01  2e+01  1e+01  1e+01  7e+01
      perc     4.4%   2.9%   2.4%   2.4%  12.0%
      p.row   36.6%  23.9%  19.7%  19.7%      .
      p.col   11.8%   7.9%  15.1%  21.9%      .

Blond freq    7e+00  9e+01  1e+01  2e+01  1e+02
      perc     1.2%  15.9%   1.7%   2.7%  21.5%
      p.row    5.5%  74.0%   7.9%  12.6%      .
      p.col    3.2%  43.7%  10.8%  25.0%      .

Sum   freq    2e+02  2e+02  9e+01  6e+01  6e+02
      perc    37.2%  36.3%  15.7%  10.8% 100.0%
      p.row       .      .      .      .      .
      p.col       .      .      .      .      .

~~~

`Margins(HairEyeColor, ord="desc")` 명령어처럼 `Margins()` 함수가 있어 표 자료형을 입력받아 
각 표차원별로 표를 신속하게 생성할 수 있다.


## 5. 표 데이터 자료형 변환

표데이터를 다음과 같이 `Case-by-Case`, `빈도수 가중치`, `표` 세가지 자료형이 존재한다.

1. **관측점 하나에 빈도수 하나인 경우(Case-by-Case)**: `d.col <- Untable(HairEyeColor)`
1. **빈도수(Frequency)**: `d.weight <- as.data.frame(HairEyeColor)`
1. **표(Table)**: `tab <- HairEyeColor`


- `사례별(Case-by-Case)` &rarr; `빈도수(Frequency)` :  `as.data.frame(table(d.col))`
    - `사례별(Case-by-Case)` &rarr; 표(Table) &rarr; `빈도수(Frequency)` 변환시킴
- `빈도수(Frequency)` &rarr; `사례별(Case-by-Case)` : `Untable(d.weight)`
    - `library(DescTools)` 팩키지 `Untable()` 함수 사용
- `사례별(Case-by-Case)` &rarr; `표(Table)` :  `table(d.col)`
-  `표(Table)` &rarr; `사례별(Case-by-Case)` : `Untable(tab)`
- `빈도수(Frequency)` &rarr; `표(Table)` : `xtabs(Freq ~ ., d.weight)`
- `표(Table)` &rarr; `빈도수(Frequency)` : `as.data.frame(tab)`


## 6. 시각화

`mosaicplot()` 모자이크 그래프를 사용하여 범주형 데이터를 시각화 한다.
먼저 데이터를 준비하고 색상을 정의한다. 그리고 나서 `PlotMosaic()` 함수를 호출하여 도식화한다.


~~~{.r}
tab <- as.table(apply(HairEyeColor, c(1,2), sum))
tab <- tab[,c("Brown","Hazel","Green","Blue")]
cols <- SetAlpha(c("sienna4", "burlywood", "chartreuse3", "slategray1"), 0.6)
PlotMosaic(tab, col=cols, main = "Hair ~ Eye") 
~~~

<img src="fig/unnamed-chunk-19-1.png" title="plot of chunk unnamed-chunk-19" alt="plot of chunk unnamed-chunk-19" style="display: block; margin: auto;" />


~~~{.r}
PercTable(tab, freq=FALSE, rfrq="010")
~~~



~~~{.output}
      Eye
       Brown Hazel Green  Blue
Hair                          
Black  63.0% 13.9%  4.6% 18.5%
Brown  41.6% 18.9% 10.1% 29.4%
Red    36.6% 19.7% 19.7% 23.9%
Blond   5.5%  7.9% 12.6% 74.0%

~~~



~~~{.r}
prop.table(margin.table(tab, 1)) 
~~~



~~~{.output}
Hair
    Black     Brown       Red     Blond 
0.1824324 0.4831081 0.1199324 0.2145270 

~~~

`horiz = FALSE` 인자를 넘겨 행과 열을 바꿔 모자이크 그래프로 도식화도 가능하다.


~~~{.r}
cols <- SetAlpha(c("moccasin", "salmon1", "wheat3", "gray32"), 0.8)
PlotMosaic(tab, col=cols, main = "Hair ~ Eye", horiz = FALSE) 
~~~

<img src="fig/unnamed-chunk-21-1.png" title="plot of chunk unnamed-chunk-21" alt="plot of chunk unnamed-chunk-21" style="display: block; margin: auto;" />


~~~{.r}
PercTable(tab, freq=FALSE, rfrq="001")
~~~



~~~{.output}
      Eye
       Brown Hazel Green  Blue
Hair                          
Black  30.9% 16.1%  7.8%  9.3%
Brown  54.1% 58.1% 45.3% 39.1%
Red    11.8% 15.1% 21.9%  7.9%
Blond   3.2% 10.8% 25.0% 43.7%

~~~



~~~{.r}
prop.table(margin.table(tab, 2))
~~~



~~~{.output}
Eye
    Brown     Hazel     Green      Blue 
0.3716216 0.1570946 0.1081081 0.3631757 

~~~

`PlotCirc()` 함수를 통해 두 변수의 각 수준별 관련성을 도식화하는 것도 가능하다.


~~~{.r}
# 원그래프
cols <- c("moccasin", "salmon1",
          "wheat3", "gray32",
          "slategray1", "chartreuse3",
          "burlywood", "sienna4")
PlotCirc(t(tab), acol=cols)
~~~

<img src="fig/unnamed-chunk-23-1.png" title="plot of chunk unnamed-chunk-23" alt="plot of chunk unnamed-chunk-23" style="display: block; margin: auto;" />
