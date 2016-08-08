---
layout: page
title: xwMOOC ê¸°ê³„<ed>•™<ec>Šµ
subtitle: <ec> „<ed>†µë°©ì‹ ëª¨í˜•ê°œë°œ - <ed><83>€<ec>´<ed><83>€<eb>‹‰ <ec>ƒì¡<b4> <eb>°<ec>´<ed>„°
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---


 
> ## <ed>•™<ec>Šµëª©í‘œ {.objectives}
>
> * <ec> „<ed>†µë°©ì‹ ëª¨í˜•ê°œë°œ ë°©ì‹<ec>„ <ed><83>€<ec>´<ed><83>€<eb>‹‰ <ec>ƒì¡´ë°<ec>´<ed>„°<ec>— <ec> <ec>š©<ed>•œ<eb>‹¤.
> * CMM 3<ec>ˆ˜ì¤€<ec>— <ed>•´<eb>‹¹<eb>˜<eb>Š” ëª¨í˜•ê°œë°œ ë°©ì‹<ec>œ¼ë¡<9c> ê°„ì£¼<ed>•  <ec>ˆ˜<eb>„ <ec>ˆ<eb>‹¤.

## 1. <ed><83>€<ec>´<ed><83>€<eb>‹‰ <ec>ƒì¡<b4> <eb>°<ec>´<ed>„° [^r-bloggers-logistic]

