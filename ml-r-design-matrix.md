# xwMOOC 기계학습
 


## R 모형 설계행렬(Design Matrix) [^design-matrix-in-r]

[^design-matrix-in-r]: [The R Formula Method: The Good Parts](https://rviews.rstudio.com/2017/02/01/the-r-formula-method-the-good-parts/)

회귀분석(`lm`)같은 예측모형 함수를 생성하는데 중요하게 사용되는 것이 **설계행렬(design matrix)**이다.
설계행렬은 통계학에서 2차원 $X$ 행렬로 행은 관측점, 열은 예측변수로 구성된다. 

- 예측모형 개발을 위해 필요한 모형 구성요소
    - `Sepal.Width`: 예측할 변수
    - `Petal.Width + log(Petal.Length) + Species`: 예측에 사용될 변수
    - `Species`: 범주형 요인(factor) 변수, 일반적으로 가변수(dummy variable)로 변환됨
    - `log(Petal.Length)`: 변수 치우침이 심한 경우 변수 변환
    - `subset = Sepal.Length > 4.6`: 예측모형에 사용될 관측점으로 층화(strata) 모형 개발에 활용
    - `offset`, `weight`: 기타 모형 설정에 사용됨.

`Sepal.Width` 변수를 예측하는데 3개 변수가 투입되었지만, `Species` 변수가 수준 3개를 갖는 범주형이라 실제 설계행렬에는 변수가 4개 들어있음.
단, 절편(intercept)은 제외된다.



~~~{.r}
# 0. 환경설정 ----------------------------------------------------
library(tidyverse)

# 1. 예측모형 ----------------------------------------------------
mod1 <- lm(Sepal.Width ~ Petal.Width + log(Petal.Length) + Species, 
           data = iris, subset = Sepal.Length > 4.6)

# 2. model.frame ----------------------------------------------------

mf <- stats::model.frame(formula = Sepal.Width ~ Petal.Width + log(Petal.Length) + Species, 
                   data = iris, 
                   subset = Sepal.Length > 4.6, 
                   drop.unused.levels = TRUE)

mf <- stats::model.frame(formula = Sepal.Width ~ Petal.Width + log(Petal.Length) + Species, 
                   data = iris, 
                   subset = Sepal.Length > 4.6, 
                   drop.unused.levels = TRUE)

eval(expr = mf, envir = parent.frame()) %>% head
~~~



~~~{.output}
  Sepal.Width Petal.Width log(Petal.Length) Species
1         3.5         0.2         0.3364722  setosa
2         3.0         0.2         0.3364722  setosa
3         3.2         0.2         0.2623643  setosa
5         3.6         0.2         0.3364722  setosa
6         3.9         0.4         0.5306283  setosa
8         3.4         0.2         0.4054651  setosa

~~~

설계행렬을 얻는데 중요한 역할을 수행하는 것이 `model.frame`, `model.matrix` 함수다.
예를 들어 `lm` 함수에 포함된 모형수식(formula, `Sepal.Width ~ Petal.Width + log(Petal.Length) + Species`)을 받아 
`stats` 팩키지의 `model.frame` 함수에 넘겨 설계행렬을 뽑아낸다. 

### 1.1. 설계행렬 핵심객체: `terms`

`model.frame` 객체, `mf`에서 설계행렬에 대한 중요한 정보는 `terms`에 담겨있다.
`terms`에 변수간 관계, 변수 변환등 설계행렬에 대한 상세한 정보가 담긴다.


~~~{.r}
# attributes(mf)
terms(mf)
~~~



~~~{.output}
Sepal.Width ~ Petal.Width + log(Petal.Length) + Species
attr(,"variables")
list(Sepal.Width, Petal.Width, log(Petal.Length), Species)
attr(,"factors")
                  Petal.Width log(Petal.Length) Species
Sepal.Width                 0                 0       0
Petal.Width                 1                 0       0
log(Petal.Length)           0                 1       0
Species                     0                 0       1
attr(,"term.labels")
[1] "Petal.Width"       "log(Petal.Length)" "Species"          
attr(,"order")
[1] 1 1 1
attr(,"intercept")
[1] 1
attr(,"response")
[1] 1
attr(,".Environment")
<environment: R_GlobalEnv>
attr(,"predvars")
list(Sepal.Width, Petal.Width, log(Petal.Length), Species)
attr(,"dataClasses")
      Sepal.Width       Petal.Width log(Petal.Length)           Species 
        "numeric"         "numeric"         "numeric"          "factor" 

~~~

`terms` 객체가 중요한 이유는 예측모형이 개발된 후에 예측할 데이터가 들어올 때 예측을 위한 설계행렬을 만드는데 활용되기 때문이다.

### 1.2. 설계행렬 생성: `model.matrix`

`model.frame`을 통해 `terms` 객체를 추출하고 나면 이를 `model.matrix`에 넣게 되면 설계행렬(design matrix)을 얻게 된다.
`model.matrix()` 함수가 가변수, 교호작용 등을 표현한 설계행렬 정보를 담아낸다.


~~~{.r}
# 3. design matrix ----------------------------------------------------

mt <- attr(x = mf, which = "terms")

model.matrix(object = mt, data = mod1$model, contrasts.arg = contrasts) %>% head
~~~



~~~{.output}
  (Intercept) Petal.Width log(Petal.Length) Speciesversicolor Speciesvirginica
1           1         0.2         0.3364722                 0                0
2           1         0.2         0.3364722                 0                0
3           1         0.2         0.2623643                 0                0
5           1         0.2         0.3364722                 0                0
6           1         0.4         0.5306283                 0                0
8           1         0.2         0.4054651                 0                0

~~~

## R 모형 수식 표현의 한계점 [^ripley-model-formula] [^max-khun-model-evaluation]

[^ripley-model-formula]: [Model Fitting Functions in R](https://developer.r-project.org/model-fitting-functions.html)

[^max-khun-model-evaluation]: [The R Formula Method: The Bad Parts](https://rviews.rstudio.com/2017/03/01/the-r-formula-method-the-bad-parts/)

[`caret` 팩키지](http://topepo.github.io/caret/index.html) 저자로 현재 RStudio 근무중인 Max Khun 박사가 예측모형 개발을 위한 R 모형수식 메쏘드에 다음 문제점을 언급하며 
[Recipes](https://topepo.github.io/recipes/)를 caret 대신 개발한 사유를 밝히고 있다.

- 확장성에 제한 
    - 예측변수를 다수 변수변환하는 경우: 예를 들어 변수 50개를 로그 변환
    - `predvars` 변수 사용: knn_impute(x1) + knn_impute(x2) 모형수식을 예측모형에 반영할 경우 `predvars`에 중복 반영?
    - 연산자 적용이 변수 하나, 즉 칼럼 하나에만 국한됨: 예를 들어 `lm(y ~ pca(x1, x2, x3), data = dat)`, `lm(y ~ pca(scale(x1), scale(x2), scale(x3)), data = dat)`은 허용안됨.
- 모든 작업이 한방에 처리되는 한계점
    - 대부분의 모형개발과정은 순차적인 데이터 연산작업으로 구성됨
        - 예를 들어, 결측값 매꿔넣기 &rarr; 정규화(centering & scaling) &rarr; PCA 점수 변환
    - `caret::preProcess` 함수가 순차처리에 활용되나 `ggplot2, dplyr, magrittr`와는 달리 수행은 한방에 실행됨.
    -  `caret::preProcess` 함수는 filters, single-variable transformations, normalizations, imputation, signal extraction, spatial sign까지 전 과정이 함수 하나로 되어 수행됨.
- 재사용이 안됨
    - 다수 예측변수를 갖는 CART 모형을 개발할 때, 이론적으로 random forest 모형이 매번 설계행렬(design matrix)을 다시 만들필요는 없다.
    - 전처리 과정에 컴퓨팅 자원을 많이 사용한 경우 모형개발을 위해 다시 전처리과정을 반복하는 것은 문제임.
- 모형수식과 폭넓은(wide) 데이터셋 
    - R 모형수식은 데이터 크기가 작은 것을 가정하고 교호작용과 내포/중첩(nesting) 등에 방점을 두고 개발되어 현재 상황과는 맞지 않는다.
    - 변수가 많아짐에 따라 현재 R 모형수식을 넣게 되면 컴퓨팅 자원을 상당히 많이 사용하는 구조로 되어 있다.
    - 범주형 변수를 요인자료구조로 반영하여 가변수처리할 경우 [Sparsity-of-effects principle](https://en.wikipedia.org/wiki/Sparsity-of-effects_principle)에 따라 주효과와 저차 교호작용이 파레토 원칙에 따라
      상당한 중요성을 갖고 있음에도 불구하구, 거의 0인 희소행렬을 설계행렬에 반영하게 된다.
- 변수 역할 : 전통적으로 모형개발을 위한 R 모형수식은 `~` 왼편에 변수 하나와 우측편에 다수 예측변수 혹은 설명변수를 가정
    - 모형개발에 활용되는 데이터의 역할은 단순히 종속변수와 설명변수를 넘어 다양함.
        - 종속변수 혹은 예측결과
        - 설명변수 혹은 예측변수
        - 층화(stratification)
        - 모형 성능 평가에 활용되는 데이터
        - 조건부 혹은 퍼싯(facet) 변수 (`lattice`, `ggplot2`에 활용)
        - 임의효과(random effects) 혹은 계층 or 계층모형(hierarchical model) ID 변수
        - 가중치(case weights)
        - 오프셋(offset)
        - 오차항(error terms, 단 aov() 함수 오차에 한정)


