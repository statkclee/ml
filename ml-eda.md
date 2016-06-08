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

데이터 과학 프로세스는 현실세계에서 데이터를 수집하고, 데이터를 전처리하고, 정제된 데이터셋을 만든 뒤에 모형과 알고리듬을 개발하여 데이터 과학 결과물을 사람을 위한 의사결정에 사용하는 것이 하나고, 데이터제품을 통해 알고리듬으로 현실세계에 영향을 주는 것이 또 하나다.
특히, 정제된 데이터셋과 모형 & 알고리듬 개발 과정에서 탐색적 자료분석 과정이 꼭 수반된다.

탐색적 자료 분석과정은 미국의 튜키박사에 의해 창안되었고, 가설검증이나 모형을 적용하기 전에 데이터가 스스로에 대해 사람에게 정보를 전달하도록 만드는 방법으로 시각적인 기법을 사용도 하고 5-숫자요약(5-number summary) 등 다양한 방법을 적용한다.

<img src="fig/ml-data-science-process.png" width="57%" alt="데이터 과학 프로세스">

## 2. 데이터 탐색과정

수십년에 걸쳐 개발된 R언어는 수많은 통계학자를 비롯한 다양한 연구자와 실무담당자가 만들어 낸 팩키지와 그들만의 사용법이 존재한다는 사실을 인정하고, 나름대로 효율적이고 효과적인 나만의 방법론을 만들어 나갈 것을 추천한다. 다음에 제시되는 데이터 탐색과정은 그 과정 중 하나일 뿐이니 참고로 활용한다.

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
head(store.df)
~~~



~~~{.output}
  storeNum Year Week p1sales p2sales p1price p2price p1prom p2prom country
1      101    1    1     127     106    2.29    2.29      0      0      US
2      101    1    2     137     105    2.49    2.49      0      0      US
3      101    1    3     156      97    2.99    2.99      1      0      US
4      101    1    4     117     106    2.99    3.19      0      0      US
5      101    1    5     138     100    2.49    2.59      0      1      US
6      101    1    6     115     127    2.79    2.49      0      0      US

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




## 3. 통계 모형 개발과정

통계모형 개발과정은 데이터 과학 프로세스에서 크게 차이가 나지 않는다. 다만, 일반적인 통계모형을 개발할 경우 다음과 같은 과정을 거치게 되고, 지난한 과정이 될 수도 있다.

1. 데이터를 정제하고, 모형에 적합한 데이터(R과 모형 팩키지와 소통이 될 수 있는 데이터형태)가 되도록 준비한다.
1. 변수에 대한 분포를 분석하고 기울어짐이 심한 경우 변수변환도 적용한다.
1. 변수와 변수간에, 종속변수와 설명변수간에 산점도와 상관계수를 계산한다. 특히 변수간 상관관계가 $r > 0.9$ 혹은 근처인 경우 변수를 빼거나 다른 방법을 강구한다.
1. 동일한 척도로 회귀계수를 추정하고 평가하려는 경우, `scale()` 함수로 척도로 표준화한다.
1. 모형을 적합시킨 후에 잔차를 보고, 백색잡음(whitenoise)인지 확인한다. 만약, 잔차에 특정한 패턴이 보이는 경우 패턴을 잡아내는 모형을 새로 개발한다.
    1. `plot()` 함수를 사용해서 이상점이 있는지, 비선형관계를 잘 잡아냈는지 시각적으로 확인한다.
    1. 다양한 모형을 적합시키고 `R^2` 와 `RMSE`, 정확도 등 모형평가 결과가 가장 좋은 것을 선정한다.
    1. 절약성의 원리(principle of parsimony)를 필히 준수하여 가장 간결한 모형이 되도록 노력한다.
1. 최종 모형을 선택하고 모형에 대한 해석결과와 더불어 신뢰구간 정보를 넣어 마무리한다.    

> ### R 공식 {.callout}
> 
> 수학공식을 R공식으로 변환해서 표현해야 되는 사유는 자판을 통해 수식을 입력해야 한다는 한계에 기인한다.
> 따라서, 자판에 있는 키보드의 특수기호를 잘 활용하여 가장 가독성이 좋고 입력이 용이하게 나름대로 R에서 
> 구현한 방식은 다음과 같다.
> 
> 1. 주효과에 대해 변수를 입력으로 넣을 `+`를 사용한다.
> 1. 교호작용을 변수간에 표현할 때 `:`을 사용한다. 예를 들어 `x*y`는 `x+y+x:z`와 같다.
> 1. 모든 변수를 표기할 때 `.`을 사용한다. 
> 1. 종속변수와 예측변수를 구분할 때 `~`을 사용한다. `y ~ .`은 데이터프레임에 있는 모든 변수를 사용한다는 의미가 된다.
> 1. 특정변수를 제거할 때는 `-`를 사용한다. `y ~ . -x`는 모든 예측변수를 사용하고, 특정 변수 `x`를 제거한다는 의미가 된다.
> 1. 상수항을 제거할 때는 `-1`을 사용한다.
> 
> 
> | R 공식구문 | 수학 모형 | 설명 |
> |------------|---------------|-----------------------------|
> |`y~x`       | $y_i = \beta_0 + \beta_1 x_i + \epsilon_i$ | `x`를 `y`에 적합시키는 1차 선형회귀식 |
> |`y~x -1`       | $y_i = \beta_1 x_i + \epsilon_i$ | `x`를 `y`에 적합시 절편 없는 1차 선형회귀식 |
> |`y~x+z`       | $y_i = \beta_0 + \beta_1 x_i + \beta_2 z_i +\epsilon_i$ | `x`와 `z`를 `y`에 적합시키는 1차 선형회귀식 |
> |`y~x:z`       | $y_i = \beta_0 + \beta_1 x_i \times z_i +\epsilon_i$ | `x`와 `z` 교호작용 항을 `y`에 적합시키는 1차 선형회귀식 |
> |`y~x*z`       | $y_i = \beta_0 + \beta_1 x_i + \beta_2 z_i + \beta_1 x_i \times z_i +\epsilon_i$ | `x`와 `z`, 교호작용항을 `y`에 적합시키는 1차 선형회귀식 |