[^r-bloggers-logistic]: [R-bloggers, How to perform a Logistic Regression in R](http://www.r-bloggers.com/how-to-perform-a-logistic-regression-in-r/)

<ed><83>€<ec>´<ed><83>€<eb>‹‰ <ec>ƒì¡´ë°<ec>´<ed>„°<eb>Š” <ec>˜<ed>™”ë¡œë„ ë§Œë“¤<ec>–´ì§€ê³<a0>, <ec>—¬<eb>Ÿ¬ê°€ì§€ <ec>—<ed>”¼<ec>†Œ<eb>“œê°€ ë§ì´ <eb>“¤<ec>–´<ec>ˆ<eb>Š” <ec>†Œ<ec>¬ë¡<9c> <eb>°<ec>´<ed>„° ê³¼í•™ê³<bc> <ed>†µê³„í•™<ec> <ec>¸ ì¸¡ë©´<ec>—<ec>„œ ë°”ë¼ë³´ë©´ ë²”ì£¼<ed>˜• <eb>°<ec>´<ed>„°ë¡<9c> <ec>ƒì¡´ì—¬ë¶€ê°€ ì¢…ì†ë³€<ec>ˆ˜ë¡<9c> <eb>…¹<ec>•„<ec> ¸ <ec>ˆ<ec>–´, <ec>˜ˆì¸¡ëª¨<ed>˜•<ec>œ¼ë¡<9c> <ec> <ed>•©<ec>‹œ<ed>‚¤ê¸°ë„ <ec> <ec> ˆ<ed>•œ <eb>°<ec>´<ed>„°<ec>´ê¸°ë„ <ed>•˜<eb>‹¤.

<iframe width="560" height="315" src="https://www.youtube.com/embed/9xoqXVjBEF8" frameborder="0" allowfullscreen></iframe>


### 1.1. <ed><83>€<ec>´<ed><83>€<eb>‹‰ <ec>ƒì¡<b4> <eb>°<ec>´<ed>„° ê°€<ec> ¸<ec>˜¤ê¸<b0> [^r-blogger-titanic]

[^r-blogger-titanic]: [How to perform a Logistic Regression in R](http://www.r-bloggers.com/how-to-perform-a-logistic-regression-in-r/)

[ìºê<b8>€ <ed><83>€<ec>´<ed><83>€<eb>‹‰ <eb>°<ec>´<ed>„°](https://www.kaggle.com/c/titanic/data)ë¥<bc> <eb>‹¤<ec>š´ë¡œë“œ ë°›ì•„ ë¡œì»¬ì»´í“¨<ed>„°<ec>—<ec>„œ ë¶ˆëŸ¬<ec>½<ec>–´<ec>˜¤ê±°ë‚˜,
GitHub <ec>‚¬<ec>´<ed>Š¸<ec>—<ec>„œ ìºê<b8>€ <ed><83>€<ec>´<ed><83>€<eb>‹‰ <eb>°<ec>´<ed>„°ë¥<bc> <ec>˜¬<eb> ¤<eb>†“<ec><9d>€ ê²ƒì„ ë°”ë¡œ ë¶ˆëŸ¬<ec>˜¨<eb>‹¤.
ìºê<b8>€ <ed><83>€<ec>´<eb>‚˜<ed>‹± <ec>ƒì¡<b4> <eb>°<ec>´<ed>„°<eb>Š” `train.csv`<ec><99>€ `test.csv`ë¡<9c> <eb>‚˜<eb>ˆ <ec> ¸ <ec>ˆ<eb>Š”<eb>° <ec>¼<eb>‹¨ ëª¨ë‘ <ed>•©ì³<90> <ed>•˜<eb>‚˜<ec>˜ <eb>°<ec>´<ed>„°<ec>…‹<ec>œ¼ë¡<9c> ë§Œë“¤ê³<a0> <eb>‚œ<ed>›„<ec>— <eb>™<ec>¼<ed>•˜ê²<8c> <ec> „ì²˜ë¦¬ <ec>‘<ec>—…<ec>„ <ed>•˜ê³<a0> <ec> „<ed>†µ<ec>  ë°©ì‹<ec>œ¼ë¡<9c> <ec>˜ˆì¸¡í•˜<eb>Š” ë°©ë²•<ec>„ <ec> „ê°œí•œ<eb>‹¤.

|  ë³€<ec>ˆ˜ëª<85>        |          ë³€<ec>ˆ˜ëª<85> <ec>„¤ëª<85>            |
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

`survival` <ec>´ ì¢…ì†ë³€<ec>ˆ˜<ec>´ë©<b0>, <eb>‚˜ë¨¸ì<a7>€ë¥<bc> <ec>˜ˆì¸¡ë<b3>€<ec>ˆ˜ë¡<9c> <ec>‚¬<ec>š©<ed>•´<ec>„œ <ec>ƒì¡´ì„ <ec>˜ˆì¸¡í•˜<eb>Š” ëª¨í˜•<ec>„ ê°œë°œ<ed>•œ<eb>‹¤.


~~~{.r}
##========================================================
## 01. <U+653C><U+3E62>°<U+653C><U+3E63>´<U+653C><U+3E64>„° ì¤€ë¹<U+383C><U+3E34>
##========================================================
# Titanic: Machine Learning from Disaster, https://www.kaggle.com/c/titanic/data

suppressMessages(library(readr))
suppressMessages(library(dplyr))
titanic.train.df <- read_csv("https://raw.githubusercontent.com/agconti/kaggle-titanic/master/data/train.csv")
titanic.test.df <- read_csv("https://raw.githubusercontent.com/agconti/kaggle-titanic/master/data/test.csv")
titanic <- bind_rows(titanic.train.df, titanic.test.df)
~~~


## 1.2. <eb>°<ec>´<ed>„° <ec> •<ec> œ 

<ed><83>€<ec>´<ed><83>€<eb>‹‰ <ec>ƒì¡´ë°<ec>´<ed>„°ë¥<bc> ë¶ˆëŸ¬<ec>˜¨ <eb>‹¤<ec>Œ <ed>˜„<ed>™©<ec>„ <ed>ŒŒ<ec>•…<ed>•˜ê³<a0>, ê²°ì¸¡ê°’ì— <eb><8c>€<ed>•œ <eb><8c>€<ec>‘ë°©ì•ˆ<ec>„ ë§ˆë ¨<ed>•œ<eb>‹¤.
<ec>˜ˆë¥<bc> <eb>“¤<ec>–´, ê²°ì¸¡ê°’ì´ <eb>„ˆë¬<b4> ë§ì<9d>€ ê²½ìš° ë³€<ec>ˆ˜(`Cabin`) <ec>ì²´ë<a5><bc> <ec> œê±°í•œ<eb>‹¤.
`Name`, `Ticket`ì²˜ëŸ¼ ê´€ì¸¡ì ë§ˆë‹¤ <ec>œ <ec>¼<ed>•œ ë³€<ec>ˆ˜<eb>Š” <ec> •ë³´ë¡œ<ec>„œ <ec>˜ë¯¸ê<b0>€ <ec>—†ê¸<b0> <eb>•Œë¬¸ì— <ec>´ê²ƒë„ <ec> œê±°í•œ<eb>‹¤.
`Age` ë³€<ec>ˆ˜<eb>Š” <ed>‰ê· ì„ ë§¤ì›Œ<eb>„£<eb>Š” ê²ƒìœ¼ë¡<9c> <ed>•˜ê³<a0>, <ec>ƒ<eb><8c>€<ec> <ec>œ¼ë¡<9c> <ec> <ec><9d>€ ê²°ì¸¡ê°’ì´ <ec>ˆ<eb>Š” ê´€ì¸¡ì <ec><9d>€ 
`Embarked`, `Fare`, `Survived`<eb>Š” ê´€ì¸¡ì <ec>„ <ec> œê±°í•˜<eb>Š” ë°©ì‹<ec>œ¼ë¡<9c> <ec> •<ec> œ <ec>‘<ec>—…<ec>„ <ec>ˆ˜<ed>–‰<ed>•œ<eb>‹¤.

<ed>Š¹<ed>ˆ, `Amelia` <ed>Œ©<ed>‚¤ì§€<ec>˜ `missmap` <ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ ê²°ì¸¡ê°<92> ì§„í–‰ <ec>‘<ec>—…<ec>„ ë°”ë¡œ <ec>‹œê°ì <ec>œ¼ë¡<9c> <ed>™•<ec>¸<ed>•œ<eb>‹¤.


~~~{.r}
##========================================================
## 02. <U+653C><U+3E62>°<U+653C><U+3E63>´<U+653C><U+3E64>„° <U+653C><U+3E63> •<U+653C><U+3E63> œ
##========================================================
# 2.1. <U+653C><U+3E64>˜„<U+653C><U+3E64>™© <U+653C><U+3E64>ŒŒ<U+653C><U+3E63>•…
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
missmap(titanic, main = "ê²°ì¸¡ê°’ê³¼ ê´€ì¸¡ê°’")
~~~

<img src="fig/titanic-clean-1.png" title="plot of chunk titanic-clean" alt="plot of chunk titanic-clean" style="display: block; margin: auto;" />

~~~{.r}
# 2.2. ê²°ì¸¡ê°’ì— <U+653C><U+3E62><U+383C><U+3E63>€<U+653C><U+3E64>•œ <U+653C><U+3E63>‘ì§<U+393C><U+3E35>
# ë¶„ì„<U+653C><U+3E63>— <U+653C><U+3E63>‚¬<U+653C><U+3E63>š©<U+653C><U+3E62>  ë³€<U+653C><U+3E63>ˆ˜ë§<U+383C><U+3E63> <U+653C><U+3E63>„ <U+653C><U+3E63> •

titanic <- titanic %>% 
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare, Embarked) %>%  # ê²°ì¸¡ê°’ì´ ë§ì<U+393C><U+3E64>€ Cabinê³<U+623C><U+3E63> <U+653C><U+3E63>´ë¦<U+383C><U+3E34>, Ticket<U+653C><U+3E63><U+393C><U+3E64>€ <U+653C><U+3E63> œê±<U+623C><U+3E30>
  mutate(Age = ifelse(is.na(Age), mean(Age, na.rm=TRUE), Age)) %>%  # <U+653C><U+3E62>‚˜<U+653C><U+3E63>´ë¥<U+623C><U+3E63> <U+653C><U+3E64>‰ê· ê°’<U+653C><U+3E63>œ¼ë¡<U+393C><U+3E63> ì¹˜í™˜
  filter(!is.na(Embarked)) %>%  # ê²°ì¸¡ê°<U+393C><U+3E32> 2ê°<U+393C><U+3E63> <U+653C><U+3E64>–‰ <U+653C><U+3E63> œê±<U+623C><U+3E30>
  filter(!is.na(Fare)) %>%   # ê²°ì¸¡ê°<U+393C><U+3E32> 1ê°<U+393C><U+3E63> <U+653C><U+3E64>–‰ <U+653C><U+3E63> œê±<U+623C><U+3E30>
  filter(!is.na(Survived))   # ê²°ì¸¡ê°<U+393C><U+3E32> 418ê°<U+393C><U+3E63> <U+653C><U+3E64>–‰ <U+653C><U+3E63> œê±<U+623C><U+3E30>

missmap(titanic, main = "ê²°ì¸¡ê°’ê³¼ ê´€ì¸¡ê°’")
~~~

<img src="fig/titanic-clean-2.png" title="plot of chunk titanic-clean" alt="plot of chunk titanic-clean" style="display: block; margin: auto;" />

## 1.3. <ec>˜ˆì¸¡ëª¨<ed>˜• <ec> <ec>š©

`caret` <ed>Œ©<ed>‚¤ì§€ `createDataPartition` <ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ 7:3<ec>œ¼ë¡<9c> <ed>›ˆ<eb> ¨<eb>°<ec>´<ed>„°<ec><99>€ ê²€ì¦ë°<ec>´<ed>„°ë¡<9c> êµ¬ë¶„<ed>•œ<eb>‹¤.

`glm` <ed>•¨<ec>ˆ˜<ec>— `family=binomial(link='logit')` <ec>¸<ec>ë¥<bc> <eb>„£<ec>–´ <ec>´<ed>•­<ed>šŒê·€ëª¨í˜•<ec>„ <ec> <ed>•©<ec>‹œ<ed>‚¨<eb>‹¤.
<ed>Š¹<ed>ˆ, <ec> „ì²<b4> ë³€<ec>ˆ˜ë¥<bc> ëª¨ë‘ <eb>„£<ec>–´ `Survived ~.` <ec>ƒì¡´ì„ <ec>˜ˆì¸¡í•˜<eb>Š” ëª¨í˜•<ec>„ êµ¬ì¶•<ed>•œ<eb>‹¤.

ë³€<ec>ˆ˜ë¥<bc> <ec>„ <ec> •<ed>•˜<eb>Š” ë°©ë²•<ec><9d>€ <ec>—¬<eb>Ÿ¬ê°€ì§€ê°€ <ec>ˆ<ec>œ¼<eb>‚˜, ë¨¼ì<a0>€ `anova`<ed>•¨<ec>ˆ˜ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ <ed>¬<ed>™”ëª¨ë¸<ec>—<ec>„œ 
<ec>œ <ec>˜<ec> <ec>¸ ë³€<ec>ˆ˜<ec><99>€ ê·¸ë ‡ì§€ <ec>•Š<eb>Š” ë³€<ec>ˆ˜ë¥<bc> êµ¬ë³„<ed>•œ<eb>‹¤. ë¹„ìœ <ec>˜<ec> <ec>¸ ë³€<ec>ˆ˜ë¥<bc> <ec> œê±°í•˜ê³<a0> `logit.reduced.m` ì¶•ì†Œ<eb>œ 
<ec>´<ed>•­<ed>šŒê·€ëª¨í˜•<ec>„ ê°œë°œ<ed>•œ<eb>‹¤. 

<ec>´<ed>•­<ed>šŒê·€<ec>‹<ec>—<eb>Š” $R^2$ ê²°ì •ê³„ìˆ˜ê°€ <ed>° <ec>˜ë¯¸ê<b0>€ <ec>—†<eb>‹¤ê³<a0> ì£¼ì¥<ed>•˜<eb>Š” ê²½ìš°<eb>„ <ec>ˆ<ec>œ¼<eb>‚˜, `pscl` <ed>Œ©<ed>‚¤ì§€<ec>˜ ê¸°ëŠ¥<ec>„ <ec>‚¬<ec>š©<ed>•˜<ec>—¬ ê³„ì‚°<ed>•´ë³¸ë‹¤.

`ROCR` <ed>Œ©<ed>‚¤ì§€ë¥<bc> <ec>‚¬<ec>š©<ed>•´<ec>„œ <ed>¬<ed>™”ëª¨í˜•ê³<bc> ì¶•ì†Œëª¨í˜•ê°„ì— ì°¨ì´ê°€ <ec>ˆ<eb>Š”ì§€ ROC ë©´ì ê³<bc> <eb>”ë¶ˆì–´ ROC ê³¡ì„ <ec>„ <eb>„<ec>‹<ed>™”<ed>•˜<ec>—¬ ë¹„êµ<ed>•œ<eb>‹¤.

<eb>‘ ëª¨í˜•ê°„ì— <ec>„±<eb>Š¥<ec>˜ ì°¨ì´<eb>Š” <ec>—†<ec>–´ ë³´ì´ë©<b0>, 4ê°<9c> ëª¨í˜•<ec>´ <ec>‚¬<ec>š©<eb>œ ì¶•ì•½<eb>œ ëª¨í˜•<ec>´ <ed>¬<ed>™”ëª¨í˜•ê³<bc> ê±°ì˜ ë¹„ìŠ·<ed>•œ <ec>„±<eb>Š¥<ec>„ <eb>‚´ê³<a0> <ec>ˆ<eb>‹¤.


~~~{.r}
##========================================================
## 03. ëª¨í˜• <U+653C><U+3E63> <U+653C><U+3E64>•©
##========================================================
## 
suppressMessages(library(caret))

#---------------------------------------------------------
# 3.1. <U+653C><U+3E64>›ˆ<U+653C><U+3E62> ¨<U+653C><U+3E62>°<U+653C><U+3E63>´<U+653C><U+3E64>„°<U+653C><U+3E63><U+393C><U+3E39>€ ê²€ì¦ë°<U+653C><U+3E63>´<U+653C><U+3E64>„° ë¶„ë¦¬

train.id <- createDataPartition(titanic$Survived, p = 0.7)[[1]] 
titanic.train.df <- titanic[ train.id,] 
titanic.test.df <- titanic[-train.id,]

#---------------------------------------------------------
# 3.1. <U+653C><U+3E63>„ <U+653C><U+3E64>˜•<U+653C><U+3E64>šŒê·€ <U+653C><U+3E63> <U+653C><U+3E64>•©

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
# 3.2. ë³€<U+653C><U+3E63>ˆ˜<U+653C><U+3E63>„ <U+653C><U+3E64>ƒ
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
# 3.3. ìµœì ëª¨í˜•

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
# 3.3. R^2 ê²°ì •ê³„ìˆ˜

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
# 3.4. ëª¨í˜• <U+653C><U+3E64>‰ê°€

suppressMessages(library(ROCR))
# <U+653C><U+3E63> „ì²<U+623C><U+3E34> ëª¨í˜•
logit.full.pred <- predict(logit.full.m, newdata=titanic.test.df, type="response")
logit.full.pr <- prediction(logit.full.pred, titanic.test.df$Survived)
logit.full.prf <- performance(logit.full.pr, measure = "tpr", x.measure = "fpr")
plot(logit.full.prf)
~~~

<img src="fig/titanic-model-1.png" title="plot of chunk titanic-model" alt="plot of chunk titanic-model" style="display: block; margin: auto;" />

~~~{.r}
# ROC ë©´ì 
logit.full.auc <- performance(logit.full.pr, measure = "auc")
logit.full.auc <- logit.full.auc@y.values[[1]]
logit.full.auc
~~~



~~~{.output}
[1] 0.8632075

~~~



~~~{.r}
# ì¶•ì†Œ ëª¨í˜•
logit.reduced.pred <- predict(logit.reduced.m, newdata=titanic.test.df, type="response")
logit.reduced.pr <- prediction(logit.reduced.pred, titanic.test.df$Survived)
logit.reduced.prf <- performance(logit.reduced.pr, measure = "tpr", x.measure = "fpr")
plot(logit.reduced.prf)
~~~

<img src="fig/titanic-model-2.png" title="plot of chunk titanic-model" alt="plot of chunk titanic-model" style="display: block; margin: auto;" />

~~~{.r}
# ROC ë©´ì 
logit.reduced.auc <- performance(logit.reduced.pr, measure = "auc")
logit.reduced.auc <- logit.reduced.auc@y.values[[1]]
logit.reduced.auc
~~~



~~~{.output}
[1] 0.8604953

~~~



~~~{.r}
#---------------------------------------------------------
# 3.5. ROC ë©´ì ë¹„êµ

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

## 1.4. <ec><eb>™ ëª¨í˜• <ec>„ <ec> • ë°©ë²•

ë§Œì•½ $p$ê°<9c> ë³€<ec>ˆ˜ê°€ <ec>ˆ<eb>‹¤ë©<b4> $2^p$ ë§Œí¼ ê°€<eb>Š¥<ed>•œ ëª¨í˜•<ec>´ ì¡´ì¬<ed>•œ<eb>‹¤. ëª¨í˜•<ec>„ ëª¨ë‘ <ec> <ed>•©<ec>‹œì¼<9c> $2^p$ ëª¨í˜•ì¤‘ì—<ec>„œ <ec>„±<eb>Š¥ <eb>“± ê¸°ì<a4>€ì¡°ê±´<ec>„ ë§Œì¡±<ed>•˜<eb>Š” ìµœì <ec>˜ ëª¨í˜•<ec>„ <ec>„ <ec> •<ed>•œ<eb>‹¤. ê²½ìš°<ec>˜ <ec>ˆ˜ê°€ <eb>„ˆë¬<b4> ë§ê³ , <ec>„±<eb>Š¥<ec>´ ë¹„ìŠ·<ed>•œ ëª¨í˜•<ec>„ ë°˜ë³µ<ec> <ec>œ¼ë¡<9c> ê°œë°œ<ed>•  <ec>š°<eb> ¤<eb>„ <ec>ˆê³<a0> <ed>•´<ec>„œ, ê¸°ì<a4>€ì¡°ê±´(Criterion-based) ë°©ë²•<ec>œ¼ë¡<9c> <ed>†µ<ed>•´ ë³€<ec>ˆ˜ë¥<bc> ì¶”ì¶œ<ed>•´ <eb>‚˜ê°„ë‹¤. ì¦<89>, ê°€<ec>¥ <ec>„±<eb>Š¥<ec>´ ì¢‹ì<9d>€ ë³€<ec>ˆ˜ë¶€<ed>„° <ec>„ <ed>ƒ<ed>•´ <eb>‚˜ê°€ë©´ì„œ ë³µì¡<ec>„±ê³<bc> <ec>„±<eb>Š¥<ec>„ ìµœì <ed>™”<ed>•œ<eb>‹¤. ê°€<ec>¥ <ec>¼ë°˜ì <ec>œ¼ë¡<9c> ë§ì´ <ec>‚¬<ec>š©<eb>˜<eb>Š” ë°©ì‹<ec>´ $AIC(Akaike Information Criterion)$, $BIC(Bayes Information Criterion)$<ec>„ <eb>“¤ <ec>ˆ˜ <ec>ˆ<eb>‹¤.

$$AIC = -2 ln(L) + 2k $$
$$BIC = -2 ln(L) + k ln(n) $$

$L$<ec><9d>€ ëª¨í˜•<ec>— <eb><8c>€<ed>•œ <ec>š°<eb>„<ed>•¨<ec>ˆ˜ ìµœë<8c>€ê°’ì´ê³<a0>, $k$<eb>Š” ëª¨í˜•<ec>— <ec>‚¬<ec>š©<eb>œ ì¶”ì •ëª¨ìˆ˜ê°<af><ec>ˆ˜, $n$<ec><9d>€ ê´€ì¸¡ì  ê°<af><ec>ˆ˜ê°€ <eb>œ<eb>‹¤.


~~~{.r}
##========================================================
## 04. ë³€<U+653C><U+3E63>ˆ˜<U+653C><U+3E63>„ <U+653C><U+3E64>ƒ ëª¨í˜• <U+653C><U+3E63>„ <U+653C><U+3E63> •
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
