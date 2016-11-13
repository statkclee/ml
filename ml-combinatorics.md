---
layout: page
title: xwMOOC 기계학습
subtitle: R 조합수학(Combinatorics)
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---


 
> ## 핵심 개념 {.objectives}
>
> * **순열(permutation):**특정 순서로 정렬
> * **순서를 갖는 표본 vs. 순서 없는 표본:** 순서를 갖는 표본에서 표본의 원소 순서가 중요하다; 
>   예를 들어, 핸드폰 번호, 단어의 글자. 순서를 갖지 않는 표본에서 원소의 순서는 관계가 없다;
>   예를 들어, 로또 번호, 샐러드에 포함된 야채.
> * **복원 표본 vs. 비복원 표본:** 복원 추출의 경우 동일원소 반복이 허용되는 경우(자동차 번호판 숫자);
>   로또 번호를 추출하는 경우 반복이 허용되지 않는다. 번호가 뽑혀지면, 다시 추출할 수는 없다.

$n=4$, 문자 "a", "b", "c", "d", 4개를 갖는 사례를 갖고 계산하는 것을 살펴본다.
순열과 조합에 대한 갯수를 계산하는 공식이 주어지고 표본을 추출해 해는 접근법을 제시한다.



~~~{.r}
library(DescTools)

x <- letters[1:4]
n <- length(x)
m <- 2
~~~

## 1. 기본 숫자 함수 [^r-combinatorics] [^DescTools-combinatorics]

