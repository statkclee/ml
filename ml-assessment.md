---
layout: page
title: xwMOOC 기계학습
subtitle: 알고리즘 성능평가
---

> ## 학습목표 {.objectives}
>
> * 기계학습 알고리즘 성능평가를 이해한다.


## 기계학습 알고리즘 성능평가

기계학습 알고리즘 성능평가는 데이터를 이용해서 풀려는 문제에 따라 다르다.

* 분류 
* 예측

### 범주형 성능평가 

전자우편을 스팸(spam)이냐 정상햄(ham)이냐를 분류한 기계학습 알고리즘의 성능을 평가할 때 정량화된 측도가 필요하다. 
일견 스팸전자우편을 스팸이라고 분류하고, 정상 전자우편을 정상으로 분류하면 되는 간단한 문제로 보이지만 사실 그렇게 간단한 것은 아니다.
기업부도예측이나, 신용분량, 사기탐지 등을 보면, 정상적인 사례가 99% 이상이고, 사기나 해킹, 신용분량, 부도 등의 사례는 
채 1%가 되지 않는 경우가 허다하다. 통계학 이항 회귀분석 및 검색엔진, 의학정보학 등 다양한 분야에서 이 문제에 관심을 가지고 다뤄왔다.



먼저, 용어정의를 정의하자.

* TP(True Positive) : **참양성**, 통계상 실제 양성인데 검사 결과 양성.
* FP(False Positive) : **거짓양성(1종 오류)**,  통계상 실제로는 음성인데 검사 결과는 양성. 위양성, 거짓 경보(False Alarm).
* FN(False Negative) : **거짓음성(2종 오류)**, 통계상 실제로는 양성인데 검사 결과는 음성
* TN(True Negative) : **참음성**, 통계상 실제 음성인데 검사 결과 음성.

기계학습을 통해 나온 결과를 상기 옹어로 정리한 것이 **오차행렬(confusion matrix)** 이 된다. 2가지 이상되는 분류문제에도 적용될 수 있다. 

|                |                |     **실제 정답**  |              | 
|----------------|----------------|---------------|---------------|
|                |                |     참(True)  |  거짓(False)   | 
| **실험 결과**    |  양성(Positive)  | TP(True Positive)| FP(False Positive) | 
|                |  음성(Negative) | FN(False Negative)| TN(True Negative) |

<img src="fig/ml-precision-recall.svg" alt="정밀도와 재현율 도식화" width="50%"> [^wiki-walber]

[^wiki-walber]: [Precision and recall SVG 파일](https://commons.wikimedia.org/wiki/File:Precisionrecall.svg)

범주형 자료를 목적으로 분류하는 기계학습 알고리즘의 경우 정밀도, 재현율, 정확도를 통상적인 추적 모니터링 대상 측도가 된다.

* 정밀도(Precision): 선택된 항목이 얼마나 연관성이 있나를 측정. $$정밀도 = \frac{TP}{TP+FP}$$
* 재현율(Recall) 혹은 민감도(Sensitivity): 예를 들어, 환자가 실제 암이 있는데, 양성으로 검진될 확률. 연관된 항목이 얼마나 많이 선택되었는지 측정. $$재현율 = \frac{TP}{TP+FN}$$
* 정확도(Accuracy): 1 에서 빼면 오분류율이 된다. $$정확도 = \frac{TP+TN}{TP+TN+FP+FN}$$
* 특이성(Specificity): 예를 들어, 환자가 정상인데, 음성으로 검질될 확률. $$특이성 = \frac{TN} {TN+FP}$$

이를 하나의 숫자로 바꾼것이 $F_1$ 점수($F_1$ Score, $F$-Score, $F$-Measure)로 불리는 것으로 정밀도와 재현율을 조화평균한 것이다.

$$F_1 = \frac{2}{\frac{1}{정밀도}+\frac{1}{재현율}} = 2 \times \frac{정밀도 \times 재현율}{정밀도 + 재현율}$$


### 연속형 성능평가 

회귀분석 등을 통해서 연속형 변수 성능을 평가하고 모니터링할 경우, 평균제곱오차(Mean Squared Error)를 사용한다. 그렇다고 평균제곱오차가 가장 좋다는 의미는 아니다. 다만, 기본적인 성능평가 추정 모니터링 방법은 다음과 같다.


$(\hat{y} -y)^2 = \epsilon$으로 오차가 되고, 오차 평균은 $\bar{\epsilon}_n = \frac{\epsilon_1 + \epsilon_2 + \dots + \epsilon_n}{n}$ 와 같이 되고, 새로 추가되는 오차는 $\overline{\epsilon_{n+1}} = \frac{\epsilon_1 + \epsilon_2 + \dots + \epsilon_n + \epsilon_{n+1}}{n+1}$와 같이 되고, 정리하면, 

$$\overline{\epsilon_{n+1}} = \frac{n\times\bar{\epsilon_n} + \epsilon_{n+1}}{n+1}$$

기계학습 알고리즘이 새로운 데이터에서 산출해내는 평균제곱오차를 상기 공식에 맞춰 추적 모니터링한다.