## 4. 전통적인 가내수공업 방식 모형개발 사례

데이터과학 제품을 만드는 방식은 여러가지 방식이 존재한다. 공학적인 방식으로 보면
장인이 제자에게 비법을 가미해서 전통적으로 내려오던 가내수공업 방식부터 컨베이어 벨트를 타고 포드생산방식을 거쳐
Mass Customization을 지나 기계학습과 딥러닝이 결합된 모형개발 방식까지 정말 다양한 방식이 혼재되어 있다.

전통적인 가내수공업 방식은 인간이 가장 많은 것을 이해하고 주문형 모형을 만들어내는 가장 최적의 방식이다.
이를 간략하게 살펴본다.


~~~{.r}
##========================================================
## 01. 데이터 준비
##========================================================
## 모의시험 데이터 생성

x <- seq(1, 100,1)
y <- x**2 + jitter(x, 1000)

df <- data.frame(x,y)
head(df)
~~~



~~~{.output}
  x          y
1 1 -107.82261
2 2  100.69141
3 3   35.46007
4 4 -150.01242
5 5  225.13046
6 6  -63.13950

~~~



~~~{.r}
##========================================================
## 02. 탐색적 데이터 분석
##========================================================
# 통계량
psych::describe(df)
~~~



~~~{.output}
  vars   n    mean      sd  median trimmed     mad     min      max
x    1 100   50.50   29.01   50.50   50.50   37.06    1.00   100.00
y    2 100 3446.14 3055.63 2695.96 3146.97 3294.81 -150.01 10211.21
     range skew kurtosis     se
x    99.00 0.00    -1.24   2.90
y 10361.22 0.62    -0.90 305.56

~~~



~~~{.r}
# 산점도
plot(x, y)
~~~

<img src="fig/traditional-modeling-1.png" title="plot of chunk traditional-modeling" alt="plot of chunk traditional-modeling" style="display: block; margin: auto;" />

~~~{.r}
##========================================================
## 03. 모형 적합
##========================================================

#---------------------------------------------------------
# 3.1. 선형회귀 적합
lm.m <- lm(y ~ x, data=df)
summary(lm.m)
~~~



~~~{.output}

Call:
lm(formula = y ~ x, data = df)

Residuals:
    Min      1Q  Median      3Q     Max 
-1019.0  -684.6  -177.7   558.6  1719.1 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) -1701.728    155.675  -10.93   <2e-16 ***
x             101.938      2.676   38.09   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 772.5 on 98 degrees of freedom
Multiple R-squared:  0.9367,	Adjusted R-squared:  0.9361 
F-statistic:  1451 on 1 and 98 DF,  p-value: < 2.2e-16

~~~



~~~{.r}
par(mfrow=c(1,2))
# 적합모형 시각화
plot(x,y, data=df, cex=0.7)
abline(lm.m, col='blue')

# 잔차 
plot(resid(lm.m))
abline(h=0, type='3', col='blue')
~~~

<img src="fig/traditional-modeling-2.png" title="plot of chunk traditional-modeling" alt="plot of chunk traditional-modeling" style="display: block; margin: auto;" />

~~~{.r}
#---------------------------------------------------------
# 3.2. 비선형회귀 적합
# 비선형회귀적합
df$x2 <- df$x**2

nlm.m <- lm(y ~ x + x2, data=df)
summary(nlm.m)
~~~



~~~{.output}

Call:
lm(formula = y ~ x + x2, data = df)

Residuals:
    Min      1Q  Median      3Q     Max 
-215.60 -106.88   14.37  104.39  182.19 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 38.99136   36.98903   1.054    0.294    
x           -0.45723    1.69050  -0.270    0.787    
x2           1.01381    0.01622  62.518   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 120.8 on 97 degrees of freedom
Multiple R-squared:  0.9985,	Adjusted R-squared:  0.9984 
F-statistic: 3.16e+04 on 2 and 97 DF,  p-value: < 2.2e-16

~~~



~~~{.r}
par(mfrow=c(1,2))
# 적합모형 시각화
plot(x, y, data=df, cex=0.7)
lines(x, fitted(nlm.m), col='blue')
# 잔차 
plot(resid(nlm.m), cex=0.7)
abline(h=0, type='3', col='blue')
~~~

<img src="fig/traditional-modeling-3.png" title="plot of chunk traditional-modeling" alt="plot of chunk traditional-modeling" style="display: block; margin: auto;" />

데이터를 준비하고 $y = \beta_0 + \beta_1 x + \beta_1 x^2$ 수식으로 돌아가는 시스템에서 데이터를 추출하고 이를 먼저 선형 모형으로 적합시키고 나서, 오차 및 모형 분석을 통한 후에 최종적으로 2차 모형을 적합시켜 잔차 및 모형 결과를 최종적으로 검증하는 것을 시연했다.
