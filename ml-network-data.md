---
layout: page
title: xwMOOC 기계학습
subtitle: 네트워크 데이터
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---
 


### 1. 네트워크 데이터 구조

네트워크 데이터는 **노드(Node)** 와 **엣지(Edge)** 로 구성된다. 
노드 데이터는 네트워크 노드에 대한 상세 정보가 담겨있다.
반면에 엣지 정보는 연결된 링크 정보를 담고 있는데 `from`, `to` 형식으로
데이터를 담을 수도 있고, 노드간의 관계를 관계 없음은 `0`, 관계 있음은 `1`로
표현한다.

첫번째 네트워크 데이터 형식 표현을 **Edgelist** 라고 하고, 두번째 
데이터 표현방법을 **행렬(Matrix)** 이라고 부른다.

두가지 형태를 갖는 데이터를 불러 읽어오자.



~~~{.r}
suppressMessages(library(readr))
suppressMessages(library(dplyr))
#-----------------------------------------------------------------------
# edgelist

nodes <- read_csv("https://raw.githubusercontent.com/kateto/R-Network-Visualization-Workshop/master/Data/Dataset1-Media-Example-NODES.csv", col_names = TRUE)
~~~



~~~{.output}
Parsed with column specification:
cols(
  id = col_character(),
  media = col_character(),
  media.type = col_integer(),
  type.label = col_character(),
  audience.size = col_integer()
)

~~~



~~~{.r}
links <- read_csv("https://raw.githubusercontent.com/kateto/R-Network-Visualization-Workshop/master/Data/Dataset1-Media-Example-EDGES.csv", col_names = TRUE)
~~~



~~~{.output}
Parsed with column specification:
cols(
  from = col_character(),
  to = col_character(),
  weight = col_integer(),
  type = col_character()
)

~~~



~~~{.r}
#-----------------------------------------------------------------------
# 행렬

nodes2 <- read_csv("https://raw.githubusercontent.com/kateto/R-Network-Visualization-Workshop/master/Data/Dataset2-Media-User-Example-NODES.csv", col_names = TRUE)
~~~



~~~{.output}
Parsed with column specification:
cols(
  id = col_character(),
  media = col_character(),
  media.type = col_integer(),
  media.name = col_character(),
  audience.size = col_integer()
)

~~~



~~~{.r}
links2 <- read_csv("https://raw.githubusercontent.com/kateto/R-Network-Visualization-Workshop/master/Data/Dataset2-Media-User-Example-EDGES.csv", col_names = TRUE)
~~~



~~~{.output}
Parsed with column specification:
cols(
  .default = col_integer(),
  X1 = col_character()
)

~~~



~~~{.output}
See spec(...) for full column specifications.

~~~



~~~{.r}
#-----------------------------------------------------------------------
# 데이터 살펴보기
#-----------------------------------------------------------------------

head(nodes)
~~~



~~~{.output}
# A tibble: 6 x 5
     id               media media.type type.label audience.size
  <chr>               <chr>      <int>      <chr>         <int>
1   s01            NY Times          1  Newspaper            20
2   s02     Washington Post          1  Newspaper            25
3   s03 Wall Street Journal          1  Newspaper            30
4   s04           USA Today          1  Newspaper            32
5   s05            LA Times          1  Newspaper            20
6   s06       New York Post          1  Newspaper            50

~~~



~~~{.r}
head(links)
~~~



~~~{.output}
# A tibble: 6 x 4
   from    to weight      type
  <chr> <chr>  <int>     <chr>
1   s01   s02     10 hyperlink
2   s01   s02     12 hyperlink
3   s01   s03     22 hyperlink
4   s01   s04     21 hyperlink
5   s04   s11     22   mention
6   s05   s15     21   mention

~~~



~~~{.r}
nrow(nodes); length(unique(nodes$id))
~~~



~~~{.output}
[1] 17

~~~



~~~{.output}
[1] 17

~~~



~~~{.r}
nrow(links); nrow(unique(links[,c("from", "to")]))
~~~



~~~{.output}
[1] 52

~~~



~~~{.output}
[1] 49

~~~



~~~{.r}
# 데이터 중복 처리 : 총합
links <- links %>% group_by(from, to, type) %>%  
                   summarise(weight = sum(weight)) %>% 
                   arrange(from, to)
~~~


`head(nodes)` 명령어를 통해서 살펴보면 `head(nodes2)`와 별다른 차이가 없다.


