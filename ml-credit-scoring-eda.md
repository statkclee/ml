---
layout: page
title: xwMOOC 기계학습
subtitle: 신용평점모형 탐색적 데이터 분석
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 


> ### 학습목표 {.getready}
>
> * 



~~~{.r}
##=====================================================================
## 07. 채무 불이행 예측
##=====================================================================
# 종속변수 탐색
bad_indicators <- c("Charged Off",
                    "Default",
                    "Does not meet the credit policy. Status:Charged Off",
                    "In Grace Period", 
                    "Default Receiver", 
                    "Late (16-30 days)",
                    "Late (31-120 days)")

loan.dat$loan_status_yn <- ifelse(loan.dat$loan_status %in% bad_indicators, 1, 0)
~~~



~~~{.output}
Error in match(x, table, nomatch = 0L): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
# 1. 표를 통한 EDA 분석
## 단변량 표
CrossTable(loan.dat$loan_status_yn)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "CrossTable"를 찾을 수 없습니다

~~~



~~~{.r}
## 두변수 표
CrossTable(loan.dat$grade, loan.dat$loan_status_yn, prop.r = TRUE, prop.c=FALSE, prop.t=FALSE, prop.chisq=FALSE)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "CrossTable"를 찾을 수 없습니다

~~~



~~~{.r}
# 2. 그래프를 통한 EDA 분석
library(DescTools)
~~~



~~~{.output}
Error in library(DescTools): there is no package called 'DescTools'

~~~



~~~{.r}
## 단변량: 히스토그램
Desc(loan.dat$loan_amnt, plotit=TRUE)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "Desc"를 찾을 수 없습니다

~~~



~~~{.r}
index_highincome <- which(loan.dat$annual_inc > 2e+06)
~~~



~~~{.output}
Error in which(loan.dat$annual_inc > 2e+06): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
loan.dat2 <- loan.dat[-index_highincome,]
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
# Desc(loan.dat$annual_inc, plotit=TRUE)
Desc(loan.dat2$annual_inc, plotit=TRUE)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "Desc"를 찾을 수 없습니다

~~~



~~~{.r}
## 다변량: 산점도
index_sample <- sample(1:nrow(loan.dat2), 0.1*nrow(loan.dat2))
~~~



~~~{.output}
Error in nrow(loan.dat2): 객체 'loan.dat2'를 찾을 수 없습니다

~~~



~~~{.r}
loan.plot.dat <- loan.dat2[index_sample, ]
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'loan.dat2'를 찾을 수 없습니다

~~~



~~~{.r}
Desc(loan.plot.dat$loan_amnt ~ loan.plot.dat$annual_inc, plotit=TRUE)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "Desc"를 찾을 수 없습니다

~~~



~~~{.r}
# 3. 결측값 처리
# 결측값 생성하기
summary(loan.dat$int_rate)
~~~



~~~{.output}
Error in summary(loan.dat$int_rate): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
na_index <- sample(1:nrow(loan.dat), 0.1*nrow(loan.dat))
~~~



~~~{.output}
Error in nrow(loan.dat): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
loan.dat[na_index, "int_rate"] <- NA
~~~



~~~{.output}
Error in loan.dat[na_index, "int_rate"] <- NA: 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
summary(loan.dat$int_rate)
~~~



~~~{.output}
Error in summary(loan.dat$int_rate): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
# 전략1: 결측값 제거
int_na_index <- which(is.na(loan.dat$int_rate))
~~~



~~~{.output}
Error in which(is.na(loan.dat$int_rate)): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
loan.dat.delrow.na <- loan.dat[-int_na_index, ]
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
dim(loan.dat.delrow.na)
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'loan.dat.delrow.na'를 찾을 수 없습니다

~~~



~~~{.r}
# 전략2: 결측값 채워넣기
median_ir <- median(loan.dat$int_rate, na.rm=TRUE)
~~~



~~~{.output}
Error in median(loan.dat$int_rate, na.rm = TRUE): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
mean_ir <- mean(loan.dat$int_rate, na.rm=TRUE)
~~~



