---
layout: page
title: xwMOOC 기계학습
subtitle: 기계학습 적용
---

> ## 학습목표 {.objectives}
>
> * 기계학습과 딥러닝 실제 적용을 준비한다.

## 1. 기계학습 완성 과정

* 기계학습 설계 과정
    1. 목표 설정: 오차 측도 설정, 목표 변수 설정
    1. 시작과 끝을 잇는 파이프라인 구축: 성능 측정 및 모니터링 측도 포함 자동화 프로세스 구축
    1. 성능 문제점을 잘 파악하도록 시스템을 계측: 성능이 떨어지는 구성요소를 진단하고, 원인이 과대적합, 과소적합, 데이터 혹은 소프트웨어 결함(defect)인지 파악한다.
    1. 지속적인 공정 개선: 신규 데이터 수집, 초모수(hyperparameter) 조정, 알고리듬 변경 등

### 1.1. 목표 설정

오차가 전혀없는 기계학습 알고리듬을 개발하는 것은 불가능하다. 완벽하게 목표변수를 예측하는 데이터 수집이 불가능하기도 하고, 표현하는 알고리즘 자체가 확률적이라 일정부분 오차가 내재하기 때문이다. 또한, 기계학습 알고리듬이 처리할 수 있는 **유효범위(Coverage)** 를 잘 설정하는 것도 반듯이 필요하다. 

### 1.2. 파이프 라인 구축

다양한 기계학습 알고리듬 적용을 고민할 필요없이, **AI-complete** 범주에 속하는 문제, 즉, 사물인식, 음성인식, 기계번역 등의 경우 기계학습/딥러닝을 적용한다. 

1. 기계학습/러닝 모형 선정
    * 기존 논문에 제시된 가장 성능좋은 혹은 일반적으로 알려진 기계학습/딥러닝 알고리듬을 비교 벤치마킹 대상으로 선정한다.
    * 고정길이 벡터 입력값이며 지도학습 알고리듬 &rarr; 전방향 신경망(feedforward network with fully connected layers)
    * 영상처럼 위상관계(topology)가 알려진 경우 &rarr; 회선 신경망(Convolutional Neural Network)
    * 입력 혹은 출력이 순열인 경우 &rarr; 창구가 있는 재귀 신경망(Gated Recurrent Neural Network), LSTM 혹 GRU
1. 최적화 알고리즘
    * 학습율, 운동량을 모수로 설정한 [SGD](https://en.wikipedia.org/wiki/Stochastic_gradient_descent)
    * [ADAM](http://sebastianruder.com/optimizing-gradient-descent/index.html#adam)
    * 배치 정규화(Batch normalization)
1. 알고리듬 과대적합 방지, 오캄의 면도날
    * 정규화 (Regularization)
    * Dropout
    * 조기 종류(Early Stopping)

### 1.3. 기계학습/딥러닝 알고리듬 성능 개선

분산과 편향이 높게 나타나서 전체적인 기계학습/딥러닝 알고리듬이 떨어지는 것이 관측되는 경우.

1. 신규 학습 데이터 추가 &rarr; 분산이 큰 경우 해결책
1. 모형에 사용되는 변수를 축소 &rarr; 분산이 큰 경우 해결책
1. 모형에 변수를 추가 &rarr; 편향이 큰 경우 해결책
1. 새로운 변수를 추가 &rarr; 편향이 큰 경우 해결책
1. 최적화 알고리듬을 반복횟수를 증가 &rarr; 학습이 덜된 경우 최적화 알고리즘이 해결책
1. 뉴톤 알고리듬을 적용 &rarr; 학습이 덜된 경우 다른 최적화 알고리즘을 탐색
1. 학습율(learning rate), 운동량(moment)를 다르게 시도 &rarr; 학습이 덜된 경우 최적화 알고리즘 모수를 조정하는 것이 해결책
1. SVM, RF 등 다양한 학습 알고리듬을 적용 &rarr; 학습이 잘 되지 않는 경우 다른 최적화 알고리즘 혹은 모형을 탐색

> ### 초모수(Hyperparameter) 설정 {.callout} 
>
> 초모수 설정은 학습훈련 오차, 교차 검증 일반화 오차, 컴퓨터 자원(저장공간, 실행시간)에 영향을 준다.  
> 
> * 교차 검증 일반화 오차 최소화 &rarr; 실행시간과 저장공간 절약  
> * 효과적인 기계학습/딥러닝 알고리즘 구축 &rarr; 정규화, 조기종료 등을 통해 과대적합을 방지  
> * 학습율(learning rate)이 시간이 없는 경우, 가장 효과적으로 조정해야 하는 도구.  






[Andrew Ng (2015), "Advice for applying Machine Learning", Standford University](https://see.stanford.edu/materials/aimlcs229/ML-advice.pdf)

[ICLR 2014 Talk: "Multi-digit Number Recognition from Street View Imagery using Deep Convolutional Neural Networks" by Ian J. Goodfellow, Yaroslav Bulatov, Julian Ibarz, Sacha Arnoud, Vinay Shet](https://www.youtube.com/watch?v=vGPI_JvLoN0)