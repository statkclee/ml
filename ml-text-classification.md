# xwMOOC 기계학습
 


## 1. 텍스트 분류(Text classification) [^apac-machine-learning-summit]

[^apac-machine-learning-summit]: [송치성, "Naïve or not", 바벨피쉬, APAC 머신러닝, 데이터 사이언스 커뮤니티 서밋](http://onoffmix.com/event/97444)

분류기는 사전 분류될 집단이 정해진 경우 어떤 집단에 속할 것인지 판별하여 지정하는 역할 수행한다.
텍스트 분류의 종류는 다음과 같은 것이 있다.

- 주제(Topic): 텍스트가 무엇에 관한 것인가 분류.
- 감정(Sentiment): 다양한 감정 상태 중 어떤 감정 상태에 가까운가 분류.
- 언어(Language): 어느 나라, 어느 민족 텍스트인지 분류.
- 쟝르(Genre): 텍스트가 어떤 쟝르(시, 소설, 등)에 속하는지 분류.
- 저자(Author): 텍스트를 보고 누구의 글인지 판별.
- ...

## 2. 베이즈 정리를 활용한 텍스트 분류기

전자우편/채팅이 스팸일 확률을 찾고자 하는데 베이즈 정리로 출발해서, 
단어가 하나인 경우를 경유하여 단어를 다수 포함한 전자우편/채팅으로 확장해 보자.

### 2.1. 베이즈 정리 

특정 단어가 나오면 그 전자우편/채팅이 스팸일 확률을 베이즈 정리를 활용하면 다음과 같다.

$$ P(s|w) = \frac {P(s,w)}{P(w)} = \frac {P(w|s)P(s)}{P(w)} $$

여기서, $P(w):$ 전자우편이나 채팅에서 특정단어가 출현할 확률(예를 들어, Sell, 팔아요 등), $P(s)$는 전자우편이나 채팅이 스팸일 확률

$$P(w) = P(w, s) + P(w, \sim s)$$

### 2.2. 단어 한개를 가정한 베이즈 정리

상기 관계를 이용하여 단어가 주어졌을 때 스팸일 확률을 다음과 같이 정리할 수 있다.

$$ P(s|w) = \frac {P(w|s)P(s)}{P(w)} = \frac {P(w|s)P(s)}{P(w, s) + P(w, \sim s)} = \frac {P(w|s)P(s)}{P(w|s)P(s) + P(w| \sim s)P(\sim s)}$$

즉, 스팸중에서 특정 단어가 출현할 조건부 확률 $P(w|s)$ 과 스팸이 아닌 것 중에 특정 단어가 출현할 확률 $P(w|\sim s)$만 알게 된다면 
단어가 주어졌을 때 스팸일 확률을 계산할 수 있게 된다.

### 2.2. 다수 단어를 가정한 베이즈 정리

우선 다수 단어를 $W$라고 가정한다. 즉, $W = w_1 , w_2 , \cdots , w_n$ 라고 다수 단어를 표현한다.
그리고, 각 단어가 서로 독립적이라는 가정을 넣으면 수식은 다음과 같이 단순화된다.

$$\begin{aligned} 
   P(s|W) &= \frac {P(W|s) P(s)}{P(W)} \\
          &= P(w_1 , w_2 , \cdots , w_n |s) P(s) \\
          &= P(w_1 |s)P(w_2 |s) \cdots P(w_n |s)
\end{aligned}
$$

## 3. SMS 단문문자 스팸 분류 [^nb-spam-classifier]

[^nb-spam-classifier]: [Jesus M. Castagnetto (2015-01-03), SPAM/HAM SMS classification using caret and Naive Bayes](https://rpubs.com/jesuscastagnetto/caret-naive-bayes-spam-ham-sms)

나이브 베이즈를 활용해서 SMS 단문문자 스팸 분류기 모형을 다음과 같이 개발할 수 있다.
가장 먼저, 데이터는 국내에도 SMS 단문문자 스팸데이터가 있다면 공유되면 좋을텐데 아쉽게도 해외 
Tiago A. Almeida, José Maria Gómez Hidalgo 분들이 생성한 `SMS Spam Collection v.1` 데이터를 활용한다.


### 3.1. 환경설정과 데이터 가져오기 

[http://www.dt.fee.unicamp.br/~tiago/smsspamcollection/smsspamcollection.zip](http://www.dt.fee.unicamp.br/~tiago/smsspamcollection/smsspamcollection.zip) 
웹사이트에서 직접 다운로드 해서 모형 개발 디렉토리 넣고 압축을 풀어 분석을 수행해도 된다.


~~~{.r}
# 0. 환경설정 -------------------------------------
# library(tidyverse)
# library(caret)
# library(tm)
# library(extrafont)
# loadfonts()
# library(ggthemes)
# library(doMC)
# registerDoMC(cores=4)
# library(forcats)
# library(randomForest)
# library(extrafont)
# library(knitr)
# library(gridExtra)
# library(FactoMineR)
# library(ggmosaic)


# 1. 데이터 가져오기 -------------------------------------

# if (!file.exists("smsspamcollection.zip")) {
#     download.file(url="http://www.dt.fee.unicamp.br/~tiago/smsspamcollection/smsspamcollection.zip",
#                   destfile="smsspamcollection.zip", method="curl")}
# 
# unzip("data/smsspamcollection.zip", exdir="./data")

sms_raw <- read_delim("data/SMSSpamCollection/SMSSpamCollection.txt", delim="\t", col_names = FALSE)
colnames(sms_raw) <- c("type", "text")
~~~

### 3.2. 데이터 전처리

기본적으로 스팸이냐 아니냐는 `sms_raw$type` 변수에 저장되어 있다.
즉, 스팸이냐 아니냐는 SMS 단문 메시지에 담긴 문자내용이 핵심인데, 
나이브 베이즈 모형에 넣도록 단어를 추출해서 이를 문선단어행렬(DocumentTermMatrix)로 변환한다.
그리고 훈련과 검증 데이터로 분할한다.


~~~{.r}
# 2. 데이터 전처리 -------------------------------------
sms_raw$type <- factor(sms_raw$type)

sms_corpus <- Corpus(VectorSource(sms_raw$text))
sms_corpus_clean <- sms_corpus %>%
    tm_map(content_transformer(tolower)) %>% 
    tm_map(removeNumbers) %>%
    tm_map(removeWords, stopwords(kind="en")) %>%
    tm_map(removePunctuation) %>%
    tm_map(stripWhitespace)

sms_dtm <- DocumentTermMatrix(sms_corpus_clean)

# 3. 기계학습 모형 -------------------------------------
## 3.1. 훈련/검증 데이터 -------------------------------
train_index <- createDataPartition(sms_raw$type, p=0.75, list=FALSE)
# 훈련/검증 데이터
sms_raw_train <- sms_raw[train_index,]
sms_raw_test <- sms_raw[-train_index,]

# 훈련/검증 텍스트 코퍼스
sms_corpus_clean_train <- sms_corpus_clean[train_index]
sms_corpus_clean_test <- sms_corpus_clean[-train_index]

# 훈련/검증 문서단어행렬
sms_dtm_train <- sms_dtm[train_index,]
sms_dtm_test <- sms_dtm[-train_index,]

## 3.2. 모형설계행렬 -------------------------------
sms_dict <- findFreqTerms(sms_dtm_train, lowfreq=5)
sms_train <- DocumentTermMatrix(sms_corpus_clean_train, list(dictionary=sms_dict))
sms_test <- DocumentTermMatrix(sms_corpus_clean_test, list(dictionary=sms_dict))

convert_counts <- function(x) {
    x <- ifelse(x > 0, 1, 0)
    x <- factor(x, levels = c(0, 1), labels = c("Absent", "Present"))
}

sms_train <- sms_train %>% apply(MARGIN=2, FUN=convert_counts)
sms_test <- sms_test %>% apply(MARGIN=2, FUN=convert_counts)

sms_train %>% tbl_df %>% 
    sample_n(100) %>% 
    dplyr::select(1:10) %>% 
    DT::datatable()
~~~

<!--html_preserve--><div id="htmlwidget-9b2ce78131eb88acac00" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-9b2ce78131eb88acac00">{"x":{"filter":"none","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"],["Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent"],["Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent"],["Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Present","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent"],["Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent"],["Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent"],["Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent"],["Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent"],["Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Present","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Present","Present","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Present","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Present","Absent","Absent","Absent","Absent","Absent"],["Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent"],["Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Present","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent","Absent"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>available<\/th>\n      <th>cine<\/th>\n      <th>crazy<\/th>\n      <th>got<\/th>\n      <th>great<\/th>\n      <th>point<\/th>\n      <th>wat<\/th>\n      <th>world<\/th>\n      <th>lar<\/th>\n      <th>wif<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"crosstalkOptions":{"key":null,"group":null},"order":[],"autoWidth":false,"orderClasses":false,"columnDefs":[{"orderable":false,"targets":0}]},"selection":{"mode":"multiple","selected":null,"target":"row"}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

### 3.3. 나이브 베이즈 모형

`caret` 팩키지에 내장된 나이브베이즈 모형에 적합시키고 성능을 시각화한다.
나이브베이즈 모형의 성능평가는 훈련데이터가 아니라 검증데이터를 활용하여 성능을 평가한다.
그리고, `ggplot`을 활용하여 스팸과 정상 SMS 확률을 시각화한다.


~~~{.r}
## 3.3. 베이즈모형 적합 -------------------------------
ctrl <- trainControl(method="cv", number=10, repeats=3)
nb_grid <- data.frame(.fL=c(1), .usekernel=c(FALSE), .adjust=c(FALSE))

system.time(
sms_nb_mod <- train(sms_train, sms_raw_train$type, 
                    method="nb",
                    tuneGrid = nb_grid,
                    trControl=ctrl)
)
~~~



~~~{.output}
   user  system elapsed 
  39.66    0.39   40.47 

~~~



~~~{.r}
sms_nb_mod
~~~



~~~{.output}
Naive Bayes 

3629 samples
1245 predictors
   2 classes: 'ham', 'spam' 

No pre-processing
Resampling: Cross-Validated (10 fold) 
Summary of sample sizes: 3267, 3266, 3266, 3266, 3266, 3266, ... 
Resampling results:

  Accuracy   Kappa    
  0.9779538  0.8975798

Tuning parameter 'fL' was held constant at a value of 1
Tuning
 parameter 'usekernel' was held constant at a value of FALSE

Tuning parameter 'adjust' was held constant at a value of FALSE

~~~



~~~{.r}
## 3.4. 베이즈모형 성능평가 -------------------------------

sms_nb_pred <- predict(sms_nb_mod, sms_test)
cm_nb <- confusionMatrix(sms_nb_pred, sms_raw_test$type, positive="spam")
cm_nb
~~~



~~~{.output}
Confusion Matrix and Statistics

          Reference
Prediction ham spam
      ham  959  105
      spam  90   54
                                          
               Accuracy : 0.8386          
                 95% CI : (0.8166, 0.8589)
    No Information Rate : 0.8684          
    P-Value [Acc > NIR] : 0.9988          
                                          
                  Kappa : 0.2644          
 Mcnemar's Test P-Value : 0.3161          
                                          
            Sensitivity : 0.3396          
            Specificity : 0.9142          
         Pos Pred Value : 0.3750          
         Neg Pred Value : 0.9013          
             Prevalence : 0.1316          
         Detection Rate : 0.0447          
   Detection Prevalence : 0.1192          
      Balanced Accuracy : 0.6269          
                                          
       'Positive' Class : spam            
                                          

~~~



~~~{.r}
## 3.5. 베이즈 모형평가 시각화 -------------------------------

sms_nb_prob <- predict(sms_nb_mod, sms_test, type="prob")

sms_nb_prob %>% 
  gather(spam_ham, prob) %>% 
  ggplot(., aes(x=prob)) +
    geom_density(aes(color=spam_ham, fill=spam_ham, alpha=0.3)) +
    theme_bw(base_family = "NanumGothic") +
    scale_x_continuous(labels = scales::percent) +
    labs(x="", y="밀도", title="단문문자 스팸 분류기 성능") +
    theme(legend.position = "top") +
    guides(alpha=FALSE)
~~~

<img src="fig/naive-bayes-spam-naive-bayes-1.png" style="display: block; margin: auto;" />

## 4. 유방암 발병 예측 [^navie-bayes-breast-cancer]

[^navie-bayes-breast-cancer]: [Naive Bayes Classification in R (Part 2)](https://sw23993.wordpress.com/2017/02/17/naive-bayes-classification-in-r-part-2/)

슬로베니아 (구, 유고슬라비아) Matjaz Zwitter, Milan Soklic가 공개한 
[유방암(Breast Cancer Data Set) 데이터셋](https://archive.ics.uci.edu/ml/datasets/Breast+Cancer)은 현재 
UCI에 담당자에게 전자우편을 전달하면 2--3일 후 전달받을 수 있다.
나이브 베이즈를 활용하여 유방암 발병예측하는데 좋은 데이터셋으로 전체 변수가 모두 범주형으로 되어 있다.

### 4.1. 데이터 설명 

- class: 유방암 발병 여부
- age: 연령대 20-29 ~ 70-79
- menopause: 진단시 환자가 폐경인지 폐경이 아닌지 여부 
- tumor.size: 최대 절제 암 크기 직경(mm)
- inv.nodes: 림프노드 갯수(number of axillary lymph nodes)
- node.caps: 림프 노드 캡술에 전싱성 암이 포함되었는지 여부
- deg.malign: 암에 대한 조직학적 등급 분류 (1--3, 3 = 매우 비정상 세포)
- breast: 암이 왼쪽 오른쪽 어느 유방에 위치했나 
- breast.quad: 유방암이 발병한 지역 (유두를 중심으로 4분면)
- irradiat: 환자가 방사선 치료를 받았는지 여부 

### 4.1. 사전 준비 

UCI 담당자에게서 전달받은 데이터를 불러와서, 
데이터분석을 위해 변수명을 부여하고 문자형 데이터를 요인형 데이터로 변환시켜 `naiveBayes` 모형 적합시킬 준비를 한다.


~~~{.r}
# 0. 환경설정 -----------------------
# library(tidyverse)
# library(e1071)

# 1. 데이터 가져오기 -----------------------
breast_cancer <- read_csv("data/breast-cancer/breast-cancer.data", col_names = FALSE)

# 2. 데이터 전처리 -----------------------
names(breast_cancer) <- c("class", "age", "menopause", "tumor.size", "inv.nodes", "node.caps","deg.malign","breast","breast.quad","irradia")

breast_cancer <- breast_cancer %>% 
    mutate_all(funs(as.factor(.))) %>% 
    mutate(inv.nodes = fct_relevel(inv.nodes, "0-2","3-5","6-8", "9-11", "12-14", "15-17", "24-26")) %>% 
    mutate(tumor.size = fct_relevel(tumor.size, "0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54")) %>% 
    mutate(class = fct_relevel(class, "recurrence-events", "no-recurrence-events"))

# glimpse(breast_cancer)    
~~~

### 4.3. 유방암 발병 탐색적 데이터 분석

유방암 발병과 관련하여 `breast_cancer` 데이터프레임에는 총 10개의 변수가 있고,
결국 `class` 종속변수(유방암 발병 여부)를 나머지 범주형 9개 변수를 통해 예측하는 것이다.
종속변수와 연관이 있는 변수를 사전에 탐색적 데이터 과정을 통해 살펴보는 것도 향후 예측모형 개발과 연관되어 
중요하다. 다변량 대응분석(Multivariate Correspondance Analysis, MCA)을 통해 `class` 변수와 연관된 범주형 데이터에 대한 
대응분석을 실시한다.



~~~{.r}
# 3. 탐색적 데이터 분석 -----------------------
bc_df <- breast_cancer %>% 
    group_by(class,age, menopause, tumor.size, inv.nodes, node.caps, deg.malign, breast.quad, irradia) %>% 
    summarise(cnt = n())

## 3.1. MCA
bc_mca <- MCA(breast_cancer, quali.sup = 1, graph=FALSE)

par(mfrow=c(1,3))
plot(bc_mca, axes=c(1,2), choix="var", autoLab="n", invisible = c( "ind"),  shadow=TRUE, hab="quali")
plot(bc_mca, axes=c(1,3), choix="var", autoLab="n", invisible = c( "ind"),  shadow=TRUE, hab="quali")
plot(bc_mca, axes=c(2,3), choix="var", autoLab="n", invisible = c( "ind"),  shadow=TRUE, hab="quali")
~~~

<img src="fig/nb-breast-cancer-ca-1.png" style="display: block; margin: auto;" />

대응분석으로 `class` 종속변수와 관련성 높은 설명변수를 일부 추려 모자이크 그래프를 통해 시각화한다.



~~~{.r}
## 3.2. ggplot 시각화
class_by_nodes_gg <- ggplot(bc_df) +
    geom_mosaic(aes(weight=cnt, x=product(age), fill=class) ,na.rm=TRUE) +
    facet_grid(inv.nodes~.) +
    labs(x="연령", title='연령별, 림프노드 갯수별 유방암 발병') + 
    theme_bw(base_family="NanumGothic") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1),
          legend.position='top', legend.direction='horizontal') +
    scale_fill_brewer(palette="Set2") +
    guides(fill=guide_legend(title = "유방암 발병", reverse = TRUE))

class_by_quad_gg <- ggplot(bc_df) +
    geom_mosaic(aes(weight=cnt, x=product(age), fill=class) ,na.rm=TRUE) +
    facet_grid(breast.quad~.) +
    labs(x="연령", title='연령별, 유방암이 발병한 지역별 유방암 발병') + 
    theme_bw(base_family="NanumGothic") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1),
          legend.position='top', legend.direction='horizontal') +
    scale_fill_brewer(palette="Set2") +
    guides(fill=guide_legend(title = "유방암 발병", reverse = TRUE))

grid.arrange(class_by_nodes_gg, class_by_quad_gg, ncol=2)
~~~

<img src="fig/nb-breast-cancer-ggplot-1.png" style="display: block; margin: auto;" />

범주형 데이터를 시각화하는 것과 함께 `dplyr` 깔끔한(tidy) 데이터를 바탕으로 
표로 표현하는 것도 가능하다.


~~~{.r}
# breast_cancer %>% 
#     ungroup() %>% 
#     count(class, age, breast.quad) %>% 
#     group_by(age,breast.quad) %>% 
#     mutate(pcnt = scales::percent(n/sum(n))) %>% 
#     select(-pcnt) %>% 
#     spread(age, n, fill=0) %>% 
#     kable()

breast_cancer %>% 
    count(class, age, breast.quad) %>% 
    group_by(age, breast.quad) %>% 
    mutate(pcnt = scales::percent(n/sum(n))) %>% 
    # select(-n) %>%
    spread(age, pcnt, fill=0) %>% 
    kable()
~~~



class                  breast.quad     n  20-29   30-39   40-49   50-59    60-69   70-79 
---------------------  ------------  ---  ------  ------  ------  -------  ------  ------
recurrence-events      ?               1  0       0       0       100%     0       0     
recurrence-events      central         1  0       20%     0       12.5%    0       0     
recurrence-events      central         2  0       0       0       0        50%     0     
recurrence-events      left_low        1  0       0       0       0        0       100%  
recurrence-events      left_low        6  0       0       0       0        25%     0     
recurrence-events      left_low        7  0       50%     0       0        0       0     
recurrence-events      left_low        9  0       0       0       23.7%    0       0     
recurrence-events      left_low       12  0       0       36.4%   0        0       0     
recurrence-events      left_up         5  0       0       0       0        22.7%   0     
recurrence-events      left_up         6  0       60%     0       18.8%    0       0     
recurrence-events      left_up         9  0       0       29%     0        0       0     
recurrence-events      right_low       1  0       25%     9.1%    0        50%     0     
recurrence-events      right_low       3  0       0       0       50%      0       0     
recurrence-events      right_up        3  0       0       0       0        60%     0     
recurrence-events      right_up        5  0       0       41.7%   45.45%   0       0     
no-recurrence-events   central         1  0       0       0       0        0       100%  
no-recurrence-events   central         2  0       0       0       0        50%     0     
no-recurrence-events   central         3  0       0       100%    0        0       0     
no-recurrence-events   central         4  0       80%     0       0        0       0     
no-recurrence-events   central         7  0       0       0       87.5%    0       0     
no-recurrence-events   left_low        7  0       50%     0       0        0       0     
no-recurrence-events   left_low       18  0       0       0       0        75%     0     
no-recurrence-events   left_low       21  0       0       63.6%   0        0       0     
no-recurrence-events   left_low       29  0       0       0       76.3%    0       0     
no-recurrence-events   left_up         2  0       0       0       0        0       100%  
no-recurrence-events   left_up         4  0       40%     0       0        0       0     
no-recurrence-events   left_up        17  0       0       0       0        77.3%   0     
no-recurrence-events   left_up        22  0       0       71%     0        0       0     
no-recurrence-events   left_up        26  0       0       0       81.2%    0       0     
no-recurrence-events   right_low       1  0       0       0       0        50%     100%  
no-recurrence-events   right_low       3  0       75%     0       50%      0       0     
no-recurrence-events   right_low      10  0       0       90.9%   0        0       0     
no-recurrence-events   right_up        1  100%    0       0       0        0       100%  
no-recurrence-events   right_up        2  0       0       0       0        40%     0     
no-recurrence-events   right_up        3  0       100%    0       0        0       0     
no-recurrence-events   right_up        6  0       0       0       54.55%   0       0     
no-recurrence-events   right_up        7  0       0       58.3%   0        0       0     

`tumor.size`도 고려하여 모자이크 그래프를 통해 시각화한다.


~~~{.r}
ggplot(bc_df) +
    geom_mosaic(aes(weight=cnt, x=product(age), fill=class) ,na.rm=TRUE) +
    facet_grid(tumor.size~.)  +
    labs(x="연령", title='연령별, 최대 절제 암 크기 직경별 유방암 발병') + 
    theme_bw(base_family="NanumGothic") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1),
          legend.position='right', legend.direction='vertical') +
    scale_fill_brewer(palette="Set2") +
    guides(fill=guide_legend(title = "유방암 발병", reverse = TRUE))
