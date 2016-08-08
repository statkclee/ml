---
layout: page
title: xwMOOC 기계<ed>��<ec>��
subtitle: <ec>��<ed>��방식 모형개발 - <ed><83>�<ec>��<ed><83>�<eb>�� <ec>���<b4> <eb>��<ec>��<ed>��
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---


 
> ## <ed>��<ec>��목표 {.objectives}
>
> * <ec>��<ed>��방식 모형개발 방식<ec>�� <ed><83>�<ec>��<ed><83>�<eb>�� <ec>��존데<ec>��<ed>��<ec>�� <ec>��<ec>��<ed>��<eb>��.
> * CMM 3<ec>��준<ec>�� <ed>��<eb>��<eb>��<eb>�� 모형개발 방식<ec>���<9c> 간주<ed>�� <ec>��<eb>�� <ec>��<eb>��.

## 1. <ed><83>�<ec>��<ed><83>�<eb>�� <ec>���<b4> <eb>��<ec>��<ed>�� [^r-bloggers-logistic]

[^r-bloggers-logistic]: [R-bloggers, How to perform a Logistic Regression in R](http://www.r-bloggers.com/how-to-perform-a-logistic-regression-in-r/)

<ed><83>�<ec>��<ed><83>�<eb>�� <ec>��존데<ec>��<ed>��<eb>�� <ec>��<ed>��로도 만들<ec>��지�<a0>, <ec>��<eb>��가지 <ec>��<ed>��<ec>��<eb>��가 많이 <eb>��<ec>��<ec>��<eb>�� <ec>��<ec>���<9c> <eb>��<ec>��<ed>�� 과학�<bc> <ed>��계학<ec>��<ec>�� 측면<ec>��<ec>�� 바라보면 범주<ed>�� <eb>��<ec>��<ed>���<9c> <ec>��존여부가 종속변<ec>���<9c> <eb>��<ec>��<ec>�� <ec>��<ec>��, <ec>��측모<ed>��<ec>���<9c> <ec>��<ed>��<ec>��<ed>��기도 <ec>��<ec>��<ed>�� <eb>��<ec>��<ed>��<ec>��기도 <ed>��<eb>��.

<iframe width="560" height="315" src="https://www.youtube.com/embed/9xoqXVjBEF8" frameborder="0" allowfullscreen></iframe>


### 1.1. <ed><83>�<ec>��<ed><83>�<eb>�� <ec>���<b4> <eb>��<ec>��<ed>�� 가<ec>��<ec>���<b0> [^r-blogger-titanic]

[^r-blogger-titanic]: [How to perform a Logistic Regression in R](http://www.r-bloggers.com/how-to-perform-a-logistic-regression-in-r/)

[캐�<b8>� <ed><83>�<ec>��<ed><83>�<eb>�� <eb>��<ec>��<ed>��](https://www.kaggle.com/c/titanic/data)�<bc> <eb>��<ec>��로드 받아 로컬컴퓨<ed>��<ec>��<ec>�� 불러<ec>��<ec>��<ec>��거나,
GitHub <ec>��<ec>��<ed>��<ec>��<ec>�� 캐�<b8>� <ed><83>�<ec>��<ed><83>�<eb>�� <eb>��<ec>��<ed>���<bc> <ec>��<eb>��<eb>��<ec><9d>� 것을 바로 불러<ec>��<eb>��.
캐�<b8>� <ed><83>�<ec>��<eb>��<ed>�� <ec>���<b4> <eb>��<ec>��<ed>��<eb>�� `train.csv`<ec><99>� `test.csv`�<9c> <eb>��<eb>��<ec>�� <ec>��<eb>��<eb>�� <ec>��<eb>�� 모두 <ed>���<90> <ed>��<eb>��<ec>�� <eb>��<ec>��<ed>��<ec>��<ec>���<9c> 만들�<a0> <eb>��<ed>��<ec>�� <eb>��<ec>��<ed>���<8c> <ec>��처리 <ec>��<ec>��<ec>�� <ed>���<a0> <ec>��<ed>��<ec>�� 방식<ec>���<9c> <ec>��측하<eb>�� 방법<ec>�� <ec>��개한<eb>��.

|  변<ec>���<85>        |          변<ec>���<85> <ec>���<85>            |
|--------------|------------------------------|
|  **survival**    |    Survival (0 = No; 1 = Yes)|
|  pclass      |    Passenger Class  (1 = 1st; 2 = 2nd; 3 = 3rd)|
|  name        |    Name|
|  sex         |    Sex|
|  age         |    Age|
|  sibsp       |    Number of Siblings/Spouses Aboard|
|  parch       |    Number of Parents/Children Aboard|
|  ticket      |    Ticket Number|
|  fare        |    Passenger Fare|
|  cabin       |    Cabin|
|  embarked    |    Port of Embarkation (C = Cherbourg; Q = Queenstown; S = Southampton)|

`survival` <ec>�� 종속변<ec>��<ec>���<b0>, <eb>��머�<a7>��<bc> <ec>��측�<b3>�<ec>���<9c> <ec>��<ec>��<ed>��<ec>�� <ec>��존을 <ec>��측하<eb>�� 모형<ec>�� 개발<ed>��<eb>��.


~~~{.r}
##========================================================
## 01. <U+653C><U+3E62>��<U+653C><U+3E63>��<U+653C><U+3E64>�� 준�<U+383C><U+3E34>
##========================================================
# Titanic: Machine Learning from Disaster, https://www.kaggle.com/c/titanic/data

suppressMessages(library(readr))
suppressMessages(library(dplyr))
titanic.train.df <- read_csv("https://raw.githubusercontent.com/agconti/kaggle-titanic/master/data/train.csv")
titanic.test.df <- read_csv("https://raw.githubusercontent.com/agconti/kaggle-titanic/master/data/test.csv")
titanic <- bind_rows(titanic.train.df, titanic.test.df)
~~~


## 1.2. <eb>��<ec>��<ed>�� <ec>��<ec>�� 

<ed><83>�<ec>��<ed><83>�<eb>�� <ec>��존데<ec>��<ed>���<bc> 불러<ec>�� <eb>��<ec>�� <ed>��<ed>��<ec>�� <ed>��<ec>��<ed>���<a0>, 결측값에 <eb><8c>�<ed>�� <eb><8c>�<ec>��방안<ec>�� 마련<ed>��<eb>��.
<ec>���<bc> <eb>��<ec>��, 결측값이 <eb>���<b4> 많�<9d>� 경우 변<ec>��(`Cabin`) <ec>��체�<a5><bc> <ec>��거한<eb>��.
`Name`, `Ticket`처럼 관측점마다 <ec>��<ec>��<ed>�� 변<ec>��<eb>�� <ec>��보로<ec>�� <ec>��미�<b0>� <ec>���<b0> <eb>��문에 <ec>��것도 <ec>��거한<eb>��.
`Age` 변<ec>��<eb>�� <ed>��균을 매워<eb>��<eb>�� 것으�<9c> <ed>���<a0>, <ec>��<eb><8c>�<ec>��<ec>���<9c> <ec>��<ec><9d>� 결측값이 <ec>��<eb>�� 관측점<ec><9d>� 
`Embarked`, `Fare`, `Survived`<eb>�� 관측점<ec>�� <ec>��거하<eb>�� 방식<ec>���<9c> <ec>��<ec>�� <ec>��<ec>��<ec>�� <ec>��<ed>��<ed>��<eb>��.

<ed>��<ed>��, `Amelia` <ed>��<ed>��지<ec>�� `missmap` <ed>��<ec>���<bc> <ec>��<ec>��<ed>��<ec>�� 결측�<92> 진행 <ec>��<ec>��<ec>�� 바로 <ec>��각적<ec>���<9c> <ed>��<ec>��<ed>��<eb>��.


~~~{.r}
##========================================================
## 02. <U+653C><U+3E62>��<U+653C><U+3E63>��<U+653C><U+3E64>�� <U+653C><U+3E63>��<U+653C><U+3E63>��
##========================================================
# 2.1. <U+653C><U+3E64>��<U+653C><U+3E64>�� <U+653C><U+3E64>��<U+653C><U+3E63>��
summary(titanic)
~~~



~~~{.output}
  PassengerId      Survived          Pclass          Name          
 Min.   :   1   Min.   :0.0000   Min.   :1.000   Length:1309       
 1st Qu.: 328   1st Qu.:0.0000   1st Qu.:2.000   Class :character  
 Median : 655   Median :0.0000   Median :3.000   Mode  :character  
 Mean   : 655   Mean   :0.3838   Mean   :2.295                     
 3rd Qu.: 982   3rd Qu.:1.0000   3rd Qu.:3.000                     
 Max.   :1309   Max.   :1.0000   Max.   :3.000                     
                NA's   :418                                        
     Sex                 Age            SibSp            Parch      
 Length:1309        Min.   : 0.17   Min.   :0.0000   Min.   :0.000  
 Class :character   1st Qu.:21.00   1st Qu.:0.0000   1st Qu.:0.000  
 Mode  :character   Median :28.00   Median :0.0000   Median :0.000  
                    Mean   :29.88   Mean   :0.4989   Mean   :0.385  
                    3rd Qu.:39.00   3rd Qu.:1.0000   3rd Qu.:0.000  
                    Max.   :80.00   Max.   :8.0000   Max.   :9.000  
                    NA's   :263                                     
    Ticket               Fare            Cabin          
 Length:1309        Min.   :  0.000   Length:1309       
 Class :character   1st Qu.:  7.896   Class :character  
 Mode  :character   Median : 14.454   Mode  :character  
                    Mean   : 33.295                     
                    3rd Qu.: 31.275                     
                    Max.   :512.329                     
                    NA's   :1                           
   Embarked        
 Length:1309       
 Class :character  
 Mode  :character  
                   
                   
                   
                   

~~~



~~~{.r}
sapply(titanic, function(x) sum(is.na(x)))
~~~



~~~{.output}
PassengerId    Survived      Pclass        Name         Sex         Age 
          0         418           0           0           0         263 
      SibSp       Parch      Ticket        Fare       Cabin    Embarked 
          0           0           0           1        1014           2 

~~~



~~~{.r}
sapply(titanic, function(x) length(unique(x)))
~~~



~~~{.output}
PassengerId    Survived      Pclass        Name         Sex         Age 
       1309           3           3        1307           2          99 
      SibSp       Parch      Ticket        Fare       Cabin    Embarked 
          7           8         929         282         187           4 

~~~



~~~{.r}
suppressMessages(library(Amelia))
missmap(titanic, main = "결측값과 관측값")
~~~

<img src="fig/titanic-clean-1.png" title="plot of chunk titanic-clean" alt="plot of chunk titanic-clean" style="display: block; margin: auto;" />

~~~{.r}
# 2.2. 결측값에 <U+653C><U+3E62><U+383C><U+3E63>�<U+653C><U+3E64>�� <U+653C><U+3E63>���<U+393C><U+3E35>
# 분석<U+653C><U+3E63>�� <U+653C><U+3E63>��<U+653C><U+3E63>��<U+653C><U+3E62>�� 변<U+653C><U+3E63>���<U+383C><U+3E63> <U+653C><U+3E63>��<U+653C><U+3E63>��

titanic <- titanic %>% 
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare, Embarked) %>%  # 결측값이 많�<U+393C><U+3E64>� Cabin�<U+623C><U+3E63> <U+653C><U+3E63>���<U+383C><U+3E34>, Ticket<U+653C><U+3E63><U+393C><U+3E64>� <U+653C><U+3E63>���<U+623C><U+3E30>
  mutate(Age = ifelse(is.na(Age), mean(Age, na.rm=TRUE), Age)) %>%  # <U+653C><U+3E62>��<U+653C><U+3E63>���<U+623C><U+3E63> <U+653C><U+3E64>��균값<U+653C><U+3E63>���<U+393C><U+3E63> 치환
  filter(!is.na(Embarked)) %>%  # 결측�<U+393C><U+3E32> 2�<U+393C><U+3E63> <U+653C><U+3E64>�� <U+653C><U+3E63>���<U+623C><U+3E30>
  filter(!is.na(Fare)) %>%   # 결측�<U+393C><U+3E32> 1�<U+393C><U+3E63> <U+653C><U+3E64>�� <U+653C><U+3E63>���<U+623C><U+3E30>
  filter(!is.na(Survived))   # 결측�<U+393C><U+3E32> 418�<U+393C><U+3E63> <U+653C><U+3E64>�� <U+653C><U+3E63>���<U+623C><U+3E30>

missmap(titanic, main = "결측값과 관측값")
~~~

<img src="fig/titanic-clean-2.png" title="plot of chunk titanic-clean" alt="plot of chunk titanic-clean" style="display: block; margin: auto;" />

## 1.3. <ec>��측모<ed>�� <ec>��<ec>��

`caret` <ed>��<ed>��지 `createDataPartition` <ed>��<ec>���<bc> <ec>��<ec>��<ed>��<ec>�� 7:3<ec>���<9c> <ed>��<eb>��<eb>��<ec>��<ed>��<ec><99>� 검증데<ec>��<ed>���<9c> 구분<ed>��<eb>��.

`glm` <ed>��<ec>��<ec>�� `family=binomial(link='logit')` <ec>��<ec>���<bc> <eb>��<ec>�� <ec>��<ed>��<ed>��귀모형<ec>�� <ec>��<ed>��<ec>��<ed>��<eb>��.
<ed>��<ed>��, <ec>���<b4> 변<ec>���<bc> 모두 <eb>��<ec>�� `Survived ~.` <ec>��존을 <ec>��측하<eb>�� 모형<ec>�� 구축<ed>��<eb>��.

변<ec>���<bc> <ec>��<ec>��<ed>��<eb>�� 방법<ec><9d>� <ec>��<eb>��가지가 <ec>��<ec>��<eb>��, 먼�<a0>� `anova`<ed>��<ec>���<bc> <ec>��<ec>��<ed>��<ec>�� <ed>��<ed>��모델<ec>��<ec>�� 
<ec>��<ec>��<ec>��<ec>�� 변<ec>��<ec><99>� 그렇지 <ec>��<eb>�� 변<ec>���<bc> 구별<ed>��<eb>��. 비유<ec>��<ec>��<ec>�� 변<ec>���<bc> <ec>��거하�<a0> `logit.reduced.m` 축소<eb>�� 
<ec>��<ed>��<ed>��귀모형<ec>�� 개발<ed>��<eb>��. 

<ec>��<ed>��<ed>��귀<ec>��<ec>��<eb>�� $R^2$ 결정계수가 <ed>�� <ec>��미�<b0>� <ec>��<eb>���<a0> 주장<ed>��<eb>�� 경우<eb>�� <ec>��<ec>��<eb>��, `pscl` <ed>��<ed>��지<ec>�� 기능<ec>�� <ec>��<ec>��<ed>��<ec>�� 계산<ed>��본다.

`ROCR` <ed>��<ed>��지�<bc> <ec>��<ec>��<ed>��<ec>�� <ed>��<ed>��모형�<bc> 축소모형간에 차이가 <ec>��<eb>��지 ROC 면적�<bc> <eb>��불어 ROC 곡선<ec>�� <eb>��<ec>��<ed>��<ed>��<ec>�� 비교<ed>��<eb>��.

<eb>�� 모형간에 <ec>��<eb>��<ec>�� 차이<eb>�� <ec>��<ec>�� 보이�<b0>, 4�<9c> 모형<ec>�� <ec>��<ec>��<eb>�� 축약<eb>�� 모형<ec>�� <ed>��<ed>��모형�<bc> 거의 비슷<ed>�� <ec>��<eb>��<ec>�� <eb>���<a0> <ec>��<eb>��.


~~~{.r}
##========================================================
## 03. 모형 <U+653C><U+3E63>��<U+653C><U+3E64>��
##========================================================
## 
suppressMessages(library(caret))

#---------------------------------------------------------
# 3.1. <U+653C><U+3E64>��<U+653C><U+3E62>��<U+653C><U+3E62>��<U+653C><U+3E63>��<U+653C><U+3E64>��<U+653C><U+3E63><U+393C><U+3E39>� 검증데<U+653C><U+3E63>��<U+653C><U+3E64>�� 분리

train.id <- createDataPartition(titanic$Survived, p = 0.7)[[1]] 
titanic.train.df <- titanic[ train.id,] 
titanic.test.df <- titanic[-train.id,]

#---------------------------------------------------------
# 3.1. <U+653C><U+3E63>��<U+653C><U+3E64>��<U+653C><U+3E64>��귀 <U+653C><U+3E63>��<U+653C><U+3E64>��

logit.full.m <- glm(Survived ~.,family=binomial(link='logit'), data=titanic.train.df)
summary(logit.full.m)
~~~



~~~{.output}

Call:
glm(formula = Survived ~ ., family = binomial(link = "logit"), 
    data = titanic.train.df)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.5871  -0.6017  -0.4179   0.6264   2.4131  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)    
(Intercept)  5.170595   0.711947   7.263 3.80e-13 ***
Pclass      -1.142039   0.179502  -6.362 1.99e-10 ***
Sexmale     -2.602075   0.241133 -10.791  < 2e-16 ***
Age         -0.038474   0.009732  -3.953 7.71e-05 ***
SibSp       -0.344928   0.138358  -2.493   0.0127 *  
Parch       -0.133834   0.140858  -0.950   0.3420    
Fare         0.001663   0.003926   0.424   0.6719    
EmbarkedQ   -0.180700   0.456920  -0.395   0.6925    
EmbarkedS   -0.280202   0.287094  -0.976   0.3291    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 824.69  on 622  degrees of freedom
Residual deviance: 554.42  on 614  degrees of freedom
AIC: 572.42

Number of Fisher Scoring iterations: 5

~~~



~~~{.r}
#---------------------------------------------------------
# 3.2. 변<U+653C><U+3E63>��<U+653C><U+3E63>��<U+653C><U+3E64>��
anova(logit.full.m, test="Chisq")
~~~



~~~{.output}
Analysis of Deviance Table

Model: binomial, link: logit

Response: Survived

Terms added sequentially (first to last)

         Df Deviance Resid. Df Resid. Dev  Pr(>Chi)    
NULL                       622     824.69              
Pclass    1   84.741       621     739.95 < 2.2e-16 ***
Sex       1  160.268       620     579.68 < 2.2e-16 ***
Age       1   12.917       619     566.77 0.0003257 ***
SibSp     1   10.217       618     556.55 0.0013913 ** 
Parch     1    0.809       617     555.74 0.3683342    
Fare      1    0.355       616     555.38 0.5514932    
Embarked  2    0.966       614     554.42 0.6169738    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

~~~



~~~{.r}
#---------------------------------------------------------
# 3.3. 최적모형

logit.reduced.m <- glm(Survived  ~ Pclass+Sex+Age+SibSp, family=binomial(link='logit'), data=titanic.train.df)
summary(logit.reduced.m)
~~~



~~~{.output}

Call:
glm(formula = Survived ~ Pclass + Sex + Age + SibSp, family = binomial(link = "logit"), 
    data = titanic.train.df)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.6350  -0.5987  -0.4122   0.6272   2.4755  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)    