~~~{.output}
Error in mean(loan.dat$int_rate, na.rm = TRUE): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
loan.dat$int_rate[int_na_index] <- median_ir
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'median_ir'를 찾을 수 없습니다

~~~



~~~{.r}
loan.dat$int_rate[int_na_index] <- mean_ir
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'mean_ir'를 찾을 수 없습니다

~~~



~~~{.r}
# 전략3: 결측값 보존 -- 중요한 정보를 갖음

loan.dat$ir_cat <- rep(NA, length(loan.dat$int_rate))
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
loan.dat$ir_cat[which(loan.dat$int_rate <= 8)] <- "0-8"
~~~



~~~{.output}
Error in loan.dat$ir_cat[which(loan.dat$int_rate <= 8)] <- "0-8": 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
loan.dat$ir_cat[which(loan.dat$int_rate > 8 & loan.dat$int_rate <= 11)] <- "8-11"
~~~



~~~{.output}
Error in loan.dat$ir_cat[which(loan.dat$int_rate > 8 & loan.dat$int_rate <= : 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
loan.dat$ir_cat[which(loan.dat$int_rate > 11 & loan.dat$int_rate <= 13.5)] <- "11-13.5"
~~~



~~~{.output}
Error in loan.dat$ir_cat[which(loan.dat$int_rate > 11 & loan.dat$int_rate <= : 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
loan.dat$ir_cat[which(loan.dat$int_rate > 13.5)] <- "13.5+"
~~~



~~~{.output}
Error in loan.dat$ir_cat[which(loan.dat$int_rate > 13.5)] <- "13.5+": 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
loan.dat$ir_cat[which(is.na(loan.dat$int_rate))] <- "Missing"
~~~



~~~{.output}
Error in loan.dat$ir_cat[which(is.na(loan.dat$int_rate))] <- "Missing": 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
loan.dat$ir_cat <- as.factor(loan.dat$ir_cat)
~~~



~~~{.output}
Error in is.factor(x): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
# Look at your new variable using plot()
plot(loan.dat$ir_cat)
~~~



~~~{.output}
Error in plot(loan.dat$ir_cat): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
# 심화 탐색

numeric_cols <- sapply(loan.dat, is.numeric)
~~~



~~~{.output}
Error in lapply(X = X, FUN = FUN, ...): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
library(reshape2)
loanbook.lng <- melt(loan.dat[,numeric_cols], id="is_bad")
~~~



~~~{.output}
Error in melt(loan.dat[, numeric_cols], id = "is_bad"): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
library(ggplot2)
p <- ggplot(aes(x = value, group = is_bad, colour = factor(is_bad)), 
            data = loanbook.lng)
~~~



~~~{.output}
Error in ggplot(aes(x = value, group = is_bad, colour = factor(is_bad)), : 객체 'loanbook.lng'를 찾을 수 없습니다

~~~



~~~{.r}
p + geom_density() + facet_wrap(~variable, scales="free")
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'p'를 찾을 수 없습니다

~~~



~~~{.r}
install.packages("DT")
~~~



~~~{.output}
Error in contrib.url(repos, "source"): trying to use CRAN without setting a mirror

~~~



~~~{.r}
library(DT)
~~~



~~~{.output}
Error in library(DT): there is no package called 'DT'

~~~



~~~{.r}
loan.dat %>% 
  filter(loan_status_yn == '1') %>% 
  select(annual_inc, int_rate, loan_status) %>% 
  datatable(., options = list(pageLength = 10))
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 함수 "%>%"를 찾을 수 없습니다

~~~



~~~{.r}
##=====================================================================
## 03. 렌딩클럽 데이터 기계학습
##=====================================================================

# 0. 훈련과 테스트 데이터셋 분리
index_train <- sample(1:nrow(loan.dat), 2/3*nrow(loan.dat))
~~~



~~~{.output}
Error in nrow(loan.dat): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
training_set <- loan.dat[index_train, ]
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'loan.dat'를 찾을 수 없습니다

~~~



~~~{.r}
test_set <- loan.dat[-index_train,]  
~~~



~~~{.output}
Error in eval(expr, envir, enclos): 객체 'loan.dat'를 찾을 수 없습니다

~~~
