---
layout: page
title: xwMOOC 기계학습
subtitle: 모형식별 및 선택
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 
> ## 학습목표 {.objectives}
>
> * 기계학습 모형식별하고 선택한다.
> * 기계학습 모형식별의 중요한 결정사항에 대해 파악한다.



## 1. 기계학습 모형 선택 [^applied-predictive-modeling]

[^applied-predictive-modeling]: [Kuhn, Max, and Kjell Johnson. Applied predictive modeling. New York: Springer, 2013.](http://link.springer.com/book/10.1007/978-1-4614-6849-3)

기계학습 모형을 선정할 때, 인간이 사용하는 경우 **성능 상한(Performance Ceiling)** 을 가장 복잡한 모형으로 잡고, 컴퓨팅 복잡성, 예측 용이성, 해석 편이성을 고려하여 모형을 선정한다. 예를 들어, 비선형 지지도 벡터 머신(Nonlinear SVM) 혹은 확률숲(Random Forest)의 경우 데이터에 대한 접합은 좋지만, 실제 운영환경으로 배포하기가 그다지 좋지는 못하다.

1. 기계학습 모형을 최종 모형으로 선정할 때 가장 해석이 되지 않지만 가장 유연한 모형으로 시작한다.
예를 들어, 부스팅 나무모형(Boosting Tree Models), 지지도 벡터 머신(Support Vector Machine, SVM)으로 시작하는데 이유는 가장 정확한 최적의 결과를 제공하기 때문이다.
1. 최적의 모형이 어떻게 보면 가장 좋은 성능의 상한을 제시하게 되고, 이를 기반으로 최적의 성능에 버금가는 해석이 용이한 모형을 탐색한다. 예를 들어, multivariate adaptive regression splines (MARS), partial least squares, generalized additive models, 나이브 베이즈 모형이 대표적이다.
1. 성능은 복잡성이 높은 모형이 기준이 되고, 검토하는 모형은 가장 단순한 모형으로 선정한다.


## 2. 모형 선정 사례 -- 독일신용평가 데이터

### 2.1. 데이터 가져오기

독일신용평가 데이터를 `caret` 팩키지에 포함된 것을 사용한다. 훈련데이터와 검증데이터를 반반 나눈다.
`createDataPartition` 함수를 사용해서 쉽게 사용한다. `sample` 함수를 사용해도 좋다.


~~~{.r}
##==========================================================================================
## 01. 데이터 가져오기
##==========================================================================================
suppressMessages(library(caret))
data(GermanCredit)

in_train <- createDataPartition(GermanCredit$Class, p = .5, list = FALSE)

credit.train.df <- GermanCredit[in_train, ]
credit.test.df <- GermanCredit[-in_train, ]
~~~

### 2.2. 데이터 전처리

이미 데이터 전처리가 깔끔히 되어 있으니 생략한다. 필요하면 더 작업을 해도 좋다.


~~~{.r}
##==========================================================================================
## 02. 데이터 전처리
##==========================================================================================
# 생략... 이미 정제가 완료된 데이터
~~~

### 2.3. 데이터에 모형을 적합

R에 공식 비공식적으로 10,000개가 넘는 팩키지가 존재하고 각 팩키지마다 모형을 명세하는 방식이 다르다.
크게 `~` 공식을 사용하는 방식과 데이터프레임 `=` 을 사용하는 방식이 있는데 팩키지마다 공식을 명세하는 방식을 준용하면 된다. 중요한 것은 `~`, `=` 좌측은 종속변수, 우측은 독립변수가 위치해 넣으면 된다.

이항회귀모형과 SVM, 확률숲(randomForest) 모형을 차례로 적합시켜 **성능**은 가장 뛰어나면서, 

1. 가장 단순한 모형
1. 가장 이해하기 쉬운 모형
1. 가장 실운영환경에 배포하기 좋은 모형

이런 모형을 선정한다.


~~~{.r}
##==========================================================================================
## 03. 모형적합
##==========================================================================================
# 모형 공식 준비

credit.var <- setdiff(colnames(credit.train.df),list('Class'))
credit.formula <- as.formula(paste('Class', paste(credit.var,collapse=' + '), sep=' ~ '))

#-------------------------------------------------------------------------------------------
# 1. 이항회귀모형 적합

credit.logit.m <- train(credit.formula, data = credit.train.df,
                       method = "glm", family=binomial(link='logit'),
                       trControl = trainControl(method = "repeatedcv", repeats = 5))
credit.logit.m
~~~



~~~{.output}
Generalized Linear Model 

500 samples
 61 predictor
  2 classes: 'Bad', 'Good' 

No pre-processing
Resampling: Cross-Validated (10 fold, repeated 5 times) 
Summary of sample sizes: 450, 450, 450, 450, 450, 450, ... 
Resampling results:

  Accuracy  Kappa   
  0.7388    0.333501

 

~~~



~~~{.r}
#-------------------------------------------------------------------------------------------
# 2. SVM 

credit.svm.m <- train(credit.formula, data = credit.train.df,
                  method = "svmRadial",
                  tuneLength = 10,
                  trControl = trainControl(method = "repeatedcv", repeats = 5))
~~~



~~~{.output}
Loading required package: kernlab

~~~



~~~{.output}

Attaching package: 'kernlab'

~~~



~~~{.output}
The following object is masked from 'package:ggplot2':

    alpha

~~~



~~~{.r}
credit.svm.m
~~~



~~~{.output}
Support Vector Machines with Radial Basis Function Kernel 

500 samples
 61 predictor
  2 classes: 'Bad', 'Good' 

No pre-processing
Resampling: Cross-Validated (10 fold, repeated 5 times) 
Summary of sample sizes: 450, 450, 450, 450, 450, 450, ... 
Resampling results across tuning parameters:

  C       Accuracy  Kappa     
    0.25  0.7000    0.00000000
    0.50  0.6964    0.00350554
    1.00  0.7000    0.04857991
    2.00  0.6956    0.04221790
    4.00  0.6940    0.04318553
    8.00  0.6892    0.03335577
   16.00  0.6848    0.02801668
   32.00  0.6872    0.03936246
   64.00  0.6856    0.04011345
  128.00  0.6800    0.04093977

Tuning parameter 'sigma' was held constant at a value of 6.466226e-06
Accuracy was used to select the optimal model using  the largest value.
The final values used for the model were sigma = 6.466226e-06 and C = 0.25. 

~~~



~~~{.r}
#-------------------------------------------------------------------------------------------
# 3. randomForest

credit.rf.m <- train(credit.formula, data = credit.train.df,
                method = "rf",
                trControl=trainControl(method="repeatedcv",repeats=5),
                prox=TRUE, allowParallel=TRUE)
~~~



~~~{.output}
Loading required package: randomForest

~~~



~~~{.output}
randomForest 4.6-12

~~~



~~~{.output}
Type rfNews() to see new features/changes/bug fixes.

~~~



~~~{.output}

Attaching package: 'randomForest'

~~~



~~~{.output}
The following object is masked from 'package:ggplot2':

    margin

~~~



~~~{.r}
credit.rf.m
~~~



~~~{.output}
Random Forest 

500 samples
 61 predictor
  2 classes: 'Bad', 'Good' 

No pre-processing
Resampling: Cross-Validated (10 fold, repeated 5 times) 
Summary of sample sizes: 450, 450, 450, 450, 450, 450, ... 
Resampling results across tuning parameters:

  mtry  Accuracy  Kappa     
   2    0.7104    0.06060889
  31    0.7428    0.32584075
  61    0.7368    0.31365031

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was mtry = 31. 

~~~


### 2.4. 모형 평가 및 선정

SVM, 이항회귀모형, 확률숲(randomForest) 모형의 성능을 각각 비교하고,
쌍체 t-검증 (paired t-test)을 사용하여 모형간 유의성을 검증한다.
이항회귀모형과 확률숲 모형간에 유의미한 차이가 발견되지 않아 단순한 이항회귀모형을 선정한다.


~~~{.r}
resample.res <- resamples(list(SVM = credit.svm.m, Logistic = credit.logit.m, randomForest=credit.rf.m))
summary(resample.res)
~~~



~~~{.output}

Call:
summary.resamples(object = resample.res)

Models: SVM, Logistic, randomForest 
Number of resamples: 50 

Accuracy 
             Min. 1st Qu. Median   Mean 3rd Qu. Max. NA's
SVM          0.70    0.70   0.70 0.7000    0.70 0.70    0
Logistic     0.62    0.72   0.74 0.7388    0.78 0.84    0
randomForest 0.60    0.72   0.74 0.7428    0.78 0.86    0

Kappa 
                   Min. 1st Qu. Median   Mean 3rd Qu.   Max. NA's
SVM           0.000e+00  0.0000 0.0000 0.0000  0.0000 0.0000    0
Logistic      2.922e-16  0.2784 0.3246 0.3335  0.4348 0.5876    0
randomForest -7.527e-02  0.2436 0.3296 0.3258  0.4173 0.6316    0

~~~



~~~{.r}
model.diff <- diff(resample.res)
summary(model.diff)
~~~



~~~{.output}

Call:
summary.diff.resamples(object = model.diff)

p-value adjustment: bonferroni 
Upper diagonal: estimates of the difference
Lower diagonal: p-value for H0: difference = 0

Accuracy 
             SVM       Logistic randomForest
SVM                    -0.0388  -0.0428     
Logistic     4.361e-06          -0.0040     
randomForest 1.734e-06 1                    

Kappa 
             SVM    Logistic randomForest
SVM                 -0.33350 -0.32584    
Logistic     <2e-16           0.00766    
randomForest <2e-16 1                    

~~~
