---
layout: page
title: xwMOOC 기계학습
subtitle: 데이터 과학자가 바라본 기계학습
---


> ### 기계와의 경쟁을 준비하며... {.challenge}
> "The future is here, it's just not evenly distributed yet."  
>                                                           - William Gibson


## 학습 목차

1. **환경설정**
    1. [명령라인 데이터 분석 맛보기](00-toolchain-cmd.html)    
        1. [대용량 데이터 표본추출](ml-random-sampling.html)    
    1. [파이썬기반 기계학습 툴체인(toolchain)](00-toolchain.html): 파이썬 기계학습 생태계
    1. [기계학습 (순수한) 맛보기](ml-taste-with-r.html): 전통적인 통계모형 개발과정 맛보기     
1. **[기계학습 지도와 통계모형](ml-map.html)**
    1. [3가지 기계학습 원리](ml-three-principles.html)
        1. [(사업) 문제의 정의](01-problem.html)
        1. [데이터(Data)](02-data.html)
        1. [데이터를 통한 문제풀이 과정](03-process.html)
    1. [테스트 주도 기계학습](31-ml-tdd.html)
    1. [기계학습 알고리즘](04-algorithm.html)
        1. [나무기반 기계학습모형](ml-tree-model.html)
        1. [기계학습 예측모형 준비](ml-predictive-modeling-basic.html)        
    1. **R 예측모형 안쪽**
        - [R 모형설계행렬(Recipe)](ml-r-design-matrix.html)
        - [R기반 빅데이터 개발/운영환경](ml-r-bigdata-workflow.html)
        - [R 모형개발 자동화(recipe, caret, twidlr)](ml-r-pipeline.html)
    1. 데이터 전처리
        1. [예측모형 적용을 위한 전처리](ml-preprocessing.html)
        1. [데이터 전처리 및 정제(파이썬)](14-ml-data-munging.html)
        1. [클래스 불균형(Class imbalance)](ml-class-imbalance.html)
    1. [탐색적 데이터 분석(EDA)](ml-eda.html)
        1. [범주형 변수와 표](ml-categorical-var-table.html)
        1. [텍스트 콘솔기반 탐색적 데이터 분석(EDA)](ml-text-console.html)
        1. [단변량/다변량 이상점 검출 - anomaly 탐지](ml-detect-anomaly.html)
        1. [단변량/다변량 이상점 검출 - 사기 탐지](ml-detect-outliers-mahalanobis.html)
            * [이상점(Outlier) 검출](ml-detect-outliers.html)
        1. [차원축소 - 포켓몬](ml-pokemon-unsupervised.html)
        1. [군집분석(Clustering) - 포켓몬](ml-pokemon-clustering-pipeline.html)
    1. [알고리즘 성능평가](ml-assessment.html)