(Intercept)  5.103170   0.566080   9.015  < 2e-16 ***
Pclass      -1.209210   0.139888  -8.644  < 2e-16 ***
Sexmale     -2.582587   0.228822 -11.286  < 2e-16 ***
Age         -0.038695   0.009624  -4.021  5.8e-05 ***
SibSp       -0.376501   0.129534  -2.907  0.00365 ** 
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 824.69  on 622  degrees of freedom
Residual deviance: 556.55  on 618  degrees of freedom
AIC: 566.55

Number of Fisher Scoring iterations: 5

~~~



~~~{.r}
#---------------------------------------------------------
# 3.3. R^2 결정계수

suppressMessages(library(pscl))
pR2(logit.full.m)
~~~



~~~{.output}
         llh      llhNull           G2     McFadden         r2ML 
-277.2089507 -412.3449755  270.2720497    0.3277256    0.3519734 
        r2CU 
   0.4796180 

~~~



~~~{.r}
pR2(logit.reduced.m)
~~~



~~~{.output}
         llh      llhNull           G2     McFadden         r2ML 
-278.2738423 -412.3449755  268.1422665    0.3251431    0.3497543 
        r2CU 
   0.4765941 

~~~



~~~{.r}
#---------------------------------------------------------
# 3.4. 모형 <U+653C><U+3E64>��가

