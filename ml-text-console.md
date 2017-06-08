# xwMOOC 기계학습
 


## 1. 탐색적 데이터분석 - 요약 통계량 

### 1.1. 동기

R에서 다양한 탐색적 데이터분석을 위한 팩키지와 함수가 다수 제공되고 있지만, 데이터과학자에게 딱 이거다하는 
도구를 찾기는 힘들다. 특히 요약통계량을 통해 탐색적 데이터분석을 시작할 때 더욱 그렇다.

탐색적 데이터 분석에서 가장 먼저 구조를 살펴보는 것으로 작업을 시작한다.
`str`, `summary` 함수가 큰 역할을 수행한다. `str`, `summary` 함수가 제공하는 기능을 tidyverse 팩키지 `glimpse` 함수가 대신하기도 한다.

한걸음 더 들어가면 숫자형에 대해서는 나름 충분한 정보가 명령어 하나로 제공되지만, 범주형 변수가 섞여 있거나 
숫자형 변수에 대해 세밀히 살펴보려면 `mosaic::favstats()` 함수를 사용해야 하는 번거러음도 존재한다. 


~~~{.r}
# 2. 텍스트 기반 데이터분석 동기 ---------------------------------------
# https://rawgit.com/ropenscilabs/skimr/master/blog.html
## 2.1 구조분석
str(mtcars)
~~~



~~~{.output}
'data.frame':	32 obs. of  11 variables:
 $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
 $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
 $ disp: num  160 160 108 258 360 ...
 $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
 $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
 $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
 $ qsec: num  16.5 17 18.6 19.4 17 ...
 $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
 $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
 $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
 $ carb: num  4 4 1 1 2 1 4 2 2 4 ...

~~~



~~~{.r}
summary(mtcars)
~~~



~~~{.output}
      mpg             cyl             disp             hp       
 Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0  
 1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5  
 Median :19.20   Median :6.000   Median :196.3   Median :123.0  
 Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7  
 3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0  
 Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0  
      drat             wt             qsec             vs        
 Min.   :2.760   Min.   :1.513   Min.   :14.50   Min.   :0.0000  
 1st Qu.:3.080   1st Qu.:2.581   1st Qu.:16.89   1st Qu.:0.0000  
 Median :3.695   Median :3.325   Median :17.71   Median :0.0000  
 Mean   :3.597   Mean   :3.217   Mean   :17.85   Mean   :0.4375  
 3rd Qu.:3.920   3rd Qu.:3.610   3rd Qu.:18.90   3rd Qu.:1.0000  
 Max.   :4.930   Max.   :5.424   Max.   :22.90   Max.   :1.0000  
       am              gear            carb      
 Min.   :0.0000   Min.   :3.000   Min.   :1.000  
 1st Qu.:0.0000   1st Qu.:3.000   1st Qu.:2.000  
 Median :0.0000   Median :4.000   Median :2.000  
 Mean   :0.4062   Mean   :3.688   Mean   :2.812  
 3rd Qu.:1.0000   3rd Qu.:4.000   3rd Qu.:4.000  
 Max.   :1.0000   Max.   :5.000   Max.   :8.000  

~~~



~~~{.r}
## 2.2 숫자형과 범주형 변수 요약 통계량 한계 ---------------------------

summary(mtcars$mpg) # 숫자형 좋아요
~~~



~~~{.output}
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  10.40   15.43   19.20   20.09   22.80   33.90 

~~~



~~~{.r}
summary(mtcars$cyl) # 범주형 이건 뭐죠???
~~~



~~~{.output}
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  4.000   4.000   6.000   6.188   8.000   8.000 

~~~



~~~{.r}
### 범주형에 대한 충분한 설명이 부족
mosaic::tally(~cyl, data=mtcars) 
~~~



~~~{.output}
cyl
 4  6  8 
11  7 14 

~~~



~~~{.r}
table(mtcars$cyl, mtcars$vs) ## 범주에 대한 라벨도 없음
~~~



~~~{.output}
   
     0  1
  4  1 10
  6  3  4
  8 14  0

~~~



~~~{.r}
### 그래서 다음과 같은 팩키지에 함수가 지원되지만, 뭔가 엉뚱한 곳에 가있는 듯한 느낌
mosaic::favstats(~mpg, data=mtcars) 
~~~



~~~{.output}
  min     Q1 median   Q3  max     mean       sd  n missing
 10.4 15.425   19.2 22.8 33.9 20.09062 6.026948 32       0

~~~

### 1.2. 요약통계량 

`skimr` 팩키지가 이런 갈증을 해소시킬 수 있을 것으로 보인다.