1. [기계학습 운영 및 자동화 - 파이프라인](ml-production.html)
    1. [빅데이터 - AWS](https://statkclee.github.io/bigdata/)
    1. [데이터에 무게를 둔 예측모형](ml-modeling.html)
        1. **인간 중심 기계학습 모형**
            1. [선형대수와 함께하는 회귀분석 이해](ml-linear-algebra-reg.html)    
            1. [통계적 모형개발 기초](ml-modeling-basic.html)            
            1. [전통방식 모형개발 -타이타닉 생존데이터](ml-modeling-titanic.html)  
        1. **인간과 기계가 함께하는 기계학습 예측모형**  
            1. [기계학습 예측모형 실습](ml-predictive-modeling.html)
            1. [모형식별 및 선택](ml-model-selection.html)
            1. [회귀모형 &rarr; caret &rarr; 스파크 &rarr; $H_2 O$ - 1부](ml-from-reg-to-h2o.html)
            1. [회귀모형 &rarr; caret &rarr; 스파크 &rarr; $H_2 O$ - 2부](ml-from-reg-to-h2o-part-2.html)
            1. [사례 - 도요타 중고차 가격 예측](ml-pm-continuous.html)
            1. [사례 - 콘크리트 강도](ml-pm-continuous-concrete.html)
            1. [사례 - 카드발급](ml-credit-greene.html)
            1. [사례 - 기계고장 빈도수 예측](ml-machine-failures.html)            
        1. **기계 중심 기계학습**
1. **데이터 유형별 기계학습 모형**
    1. [네트워크 데이터](https://statkclee.github.io/network/): 보다 심화된 네트워크 데이터에 대한 분석을 위해 별도 저장소로 2017-12월 이동.
    1. [텍스트 데이터](https://statkclee.github.io/text/): 보다 심화된 네트워크 데이터에 대한 분석을 위해 별도 저장소로 2018-01월 이동.
        - [텍스트 데이터와 저작](https://statkclee.github.io/ds-authoring/)
    1. [공간정보 데이터](https://statkclee.github.io/spatial/)
    1. [시각 데이터](https://statkclee.github.io/trilobite/)
    1. **[장바구니 데이터 분석](ml-market-basket.html)** 
1. **기계학습 상용화**
    1. [기계학습 - 기술부채(Technical Debt)](ml-technical-debt.html)
    1. [보스턴 집값예측 - 주성분 회귀](ml-pm-boston.html)  
    1. [신용평점모형 개발](ml-credit-scoring-overview.html)
        1. [신용평점모형 탐색적 데이터 분석, 전처리](ml-credit-scoring-eda.html)
        1. [신용평점모형 - 로지스틱 회귀모형과 의사결정나무](ml-credit-scoring-model.html)
        1. [신용평가와 신용평점모형](ml-credit-scoring-business.html)
        1. [소매금융 부도예측 - 독일신용 데이터](ml-credit-scoring.html)
    1. [랜딩클럽 - 채무불이행 예측모형](ml-css-lendingclub.html)
    1. **마케팅**
        1. [마케팅 반응 예측모형](ml-pm-discrete.html)      
        1. [마케팅 - RFM 및 응용분야](ml-pm-applications.html)
    1. **[고객 이탈(churn)](ml-churn.html)**
        1. [데이터 위생처리(sanitize)](ml-pm-churn-sanitize.html)
        1. [고객 이탈(churn): 탐색적 데이터 분석(EDA)](ml-pm-churn-eda.html)
        1. [고객 이탈(churn) 예측모형](ml-pm-churn.html)
        1. [생존분석(Survival Analysis)](ml-pm-survival.html)
    1. [지방선거 광역단체장 지지율 예측모형](ml-local-election.html)


## 기계학습 관련 정보 [^David-Julian-2016]

* [Kevin Patrick Murphy, Machine Learning: a Probabilistic Perspective](www.cs.ubc.ca/~murphyk/MLbook)
* [metaoptimize.com](http://metaoptimize.com/qa)
* [stats.stackexchange.com](http://stats.stackexchange.com/)
* [캐글 블로그](http://blog.kaggle.com/)
* [MLcomp](http://mlcomp.org/): 기계학습 프로그램 비교 사이트
* [기계학습 이론 블로그](http://hunch.net)
* [텍스트 & 데이터 마이닝](http://textanddatamining.blogspot.kr/)
* [Caltech MOOC, Yaser Abu-Mostafa, Introductory Machine Learning, 2012](https://work.caltech.edu/telecourse.html)
* [Andrew Ng, Machine Learning, Stanford University](https://www.coursera.org/learn/machine-learning/)
* [Trevor Hastie, Robert Tibshirani, Jerome Friedman, The Elements of Statistical Learning - Data Mining, Inference, and Prediction, 2009](http://statweb.stanford.edu/~tibs/ElemStatLearn/)

> ### xwMOOC 오픈 교재
> 
> - [컴퓨터 과학 언플러그드](http://unplugged.xwmooc.org)  
> - [리보그](http://reeborg.xwmooc.org)  
>      - [러플](http://rur-ple.xwmooc.org)  
> - [파이썬 거북이](http://swcarpentry.github.io/python-novice-turtles/index-kr.html)  
> - [정보과학을 위한 파이썬](http://python.xwmooc.org)  
> - [소프트웨어 카펜트리 5.3](http://swcarpentry.xwmooc.org)
> - [통계적 사고](http://think-stat.xwmooc.org/)
> - [IoT 오픈 하드웨어(라즈베리 파이)](http://raspberry-pi.xwmooc.org/)
>     - [$100 오픈 컴퓨터](http://computer.xwmooc.org/)   
>     - [$100 오픈 슈퍼컴퓨터](http://computers.xwmooc.org/)
> - [R 데이터과학](http://data-science.xwmooc.org/)
> - [R 팩키지](http://r-pkgs.xwmooc.org/)
> - [기호 수학(Symbolic Math)](http://sympy.xwmooc.org/)
> - [선거와 투표](http://politics.xwmooc.org/)

[^David-Julian-2016]: [David Julian (2016), "Building Machine Learning Systems with Python", Packt Publishing](https://www.packtpub.com/big-data-and-business-intelligence/building-machine-learning-systems-python)