suppressMessages(library(ROCR))
# <U+653C><U+3E63>���<U+623C><U+3E34> 모형
logit.full.pred <- predict(logit.full.m, newdata=titanic.test.df, type="response")
logit.full.pr <- prediction(logit.full.pred, titanic.test.df$Survived)
logit.full.prf <- performance(logit.full.pr, measure = "tpr", x.measure = "fpr")
plot(logit.full.prf)
~~~

<img src="fig/titanic-model-1.png" title="plot of chunk titanic-model" alt="plot of chunk titanic-model" style="display: block; margin: auto;" />

~~~{.r}
# ROC 면적
logit.full.auc <- performance(logit.full.pr, measure = "auc")
logit.full.auc <- logit.full.auc@y.values[[1]]
logit.full.auc
~~~



~~~{.output}
[1] 0.8632075

~~~



~~~{.r}
# 축소 모형
logit.reduced.pred <- predict(logit.reduced.m, newdata=titanic.test.df, type="response")
logit.reduced.pr <- prediction(logit.reduced.pred, titanic.test.df$Survived)
logit.reduced.prf <- performance(logit.reduced.pr, measure = "tpr", x.measure = "fpr")
plot(logit.reduced.prf)
~~~

<img src="fig/titanic-model-2.png" title="plot of chunk titanic-model" alt="plot of chunk titanic-model" style="display: block; margin: auto;" />