~~~

<img src="fig/nb-breast-cancer-ggplot2-1.png" style="display: block; margin: auto;" />

`Random Forest` 팩키지를 활용하여 예측에 중요하게 사용되는 변수도 추출해 본다.


~~~{.r}
# 4. randomForest -----------------------
bc_fit <- randomForest(class ~ .,
                    data=breast_cancer, 
                    importance=TRUE, 
                    ntree=1000)

par(family = "NanumGothic")
varImpPlot(bc_fit, main="유방암 예측 변수 중요도")
~~~

<img src="fig/nb-breast-cancer-rf-1.png" style="display: block; margin: auto;" />

~~~{.r}
bc_pred <- predict(bc_fit, breast_cancer, type="response")
(conf_matrix <- table(bc_pred, breast_cancer$class))
~~~



~~~{.output}
                      
bc_pred                recurrence-events no-recurrence-events
  recurrence-events                   71                    1
  no-recurrence-events                14                  200

~~~

### 4.2. 나이브 베이즈 모형 적합

`e1071` 팩키지에 포함된 `naiveBayes` 모형을 활용하여 예측 모형을 생성한다.
그리고, 오차행렬을 통해 전체 데이터에 대한 예측 정확도를 평가한다.


~~~{.r}
# 3. 나이브 베이즈 모형 -----------------------
model <- naiveBayes(class ~ ., data = breast_cancer)
summary(model)
~~~



~~~{.output}
        Length Class  Mode     
apriori 2      table  numeric  
tables  9      -none- list     
levels  2      -none- character
call    4      -none- call     

~~~



~~~{.r}
# 4. 모형 성능평가 -----------------------
preds <- predict(model, newdata = breast_cancer)
(conf_matrix <- table(preds, breast_cancer$class))
~~~



~~~{.output}
                      
preds                  recurrence-events no-recurrence-events
  recurrence-events                   47                   32
  no-recurrence-events                38                  169

~~~
