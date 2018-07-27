---
layout: page
title: xwMOOC 기계학습
subtitle: 고객 이탈(churn)
date: "2018-07-27"
output:
  html_document: 
    toc: yes
    toc_float: true
    highlight: tango
    code_folding: hide
    number_section: true
---
 




# 고객이탈(Churn) [^mca-churn] [^logistic-churn] {#customer-attrition-basics} 

[^mca-churn]: [Data Science +, "Using MCA and variable clustering in R for insights in customer attrition"](https://datascienceplus.com/using-mca-and-variable-clustering-in-r-for-insights-in-customer-attrition/)

[^logistic-churn]: [Data Science +, "Predict Customer Churn – Logistic Regression, Decision Tree and Random Forest"](https://datascienceplus.com/predict-customer-churn-logistic-regression-decision-tree-and-random-forest/)


고객이탈은 영어로 "Customer Churn" 혹은 "Customer Attrition"이라고 하는데 통상적으로 고객이 
더이상 서비스 이용이나 제품구매를 멈출 때 발생된다.
거의 모든 사업영역에서 고객이탈이 문제가 되지만, 
특히 문제가 되는 분야가 통신(텔코, Tele-communication)산업으로 KT, SKT, U+ 등 통신3사가 거의 과점을 하고 있는 
산업분야로 이해하면 된다.

# 데이터셋 {#customer-attrition-dataset}

고객이탈 데이터셋으로 [IBM Watson Analytics, Guide to Sample Data Sets](https://www.ibm.com/communities/analytics/watson-analytics-blog/guide-to-sample-datasets/) 
웹사이트에 다양한 데이터가 공개되어 있으며, 
그중 고객지원(Customer Support), [WA_Fn UseC_ Telco Customer Churn.csv](https://community.watsonanalytics.com/wp-content/uploads/2015/03/WA_Fn-UseC_-Telco-Customer-Churn.csv)
데이터를 다운로드 받아 **"고객이탈 예측모형"**을 개발해 보자.

# 고객이탈 예측모형 작업흐름 {#customer-attrition-workflow}

고객이탈 예측모형은 일반적인 예측모형(predictive model)과 작업흐름이 다르지 않다.
예측하고자 하는 변수가 **이탈(churn)** 여부(0/1, yes/no, 1/2, 이탈/정상 등)로 다양하게 인코딩한다.

데이터를 분석환경으로 불러와서 데이터를 전처리하고, 탐색적 데이터 분석 및 변수공학을 동원하여 
고객이탈 예측을 높일 수 있는 변수를 찾아내고 가공한다. 
그리고 나서 고객이탈을 예측할 수 있는 다양한 모형 아키텍쳐를 식별하여 
선정된 최종 예측모형 아키텍쳐에 대해서 변수선정 및 초모수 미세조정을 통한 모형 튜닝작업을 수행한다.
고객이탈 예측모형에 대한 모형성능을 평가하고 나서, 예측모형 배포 및 서비스를 실시한다.

1. 데이터 가져오기
1. 데이터 전처리
    - 탐색적 데이터 분석
    - 변수 공학(Feature Engineering) 
    - 단/다변량 변수 시각화
1. 예측모형 개발 
    - 훈련/테스트 데이터 분할
    - 예측모형 아키텍처 선정
    - 선정된 예측모형 아키텍쳐 기반 변수선정 및 초모수(hyper parameter) 미세조정을 통한 모형 튜팅
    - 모형성능 평가
1. 예측모형 배포 및 서비스    

<img src="fig/ml-churn-pipeline.png" alt="고객이탈 예측모형 개발 파이프라인" width="100%" />