~~~{.r}
# ROC 면적
logit.reduced.auc <- performance(logit.reduced.pr, measure = "auc")
logit.reduced.auc <- logit.reduced.auc@y.values[[1]]
logit.reduced.auc
~~~



~~~{.output}
[1] 0.8604953

~~~



~~~{.r}
#---------------------------------------------------------
# 3.5. ROC 면적비교

plot(logit.full.prf)
plot(logit.reduced.prf, add=TRUE, col="red")
~~~

<img src="fig/titanic-model-3.png" title="plot of chunk titanic-model" alt="plot of chunk titanic-model" style="display: block; margin: auto;" />

~~~{.r}
logit.full.auc
~~~



~~~{.output}
[1] 0.8632075

~~~



~~~{.r}
logit.reduced.auc
~~~



~~~{.output}
[1] 0.8604953

~~~

## 1.4. <ec>��<eb>�� 모형 <ec>��<ec>�� 방법

만약 $p$�<9c> 변<ec>��가 <ec>��<eb>���<b4> $2^p$ 만큼 가<eb>��<ed>�� 모형<ec>�� 존재<ed>��<eb>��. 모형<ec>�� 모두 <ec>��<ed>��<ec>���<9c> $2^p$ 모형중에<ec>�� <ec>��<eb>�� <eb>�� 기�<a4>�조건<ec>�� 만족<ed>��<eb>�� 최적<ec>�� 모형<ec>�� <ec>��<ec>��<ed>��<eb>��. 경우<ec>�� <ec>��가 <eb>���<b4> 많고, <ec>��<eb>��<ec>�� 비슷<ed>�� 모형<ec>�� 반복<ec>��<ec>���<9c> 개발<ed>�� <ec>��<eb>��<eb>�� <ec>���<a0> <ed>��<ec>��, 기�<a4>�조건(Criterion-based) 방법<ec>���<9c> <ed>��<ed>�� 변<ec>���<bc> 추출<ed>�� <eb>��간다. �<89>, 가<ec>�� <ec>��<eb>��<ec>�� 좋�<9d>� 변<ec>��부<ed>�� <ec>��<ed>��<ed>�� <eb>��가면서 복잡<ec>���<bc> <ec>��<eb>��<ec>�� 최적<ed>��<ed>��<eb>��. 가<ec>�� <ec>��반적<ec>���<9c> 많이 <ec>��<ec>��<eb>��<eb>�� 방식<ec>�� $AIC(Akaike Information Criterion)$, $BIC(Bayes Information Criterion)$<ec>�� <eb>�� <ec>�� <ec>��<eb>��.

