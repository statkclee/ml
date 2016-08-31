---
layout: page
title: xwMOOC ê¸°ê³„<ed>•™<ec>Šµ
subtitle: ëª¨í˜•<ec>‹ë³<84> ë°<8f> <ec>„ <ed>ƒ
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 
> ## <ed>•™<ec>Šµëª©í‘œ {.objectives}
>
> * ê¸°ê³„<ed>•™<ec>Šµ ëª¨í˜•<ec>‹ë³„í•˜ê³<a0> <ec>„ <ed>ƒ<ed>•œ<eb>‹¤.
> * ê¸°ê³„<ed>•™<ec>Šµ ëª¨í˜•<ec>‹ë³„ì˜ ì¤‘ìš”<ed>•œ ê²°ì •<ec>‚¬<ed>•­<ec>— <eb><8c>€<ed>•´ <ed>ŒŒ<ec>•…<ed>•œ<eb>‹¤.



## 1. ê¸°ê³„<ed>•™<ec>Šµ ëª¨í˜• <ec>„ <ed>ƒ [^applied-predictive-modeling]

[^applied-predictive-modeling]: [Kuhn, Max, and Kjell Johnson. Applied predictive modeling. New York: Springer, 2013.](http://link.springer.com/book/10.1007/978-1-4614-6849-3)

ê¸°ê³„<ed>•™<ec>Šµ ëª¨í˜•<ec>„ <ec>„ <ec> •<ed>•  <eb>•Œ, <ec>¸ê°„ì´ <ec>‚¬<ec>š©<ed>•˜<eb>Š” ê²½ìš° **<ec>„±<eb>Š¥ <ec>ƒ<ed>•œ(Performance Ceiling)** <ec>„ ê°€<ec>ž¥ ë³µìž¡<ed>•œ ëª¨í˜•<ec>œ¼ë¡<9c> <ec>ž¡ê³<a0>, ì»´í“¨<ed>Œ… ë³µìž¡<ec>„±, <ec>˜ˆì¸<a1> <ec>š©<ec>´<ec>„±, <ed>•´<ec>„ <ed>Ž¸<ec>´<ec>„±<ec>„ ê³ ë ¤<ed>•˜<ec>—¬ ëª¨í˜•<ec>„ <ec>„ <ec> •<ed>•œ<eb>‹¤. <ec>˜ˆë¥<bc> <eb>“¤<ec>–´, ë¹„ì„ <ed>˜• ì§€ì§€<eb>„ ë²¡í„° ë¨¸ì‹ (Nonlinear SVM) <ed>˜¹<ec><9d>€ <ed>™•ë¥ ìˆ²(Random Forest)<ec>˜ ê²½ìš° <eb>°<ec>´<ed>„°<ec>— <eb><8c>€<ed>•œ <ec> ‘<ed>•©<ec><9d>€ ì¢‹ì<a7>€ë§<8c>, <ec>‹¤<ec> œ <ec>š´<ec>˜<ed>™˜ê²½ìœ¼ë¡<9c> ë°°í¬<ed>•˜ê¸°ê<b0>€ ê·¸ë‹¤ì§€ ì¢‹ì<a7>€<eb>Š” ëª»í•˜<eb>‹¤.

1. ê¸°ê³„<ed>•™<ec>Šµ ëª¨í˜•<ec>„ ìµœì¢… ëª¨í˜•<ec>œ¼ë¡<9c> <ec>„ <ec> •<ed>•  <eb>•Œ ê°€<ec>ž¥ <ed>•´<ec>„<ec>´ <eb>˜ì§€ <ec>•Šì§€ë§<8c> ê°€<ec>ž¥ <ec>œ <ec>—°<ed>•œ ëª¨í˜•<ec>œ¼ë¡<9c> <ec>‹œ<ec>ž‘<ed>•œ<eb>‹¤.
<ec>˜ˆë¥<bc> <eb>“¤<ec>–´, ë¶€<ec>Š¤<ed>Œ… <eb>‚˜ë¬´ëª¨<ed>˜•(Boosting Tree Models), ì§€ì§€<eb>„ ë²¡í„° ë¨¸ì‹ (Support Vector Machine, SVM)<ec>œ¼ë¡<9c> <ec>‹œ<ec>ž‘<ed>•˜<eb>Š”<eb>° <ec>´<ec>œ <eb>Š” ê°€<ec>ž¥ <ec> •<ed>™•<ed>•œ ìµœì <ec>˜ ê²°ê³¼ë¥<bc> <ec> œê³µí•˜ê¸<b0> <eb>•Œë¬¸ì´<eb>‹¤.
1. ìµœì <ec>˜ ëª¨í˜•<ec>´ <ec>–´<eb>–»ê²<8c> ë³´ë©´ ê°€<ec>ž¥ ì¢‹ì<9d>€ <ec>„±<eb>Š¥<ec>˜ <ec>ƒ<ed>•œ<ec>„ <ec> œ<ec>‹œ<ed>•˜ê²<8c> <eb>˜ê³<a0>, <ec>´ë¥<bc> ê¸°ë°˜<ec>œ¼ë¡<9c> ìµœì <ec>˜ <ec>„±<eb>Š¥<ec>— ë²„ê¸ˆê°€<eb>Š” <ed>•´<ec>„<ec>´ <ec>š©<ec>´<ed>•œ ëª¨í˜•<ec>„ <ed>ƒ<ec>ƒ‰<ed>•œ<eb>‹¤. <ec>˜ˆë¥<bc> <eb>“¤<ec>–´, multivariate adaptive regression splines (MARS), partial least squares, generalized additive models, <eb>‚˜<ec>´ë¸<8c> ë² ì´ì¦<88> ëª¨í˜•<ec>´ <eb><8c>€<ed>‘œ<ec> <ec>´<eb>‹¤.
1. <ec>„±<eb>Š¥<ec><9d>€ ë³µìž¡<ec>„±<ec>´ <eb>†’<ec><9d>€ ëª¨í˜•<ec>´ ê¸°ì<a4>€<ec>´ <eb>˜ê³<a0>, ê²€<ed>† <ed>•˜<eb>Š” ëª¨í˜•<ec><9d>€ ê°€<ec>ž¥ <eb>‹¨<ec>ˆœ<ed>•œ ëª¨í˜•<ec>œ¼ë¡<9c> <ec>„ <ec> •<ed>•œ<eb>‹¤.


## 2. ëª¨í˜• <ec>„ <ec> • <ec>‚¬ë¡€ -- <eb>…<ec>¼<ec>‹ <ec>š©<ed>‰ê°€ <eb>°<ec>´<ed>„°

### 2.1. <eb>°<ec>´<ed>„° ê°€<ec> ¸<ec>˜¤ê¸<b0>

<eb>…<ec>¼<ec>‹ <ec>š©<ed>‰ê°€ <eb>°<ec>´<ed>„°ë¥<bc> `caret` <ed>Œ©<ed>‚¤ì§€<ec>— <ed>¬<ed>•¨<eb>œ ê²ƒì„ <ec>‚¬<ec>š©<ed>•œ<eb>‹¤. <ed>›ˆ<eb> ¨<eb>°<ec>´<ed>„°<ec><99>€ ê²€ì¦ë°<ec>´<ed>„°ë¥<bc> ë°˜ë°˜ <eb>‚˜<eb>ˆˆ<eb>‹¤.
`createDataPartition` <ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ <ec>‰½ê²<8c> <ec>‚¬<ec>š©<ed>•œ<eb>‹¤. `sample` <ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•´<eb>„ ì¢‹ë‹¤.


~~~{.r}
##==========================================================================================
## 01. <U+653C><U+3E62>°<U+653C><U+3E63>´<U+653C><U+3E64>„° ê°€<U+653C><U+3E63> ¸<U+653C><U+3E63>˜¤ê¸<U+623C><U+3E30>
##==========================================================================================
suppressMessages(library(caret))
data(GermanCredit)

in_train <- createDataPartition(GermanCredit$Class, p = .5, list = FALSE)

credit.train.df <- GermanCredit[in_train, ]
credit.test.df <- GermanCredit[-in_train, ]
~~~

### 2.2. <eb>°<ec>´<ed>„° <ec> „ì²˜ë¦¬

<ec>´ë¯<b8> <eb>°<ec>´<ed>„° <ec> „ì²˜ë¦¬ê°€ ê¹”ë”<ed>žˆ <eb>˜<ec>–´ <ec>žˆ<ec>œ¼<eb>‹ˆ <ec>ƒ<eb>žµ<ed>•œ<eb>‹¤. <ed>•„<ec>š”<ed>•˜ë©<b4> <eb>” <ec>ž‘<ec>—…<ec>„ <ed>•´<eb>„ ì¢‹ë‹¤.


~~~{.r}
##==========================================================================================
## 02. <U+653C><U+3E62>°<U+653C><U+3E63>´<U+653C><U+3E64>„° <U+653C><U+3E63> „ì²˜ë¦¬
##==========================================================================================
# <ec>ƒ<eb>žµ... <ec>´ë¯<b8> <ec> •<ec> œê°€ <ec>™„ë£Œëœ <eb>°<ec>´<ed>„°
~~~

### 2.3. <eb>°<ec>´<ed>„°<ec>— ëª¨í˜•<ec>„ <ec> <ed>•©

R<ec>— ê³µì‹ ë¹„ê³µ<ec>‹<ec> <ec>œ¼ë¡<9c> 10,000ê°œê<b0>€ <eb>„˜<eb>Š” <ed>Œ©<ed>‚¤ì§€ê°€ ì¡´ìž¬<ed>•˜ê³<a0> ê°<81> <ed>Œ©<ed>‚¤ì§€ë§ˆë‹¤ ëª¨í˜•<ec>„ ëª…ì„¸<ed>•˜<eb>Š” ë°©ì‹<ec>´ <eb>‹¤ë¥´ë‹¤.
<ed>¬ê²<8c> `~` ê³µì‹<ec>„ <ec>‚¬<ec>š©<ed>•˜<eb>Š” ë°©ì‹ê³<bc> <eb>°<ec>´<ed>„°<ed>”„<eb> ˆ<ec>ž„ `=` <ec>„ <ec>‚¬<ec>š©<ed>•˜<eb>Š” ë°©ì‹<ec>´ <ec>žˆ<eb>Š”<eb>° <ed>Œ©<ed>‚¤ì§€ë§ˆë‹¤ ê³µì‹<ec>„ ëª…ì„¸<ed>•˜<eb>Š” ë°©ì‹<ec>„ ì¤€<ec>š©<ed>•˜ë©<b4> <eb>œ<eb>‹¤. ì¤‘ìš”<ed>•œ ê²ƒì<9d>€ `~`, `=` ì¢Œì¸¡<ec><9d>€ ì¢…ì†ë³€<ec>ˆ˜, <ec>š°ì¸¡ì<9d>€ <eb>…ë¦½ë<b3>€<ec>ˆ˜ê°€ <ec>œ„ì¹˜í•´ <eb>„£<ec>œ¼ë©<b4> <eb>œ<eb>‹¤.

<ec>´<ed>•­<ed>šŒê·€ëª¨í˜•ê³<bc> SVM, <ed>™•ë¥ ìˆ²(randomForest) ëª¨í˜•<ec>„ ì°¨ë<a1>€ë¡<9c> <ec> <ed>•©<ec>‹œì¼<9c> **<ec>„±<eb>Š¥**<ec><9d>€ ê°€<ec>ž¥ <eb>›°<ec>–´<eb>‚˜ë©´ì„œ, 

1. ê°€<ec>ž¥ <eb>‹¨<ec>ˆœ<ed>•œ ëª¨í˜•
1. ê°€<ec>ž¥ <ec>´<ed>•´<ed>•˜ê¸<b0> <ec>‰¬<ec>š´ ëª¨í˜•
1. ê°€<ec>ž¥ <ec>‹¤<ec>š´<ec>˜<ed>™˜ê²½ì— ë°°í¬<ed>•˜ê¸<b0> ì¢‹ì<9d>€ ëª¨í˜•

<ec>´<eb>Ÿ° ëª¨í˜•<ec>„ <ec>„ <ec> •<ed>•œ<eb>‹¤.


~~~{.r}
##==========================================================================================
## 03. ëª¨í˜•<U+653C><U+3E63> <U+653C><U+3E64>•©
##==========================================================================================
# ëª¨í˜• ê³µì‹ ì¤€ë¹<U+383C><U+3E34>

credit.var <- setdiff(colnames(credit.train.df),list('Class'))
credit.formula <- as.formula(paste('Class', paste(credit.var,collapse=' + '), sep=' ~ '))

#-------------------------------------------------------------------------------------------
# 1. <U+653C><U+3E63>´<U+653C><U+3E64>•­<U+653C><U+3E64>šŒê·€ëª¨í˜• <U+653C><U+3E63> <U+653C><U+3E64>•©

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


### 2.4. ëª¨í˜• <ed>‰ê°€ ë°<8f> <ec>„ <ec> •

SVM, <ec>´<ed>•­<ed>šŒê·€ëª¨í˜•, <ed>™•ë¥ ìˆ²(randomForest) ëª¨í˜•<ec>˜ <ec>„±<eb>Š¥<ec>„ ê°ê° ë¹„êµ<ed>•˜ê³<a0>,
<ec>Œì²<b4> t-ê²€ì¦<9d> (paired t-test)<ec>„ <ec>‚¬<ec>š©<ed>•˜<ec>—¬ ëª¨í˜•ê°<84> <ec>œ <ec>˜<ec>„±<ec>„ ê²€ì¦í•œ<eb>‹¤.
<ec>´<ed>•­<ed>šŒê·€ëª¨í˜•ê³<bc> <ed>™•ë¥ ìˆ² ëª¨í˜•ê°„ì— <ec>œ <ec>˜ë¯¸í•œ ì°¨ì´ê°€ ë°œê²¬<eb>˜ì§€ <ec>•Š<ec>•„ <eb>‹¨<ec>ˆœ<ed>•œ <ec>´<ed>•­<ed>šŒê·€ëª¨í˜•<ec>„ <ec>„ <ec> •<ed>•œ<eb>‹¤.


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
