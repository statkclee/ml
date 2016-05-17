---
layout: page
title: xwMOOC 기계학습
subtitle: 예측모형 A-Z (연속형)
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 
> ## 학습목표 {.objectives}
>
> * 기본 예측모형을 살펴본다.
> * 컴퓨팅 자원을 최대한 활용하는 예측모형을 개발한다.
> * $RMSE$와 $R^2$ 기준 예측모형 성능을 평가한다.



## 1. 예측모형 A-Z 

데이터가 주어진 상태에서 어떤 예측모형이 가장 최적인지는 알 수가 없다.
단 하나의 모형으로 모든 데이터에 대한 예측모형으로 최적이라고 단언하는 예측모형도 존재하지 않는다.

즉, 데이터가 주어지면 최적의 모형을 예측하는데 있어 "공짜 점심"은 없다.
전통적인 방식부터 가장 정확도가 높은 모형까지 순차적으로 개발해 나가보자.

<img src="fig/ml-predictive-model.png" alt="예측모형 A-Z" width="77%">

1. 가장 단순한 모형을 데이터에 한번 적합시키고, 예측모형 개발자의 경험과 지식을 사용하여 가장 예측을 잘하는 모형을 추출해낸다.
1. 다양한 예측모형을 모형개발자가 설정하고, R이 자동으로 특정 조건 예를 들어, $R^2$, $RMSE$, $정확도$, $민감도$, $ROC$ 등을 최적화하는 모형을 교차타당도, 훈련/검증 데이터 기준, 붓스트랩 등의 방식으로 찾아낸다.
1. 컴퓨터와 R을 사용한 예측모형개발의 경우, 시간과 자원이 많이 소요되기 때문에 가장 병렬 컴퓨팅 개념을 확장하여 작업의 효율성과 더불어 더욱 크고 복잡한 문제에 대한 예측모형을 제시한다.


## 2. 도요타 중고차 가격 예측 사례

Shmueli et al. (2010)[^toyota]에서 소개된 데이터로 도요타 코롤라 중고차 가격을 정확하게 예측하는 것이 목표다.