$$AIC = -2 ln(L) + 2k $$
$$BIC = -2 ln(L) + k ln(n) $$

$L$<ec><9d>� 모형<ec>�� <eb><8c>�<ed>�� <ec>��<eb>��<ed>��<ec>�� 최�<8c>�값이�<a0>, $k$<eb>�� 모형<ec>�� <ec>��<ec>��<eb>�� 추정모수�<af><ec>��, $n$<ec><9d>� 관측점 �<af><ec>��가 <eb>��<eb>��.


~~~{.r}
##========================================================
## 04. 변<U+653C><U+3E63>��<U+653C><U+3E63>��<U+653C><U+3E64>�� 모형 <U+653C><U+3E63>��<U+653C><U+3E63>��
##========================================================
## 

logit.null.m <- glm(Survived ~1, family=binomial(link='logit'), data=titanic.train.df)
logit.full.m <- glm(Survived ~., family=binomial(link='logit'), data=titanic.train.df)

logit.bic.m <- step(logit.null.m, scope=formula(logit.full.m), direction="both", criterion="BIC", k=log(nrow(titanic.train.df)))
~~~



~~~{.output}
Start:  AIC=831.12
Survived ~ 1

           Df Deviance    AIC
+ Sex       1   653.99 666.86
+ Pclass    1   739.95 752.82
+ Fare      1   761.77 774.64
+ Embarked  2   808.52 827.82
<none>          824.69 831.12
+ Parch     1   821.51 834.38
+ Age       1   822.26 835.13
+ SibSp     1   823.40 836.27

