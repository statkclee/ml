# xwMOOC 기계학습
 


## 숫자를 문자로 변환

데이터 분석 작업을 수행하는 경우 대부분 숫자를 다루게 되지만, 결국 숫자를 사람이 이해할 수 있고, 익숙한 형태로 변환을 해야한다.
예를 들어 천자리 넘어가는 숫자의 경우 `,` 콤마를 찍어 숫자에 대한 가독성을 높이거나 숫자의 소숫점, 환종에 대한 표현, 및 p-값 등을 표현할 때 
**숫자 서식(format)**에 대한 처리가 최종 전달단계에서 중요하게 고려해야할 사항이 된다.

- 소수점 처리 
- 천단위를 넘는 정수
- `p-값`을 포함한 과학연산 숫자 
- 환종(원화, 달러화, 엔화)을 표현한 숫자

R에서는 이에 대해 다양한 기능을 제공하는데 최종적으로 고려할 주요 함수는 다음과 같다.

- `writeLines()`: `cat()` 함수도 유사하지만 `readLines()`와 고려하여 일관성을 유지.
- `formatC`: `format()` 함수보다 일관되고 다양한 기능 제공
    - format="f" : 숫자를 있는 그대로 표현
    - format="e" : 숫자를 과학숫자 표현식으로 표현 
    - format="g" : 가능하면 숫자를 있는 그대로 표현하지만, 일정 자리수를 넘어가면 과학 표현식으로 전환, 특히 p-값 등을 표현할 때 유용함.
- `paste()`, `paste0()`: 문자와 숫자를 결합할 때 사용 
    - 인자로 `collapse`와 함께 사용


~~~{.r}
# 0. 환경설정 ---------------------------
# devtools::install_github("richierocks/rebus")
# library(rebus)
# library(stringr)
# library(stringi)

# 1. 데이터 -------------------------
p_value_v <- c(0.32, 0.99, 0.0000789, 0.00000000001)
percent_v  <- c(7, -7.97, 9.00, -1.002)
money_v <-  c(72.11, 871092.118, 7030.18, 27291.91)

# 2. 숫자를 문자------------------------

formatC(p_value_v, format="f", digits = 2)
~~~



~~~{.output}
[1] "0.32" "0.99" "0.00" "0.00"

~~~



~~~{.r}
formatC(p_value_v, format="g", digits = 2)
~~~



~~~{.output}
[1] "0.32"    "0.99"    "7.9e-05" "1e-11"  

~~~



~~~{.r}
formatC(p_value_v, format="e", digits = 2)
~~~



~~~{.output}
[1] "3.20e-01" "9.90e-01" "7.89e-05" "1.00e-11"

~~~



~~~{.r}
formatC(percent_v, digits=2, format="f")
~~~



~~~{.output}
[1] "7.00"  "-7.97" "9.00"  "-1.00"

~~~



~~~{.r}
formatC(money_v, digits=1, format="f", big.mark = ",", flag="+ ")
~~~



~~~{.output}
[1] "+72.1"      "+871,092.1" "+7,030.2"   "+27,291.9" 

~~~



~~~{.r}
writeLines(formatC(money_v, digits=1, format="f", big.mark = ",", flag="+"))
~~~



~~~{.output}
+72.1
+871,092.1
+7,030.2
+27,291.9

~~~



~~~{.r}
# 3. 숫자에 표식 ------------------------

with_currency_v <- paste("\u20A9", money_v, sep="")

paste(percent_v, "%", sep="")
~~~



~~~{.output}
[1] "7%"      "-7.97%"  "9%"      "-1.002%"

~~~



~~~{.r}
paste(with_currency_v, collapse=", ")
~~~



~~~{.output}
[1] "\\72.11, \\871092.118, \\7030.18, \\27291.91"

~~~

원화 유니코드는 `\u20A9`으로 이를 반영하여 간단한 표를 구현하는 것도 가능하다.


~~~{.r}
# 4. 숫자표 생성 ------------------------

year_names_v <- c("2014년", "2015년", "2016년", "총합")

pretty_money_v <- formatC(money_v, digits=1, big.mark=",", format="f")
korean_money <- paste("\u20A9", pretty_money_v, sep="")

formatted_names <- format(year_names_v, justify="right")

rows <- paste(formatted_names, korean_money, sep="  ---  ")

writeLines(rows)
~~~



~~~{.output}
2014년  ---  \72.1
2015년  ---  \871,092.1
2016년  ---  \7,030.2
  총합  ---  \27,291.9

~~~