[^toyota]: [Shmueli, G., Patel, N.R., and Bruce, P.C.: Data Mining for Business Intelligence. Second edition. Hoboken, NJ: John Wiley & Sons, Inc., 2010](http://as.wiley.com/WileyCDA/WileyTitle/productCd-EHEP002378.html)

[ToyotaCorolla.csv](https://raw.githubusercontent.com/datailluminations/PredictingToyotaPricesBlog/master/ToyotaCorolla.csv) 데이터는 GitHub에서도 다운로드 받아 바로 분석에 사용될 수 있다.

### 2.1. 데이터 준비

`readr` 팩키지를 사용하면 `read_csv` 함수에 인자로 웹URL을 넣으면 내부적으로 인터넷 데이터처리 핸들러가 있어 자동으로 불러올 수 있게 된다. `tuc.df` 데이터프레임으로 작명(Toyota Used Car)하여 데이터를 불러오고, 
`caret` 팩키지 `createDataPartition` 함수로 7:3으로 훈련데이터와 검증데이터로 쪼갠다.


~~~{.r}
##==============================================================================================
## 01. 데이터 가져오기
##==============================================================================================
# 1.1. 데이터 불러오기
suppressMessages(library(readr))
suppressMessages(library(dplyr))
suppressMessages(library(caret))
tuc.df <- read_csv("https://raw.githubusercontent.com/datailluminations/PredictingToyotaPricesBlog/master/ToyotaCorolla.csv")
dim(tuc.df)
~~~



~~~{.output}
[1] 1436   10

~~~



~~~{.r}
# 1.2. 훈련데이터, 검증데이터
in_train <- createDataPartition(tuc.df$Price, p = .7, list = FALSE)

tuc.train.df <- tuc.df[in_train, ]
tuc.test.df <- tuc.df[-in_train, ]
~~~

### 2.2. 데이터 정제

도요타 중고차 데이터가 이미 전처리되어 정제되어 있기 때문에 데이터 정제 및 전처리 과정은 생략한다.


~~~{.r}
##==============================================================================================
## 02. 데이터 정제 및 전처리
##==============================================================================================
# 생략
~~~

### 2.3. 예측모형 개발

전통적인 수작업 예측모형개발 과정을 살펴보고 컴퓨팅 자원과 지식을 활용한 예측모형개발 과정을 순차적으로 살펴본다.

#### 2.3.1. 전통 수작업 예측모형 개발

훈련데이터와 검증데이터로 우선 나누고 나서, 각 모형에 훈련데이터를 넣고, 적합시킨 예측모형에 검증데이터를 넣어 예측을 순서대로 진행해 나간다. 선형회귀모형, 강건 선형회귀모형, PLS(Partial Least Square, 부분최소자승법), 능선회귀모형을 예측모형으로 사용하고, 검증데이터를 넣어 성능을 예측한다.


~~~{.r}
##==============================================================================================
## 03. 예측 모형 개발
##==============================================================================================

#-----------------------------------------------------------------------------------------------
# Y변수와 X변수 구분

# 훈련 데이터
tuc.train.Y <- tuc.train.df$Price
tuc.train.X <- tuc.train.df %>% select(-Price)

# 검증 데이터
tuc.test.Y <- tuc.test.df$Price
tuc.test.X <- tuc.test.df %>% select(-Price)

#-----------------------------------------------------------------------------------------------
# 예측모형 적합

# 3.1. 선형회귀모형
tuc.lm.m <- lm(Price ~ ., data = tuc.train.df)
tuc.lm.pred <- predict(tuc.lm.m, tuc.test.X) 

tuc.lm.values <- data.frame(obs = tuc.test.Y, pred = tuc.lm.pred) 
defaultSummary(tuc.lm.values)
~~~



~~~{.output}
        RMSE     Rsquared 
1530.2292476    0.8317572 

~~~



~~~{.r}
# 3.2. 강건 선형회귀모형
suppressMessages(library(MASS))
tuc.rlm.m <- rlm(Price ~ ., data = tuc.train.df)
tuc.rlm.pred <- predict(tuc.rlm.m, tuc.test.X) 

tuc.rlm.values <- data.frame(obs = tuc.test.Y, pred = tuc.rlm.pred) 
defaultSummary(tuc.rlm.values)
~~~



~~~{.output}
        RMSE     Rsquared 
1559.0294491    0.8249595 

~~~



~~~{.r}
# 3.3. PLS (Partial Least Square)
suppressMessages(library(pls))
tuc.plsr.m <- plsr(Price ~ ., data = tuc.train.df)
tuc.plsr.pred <- predict(tuc.plsr.m, tuc.test.X, ncomp = 1:2) 

# 3.4. 능선 회귀모형(Ridge Regression)
suppressMessages(library(elasticnet)) # elasticnet
tuc.ridge.m <- enet(x = as.matrix(tuc.train.X[,-3]), y = tuc.train.Y, lambda = 0.001)

tuc.ridge.pred <- predict(tuc.ridge.m, newx = as.matrix(tuc.test.X[,-3]), 
                          s = 1, mode = "fraction", type = "fit")

tuc.ridge.coef <- predict(tuc.ridge.m, newx = as.matrix(tuc.test.X[,-3]),  
                    s = .1, mode = "fraction", type = "coefficients")

tuc.ridge.coef$coefficients
~~~



~~~{.output}
      Age        KM        HP  MetColor Automatic        CC     Doors 
-30.33547   0.00000   0.00000   0.00000   0.00000   0.00000   0.00000 
   Weight 
  0.00000 

~~~

검증데이터의 종속변수와 예측모형에서 나온 종속변수 예측값과 산점도를 그려본다.
모형에서 예측된 값을 잔차와 함께 산점도로 도식화한다.


~~~{.r}
#------------------------------------------------------------------------------------
# 모형 시각화
# 1. 선형회귀모형
suppressMessages(library(gridExtra))
p.fit <- xyplot(tuc.test.Y ~ predict(tuc.lm.m),
       type = c("p", "g"), xlab = "Predicted", ylab = "Observed")
p.resid <- xyplot(resid(tuc.lm.m) ~ predict(tuc.lm.m), add=TRUE,
       type = c("p", "g"), 
       xlab = "Predicted", ylab = "Residuals")
grid.arrange(p.fit, p.resid, ncol=2)
~~~

<img src="fig/pm-toyota-old-diagnostic-1.png" title="plot of chunk pm-toyota-old-diagnostic" alt="plot of chunk pm-toyota-old-diagnostic" style="display: block; margin: auto;" />

#### 2.3.2. 컴퓨팅을 활용한 예측모형 개발

교차타당도(cross-validation) 방법(10개 집단)을 사용해서 선형회귀모형, 강건 선형회귀모형, PLS(Partial Least Square, 부분최소자승법), 능선회귀모형, 라소 회귀방법을 적용하여 가장 최적의 모형을 선정한다.


~~~{.r}
#------------------------------------------------------------------------------------
# 컴퓨팅을 활용한 예측모형

# 0. 교차타당도 제어조건 설정

ctrl <- trainControl(method = "cv", number = 10)

# 1. 선형회귀모형
tuc.lm.tune <- train(Price ~ ., data = tuc.train.df, 
                      method = "lm", 
                      trControl = ctrl)
tuc.lm.tune
~~~



~~~{.output}
Linear Regression 

1007 samples
   9 predictor

No pre-processing
Resampling: Cross-Validated (10 fold) 
Summary of sample sizes: 907, 908, 905, 906, 906, 907, ... 
Resampling results:

  RMSE      Rsquared 
  1283.974  0.8770455

 

~~~



~~~{.r}
# 2. 강건 선형회귀모형
tuc.rlm.tune <- train(Price ~ ., data = tuc.train.df, 
                      method = "rlm", 
                      trControl = ctrl)
tuc.rlm.tune
~~~



~~~{.output}
Robust Linear Model 

1007 samples
   9 predictor

No pre-processing
Resampling: Cross-Validated (10 fold) 
Summary of sample sizes: 906, 907, 907, 906, 905, 906, ... 
Resampling results:

  RMSE      Rsquared 
  1288.344  0.8720056

 

~~~



~~~{.r}
# 3. 부분최소자승모형
tuc.plsr.tune <- train(Price ~ ., data = tuc.train.df, 
                       method = "pls",
                       preProc = c("center", "scale"),
                       tuneLength = 20, 
                       trControl = ctrl)
tuc.plsr.tune
~~~



~~~{.output}
Partial Least Squares 

1007 samples
   9 predictor

Pre-processing: centered (10), scaled (10) 
Resampling: Cross-Validated (10 fold) 
Summary of sample sizes: 907, 905, 907, 906, 907, 906, ... 
Resampling results across tuning parameters:

  ncomp  RMSE      Rsquared 
  1      1566.494  0.8137621
  2      1433.461  0.8459205
  3      1350.163  0.8640282
  4      1300.201  0.8729217
  5      1295.672  0.8735787
  6      1292.586  0.8738965
  7      1292.198  0.8739449
  8      1290.955  0.8740824
  9      1290.099  0.8741463

RMSE was used to select the optimal model using  the smallest value.
The final value used for the model was ncomp = 9. 

~~~



~~~{.r}
# 4. 능선회귀모형
ridgeGrid <- data.frame(.lambda = seq(0, .1, length = 15))
tuc.ridge.tune <- train(tuc.train.X[,-3], tuc.train.Y, 
                        method = "ridge", 
                        tuneGrid = ridgeGrid, 
                        trControl = ctrl)
tuc.ridge.tune
~~~



~~~{.output}
Ridge Regression 

1007 samples
   8 predictor

No pre-processing
Resampling: Cross-Validated (10 fold) 
Summary of sample sizes: 906, 907, 907, 907, 906, 906, ... 
Resampling results across tuning parameters:

  lambda       RMSE      Rsquared 
  0.000000000  1287.789  0.8761048
  0.007142857  1287.808  0.8761740
  0.014285714  1288.095  0.8761969
  0.021428571  1288.620  0.8761806
  0.028571429  1289.358  0.8761308
  0.035714286  1290.285  0.8760524
  0.042857143  1291.385  0.8759495
  0.050000000  1292.639  0.8758258
  0.057142857  1294.036  0.8756842
  0.064285714  1295.563  0.8755271
  0.071428571  1297.210  0.8753570
  0.078571429  1298.966  0.8751755
  0.085714286  1300.826  0.8749844
  0.092857143  1302.780  0.8747852
  0.100000000  1304.824  0.8745789

RMSE was used to select the optimal model using  the smallest value.
The final value used for the model was lambda = 0. 

~~~



~~~{.r}
# 5. 라소 회귀모형
enetGrid <- expand.grid(.lambda = c(0, 0.01, .1), 
                        .fraction = seq(.05, 1, length = 20))
tuc.lasso.tune <- train(tuc.train.X[,-3], tuc.train.Y,  
                        method = "enet", 
                        tuneGrid = enetGrid, 
                        trControl = ctrl)
tuc.lasso.tune
~~~



~~~{.output}
Elasticnet 

1007 samples
   8 predictor

No pre-processing
Resampling: Cross-Validated (10 fold) 
Summary of sample sizes: 906, 906, 906, 906, 907, 907, ... 
Resampling results across tuning parameters:

  lambda  fraction  RMSE      Rsquared 
  0.00    0.05      3381.854  0.7741226
  0.00    0.10      3144.744  0.7741226
  0.00    0.15      2915.269  0.7741226
  0.00    0.20      2695.444  0.7741226
  0.00    0.25      2487.934  0.7741226
  0.00    0.30      2296.247  0.7741226
  0.00    0.35      2131.516  0.7781362
  0.00    0.40      1988.694  0.7907208
  0.00    0.45      1854.188  0.8111188
  0.00    0.50      1732.115  0.8269871
  0.00    0.55      1628.557  0.8389092
  0.00    0.60      1534.999  0.8493421
  0.00    0.65      1458.766  0.8561388
  0.00    0.70      1402.552  0.8601380
  0.00    0.75      1367.264  0.8638263
  0.00    0.80      1338.417  0.8683626
  0.00    0.85      1317.779  0.8713530
  0.00    0.90      1305.903  0.8729941
  0.00    0.95      1298.232  0.8740580
  0.00    1.00      1295.416  0.8743474
  0.01    0.05      3383.190  0.7741226
  0.01    0.10      3147.339  0.7741226
  0.01    0.15      2919.020  0.7741226
  0.01    0.20      2700.205  0.7741226
  0.01    0.25      2493.499  0.7741226
  0.01    0.30      2302.327  0.7741226
  0.01    0.35      2138.117  0.7784138
  0.01    0.40      1995.132  0.7911574
  0.01    0.45      1860.468  0.8116416
  0.01    0.50      1737.799  0.8273128
  0.01    0.55      1634.290  0.8386402
  0.01    0.60      1540.338  0.8490707
  0.01    0.65      1463.197  0.8559463
  0.01    0.70      1405.674  0.8600364
  0.01    0.75      1369.961  0.8630349
  0.01    0.80      1340.677  0.8677158
  0.01    0.85      1319.369  0.8708940
  0.01    0.90      1307.200  0.8726483
  0.01    0.95      1299.154  0.8738615
  0.01    1.00      1295.728  0.8743415
  0.10    0.05      3389.168  0.7741226
  0.10    0.10      3158.969  0.7741226
  0.10    0.15      2935.848  0.7741226
  0.10    0.20      2721.601  0.7741226
  0.10    0.25      2518.580  0.7741226
  0.10    0.30      2329.937  0.7741432
  0.10    0.35      2170.707  0.7827375
  0.10    0.40      2026.647  0.7985962
  0.10    0.45      1890.984  0.8179881
  0.10    0.50      1766.899  0.8312803
  0.10    0.55      1658.276  0.8400877
  0.10    0.60      1566.437  0.8479099
  0.10    0.65      1485.362  0.8549828
  0.10    0.70      1422.144  0.8593916
  0.10    0.75      1379.133  0.8617649
  0.10    0.80      1357.924  0.8628490
  0.10    0.85      1337.722  0.8664318
  0.10    0.90      1324.232  0.8691208
  0.10    0.95      1317.704  0.8708612
  0.10    1.00      1313.394  0.8722438

RMSE was used to select the optimal model using  the smallest value.
The final values used for the model were fraction = 1 and lambda = 0. 

~~~

5개 모형을 $RMSE$와 $R^2$ 기준으로 가장 성능이 좋은 모형을 선정한다.


~~~{.r}
tuc.comp <- resamples(list( 
  LM =tuc.lm.tune,
  RLM = tuc.rlm.tune,
  PLS = tuc.plsr.tune,
  Lasso = tuc.lasso.tune, Ridge = tuc.ridge.tune))

bwplot(tuc.comp,  layout = c(2, 1),scales = list(relation = "free"),
       xlim = list(c(0, 2500), c(0.5, 1)))
~~~

<img src="fig/pm-toyota-pm-comp-1.png" title="plot of chunk pm-toyota-pm-comp" alt="plot of chunk pm-toyota-pm-comp" style="display: block; margin: auto;" />