Step:  AIC=666.86
Survived ~ Sex

           Df Deviance    AIC
+ Pclass    1   579.68 598.99
+ Fare      1   626.87 646.17
+ SibSp     1   645.73 665.03
<none>          653.99 666.86
+ Embarked  2   642.48 668.22
+ Parch     1   649.67 668.97
+ Age       1   653.66 672.96
- Sex       1   824.69 831.12

Step:  AIC=598.99
Survived ~ Sex + Pclass

           Df Deviance    AIC
+ Age       1   566.77 592.50
<none>          579.68 598.99
+ SibSp     1   573.90 599.63
+ Parch     1   577.74 603.48
+ Fare      1   579.68 605.42
+ Embarked  2   577.57 609.74
- Pclass    1   653.99 666.86
- Sex       1   739.95 752.82

Step:  AIC=592.5
Survived ~ Sex + Pclass + Age

           Df Deviance    AIC
+ SibSp     1   556.55 588.72
<none>          566.77 592.50
+ Parch     1   563.38 595.56
+ Fare      1   566.49 598.67
- Age       1   579.68 598.99
+ Embarked  2   564.81 603.41
- Pclass    1   653.66 672.96
- Sex       1   717.25 736.55

Step:  AIC=588.72
Survived ~ Sex + Pclass + Age + SibSp

           Df Deviance    AIC
