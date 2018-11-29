---
layout: page
title: xwMOOC 기계학습
subtitle: 생존분석(Survival Analysis)
output:
  html_document: 
    toc: yes
    toc_float: true
    highlight: tango
    code_folding: show
    number_section: true
editor_options: 
  chunk_output_type: console
---
 



# 생존분석 개요 {#survival-overview}

[생존분석(Survival analysis)](https://ko.wikipedia.org/wiki/생존분석)은 통계학의 한 분야로, 
어떠한 현상이 발생하기까지에 걸리는 시간(time-to-event)에 대해 분석한다.

**중도절단(censoring)**은 데이터의 측정값이나 관찰치가 부분적으로만 알려진 상태로 생존 분석에서 손실된 데이터를 처리하는 방법이다. 
이상적으로는 표본의 생일과 사망일을 통해 생존 기간을 파악하는 것이 좋지만, 그렇지 못한 경우에 중도절단을 사용한다.
중도절단 자료가 필연적으로 발생되는 이유는 환자 거부로 인한 중도탈락, 연락두절로 인한 추적조사 불가, 사망/고장 발생 전 연구 종결 혹은 다른 원인으로 인한 사망/고장을 들 수 있다.
추적이 불가능(이사, 연락처 소실)

생존분석의 주된 관심사는 생존함수(survival function, $S(t)$)로 다음과 같이 정의한다.
시간은 항상 양수이고, 중도절단이 항상 대두되는 데이터 특성을 갖는다는 점에서 차이가 난다.

$$S(t) = 1-F(t) =\Pr(T > t)$$

생존함수는 특정한 시간 $t$ 보다 오래 생존할 확률로 $t$ 는 특정 시간, 
$T$ 는 사망에 이르는 시점을 나타내는 확률변수로 정의되며, $\Pr$은 확률함수가 된다.
특이한 점은 $$1-F(t)$$로 1에서 누적함수($F(t)$)를 뺀 것과 동일한데 항상 중도절단을 반영하게 되는 경우 차이점이 발생된다.

## 생존분석 질문 {#survival-question}

데이터에 생존분석을 통해 모형을 갖추게 되면 다음 질문에 답을 할 수 있다.

- 혈액암 진단을 받은 환자가 3년이상 생존할 확률은 얼마나 되나? 
    - 생존확률 $S(t)$.
- 택시를 잡기까지 얼마 시간을 기다려야 되는가?
    - 중위수 $t$ 시간.
- 구직자가 100명 있는데, 1년 후 얼마나 많은 사람이 직장을 구하나?
    - $100 \times S(t)$ 명.
    

## 생존분석 응용분야 [^application-of-survival] {#survival-application}

[^application-of-survival]: [Is survival analysis the right model for you?](https://www.analyticsvidhya.com/blog/2014/04/survival-analysis-model-you/)

생존분석 응용분야는 다음는 의학에서 많이 사용되지만 동일한 기법을 마케팅, 공학(신뢰성)에도 사용이 가능하다.

- 사업계획 수립 : 이탈하지 않고 잔존기간이 긴 고객의 특성을 파악하여 전략 수립
- LTV(Lifetime Value) 예측: LTV 가치에 맞춰 고객 대응
- 유효 고객 : 고객이 특정 시점까지 유효할지 예측
- 캠페인 평가 : 고객 이탈율(생존률)에 따라 캠페인 효과 모니터링
- 산업별 생존분석
    - 소매업: 신선식품구매고객이 비신선식품 구매까지 소요되는 시간
    - 제조업: 기계부품 수명(lifetime)
    - 공공: 사회적 중요사건이 발생할 때까지 걸리는 시간
    - 카탈로그 우편주문: 다음 주문까지 걸리는 시간
    - 주택모기지: 주택 모기지 상환까지 걸리는 시간
    - 보험: 보험증권권리 소멸에 걸리는 시간

## 생존분석 도구상자 {#survival-toolbox}

- 생존시간 기술
    - 생명표(Life tables)
    - 캐플란-마이어 곡선(Kaplan-Meier curves)
    - 생존함수(Survival function)
    - 위험함수(Hazard function)
- 두집단 이상 생존시간 비교     
    - 로그 순위검정(Log-rank test)
- 생존시간에 대한 연속형, 범주형 변수의 효과를 기술
    - Cox 비례위험 회귀모형 (Cox proportional hazards regression model)
    - 모수 생존모형(Parametric survival models)
    - 생존 나무모형(Survival trees)
    - 생존 확률숲(Survival random forests)

## 생존분석 R 팩키지 {#survival-toolbox-r-package}

[CRAN Task View: Survival Analysis](https://cran.r-project.org/web/views/Survival.html)에서 앞선 다양한 생존분석관련 프로젝트 관련 사항을 실시간으로 확인할 수 있다.

- [`survival`](https://cran.r-project.org/web/packages/survival/index.html): 기본 생존분석 도구 모음
- `survminer`: 생존분석 특화된 시각화 도구
- `raprt`, `partykit`: 생존 나무모형(Survival trees) [^survival-tree]
- `ranger`: 생존 확률숲(Survival random forests) [^rview-ranger] [^amunategui-survival]

[^survival-tree]: [stackoverflow, "Using a survival tree from the 'rpart' package in R to predict new observations"](https://stackoverflow.com/questions/30700627/using-a-survival-tree-from-the-rpart-package-in-r-to-predict-new-observations)

[^rview-ranger]: [Joseph Rickert(), "Survival Analysis with R" R Views](https://rviews.rstudio.com/2017/09/25/survival-analysis-with-r/)

[^amunategui-survival]: [http://amunategui.github.io, "Survival Ensembles: Survival Plus Classification for Improved Time-Based Predictions in R"](http://amunategui.github.io/survival-ensembles/index.html)


# 생존 분석 사례 [^data-camp-survival] {#survival-analysis-example}

[^data-camp-survival]: [DataCamp, Survival Analysis in R For Beginners](https://www.datacamp.com/community/tutorials/survival-analysis-R)


## 데이터 {#survival-analysis-example-data}

`ovarian`(난소) 관련 질병으로 인한 생존시간을 살펴본다. 
`survival` 팩키지에 포함된 데이터셋으로 "Survival in a randomised trial comparing two treatments for ovarian cancer" 난소암에 대한 두가지 처방을 비교하여 생존시간에 대한 차이에 대한 정보를 담고 있다.

데이터를 가져와서 필요한 데이터 정제작업을 수행한다.


~~~{.r}
# 0. 환경설정 -----
library(tidyverse)
library(survival)
library(survminer)
library(janitor)
library(extrafont)
loadfonts()

# 1. 데이터 -----
data(ovarian)

# 2. 데이터 전처리 -----
ovarian <- ovarian %>% 
  tbl_df %>% 
  mutate(rx = factor(rx, levels = c("1", "2"), labels = c("A", "B")),
         resid.ds = factor(resid.ds, levels = c("1", "2"), labels = c("no", "yes")),
         ecog.ps = factor(ecog.ps, levels = c("1", "2"), labels = c("good", "bad"))) %>% 
  mutate(age_group = ifelse(age >=50, "old", "young") %>% as.factor)

DT::datatable(ovarian)
~~~

<!--html_preserve--><div id="htmlwidget-199440ef9a94b783144f" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-199440ef9a94b783144f">{"x":{"filter":"none","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26"],[59,115,156,421,431,448,464,475,477,563,638,744,769,770,803,855,1040,1106,1129,1206,1227,268,329,353,365,377],[1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0],[72.3315,74.4932,66.4658,53.3644,50.3397,56.4301,56.937,59.8548,64.1753,55.1781,56.7562,50.1096,59.6301,57.0521,39.2712,43.1233,38.8932,44.6,53.9068,44.2055,59.589,74.5041,43.137,63.2192,64.4247,58.3096],["yes","yes","yes","yes","yes","no","yes","yes","yes","no","no","no","yes","yes","no","no","yes","no","no","yes","no","yes","yes","no","yes","no"],["A","A","A","B","A","A","B","B","A","B","A","B","B","B","A","A","A","A","B","B","B","A","A","B","B","B"],["good","good","bad","good","good","bad","bad","bad","good","bad","bad","good","bad","good","good","bad","bad","good","good","good","bad","bad","good","bad","good","good"],["old","old","old","old","old","old","old","old","old","old","old","old","old","old","young","young","young","young","old","young","old","old","young","old","old","old"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>futime<\/th>\n      <th>fustat<\/th>\n      <th>age<\/th>\n      <th>resid.ds<\/th>\n      <th>rx<\/th>\n      <th>ecog.ps<\/th>\n      <th>age_group<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[1,2,3]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


## 단변량 분석 - Kaplan-Meier 추정 {#survival-analysis-example-univariate}

이론에서 나온 생존확률($S(t)$)를 계산하기 위해서 Kaplan-Meier 추정값을 사용한다.

- 이론: $S(t) = 1-F(t) =\Pr(T > t)$
- 추정: $\hat{S}(t) = \prod\limits_{i; t_i < t} \frac{n_i - d_i}{n_i}$

여기서, $n_i$는 해당 시점($i$) 관측점수가 되고 $d_i$는 해당 시점($i$) 사건발생 건수가 된다.

[Kaplan-Meier Survival Estimates](https://www.statsdirect.com/help/survival_analysis/kaplan_meier.htm)에 나온 데이터를 바탕으로 캐플란-마이어 추정작업을 수행한다.


## 단변량 분석 {#survival-analysis-example-univariate-real-data}

단변량, 다변량 분석에 들어가기 전에 우선 생존분석 객체(`Surv()`)를 생성한다.
그후 `rx`, `resid.ds`... 변수를 생존시간에 대한 차이를 분석하는데 동원하다.
`ggsurvplot()` 시각화 함수에 `surv.median.line = "hv"` 인자를 넣어 50% 생존율을 갖는 경우 생존시간을 구하거나, 반대 얼마동안 생존해야 50% 생존율을 갖는지 시각화를 통해 쉽게 파악할 수 있고, 아울러 아래 `risk.table` 및 관련 인자를 넣어 누적 이벤트 혹은 누적 중도절단 건수도 파악할 수 있다.


~~~{.r}
# 3. 예측모형 -----
## 3.0. 생존모형 객체 -----
surv_object <- Surv(time = ovarian$futime, event = ovarian$fustat)

## 3.1. Kaplan-Meier -----
# ovarian_km <- survfit(surv_object ~ 1)
ovarian_km <- survfit(Surv(time=futime, event=fustat) ~ 1, data = ovarian)

ggsurvplot(ovarian_km, 
           conf.int = TRUE,
           palette = "darkgreen",
           risk.table = "nrisk_cumevents",
           cumevents = TRUE,
           cumcensor = TRUE,
           linetype = 1,
           tables.height = 0.2,
           surv.median.line = "hv",
           legend = "none")
~~~

<img src="fig/datacamp-survial-univariate-1.png" width="672" style="display: block; margin: auto;" />


집단간의 차이를 검정하는 `survfit()` 함수를 통해 log rank 검정을 수행한다.
그리고 `ggsurvplot()` 함수 `pval = TRUE` 인자를 넣게 되면 집단간 생존시간 차이에 대한 
통계검정 p-값도 산출해 준다.



~~~{.r}
# 3. 예측모형 -----

## 3.2. 생존모형: 단변량 -----
### log rank 검정(rx)
km_rx_survfit <- survfit(surv_object ~ rx, data = ovarian)

summary(km_rx_survfit)
~~~



~~~{.output}
Call: survfit(formula = surv_object ~ rx, data = ovarian)

                rx=A 
 time n.risk n.event survival std.err lower 95% CI upper 95% CI
   59     13       1    0.923  0.0739        0.789        1.000
  115     12       1    0.846  0.1001        0.671        1.000
  156     11       1    0.769  0.1169        0.571        1.000
  268     10       1    0.692  0.1280        0.482        0.995
  329      9       1    0.615  0.1349        0.400        0.946
  431      8       1    0.538  0.1383        0.326        0.891
  638      5       1    0.431  0.1467        0.221        0.840

                rx=B 
 time n.risk n.event survival std.err lower 95% CI upper 95% CI
  353     13       1    0.923  0.0739        0.789        1.000
  365     12       1    0.846  0.1001        0.671        1.000
  464      9       1    0.752  0.1256        0.542        1.000
  475      8       1    0.658  0.1407        0.433        1.000
  563      7       1    0.564  0.1488        0.336        0.946

~~~



~~~{.r}
ggsurvplot(km_rx_survfit, data = ovarian, pval = TRUE)
~~~

<img src="fig/datacamp-survial-univariate-km-1.png" width="672" style="display: block; margin: auto;" />

~~~{.r}
### log rank 검정(resid.ds)
km_resid_survfit <- survfit(surv_object ~ resid.ds, data = ovarian)

summary(km_resid_survfit)
~~~



~~~{.output}
Call: survfit(formula = surv_object ~ resid.ds, data = ovarian)

                resid.ds=no 
 time n.risk n.event survival std.err lower 95% CI upper 95% CI
  353     11       1    0.909  0.0867        0.754            1
  563      8       1    0.795  0.1306        0.577            1
  638      7       1    0.682  0.1536        0.438            1

                resid.ds=yes 
 time n.risk n.event survival std.err lower 95% CI upper 95% CI
   59     15       1    0.933  0.0644        0.815        1.000
  115     14       1    0.867  0.0878        0.711        1.000
  156     13       1    0.800  0.1033        0.621        1.000
  268     12       1    0.733  0.1142        0.540        0.995
  329     11       1    0.667  0.1217        0.466        0.953
  365     10       1    0.600  0.1265        0.397        0.907
  431      8       1    0.525  0.1310        0.322        0.856
  464      7       1    0.450  0.1321        0.253        0.800
  475      6       1    0.375  0.1296        0.190        0.738

~~~



~~~{.r}
ggsurvplot(km_resid_survfit, data = ovarian, pval = TRUE)
~~~

<img src="fig/datacamp-survial-univariate-km-2.png" width="672" style="display: block; margin: auto;" />


## 단변량 생존모형 - 와이블  {#survival-analysis-weibull-model}

Kaplan-Meier 모형을 시각화하면 계단모양으로 나타나는데 이를 부드러운 함수로 근사하고자 할 경우 와이블(weibull) 모형을 활용하면 좋다. `survfit()` 함수 대신에 `survreg()` 함수를 사용하면 기본 분포로 와이블이 지정되어 별도 `dist=`로 명시할 필요는 없다.


와이블 분포를 가정하고 생존확률 모형을 구축할 경우 `predict` 함수로 중위수 50% 생존확률과 90% 사람이 생존할 확률, 즉 10% 사망확률을 다음과 같이 계산한다.


~~~{.r}
weibull_survfit <- survreg(Surv(time=futime, event=fustat) ~ 1, data = ovarian, dist="weibull")

predict(weibull_survfit, type="quantile", p=1-0.5, newdata = data.frame(1))
~~~



~~~{.output}
       1 
880.3047 

~~~



~~~{.r}
predict(weibull_survfit, type="quantile", p=1-0.9, newdata = data.frame(1))
~~~



~~~{.output}
      1 
160.795 

~~~

### 단변량 생존모형 시각화 - 와이블  {#survival-analysis-weibull-model-viz}

생존확률을 시각화할 경우 별도 데이터프레임을 제작해야 한다.
생존확률 숫자순열을 생성하고 나서 이를 `weibull_survfit` 모형 예측값으로 넣어 예상 생존시간을 산출해낸다. 그리고 나서 이를 데이터 프레임으로 만들고 `ggsurvplot_df`에 넣어 시각화한다.


~~~{.r}
surv_prob <- seq(.99, .01, by = -.01)

surv_time <- predict(weibull_survfit, type = "quantile", p = 1 - surv_prob, newdata = data.frame(1))

surv_weibull_df <- tibble(time = surv_time, 
                          surv = surv_prob, 
                          upper = NA, 
                          lower = NA, 
                          std.err = NA) %>% as.data.frame()

ggsurvplot_df(fit = surv_weibull_df, surv.geom = geom_line)
~~~

<img src="fig/datacamp-survial-univariate-weibull-viz-1.png" width="672" style="display: block; margin: auto;" />

## 다변량 분석 {#survival-analysis-example-multivariate}

각각의 변수에 대해서 일일이 생존시간의 차이를 분석하는 대신에 
`coxph()` 함수로 회귀모형을 작성해서 모형을 구축하고 중요한 변수를 식별할 수 있다.

특히, `step()` 함수로 변수선정도 가능해서 최종 보형을 `ecog.ps`가 제거된 모형이고 
콕스 모형이 가정한 사항이 맞는지를 `cox.zph()` 함수로 검정하고 모형에 대한 이해를 위해서 
`ggforest()` 함수로 1을 기준으로 생존에 긍정 혹은 부정 영향을 미치는 변수에 대한 영향도를 
시각적으로 확인한다.



~~~{.r}
## 3.3. 생존모형: 다변량 -----
### 변수선택
coxph_full <- coxph(surv_object ~ rx + resid.ds + age_group + ecog.ps, 
                   data = ovarian)

coxph_step <- step(coxph_full, direction = "both", trace = 0)

### 최종모형
coxph_survfit <- coxph(surv_object ~ rx + resid.ds + age_group, data = ovarian)

### 가설검정
cox.zph(coxph_survfit)
~~~



~~~{.output}
                  rho chisq     p
rxB             0.269 0.744 0.388
resid.dsyes    -0.415 1.550 0.213
age_groupyoung -0.226 0.660 0.417
GLOBAL             NA 3.150 0.369

~~~



~~~{.r}
par(mfrow=c(2,2))
plot(cox.zph(coxph_survfit))

### 모형 시각화
ggforest(coxph_survfit, data = ovarian)
~~~

<img src="fig/datacamp-survial-multivariate-1.png" width="672" style="display: block; margin: auto;" />

# 재구매 사례분석 [^survival-sthda] {#survival-analysis-bought-again}

[^survival-sthda]: [STHDA: Statistical tools for high-throughput data analysis - "Cox Proportional-Hazards Model"](http://www.sthda.com/english/wiki/cox-proportional-hazards-model)

## 데이터 가져오기 {#survival-analysis-bought-again-import}

재구매 여부와 첫번째 구매 이후 경과 시간을 담은 데이터를 가져온다.


~~~{.r}
# 1. 탐색적 데이터 분석 -----

order_df  <- read_csv("data/next_order_clean.csv") %>%
    mutate_if(is.character, as.factor)

# 2. 탐색적 데이터 분석 -----
# 생략
~~~

## 재구매 확률 시각화 {#survival-analysis-bought-again-viz}

재구매 하지 않을 확률 전체를 시각화한다.


~~~{.r}
# 3. 생존분석 모형 -----
## 3.0. 생존객체 생성 
order_surv <- Surv(order_df$days, order_df$buy_again)

## 3.1. 단변량 분석
### 3.1.1. 전체 생존확률 -----
km_fit <- survfit(order_surv ~ 1, data = order_df)

ggsurvplot(km_fit, data = order_df, risk.table = TRUE,
           theme=theme_minimal(base_family="NanumGothic")) +
    labs(x="첫구매시점 이후 경과일", y="재구매하지 않은 확률")
~~~

<img src="fig/repurchase-data-viz-1.png" width="672" style="display: block; margin: auto;" />

## 단변량 분석 {#survival-analysis-bought-again-univariate}

변수가 많지는 않지만, 반품여부, 쿠폰 활용여부, 성별, 첫번째 구매시 구매총합을 대상으로 각각의
Kaplan-Meier 생존분석을 돌려 유의성 검증을 수행한다.


~~~{.r}
### 3.1.2. 유의적인 단변량 변수 -----
#### 변수명 선정
order_varname_v <- order_df %>% names %>% dput
~~~



~~~{.output}
c("days", "cart_value", "gender", "voucher", "returned", "buy_again"
)

~~~



~~~{.r}
order_covariates_v <- setdiff(order_varname_v, c("days", "buy_again"))

#### 단변량변수 생존분석 모형 적합
univ_formulas <- map(order_covariates_v,
                        function(x) as.formula(paste('Surv(days, buy_again) ~ ', x)))

univ_models <- map( univ_formulas, function(x){coxph(x, data = order_df)})

# Extract data 
univ_results <- map(univ_models,
                       function(x){ 
                           x <- summary(x)
                           p.value<-signif(x$wald["pvalue"], digits=2)
                           wald.test<-signif(x$wald["test"], digits=2)
                           beta<-signif(x$coef[1], digits=2);#coeficient beta
                           HR <-signif(x$coef[2], digits=2);#exp(beta)
                           HR.confint.lower <- signif(x$conf.int[,"lower .95"], 2)
                           HR.confint.upper <- signif(x$conf.int[,"upper .95"],2)
                           HR <- paste0(HR, " (", 
                                        HR.confint.lower, "-", HR.confint.upper, ")")
                           res<-c(beta, HR, wald.test, p.value)
                           names(res)<-c("beta", "HR (95% CI for HR)", "wald.test", 
                                         "p.value")
                           return(res)
                           #return(exp(cbind(coef(x),confint(x))))
                       })

univ_res_df <- t(as.data.frame(univ_results, check.names = FALSE)) %>% tbl_df

univ_res_df %>% 
    bind_cols(var_name = order_covariates_v) %>% 
    select(var_name, everything()) %>% 
    DT::datatable()
~~~

<!--html_preserve--><div id="htmlwidget-b54a318bfea2c4d00b1e" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b54a318bfea2c4d00b1e">{"x":{"filter":"none","data":[["1","2","3","4"],["cart_value","gender","voucher","returned"],["-0.0021","0.063","-0.29","-0.31"],["1 (1-1)","1.1 (0.99-1.1)","0.75 (0.68-0.82)","0.73 (0.66-0.8)"],["57","3.1","37","40"],["4.8e-14","0.079","1.3e-09","2.1e-10"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>var_name<\/th>\n      <th>beta<\/th>\n      <th>HR (95% CI for HR)<\/th>\n      <th>wald.test<\/th>\n      <th>p.value<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"order":[],"autoWidth":false,"orderClasses":false,"columnDefs":[{"orderable":false,"targets":0}]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

## 단변량 분석 시각화 {#survival-analysis-bought-again-univariate-viz}

앞서 분석한 단변량 분석을 통해 유의적으로 판정된 변수를 대상으로 시각화작업을 수행한다.



~~~{.r}
### 3.1.2. 단변량 변수: 바우처 -----
km_voucher_fit <- survfit(order_surv ~ voucher, data = order_df)

ggsurvplot(km_voucher_fit, data = order_df, pval=TRUE, risk.table = TRUE,
           ggtheme=theme_minimal(base_family="NanumGothic")) +
    labs(x="첫구매시점 이후 경과일", y="재구매하지 않을 확률", 
         title="바우처 효과", color = "바우처 지급여부")
~~~

<img src="fig/repurchase-data-univariate-viz-1.png" width="672" style="display: block; margin: auto;" />

~~~{.r}
### 3.1.3. 단변량 변수: 반품 -----
km_return_fit <- survfit(order_surv ~ returned, data = order_df)

ggsurvplot(km_return_fit, data = order_df, pval=TRUE, risk.table = TRUE,
           ggtheme = theme_minimal(base_family="NanumGothic")) +
    labs(x="첫구매시점 이후 경과일", y="재구매하지 않을 확률", 
         subtitle="반품 효과", color="반품여부")
~~~

<img src="fig/repurchase-data-univariate-viz-2.png" width="672" style="display: block; margin: auto;" />

~~~{.r}
### 3.1.4. 단변량 변수: 성별 -----
km_gender_fit <- survfit(order_surv ~ gender, data = order_df)

ggsurvplot(km_gender_fit, data = order_df, pval=TRUE, risk.table = TRUE,
           ggtheme = theme_minimal(base_family="NanumGothic")) +
    labs(x="첫구매시점 이후 경과일", y="재구매하지 않을 확률", 
         subtitle="성별(Gender) 효과", color="성별")
~~~

<img src="fig/repurchase-data-univariate-viz-3.png" width="672" style="display: block; margin: auto;" />


## 다변량 분석 시각화 {#survival-analysis-bought-again-multivariate}

모든 변수를 한번에 넣어 다변량 분석을 수행하고 변수선택과정을 통해 절약의 법칙(Principle of Parsimony)을 충족시킨다.
그리고 `cox.zph()` 함수로 콕스 비례위험모형의 가정사항을 점검하고 
`ggforest()` 함수로 각 변수가 재구매에 미치는 영향도를 살펴본다.



~~~{.r}
## 3.2. 다변량 분석 -----
### 3.2.1. 변수선택
order_cph_full <- coxph(order_surv ~ cart_value  + voucher + returned + gender, data = order_df)

(coxph_step <- step(order_cph_full, direction = "both", trace = 0))
~~~



~~~{.output}
Call:
coxph(formula = order_surv ~ cart_value + voucher + returned + 
    gender, data = order_df)

                 coef exp(coef)  se(coef)     z       p
cart_value  -0.002164  0.997839  0.000284 -7.62 2.6e-14
voucheryes  -0.294615  0.744819  0.047969 -6.14 8.2e-10
returnedyes -0.314829  0.729914  0.049470 -6.36 2.0e-10
gendermale   0.108264  1.114341  0.036323  2.98  0.0029

Likelihood ratio test=155.7  on 4 df, p=<2e-16
n= 5122, number of events= 3199 

~~~



~~~{.r}
### 3.2.2. 최종모형
order_cph_fit <- coxph(order_surv ~ cart_value  + voucher + returned + gender, data = order_df)

### 3.2.3. 모형 가설 검정
cox.zph(order_cph_fit)
~~~



~~~{.output}
                rho chisq      p
cart_value  -0.0163 0.852 0.3560
voucheryes  -0.0154 0.768 0.3808
returnedyes  0.0261 2.179 0.1399
gendermale   0.0390 4.913 0.0267
GLOBAL           NA 8.478 0.0756

~~~



~~~{.r}
### 3.2.4. 모형 이해와 설명
ggforest(order_cph_fit, data = order_df)
~~~

<img src="fig/repurchase-data-multivariate-1.png" width="672" style="display: block; margin: auto;" />

## 다변량 분석 시각화 {#survival-analysis-bought-again-multivariate-segment}

신규 고객 세그먼트를 지정하고 나서 첫구매이후 경과일로 재구매확률 변화를 앞서 구축한 예측모형을 바탕으로 
예측한다. 5개 고객집단의 특성을 `segment_df` 데이터프레임에 정의했고 이를 `survfit()`으로 예측했다.


~~~{.r}
# 4. 재구매 예측 -----
## 신규 고객 정의 데이터
segment_df <- tribble(
    ~ days, ~cart_value, ~gender, ~voucher, ~returned,
    30,  77, "male",   1, 1,
    50,  37, "male",   0, 1,
    70,  70, "female", 0, 1,
    5,  17, "female", 0, 0,
    170, 300, "male", 1, 1) %>% 
    mutate(voucher  = factor(voucher, levels=c(0, 1), labels=c("no", "yes")),
           returned = factor(returned, levels=c(0, 1), labels=c("no", "yes")))

## 신규 고객 재구매하지 않을 확률 예측
segment_pred <- survfit(order_cph_fit, newdata = segment_df)

segment_pred %>% broom::tidy() %>% 
    select(time, contains("estimate")) %>% 
    gather(customer, purchase_prob, -time) %>% 
    # mutate(purchase_prob = 1 - purchase_prob) %>% 
    mutate(customer = str_replace(customer, "estimate", "segment")) %>% 
    ggplot(aes(x=time, y=purchase_prob, color=customer)) +
        geom_line() +
        geom_point() +
        theme_minimal(base_family="NanumGothic") +
        labs(x="첫구매시점 이후 경과일", y="재구매하지 않을 확률", 
             subtitle="경과일에 따른 고객 세그먼트별 재구매 확률 변화", color="고객 Segment") +
        scale_color_viridis_d()
~~~

<img src="fig/repurchase-data-multivariate-predict-1.png" width="672" style="display: block; margin: auto;" />

~~~{.r}
segment_pred %>% broom::tidy() %>% 
    select(time, contains("estimate")) %>% 
    rename_at(vars(contains("estimate")), funs(str_replace_all(., "estimate", "segment"))) %>% 
    DT::datatable() %>% 
      DT::formatPercentage(c(2:6), digits=1)
~~~

<!--html_preserve--><div id="htmlwidget-ae2d80813cd591627adc" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-ae2d80813cd591627adc">{"x":{"filter":"none","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115"],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,99,100,101,102,103,104,106,107,108,115,121,123,124,125,130,131,139,144],[0.999870120330498,0.999870120330498,0.998830007745691,0.997266808542146,0.995568721655193,0.993472314878082,0.989918199250167,0.985816657522624,0.981161109073455,0.975670399302825,0.96972289355702,0.963720012011815,0.9598643088736,0.950119417149199,0.942515127772445,0.934380450330389,0.92569802542903,0.918075172861311,0.908091071912904,0.895821851122836,0.885033391634945,0.874192929187909,0.861427829023941,0.849757880274866,0.839841352370341,0.827901405451544,0.815164468272404,0.802836559945853,0.791690471403592,0.77715669102105,0.763234827450347,0.749696130497548,0.738217284739485,0.723578255485449,0.71021125187828,0.693706620841075,0.679084664626148,0.664783911851315,0.650705055889593,0.634748189400719,0.622258141063239,0.610639722386208,0.594931598048399,0.580843349452323,0.568882987990977,0.554135423647603,0.539241216612669,0.524336495912125,0.50845709266134,0.497060507611013,0.486336343932622,0.470204681898221,0.454921763960152,0.441736656821968,0.428471769089678,0.416439813918198,0.404252560057291,0.397438815762714,0.38743103993958,0.370281918224346,0.360414630897961,0.349970785258073,0.33383410826308,0.320152357609242,0.304527013601124,0.296609554771393,0.285355243182913,0.264069180798872,0.25322370335655,0.243503821078931,0.237072090943321,0.231317172154294,0.22124098118171,0.211532182578088,0.202194428475208,0.186271603253143,0.179813977130476,0.174437005241002,0.171643108808499,0.16872446444944,0.165707610899495,0.157585884305271,0.152288678584491,0.146817541914385,0.137595104529272,0.135643884466598,0.135643884466598,0.129302180079747,0.122759695013827,0.122759695013827,0.120467503652647,0.118156813282624,0.115831208143025,0.108440943723864,0.10336901340598,0.0929910747200035,0.0875692760281853,0.0847831121185788,0.0763311082347799,0.0735188298087867,0.0642273669719777,0.0642273669719777,0.0570810764446078,0.0570810764446078,0.045140368281156,0.0412725508587016,0.0412725508587016,0.0412725508587016,0.0367438632327406,0.0324807004767781,0.0180749306590384,0.0129793683568229,0.0129793683568229,0.00757455425761611,0.00269361793965499],[0.999809863059386,0.999809863059386,0.998287606867804,0.996001170705763,0.993519322814092,0.990458016772628,0.985274918510168,0.979304212347796,0.972540980817135,0.96458360775035,0.955987640634116,0.947336408318006,0.941792809751528,0.927828001087247,0.916976794467415,0.905413623331833,0.893123282424573,0.882376800715357,0.868364031174953,0.851241771820288,0.836275576751397,0.821322264695089,0.803824146528328,0.787932127001388,0.774507203811782,0.758440360348224,0.741419202647895,0.725061743928463,0.710372339671478,0.691362086275987,0.673306223080718,0.655893244089825,0.641243338314568,0.622713160432163,0.605944301229605,0.585440623961664,0.567463761585809,0.550054655947908,0.533084575615333,0.514055873284155,0.499315203016449,0.485725875056576,0.467543221987222,0.451423875953976,0.437880689750855,0.421362614074457,0.404886071731166,0.388607953958454,0.371500110272365,0.35937336067701,0.3480792841602,0.331307323427804,0.315662085282917,0.302358694871955,0.289159472684943,0.277349827869486,0.265548100961449,0.259021186258707,0.249528592539225,0.233526118624537,0.224472276705716,0.215013949854232,0.200656500175907,0.1887324841603,0.17540131375046,0.16876554238619,0.159473962029566,0.142363917923433,0.133886174513177,0.126429951404962,0.121571160474432,0.1172751606658,0.109872519920904,0.102886212617195,0.096305772444984,0.0854085310289998,0.0811088449504681,0.0775828539752245,0.0757704524090037,0.0738916928196682,0.0719655028849884,0.0668609513055228,0.063596429189972,0.0602796050082427,0.0548179133931055,0.0536836095837362,0.0536836095837362,0.0500494070764812,0.0463858875944587,0.0463858875944587,0.0451233985581218,0.0438619531169293,0.0426038712464536,0.0386840233497956,0.0360642041438537,0.0308892438156235,0.0282886662294278,0.0269807809811754,0.0231358322638648,0.0218986684145748,0.0179685469205204,0.0179685469205204,0.0151187428044146,0.0151187428044146,0.0107224834204188,0.00940460563850427,0.00940460563850427,0.00940460563850427,0.00793310957395318,0.00662266716617035,0.00280786258295915,0.00172910015190576,0.00172910015190576,0.000785955226842845,0.000172995565013624],[0.999841129174629,0.999841129174629,0.998569013541519,0.996657690035936,0.994582197123066,0.99202094622736,0.987681520219556,0.982678031564929,0.977004336960775,0.970320556464326,0.963090192054175,0.955802538816534,0.951126953561004,0.939328604897443,0.930140661400974,0.920330178278844,0.909880125784316,0.900723374391226,0.888755901531879,0.874089566387265,0.86123027654876,0.848344201220196,0.833216003261782,0.819429395668781,0.807747388399908,0.793722554861862,0.778811272865119,0.764428287030221,0.751466483929475,0.734626293917053,0.718560905763249,0.703000287927664,0.689856155817401,0.673159535580258,0.657979419627551,0.639323999957614,0.622879096478897,0.60687171282749,0.591187615660688,0.573502820355862,0.559729213697441,0.546972076348103,0.529810525648809,0.514504470409438,0.501575051067942,0.485716060775085,0.469794738407508,0.453960159036854,0.437200357585483,0.425243530425391,0.41404791058076,0.397310921996537,0.381572282434051,0.368088395552284,0.354613297160192,0.342470887698378,0.330251352838993,0.323455162767375,0.313520337364077,0.296629690869689,0.286989482073837,0.276850003142867,0.261316555082221,0.248276651884053,0.233536057586782,0.226130590275168,0.215680001808701,0.196166973746192,0.186357425591564,0.177645201069875,0.171922597795205,0.166831455962033,0.1579857067978,0.149547119227726,0.141512170397678,0.128002699001665,0.122595709827109,0.118126451103772,0.1158162607378,0.113411870781669,0.110936317390062,0.104322144255003,0.100048795563752,0.0956698499257106,0.088371156309952,0.0868406589618499,0.0868406589618499,0.0819005361021421,0.0768604243992075,0.0768604243992075,0.0751085755541448,0.0733501046467396,0.0715880183975379,0.0660414139284693,0.0622830028499424,0.054722139831733,0.0508451483119261,0.0488733807486784,0.0429816834911051,0.04105263824712,0.0347987481156855,0.0347987481156855,0.03012311449574,0.03012311449574,0.0226057702382234,0.0202596017643493,0.0202596017643493,0.0202596017643493,0.0175746375597408,0.0151136967256128,0.00737901198588501,0.00492117763560335,0.00492117763560335,0.00254659039539278,0.00071895478963525],[0.999755904615628,0.999755904615628,0.997802126618101,0.994869131413075,0.991687628240409,0.987766418917151,0.98113526098744,0.973508717406992,0.964885790308037,0.954762144246765,0.94385266322632,0.932901118398094,0.925898400410615,0.908309866028078,0.89469460549565,0.880236280463454,0.864926082137451,0.851587971440148,0.834265071128189,0.813205701408595,0.794896299766475,0.77669530716144,0.75551601577108,0.736393699665786,0.720324946368991,0.701197740397009,0.681059566213651,0.661829854625895,0.644665645199606,0.622601961363633,0.601804745159161,0.581897369063054,0.565264519882345,0.544380403338105,0.525632656523424,0.502908983727528,0.483170468478961,0.46422372814683,0.445917860335696,0.425587361831614,0.409984034429281,0.39571471522178,0.376799177944019,0.36020359580071,0.346389491405004,0.329704706586593,0.313245824805143,0.297170781247119,0.280481274350178,0.268781926165253,0.257986154964811,0.242137519943833,0.227557298815413,0.215319495002684,0.203327638200649,0.192728975591715,0.182264639263834,0.176533440830699,0.168271222921221,0.154545093704803,0.14689549256608,0.138997196301123,0.127196210886248,0.117575292465005,0.107021934185827,0.101852098710503,0.0947099641128246,0.0818683955212938,0.0756631114239325,0.0702967602232776,0.0668475385331228,0.063830215652233,0.0587046345598317,0.0539563427095735,0.0495667648562136,0.0424852219995259,0.0397592212324695,0.0375540639445801,0.0364315283584799,0.0352759125734478,0.0340997514442956,0.0310263563057201,0.0290951578948843,0.0271616422384305,0.0240436872302265,0.0234068488791888,0.0234068488791888,0.0213924168619667,0.019403360639261,0.019403360639261,0.0187280062214547,0.0180585457165531,0.0173962913498599,0.0153688779403222,0.0140456874590612,0.0115128139490569,0.0102836232750584,0.00967728219141201,0.00794389325562222,0.00740272955968596,0.0057425592350268,0.0057425592350268,0.00460068324521028,0.00460068324521028,0.00295971605061752,0.00250109526841797,0.00250109526841797,0.00250109526841797,0.00201029351541203,0.00159438912433284,0.000529869592628082,0.000284349831253909,0.000284349831253909,0.000103334101483047,1.48015382400391e-005],[0.999919833387683,0.999919833387683,0.999277692976797,0.998312129887512,0.997262592121747,0.9959659188387,0.993765225305545,0.991221805242418,0.988329924909594,0.984912509540318,0.981202468054164,0.977449040675119,0.975033460639841,0.968911715328448,0.964117987116781,0.958973484272172,0.953463625794771,0.948609842274703,0.942229155250888,0.934351186009938,0.927389812629052,0.920362088315753,0.91204373309164,0.904397651626098,0.897868758328345,0.889968388108305,0.881492435310443,0.873240262104483,0.865737338399794,0.855892986891719,0.846396813567225,0.837098197243392,0.829163858101835,0.81897629446911,0.80960483104546,0.797939927886586,0.78751658492494,0.777238782636834,0.767037448606787,0.755372620473128,0.746163611856894,0.737533534211929,0.725765033298553,0.715108569436539,0.705983768856909,0.69463080954341,0.683046946007499,0.671331634205045,0.658709048832732,0.649556667785288,0.640870656499804,0.627665443973975,0.614994080250488,0.603930532424746,0.59267172225742,0.582343438845613,0.571764714683741,0.565797087895838,0.556960551527652,0.541612488350251,0.532658173982342,0.523077795707803,0.508057140464022,0.495102547544211,0.480045472722914,0.472303247946566,0.461160437940283,0.439613802317985,0.428380434713824,0.418155418284304,0.411303404012557,0.405111866941326,0.394127254891519,0.383360486028847,0.372825240265029,0.354420054372017,0.346785128242863,0.340347447297872,0.33697243868225,0.333424198758314,0.329731780857729,0.319661140680612,0.312985546889881,0.30599675834673,0.293985973582389,0.291405756201937,0.291405756201937,0.282919823296286,0.273996482901814,0.273996482901814,0.270827321717254,0.267609133233749,0.264345753816382,0.253804809783727,0.246410848976475,0.230833595550232,0.222431347148471,0.218036251760903,0.204351847246391,0.199671465246756,0.183695429249889,0.183695429249889,0.170796635798234,0.170796635798234,0.147763669193105,0.139815520800397,0.139815520800397,0.139815520800397,0.130136813813147,0.120598553586075,0.083990265372306,0.0684633506137943,0.0684633506137943,0.0491011929932134,0.0259385830305748]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>time<\/th>\n      <th>segment.1<\/th>\n      <th>segment.2<\/th>\n      <th>segment.3<\/th>\n      <th>segment.4<\/th>\n      <th>segment.5<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[1,2,3,4,5,6]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false,"rowCallback":"function(row, data) {\nDTWidget.formatPercentage(this, row, data, 2, 1, 3, ',', '.');\nDTWidget.formatPercentage(this, row, data, 3, 1, 3, ',', '.');\nDTWidget.formatPercentage(this, row, data, 4, 1, 3, ',', '.');\nDTWidget.formatPercentage(this, row, data, 5, 1, 3, ',', '.');\nDTWidget.formatPercentage(this, row, data, 6, 1, 3, ',', '.');\n}"}},"evals":["options.rowCallback"],"jsHooks":[]}</script><!--/html_preserve-->