- `skim(chickwts)`: 숫자형과 범주형 변수를 구분하고 각 변수 유형에 맞춰 의미있는 요약통계량을 한눈에 제공한다.
- `skimr::skim(chickwts) %>% dplyr::filter(stat == "hist")`: 데이터프레임으로 저장되어 이를 다시 뽑아 사용하기도 유용하다.
- `skim(babynames)`: 문자형에도 잘 동작한다.



~~~{.r}
# 2. 치킨 무게 데이터 --------------------------------------
skim(chickwts)
~~~



~~~{.output}
Numeric Variables
# A tibble: 1 x 13
     var    type missing complete     n     mean      sd   min
   <chr>   <chr>   <dbl>    <dbl> <dbl>    <dbl>   <dbl> <dbl>
1 weight numeric       0       71    71 261.3099 78.0737   108
# ... with 5 more variables: `25% quantile` <dbl>, median <dbl>, `75%
#   quantile` <dbl>, max <dbl>, hist <chr>

Factor Variables
# A tibble: 1 x 7
    var   type complete missing     n n_unique
  <chr>  <chr>    <dbl>   <dbl> <dbl>    <dbl>
1  feed factor       71       0    71        6
# ... with 1 more variables: stat <chr>

~~~



~~~{.r}
skimr::skim(chickwts) %>%
    dplyr::filter(stat == "hist")
~~~



~~~{.output}
# A tibble: 1 x 5
     var    type  stat      level value
   <chr>   <chr> <chr>      <chr> <dbl>
1 weight numeric  hist ▂▇▂▇▇▃▇▆▂▂     0

~~~



~~~{.r}
# 3. 자동차 데이터 --------------------------------------
skim(mtcars) %>% dplyr::filter(stat=="hist") %>% 
    as_tibble() %>% 
    print.listof(locale = locale(encoding = "UTF-8")) %>% 
    do.call(cbind, .)
~~~



