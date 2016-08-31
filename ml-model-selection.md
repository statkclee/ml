---
layout: page
title: xwMOOC 기계<ed>��<ec>��
subtitle: 모형<ec>���<84> �<8f> <ec>��<ed>��
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 
> ## <ed>��<ec>��목표 {.objectives}
>
> * 기계<ed>��<ec>�� 모형<ec>��별하�<a0> <ec>��<ed>��<ed>��<eb>��.
> * 기계<ed>��<ec>�� 모형<ec>��별의 중요<ed>�� 결정<ec>��<ed>��<ec>�� <eb><8c>�<ed>�� <ed>��<ec>��<ed>��<eb>��.



## 1. 기계<ed>��<ec>�� 모형 <ec>��<ed>�� [^applied-predictive-modeling]

[^applied-predictive-modeling]: [Kuhn, Max, and Kjell Johnson. Applied predictive modeling. New York: Springer, 2013.](http://link.springer.com/book/10.1007/978-1-4614-6849-3)

기계<ed>��<ec>�� 모형<ec>�� <ec>��<ec>��<ed>�� <eb>��, <ec>��간이 <ec>��<ec>��<ed>��<eb>�� 경우 **<ec>��<eb>�� <ec>��<ed>��(Performance Ceiling)** <ec>�� 가<ec>�� 복잡<ed>�� 모형<ec>���<9c> <ec>���<a0>, 컴퓨<ed>�� 복잡<ec>��, <ec>���<a1> <ec>��<ec>��<ec>��, <ed>��<ec>�� <ed>��<ec>��<ec>��<ec>�� 고려<ed>��<ec>�� 모형<ec>�� <ec>��<ec>��<ed>��<eb>��. <ec>���<bc> <eb>��<ec>��, 비선<ed>�� 지지<eb>�� 벡터 머신(Nonlinear SVM) <ed>��<ec><9d>� <ed>��률숲(Random Forest)<ec>�� 경우 <eb>��<ec>��<ed>��<ec>�� <eb><8c>�<ed>�� <ec>��<ed>��<ec><9d>� 좋�<a7>��<8c>, <ec>��<ec>�� <ec>��<ec>��<ed>��경으�<9c> 배포<ed>��기�<b0>� 그다지 좋�<a7>�<eb>�� 못하<eb>��.

1. 기계<ed>��<ec>�� 모형<ec>�� 최종 모형<ec>���<9c> <ec>��<ec>��<ed>�� <eb>�� 가<ec>�� <ed>��<ec>��<ec>�� <eb>��지 <ec>��지�<8c> 가<ec>�� <ec>��<ec>��<ed>�� 모형<ec>���<9c> <ec>��<ec>��<ed>��<eb>��.
<ec>���<bc> <eb>��<ec>��, 부<ec>��<ed>�� <eb>��무모<ed>��(Boosting Tree Models), 지지<eb>�� 벡터 머신(Support Vector Machine, SVM)<ec>���<9c> <ec>��<ec>��<ed>��<eb>��<eb>�� <ec>��<ec>��<eb>�� 가<ec>�� <ec>��<ed>��<ed>�� 최적<ec>�� 결과�<bc> <ec>��공하�<b0> <eb>��문이<eb>��.
1. 최적<ec>�� 모형<ec>�� <ec>��<eb>���<8c> 보면 가<ec>�� 좋�<9d>� <ec>��<eb>��<ec>�� <ec>��<ed>��<ec>�� <ec>��<ec>��<ed>���<8c> <eb>���<a0>, <ec>���<bc> 기반<ec>���<9c> 최적<ec>�� <ec>��<eb>��<ec>�� 버금가<eb>�� <ed>��<ec>��<ec>�� <ec>��<ec>��<ed>�� 모형<ec>�� <ed>��<ec>��<ed>��<eb>��. <ec>���<bc> <eb>��<ec>��, multivariate adaptive regression splines (MARS), partial least squares, generalized additive models, <eb>��<ec>���<8c> 베이�<88> 모형<ec>�� <eb><8c>�<ed>��<ec>��<ec>��<eb>��.
1. <ec>��<eb>��<ec><9d>� 복잡<ec>��<ec>�� <eb>��<ec><9d>� 모형<ec>�� 기�<a4>�<ec>�� <eb>���<a0>, 검<ed>��<ed>��<eb>�� 모형<ec><9d>� 가<ec>�� <eb>��<ec>��<ed>�� 모형<ec>���<9c> <ec>��<ec>��<ed>��<eb>��.


## 2. 모형 <ec>��<ec>�� <ec>��례 -- <eb>��<ec>��<ec>��<ec>��<ed>��가 <eb>��<ec>��<ed>��

### 2.1. <eb>��<ec>��<ed>�� 가<ec>��<ec>���<b0>

<eb>��<ec>��<ec>��<ec>��<ed>��가 <eb>��<ec>��<ed>���<bc> `caret` <ed>��<ed>��지<ec>�� <ed>��<ed>��<eb>�� 것을 <ec>��<ec>��<ed>��<eb>��. <ed>��<eb>��<eb>��<ec>��<ed>��<ec><99>� 검증데<ec>��<ed>���<bc> 반반 <eb>��<eb>��<eb>��.
`createDataPartition` <ed>��<ec>���<bc> <ec>��<ec>��<ed>��<ec>�� <ec>���<8c> <ec>��<ec>��<ed>��<eb>��. `sample` <ed>��<ec>���<bc> <ec>��<ec>��<ed>��<eb>�� 좋다.


~~~{.r}
##==========================================================================================
## 01. <U+653C><U+3E62>��<U+653C><U+3E63>��<U+653C><U+3E64>�� 가<U+653C><U+3E63>��<U+653C><U+3E63>���<U+623C><U+3E30>
##==========================================================================================
suppressMessages(library(caret))
data(GermanCredit)

in_train <- createDataPartition(GermanCredit$Class, p = .5, list = FALSE)

credit.train.df <- GermanCredit[in_train, ]
credit.test.df <- GermanCredit[-in_train, ]
~~~

### 2.2. <eb>��<ec>��<ed>�� <ec>��처리

<ec>���<b8> <eb>��<ec>��<ed>�� <ec>��처리가 깔끔<ed>�� <eb>��<ec>�� <ec>��<ec>��<eb>�� <ec>��<eb>��<ed>��<eb>��. <ed>��<ec>��<ed>���<b4> <eb>�� <ec>��<ec>��<ec>�� <ed>��<eb>�� 좋다.


~~~{.r}
##==========================================================================================
## 02. <U+653C><U+3E62>��<U+653C><U+3E63>��<U+653C><U+3E64>�� <U+653C><U+3E63>��처리
##==========================================================================================
# <ec>��<eb>��... <ec>���<b8> <ec>��<ec>��가 <ec>��료된 <eb>��<ec>��<ed>��
~~~

### 2.3. <eb>��<ec>��<ed>��<ec>�� 모형<ec>�� <ec>��<ed>��

R<ec>�� 공식 비공<ec>��<ec>��<ec>���<9c> 10,000개�<b0>� <eb>��<eb>�� <ed>��<ed>��지가 존재<ed>���<a0> �<81> <ed>��<ed>��지마다 모형<ec>�� 명세<ed>��<eb>�� 방식<ec>�� <eb>��르다.
<ed>���<8c> `~` 공식<ec>�� <ec>��<ec>��<ed>��<eb>�� 방식�<bc> <eb>��<ec>��<ed>��<ed>��<eb>��<ec>�� `=` <ec>�� <ec>��<ec>��<ed>��<eb>�� 방식<ec>�� <ec>��<eb>��<eb>�� <ed>��<ed>��지마다 공식<ec>�� 명세<ed>��<eb>�� 방식<ec>�� 준<ec>��<ed>���<b4> <eb>��<eb>��. 중요<ed>�� 것�<9d>� `~`, `=` 좌측<ec><9d>� 종속변<ec>��, <ec>��측�<9d>� <eb>��립�<b3>�<ec>��가 <ec>��치해 <eb>��<ec>���<b4> <eb>��<eb>��.

<ec>��<ed>��<ed>��귀모형�<bc> SVM, <ed>��률숲(randomForest) 모형<ec>�� 차�<a1>��<9c> <ec>��<ed>��<ec>���<9c> **<ec>��<eb>��**<ec><9d>� 가<ec>�� <eb>��<ec>��<eb>��면서, 

1. 가<ec>�� <eb>��<ec>��<ed>�� 모형
1. 가<ec>�� <ec>��<ed>��<ed>���<b0> <ec>��<ec>�� 모형
1. 가<ec>�� <ec>��<ec>��<ec>��<ed>��경에 배포<ed>���<b0> 좋�<9d>� 모형

<ec>��<eb>�� 모형<ec>�� <ec>��<ec>��<ed>��<eb>��.


~~~{.r}
##==========================================================================================
## 03. 모형<U+653C><U+3E63>��<U+653C><U+3E64>��
##==========================================================================================
# 모형 공식 준�<U+383C><U+3E34>

credit.var <- setdiff(colnames(credit.train.df),list('Class'))
credit.formula <- as.formula(paste('Class', paste(credit.var,collapse=' + '), sep=' ~ '))

#-------------------------------------------------------------------------------------------
# 1. <U+653C><U+3E63>��<U+653C><U+3E64>��<U+653C><U+3E64>��귀모형 <U+653C><U+3E63>��<U+653C><U+3E64>��

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
  0.7176    0.2840902

 

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
    0.25  0.7000     0.000000000
    0.50  0.6908    -0.017688275
    1.00  0.6808    -0.025140288
    2.00  0.6788    -0.010393560
    4.00  0.6724    -0.023077922
    8.00  0.6728    -0.020389752
   16.00  0.6692    -0.017992864
   32.00  0.6704    -0.007576385
   64.00  0.6736     0.006599301
  128.00  0.6756     0.018984482

Tuning parameter 'sigma' was held constant at a value of 0.000004359245
Accuracy was used to select the optimal model using  the largest value.
The final values used for the model were sigma = 0.000004359245 and C
 = 0.25. 

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
   2    0.7116    0.0590013
  31    0.7332    0.3018851
  61    0.7260    0.2940944

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was mtry = 31. 

~~~


### 2.4. 모형 <ed>��가 �<8f> <ec>��<ec>��

SVM, <ec>��<ed>��<ed>��귀모형, <ed>��률숲(randomForest) 모형<ec>�� <ec>��<eb>��<ec>�� 각각 비교<ed>���<a0>,
<ec>���<b4> t-검�<9d> (paired t-test)<ec>�� <ec>��<ec>��<ed>��<ec>�� 모형�<84> <ec>��<ec>��<ec>��<ec>�� 검증한<eb>��.
<ec>��<ed>��<ed>��귀모형�<bc> <ed>��률숲 모형간에 <ec>��<ec>��미한 차이가 발견<eb>��지 <ec>��<ec>�� <eb>��<ec>��<ed>�� <ec>��<ed>��<ed>��귀모형<ec>�� <ec>��<ec>��<ed>��<eb>��.


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
SVM          0.70    0.70   0.70 0.7000   0.700 0.70    0
Logistic     0.64    0.68   0.72 0.7176   0.740 0.82    0
randomForest 0.62    0.70   0.74 0.7332   0.775 0.82    0

Kappa 
                Min. 1st Qu. Median   Mean 3rd Qu.   Max. NA's
SVM          0.00000  0.0000 0.0000 0.0000  0.0000 0.0000    0
Logistic     0.02299  0.2196 0.2751 0.2841  0.3520 0.5455    0
randomForest 0.03226  0.2113 0.3208 0.3019  0.4059 0.5055    0

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
             SVM      Logistic randomForest
SVM                   -0.0176  -0.0332     
Logistic     0.01439           -0.0156     
randomForest 0.000029 0.36842              

Kappa 
             SVM    Logistic randomForest
SVM                 -0.28409 -0.30189    
Logistic     <2e-16          -0.01779    
randomForest <2e-16 1                    

~~~