<none>          556.55 588.72
- SibSp     1   566.77 592.50
+ Parch     1   555.74 594.35
+ Fare      1   556.40 595.01
- Age       1   573.90 599.63
+ Embarked  2   555.40 600.44
- Pclass    1   644.24 669.98
- Sex       1   714.18 739.92

~~~



~~~{.r}
logit.aic.m <- step(logit.null.m, scope=formula(logit.full.m), direction="both", criterion="AIC", k=2)
~~~



~~~{.output}
Start:  AIC=826.69
Survived ~ 1

           Df Deviance    AIC
+ Sex       1   653.99 657.99
+ Pclass    1   739.95 743.95
+ Fare      1   761.77 765.77
+ Embarked  2   808.52 814.52
+ Parch     1   821.51 825.51
+ Age       1   822.26 826.26
<none>          824.69 826.69
+ SibSp     1   823.40 827.40

Step:  AIC=657.99
Survived ~ Sex

           Df Deviance    AIC
+ Pclass    1   579.68 585.68
+ Fare      1   626.87 632.87
+ Embarked  2   642.48 650.48
+ SibSp     1   645.73 651.73
+ Parch     1   649.67 655.67
<none>          653.99 657.99
+ Age       1   653.66 659.66
- Sex       1   824.69 826.69