~~~{.r}
head(nodes)
~~~



~~~{.output}
# A tibble: 6 x 5
     id               media media.type type.label audience.size
  <chr>               <chr>      <int>      <chr>         <int>
1   s01            NY Times          1  Newspaper            20
2   s02     Washington Post          1  Newspaper            25
3   s03 Wall Street Journal          1  Newspaper            30
4   s04           USA Today          1  Newspaper            32
5   s05            LA Times          1  Newspaper            20
6   s06       New York Post          1  Newspaper            50

~~~



~~~{.r}
head(nodes2)
~~~



~~~{.output}
# A tibble: 6 x 5
     id   media media.type media.name audience.size
  <chr>   <chr>      <int>      <chr>         <int>
1   s01     NYT          1  Newspaper            20
2   s02    WaPo          1  Newspaper            25
3   s03     WSJ          1  Newspaper            30
4   s04    USAT          1  Newspaper            32
5   s05 LATimes          1  Newspaper            20
6   s06     CNN          2         TV            56

~~~

반면에 엣지 정보, 링크 정보는 하나는 `from`, `to` 형식으로, 다른 하나는 
행렬로 표현된다는 점에서 차이가 있다.


~~~{.r}
head(links)
~~~



~~~{.output}
Source: local data frame [6 x 4]
Groups: from, to [6]

   from    to      type weight
  <chr> <chr>     <chr>  <int>
1   s01   s02 hyperlink     22
2   s01   s03 hyperlink     22
3   s01   s04 hyperlink     21
4   s01   s15   mention     20
5   s02   s01 hyperlink     23
6   s02   s03 hyperlink     21

~~~



~~~{.r}
head(links2)
~~~



~~~{.output}
# A tibble: 6 x 21
     X1   U01   U02   U03   U04   U05   U06   U07   U08   U09   U10   U11
  <chr> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
1   s01     1     1     1     0     0     0     0     0     0     0     0
2   s02     0     0     0     1     1     0     0     0     0     0     0
3   s03     0     0     0     0     0     1     1     1     1     0     0
4   s04     0     0     0     0     0     0     0     0     1     1     1
5   s05     0     0     0     0     0     0     0     0     0     0     1
6   s06     0     0     0     0     0     0     0     0     0     0     0
# ... with 9 more variables: U12 <int>, U13 <int>, U14 <int>, U15 <int>,
#   U16 <int>, U17 <int>, U18 <int>, U19 <int>, U20 <int>

~~~