~~~{.output}
var :
 [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
[11] "carb"

type :
 [1] "numeric" "numeric" "numeric" "numeric" "numeric" "numeric" "numeric"
 [8] "numeric" "numeric" "numeric" "numeric"

stat :
 [1] "hist" "hist" "hist" "hist" "hist" "hist" "hist" "hist" "hist" "hist"
[11] "hist"

level :
 [1] "▂▅▇▇▇▃▁▁▂▂" "▆▁▁▁▃▁▁▁▁▇" "▇▇▅▁▁▇▃▂▁▃" "▆▆▇▂▇▂▃▁▁▁" "▃▇▂▂▃▆▅▁▁▁"
 [6] "▂▂▂▂▇▆▁▁▁▂" "▂▃▇▇▇▅▅▁▁▁" "▇▁▁▁▁▁▁▁▁▆" "▇▁▁▁▁▁▁▁▁▆" "▇▁▁▁▆▁▁▁▁▂"
[11] "▆▇▂▁▇▁▁▁▁▁"

value :
 [1] 0 0 0 0 0 0 0 0 0 0 0

~~~



~~~{.output}
      var    type      stat   level        value
 [1,] "mpg"  "numeric" "hist" "▂▅▇▇▇▃▁▁▂▂" "0"  
 [2,] "cyl"  "numeric" "hist" "▆▁▁▁▃▁▁▁▁▇" "0"  
 [3,] "disp" "numeric" "hist" "▇▇▅▁▁▇▃▂▁▃" "0"  
 [4,] "hp"   "numeric" "hist" "▆▆▇▂▇▂▃▁▁▁" "0"  
 [5,] "drat" "numeric" "hist" "▃▇▂▂▃▆▅▁▁▁" "0"  
 [6,] "wt"   "numeric" "hist" "▂▂▂▂▇▆▁▁▁▂" "0"  
 [7,] "qsec" "numeric" "hist" "▂▃▇▇▇▅▅▁▁▁" "0"  
 [8,] "vs"   "numeric" "hist" "▇▁▁▁▁▁▁▁▁▆" "0"  
 [9,] "am"   "numeric" "hist" "▇▁▁▁▁▁▁▁▁▆" "0"  
[10,] "gear" "numeric" "hist" "▇▁▁▁▆▁▁▁▁▂" "0"  
[11,] "carb" "numeric" "hist" "▆▇▂▁▇▁▁▁▁▁" "0"  

~~~



~~~{.r}
# 4. 붓꽃 데이터 ------------------------------------------
skim(iris)
~~~



~~~{.output}
Numeric Variables
# A tibble: 4 x 13
           var    type missing complete     n     mean        sd   min
         <chr>   <chr>   <dbl>    <dbl> <dbl>    <dbl>     <dbl> <dbl>
1 Petal.Length numeric       0      150   150 3.758000 1.7652982   1.0
2  Petal.Width numeric       0      150   150 1.199333 0.7622377   0.1
3 Sepal.Length numeric       0      150   150 5.843333 0.8280661   4.3
4  Sepal.Width numeric       0      150   150 3.057333 0.4358663   2.0
# ... with 5 more variables: `25% quantile` <dbl>, median <dbl>, `75%
#   quantile` <dbl>, max <dbl>, hist <chr>

Factor Variables
# A tibble: 1 x 7
      var   type complete missing     n n_unique
    <chr>  <chr>    <dbl>   <dbl> <dbl>    <dbl>
1 Species factor      150       0   150        3
# ... with 1 more variables: stat <chr>

~~~



~~~{.r}
# 4. 아기 이름 데이터 --------------------------------------
library(babynames)
skim(babynames)
~~~



~~~{.output}
Numeric Variables
# A tibble: 3 x 13
    var    type missing complete       n         mean           sd
  <chr>   <chr>   <dbl>    <dbl>   <dbl>        <dbl>        <dbl>
1     n integer       0  1858689 1858689 1.833830e+02 1555.3570871
2  prop numeric       0  1858689 1858689 1.391443e-04    0.0011702
3  year numeric       0  1858689 1858689 1.973376e+03   33.6978783
# ... with 6 more variables: min <dbl>, `25% quantile` <dbl>,
#   median <dbl>, `75% quantile` <dbl>, max <dbl>, hist <chr>

Character Variables
# A tibble: 2 x 9
    var      type complete missing empty       n   min   max n_unique
* <chr>     <chr>    <dbl>   <dbl> <dbl>   <dbl> <dbl> <dbl>    <dbl>
1  name character  1858689       0     0 1858689     2    15    95025
2   sex character  1858689       0     0 1858689     1     1        2

~~~

> ### 윈도우 스파크 히스토드램(spark histogram) 표시 문제 {.callout}
> 
> "&#9602;&#9605;&#9607;" 기호가 "`<U+2582><U+2585><U+2587>`"으로 표기되는 문제가 있다.
> 고질적인 문제로 윈도우 환경에서는 아직까지 해결책은 없다.
> 다만, `Sys.setlocale( locale='Chinese' )` 명령어를 실행한 후에 `View` 명령어로 확인하는 방법과,
> `print.listof(locale = locale(encoding = "UTF-8"))` 명령어를 사용하는 방법이 편법으로 존재한다. [^skimr-windows]

[^skimr-windows]: [Skimr - cant seem to produce the histograms](https://stackoverflow.com/questions/44253848/skimr-cant-seem-to-produce-the-histograms)


## 2. 콘솔에서 텍스트를 활용한 시각화

GUI가 일반화되기 이전에 데이터를 분석한 경험이 있는 분은 아마도 콘솔에서 그래프를 그려본 향수가 느껴질 수도 있다.
탐색적 데이터분석을 콘솔에서 가볍게 실행해 보는 방법을 살펴보자. 활용될 팩키지는 다음과 같다.


- [skimr](https://github.com/ropenscilabs/skimr): 텍스트 기반 요약 통계량 
- [txtplot](https://cran.r-project.org/web/packages/txtplot/index.html): 텍스트 기반 시각화 
- [NostalgiR: Advanced Text-Based Plots](https://cran.r-project.org/web/packages/NostalgiR/)

범주형 변수 시각화를 위한 막대그래프, 연속형 단변량 변수 시각화를 위한 분포(density), 
히스토그램(histogram), 상자그림(boxplot)이 우선 떠오르고, 시계열 데이터를 위한 자기상관 그래프, 
변수간 관계를 일별할 수 있는 산점도가 있다.



~~~{.r}
# 0. 환경설정 -------------------------------------------------
# devtools::install_github("hadley/colformat")
# devtools::install_github("ropenscilabs/skimr")
# install.packages("txtplot")

library(skimr)
library(tidyverse)
library(txtplot)

## 2.1. 수식 그래프 --------------------------------------
txtcurve(log(x), 0.1, 4, xlab = "Log")
~~~



~~~{.output}
   ++------------+------------+------------+------------+--+
   |                                       **************  |
 1 +                           ************                +
   |                    ********                           |
   |              ******                                   |
 0 +          *****                                        +
   |        ***                                            |
   |      **                                               |
-1 +    **                                                 +
   |   **                                                  |
   |  **                                                   |
-2 +  *                                                    +
   ++------------+------------+------------+------------+--+
    0            1            2            3            4   
                              Log                           

~~~



~~~{.r}
txtcurve(x^2, -4, 4, xlab = "x^2")
~~~



~~~{.output}
   +--+-----------+------------+------------+-----------+--+
15 +  **                                               **  +
   |   **                                             **   |
   |    **                                           **    |
   |      **                                       **      |
10 +       **                                     **       +
   |         **                                 **         |
   |          **                               **          |
 5 +            **                           **            +
   |              ***                     ***              |
   |                ****               ****                |
 0 +                    ***************                    +
   +--+-----------+------------+------------+-----------+--+
     -4          -2            0            2           4   
                              x^2                           

~~~



~~~{.r}
## 2.2. 막대 그래프 --------------------------------------
votes <- factor(c("기호1번", "기호1번", "기호1번", "기호2번", "기호2번", "기호3번"))

txtbarchart(votes, pch="+",  width = round(options()$width*0.7))
~~~



~~~{.output}
50 +-+----------+----------+----------+----------+-+
   | +                                             |
40 + +                                             +
   | +                     +                       |
30 + +                     +                       +
   | +                     +                       |
20 + +                     +                       +
   | +                     +                     + |
10 + +                     +                     + +
   | +                     +                     + |
 0 +-+----------+----------+----------+----------+-+
     1         1.5         2         2.5         3  
Legend: 1=기호1번, 2=기호2번, 3=기호3번

~~~



~~~{.r}
## 2.3. 상자그림 그래프 --------------------------------------
txtboxplot(rnorm(1000,0,0.5), rnorm(100, 1))
~~~



~~~{.output}
        -1          0           1          2           3    
 |-------+----------+-----------+----------+-----------+---|
                +---+---+                                   
1   ------------|   |   |------------                       
                +---+---+                                   
                         +------+------+                    
2   ---------------------|      |      |----------------    
                         +------+------+                    
Legend: 1=rnorm(1000, 0, 0.5), 2=rnorm(100, 1)

~~~



~~~{.r}
## 2.4. 분포 그래프 ------------------------------------------
txtdensity(rnorm(500), pch = "+")
~~~



~~~{.output}
    +--+--------+-------+--------+-------+--------+-------++
    |                       ++++++++++                     |
    |                     +++        +++                   |
0.3 +                    ++            ++                  +
    |                   ++              ++                 |
    |                  ++                ++                |
0.2 +                 ++                   ++              +
    |                ++                     ++             |
    |               ++                       +++           |
0.1 +             +++                          ++          +
    |           +++                              ++        |
    |         +++                                 +++      |
    | +++++++++                                     +++++  |
  0 +--+--------+-------+--------+-------+--------+-------++
      -3       -2      -1        0       1        2       3 

~~~



~~~{.r}
## 2.5. 히스토그램 ------------------------------------------
nos.hist(rnorm(500), freq=TRUE)
~~~



~~~{.output}
      +-----------+-------------+--------------+-----------+
  100 +                        o                           +
      |                        o                           |
F     |                        o  o                        |
r  80 +                    o   o  o                        +
e     |                    o   o  o   o                    |
q  60 +                    o   o  o   o                    +
u     |                o   o   o  o   o                    |
e  40 +                o   o   o  o   o   o                +
n     |                o   o   o  o   o   o  o             |
c  20 +            o   o   o   o  o   o   o  o             +
y     |            o   o   o   o  o   o   o  o   o         |
    0 + o   o   o  o   o   o   o  o   o   o  o   o   o  o  +
      +-----------+-------------+--------------+-----------+
                 -2             0              2            

~~~



~~~{.r}
## 2.6. 자기상관 그래프 ------------------------------------------
txtacf(arima.sim(list(ar = 0.7), n = 100))
~~~



~~~{.output}
    +-+------------+-----------+------------+-----------+--+
  1 + *                                                    +
    | *                                                    |
0.8 + *                                                    +
    | *  *                                                 |
0.6 + *  *                                                 +
    | *  * *                                               |
    | *  * *  *                                            |
0.4 + *  * *  *                                            +
    | *  * *  * *  *                                       |
0.2 + *  * *  * *  * *  *                     *  *         +
    | *  * *  * *  * *  * *  * *            * *  * *  * *  |
  0 + *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  +
    +-+------------+-----------+------------+-----------+--+
      0            5          10           15          20   

~~~



~~~{.r}
## 2.7. 산점도 ------------------------------------------
txtplot(iris$Sepal.Length, iris$Sepal.Width, xlab="Sepal.Length", ylab="Sepal.Width")
~~~



~~~{.output}
  4.5 +-----------+------------+------------+-------------++
S     |                 *  *                               |
e   4 +             *       *                              +
p     |            *   *   *                          * *  |
a     |     *   * **  **                       *           |
l 3.5 +     *  *  ***  **      *  **                       +
.     |   * * *** **          *    ** * * ***  *           |
W   3 + * *    ** *    *  **  *** *** *** *   ***   * *    +
i     |             *     ***  ** *** *   *       *   *    |
d 2.5 +         *  *    * ***   *  *    *             *    +
t     |    *    * *     *          *                       |
h   2 +           *            *  *                        +
      +-----------+------------+------------+-------------++
                  5            6            7             8 
                          Sepal.Length                      

~~~