Step:  AIC=585.68
Survived ~ Sex + Pclass

           Df Deviance    AIC
+ Age       1   566.77 574.77
+ SibSp     1   573.90 581.90
<none>          579.68 585.68
+ Parch     1   577.74 585.74
+ Embarked  2   577.57 587.57
+ Fare      1   579.68 587.68
- Pclass    1   653.99 657.99
- Sex       1   739.95 743.95

Step:  AIC=574.77
Survived ~ Sex + Pclass + Age

           Df Deviance    AIC
+ SibSp     1   556.55 566.55
+ Parch     1   563.38 573.38
<none>          566.77 574.77
+ Fare      1   566.49 576.49
+ Embarked  2   564.81 576.81
- Age       1   579.68 585.68
- Pclass    1   653.66 659.66
- Sex       1   717.25 723.25

Step:  AIC=566.55
Survived ~ Sex + Pclass + Age + SibSp

           Df Deviance    AIC
<none>          556.55 566.55
+ Parch     1   555.74 567.74
+ Fare      1   556.40 568.40
+ Embarked  2   555.40 569.40
- SibSp     1   566.77 574.77
- Age       1   573.90 581.90
- Pclass    1   644.24 652.24
- Sex       1   714.18 722.18

~~~



~~~{.r}
logit.bic.m
~~~



~~~{.output}

Call:  glm(formula = Survived ~ Sex + Pclass + Age + SibSp, family = binomial(link = "logit"), 
    data = titanic.train.df)

Coefficients:
(Intercept)      Sexmale       Pclass          Age        SibSp  
    5.10317     -2.58259     -1.20921     -0.03869     -0.37650  

Degrees of Freedom: 622 Total (i.e. Null);  618 Residual
Null Deviance:	    824.7 
Residual Deviance: 556.5 	AIC: 566.5

~~~



~~~{.r}
logit.aic.m
~~~



~~~{.output}

Call:  glm(formula = Survived ~ Sex + Pclass + Age + SibSp, family = binomial(link = "logit"), 
    data = titanic.train.df)

Coefficients:
(Intercept)      Sexmale       Pclass          Age        SibSp  
    5.10317     -2.58259     -1.20921     -0.03869     -0.37650  

Degrees of Freedom: 622 Total (i.e. Null);  618 Residual
Null Deviance:	    824.7 
Residual Deviance: 556.5 	AIC: 566.5

~~~