*igraph* 팩키지로 데이터를 시각화를 해본다. 가장 먼저
노드와 엣지 데이터프레임을 [igraph](http://igraph.org/) 네트워크 객체로 변환해야 된다.
`graph.data.frame` 함수가 노드와 엣지 데이터프레임 자료형을 
igraph 네트워크 객체로 변환하는데 사용된다.

`graph.data.frame` 함수에 인자를 두개 넣는다. 

* **d** : 네트워크 엣지(링크)를 넣어 넘긴다. `from`, `to` 형식으로 칼럼 두개가 먼저 정의되고,
`weight`, `type`, `label` 등 엣지를 표현하는 다른 정보가 나머지 칼럼에 담기게 된다.
* **vertices** : 노드 id 로 첫번째 칼럼이 정의되고, 노드를 표현하는 다른 정보가 순차적으로 
나머지 칼럼에 담기게 된다.


~~~{.r}
suppressMessages(library(igraph))

net <- graph.data.frame(links, nodes, directed=T)
net
~~~



~~~{.output}
IGRAPH DNW- 17 49 -- 
+ attr: name (v/c), media (v/c), media.type (v/n), type.label
| (v/c), audience.size (v/n), type (e/c), weight (e/n)
+ edges (vertex names):
 [1] s01->s02 s01->s03 s01->s04 s01->s15 s02->s01 s02->s03 s02->s09
 [8] s02->s10 s03->s01 s03->s04 s03->s05 s03->s08 s03->s10 s03->s11
[15] s03->s12 s04->s03 s04->s06 s04->s11 s04->s12 s04->s17 s05->s01
[22] s05->s02 s05->s09 s05->s15 s06->s06 s06->s16 s06->s17 s07->s03
[29] s07->s08 s07->s10 s07->s14 s08->s03 s08->s07 s08->s09 s09->s10
[36] s10->s03 s12->s06 s12->s13 s12->s14 s13->s12 s13->s17 s14->s11
[43] s14->s13 s15->s01 s15->s04 s15->s06 s16->s06 s16->s17 s17->s04

~~~

* `IGRAPH DNW- 17 49 -- ` : 
    * D 혹은 U : 방향성 있는 그래프 혹은 방향성 없는 그래프를 기술
    * N : 노드가 `name` 속성을 갖는 것을 기술
    * W : 가중값이 있는 그래프로 엣지에 `weight` 속성이 있음을 기술
    * B : 이분(Bipartite, two-mode) 그래프로 노두가 `type` 속성이 있음을 기술
    * 17 49 : 노드가 17, 엣지가 49 개가 그래프에 존재함을 기술
* `attr: name (v/c), media (v/c), media.type (v/n), type.label (v/c), audience.size (v/n), type (e/c), weight (e/n)` : 
    * (g/c) : graph-level character attribute
    * (v/c) : vertex-level character attribute
    * (e/n) : edge-level numeric attribute
    * (e/c) : edge-level character attribute

`E()` 함수를 통해 네트워크 객체에 포함된 엣지 정보를 추출한다.
`V()` 함수를 통해 네트워크 객체에 포함된 노드 정보를 추출한다.
직접 행렬 원소를 뽑아내는 것도 가능하다.


~~~{.r}
#------------------------------------------------------------------------
# 네트워크 객체 조회

E(net)       # "net" 객체 엣지정보 조회 
~~~



~~~{.output}
+ 49/49 edges (vertex names):
 [1] s01->s02 s01->s03 s01->s04 s01->s15 s02->s01 s02->s03 s02->s09
 [8] s02->s10 s03->s01 s03->s04 s03->s05 s03->s08 s03->s10 s03->s11
[15] s03->s12 s04->s03 s04->s06 s04->s11 s04->s12 s04->s17 s05->s01
[22] s05->s02 s05->s09 s05->s15 s06->s06 s06->s16 s06->s17 s07->s03
[29] s07->s08 s07->s10 s07->s14 s08->s03 s08->s07 s08->s09 s09->s10
[36] s10->s03 s12->s06 s12->s13 s12->s14 s13->s12 s13->s17 s14->s11
[43] s14->s13 s15->s01 s15->s04 s15->s06 s16->s06 s16->s17 s17->s04

~~~



~~~{.r}
V(net)       # "net" 객체 노드정보 조회
~~~



~~~{.output}
+ 17/17 vertices, named:
 [1] s01 s02 s03 s04 s05 s06 s07 s08 s09 s10 s11 s12 s13 s14 s15 s16 s17

~~~



~~~{.r}
E(net)$type  # 엣지 속성 "type"
~~~



~~~{.output}
 [1] "hyperlink" "hyperlink" "hyperlink" "mention"   "hyperlink"
 [6] "hyperlink" "hyperlink" "hyperlink" "hyperlink" "hyperlink"
[11] "hyperlink" "hyperlink" "mention"   "hyperlink" "hyperlink"
[16] "hyperlink" "mention"   "mention"   "hyperlink" "mention"  
[21] "mention"   "hyperlink" "hyperlink" "mention"   "hyperlink"
[26] "hyperlink" "mention"   "mention"   "mention"   "hyperlink"
[31] "mention"   "hyperlink" "mention"   "mention"   "mention"  
[36] "hyperlink" "mention"   "hyperlink" "mention"   "hyperlink"
[41] "mention"   "mention"   "mention"   "hyperlink" "hyperlink"
[46] "hyperlink" "hyperlink" "mention"   "hyperlink"

~~~



~~~{.r}
V(net)$media # 노드 속성 "media"
~~~



~~~{.output}
 [1] "NY Times"            "Washington Post"     "Wall Street Journal"
 [4] "USA Today"           "LA Times"            "New York Post"      
 [7] "CNN"                 "MSNBC"               "FOX News"           
[10] "ABC"                 "BBC"                 "Yahoo News"         
[13] "Google News"         "Reuters.com"         "NYTimes.com"        
[16] "WashingtonPost.com"  "AOL.com"            

~~~



~~~{.r}
# 직접 네트워크 행렬을 조작
net[1,]
~~~



~~~{.output}
s01 s02 s03 s04 s05 s06 s07 s08 s09 s10 s11 s12 s13 s14 s15 s16 s17 
  0  22  22  21   0   0   0   0   0   0   0   0   0   0  20   0   0 

~~~



~~~{.r}
net[5,7]
~~~



~~~{.output}
[1] 0

~~~