[^r-combinatorics]: [R Combinatorics](http://www.di.fc.ul.pt/~jpn/r/combinatorics/combinatorics.html) 
[^DescTools-combinatorics]: [DescTools - Combinatorics](https://cran.r-project.org/web/packages/DescTools/vignettes/Combinatorics.pdf)

`Base R` 에 다른 응용프로그램에는 포함되어 있느나 누락된 일부 함수가 있다.
`DescTools` 팩키지에 `Primes(x)` 함수가 있어 주어진 숫자 `x`까지 해당되는 모든 
소수(Prime Number)를 반환한다. `IsPrime` 함수는 인자로 받은 숫자 `x`가 소수인지 판정한다.

`Factorize()` 함수는 숫자를 소수를 기준으로 쪼개고 나서 밑과 거듭제곱 지수를 반환한다.
`GCD`는 최대공약수(Greatest Common Divisor), `LCM`은 최소공배수(Least Common multiple)를 각각 계산한다. 

`Primes(n=20)` 명령어를 통해 20보다 작은 모든 소수를 출력한다.


~~~{.r}
Primes(n=20)
~~~



~~~{.output}
[1]  2  3  5  7 11 13 17 19

~~~

`IsPrime()` 함수를 사용해서 벡터 `x`, 원소 각각이 소수인지 아닌지 판별해서 참/거짓, TRUE/FALSE 값을 반환한다.


~~~{.r}
set.seed(23)
y <- sample(1:20, 5)

IsPrime(y)
~~~



~~~{.output}
[1] FALSE  TRUE FALSE  TRUE FALSE

~~~

정수 n에 대해 소인수 분해를 수행하는데 `Factorize()` 함수를 사용한다.


~~~{.r}
Factorize(77)
~~~



~~~{.output}
$`77`
      p m
[1,]  7 1
[2,] 11 1

~~~



~~~{.r}
Factorize(n=c(56, 42))
~~~



~~~{.output}
$`56`
     p m
[1,] 2 3
[2,] 7 1

$`42`
     p m
[1,] 2 1
[2,] 3 1
[3,] 7 1

~~~

`GCD` 함수를 사용해서 인자로 입력받은 숫자에 대한 최대공약수를 계산한다.


~~~{.r}
GCD(64, 80, 160)
~~~



~~~{.output}
[1] 16

~~~

`LCM` 함수를 사용해서 최소공배수를 계산한다.


~~~{.r}
LCM(10, 4, 12, 9, 2)
~~~



~~~{.output}
[1] 180

~~~

`Fibonacci` 함수를 사용해서 처음부터 12까지 피보나치 숫자를 계산한다.


~~~{.r}
Fibonacci(1:12)
~~~



~~~{.output}
 [1]   1   1   2   3   5   8  13  21  34  55  89 144

~~~

## 2. `n` 객체에 대한 순열 

`n` 객체에 대해 가능한 순열 갯수는 $n!$ 만큼이 된다.
R Base 에 내장된 `factorial` 함수를 사용해서 전체 순열 갯수를 산출한다.
전체 순열을 데이터셋으로 생성하려면 `DescTools` 팩키지 `Permn` 함수를 사용한다.


~~~{.r}
factorial(n)
~~~



~~~{.output}
[1] 24

~~~

`Permn()` 함수를 사용해서 전체 순열 데이터셋을 생성시킨다.


~~~{.r}
Permn(x)
~~~



~~~{.output}
      [,1] [,2] [,3] [,4]
 [1,] "a"  "b"  "c"  "d" 
 [2,] "b"  "a"  "c"  "d" 
 [3,] "b"  "c"  "a"  "d" 
 [4,] "a"  "c"  "b"  "d" 
 [5,] "c"  "a"  "b"  "d" 
 [6,] "c"  "b"  "a"  "d" 
 [7,] "b"  "c"  "d"  "a" 
 [8,] "a"  "c"  "d"  "b" 
 [9,] "c"  "a"  "d"  "b" 
[10,] "c"  "b"  "d"  "a" 
[11,] "a"  "b"  "d"  "c" 
[12,] "b"  "a"  "d"  "c" 
[13,] "c"  "d"  "a"  "b" 
[14,] "c"  "d"  "b"  "a" 
[15,] "a"  "d"  "b"  "c" 
[16,] "b"  "d"  "a"  "c" 
[17,] "b"  "d"  "c"  "a" 
[18,] "a"  "d"  "c"  "b" 
[19,] "d"  "a"  "b"  "c" 
[20,] "d"  "b"  "a"  "c" 
[21,] "d"  "b"  "c"  "a" 
[22,] "d"  "a"  "c"  "b" 
[23,] "d"  "c"  "a"  "b" 
[24,] "d"  "c"  "b"  "a" 

~~~

## 3. `n` 객체중에서 복원없이 순서를 갖는 표본크기 `m` 추출

`n` 개 서로 다른 원소를 가진 집합에서 
대상들을 선택하여 순서 있게 `m`개 원소를 배열하는 갯수를 계산하는 공식:
$n(n-1) \cdots (n-m+1) = \frac{n!}{n-m}! = _{n} P_{m}$

직접 R에서 이를 계산하는 함수가 없어 감마함수(Gamma Function) 항등식을 사용한다.
모든 양의 정수에 대해서 항등식이 성립한다.

$$\Gamma(n) = (n-1)!$$

$_{n} P_{m}$을 계산하는데 `gamma(n+1)/gamma(n-m+1)` 공식을 적용하는데,
오버플로(overflow) 넘침을 방지하기 위해 `exp(lgamma(n+1)-lgamma(n-m+1))` 공식을 사용한다.
`DescTools` 팩키지에 `CombN` 함수로 구현되었다. 좀더 간단하게 `prod((n-m+1):n)` 공식도 가능하다.


~~~{.r}
CombN(x, m, ord = TRUE)
~~~



~~~{.output}
[1] 12

~~~

해당되는 전체 순열집합을 뽑아내려면 `CombSet()` 함수를 사용한다.


~~~{.r}
CombSet(x, m, repl=FALSE, ord=TRUE)
~~~



~~~{.output}
      [,1] [,2]
 [1,] "a"  "b" 
 [2,] "b"  "a" 
 [3,] "a"  "c" 
 [4,] "c"  "a" 
 [5,] "a"  "d" 
 [6,] "d"  "a" 
 [7,] "b"  "c" 
 [8,] "c"  "b" 
 [9,] "b"  "d" 
[10,] "d"  "b" 
[11,] "c"  "d" 
[12,] "d"  "c" 

~~~

## 4. `n` 객체중에서 복원없이 순서를 갖는 않는 표본크기 `m` 추출

`n` 개 서로 다른 원소를 가진 집합에서 
대상들을 선택하여 순서없이 `m`개 원소를 배열하는 갯수를 계산하는 공식:
$\binom{n}{m} = \frac{ _{n}P_{m}} {m!} = \frac{n(n-1) \cdots (n-m+1)}{m!} = \frac{n!}{m!(n-m)!}$

`choose()` 함수가 계산을 수행한다.


~~~{.r}
choose(n, m)
~~~



~~~{.output}
[1] 6

~~~

해당되는 전체 순열집합을 뽑아내려면 `CombSet()` 함수를 사용하는데, 인자를 조정한다.


~~~{.r}
CombSet(x, m, repl=FALSE, ord=FALSE)
~~~



~~~{.output}
     [,1] [,2]
[1,] "a"  "b" 
[2,] "a"  "c" 
[3,] "a"  "d" 
[4,] "b"  "c" 
[5,] "b"  "d" 
[6,] "c"  "d" 

~~~

## 5. `n` 객체중에서 복원가능하며, 순서를 갖는 표본크기 `m` 추출

`n` 개 서로 다른 원소를 가진 집합에서 
복원을 허락하여 대상들을 선택하여 순서있게 `m`개 원소를 배열하는 갯수를 계산하는 공식: $n^m$.

R에서 `n^m` 명령어를 입력하여 수행한다. 해당되는 전체 순열집합을 뽑아내려면 `CombSet()` 함수를 사용하는데, 
인자를 적절히 조정한다. 내부적으로 R Base에 내장된 `expand.grid()`, `replicate()` 함수를 사용한다.



~~~{.r}
n^m
~~~



~~~{.output}
[1] 16

~~~



~~~{.r}
CombN(x, m, repl=TRUE, ord=TRUE)
~~~



~~~{.output}
[1] 16

~~~



~~~{.r}
CombSet(x, m, repl=TRUE, ord=TRUE)
~~~



~~~{.output}
      [,1] [,2]
 [1,] "a"  "a" 
 [2,] "b"  "a" 
 [3,] "c"  "a" 
 [4,] "d"  "a" 
 [5,] "a"  "b" 
 [6,] "b"  "b" 
 [7,] "c"  "b" 
 [8,] "d"  "b" 
 [9,] "a"  "c" 
[10,] "b"  "c" 
[11,] "c"  "c" 
[12,] "d"  "c" 
[13,] "a"  "d" 
[14,] "b"  "d" 
[15,] "c"  "d" 
[16,] "d"  "d" 

~~~

## 6. `n` 객체중에서 복원가능하며, 순서를 갖지 않는 표본크기 `m` 추출

`n` 개 서로 다른 원소를 가진 집합에서 
복원을 허락하여 대상들을 선택하여 순서없이 `m`개 원소를 배열하는 갯수를 계산하는 공식: 
${n+m-1 \choose m} = \frac{(n+m-1)!}{m! (n-1)!}$

`choose()` 함수를 사용하는데 적절한 인자값을 넘겨 계산한하다.
해당되는 전체 순열집합을 뽑아내려면 `CombSet()` 함수를 사용하는데, 내부적으로는 앞서 계산한
복원이 허락되고 순서를 갖는 표본집합을 갖고, 중복을 제거하고 유일무이한 하위집합만 뽑아내서 이를 
반환한다. `CombSet()` 함수에 캡슐화되어 구현되어 있어 플래그만 변경하면 된다.


~~~{.r}
choose(n + m -1, m)
~~~



~~~{.output}
[1] 10

~~~



~~~{.r}
CombN(x, m, repl=TRUE, ord=FALSE)
~~~



~~~{.output}
[1] 10

~~~



~~~{.r}
CombSet(x, m, repl=TRUE, ord=FALSE)
~~~



~~~{.output}
      [,1] [,2]
 [1,] "a"  "a" 
 [2,] "a"  "b" 
 [3,] "a"  "c" 
 [4,] "a"  "d" 
 [5,] "b"  "b" 
 [6,] "b"  "c" 
 [7,] "b"  "d" 
 [8,] "c"  "c" 
 [9,] "c"  "d" 
[10,] "d"  "d" 

~~~




