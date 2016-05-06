---
layout: page
title: xwMOOC 기계학습
subtitle: 파이썬기반 기계학습 툴체인(toolchain)
---

> ## 학습목표 {.objectives}
>
> * 유닉스 명령라인 인터페이스를 통해 데이터 분석을 실시한다.

## 명령라인 데이터 분석 [^cmd-data-analysis] 

[^cmd-data-analysis]: [Data Science at the Command Line](http://datascienceatthecommandline.com/)

명령라인 인터페이스를 사용하면, 애자일(Agile), 다른 기술과 증강(Augmenting)이 가능하며, 확장성(Scalable)이 크며, 연장가능(Extensible)하며, 어디서나 사용(Ubiquitous)되는 장점을 갖는다.

유닉스는 **텍스트(Text)** 가 어디서나 사용되는 인터페이스로, 각 개별 구성요소는 한가지 작업만 매우 잘 처리하게 설계되었고, 복잡하고 난이도가 있는 작업은 한가지 작업만 잘 처리하는 것을 **파이프와 필터** 로 자동화하고, 그리고 **쉘스크립트** 를 통해 추상화한다.


## 1. 데이터 가져오기

데이터를 가져오는 방식은 결국 텍스트로 유닉스/리눅스 환경으로 불러와야만 된다.
**[csvkit](http://csvkit.readthedocs.io/)** 에 `in2csv`, `csvcut`, `csvlook`, `sql2csv`, `csvsql`이
포함되어 있다. 

`sudo pip install csvkit` 명령어로 설치한다.

* 로컬 파일: `cp` 복사, 원격파일 복사: `scp` 복사
* 압축파일: `tar`, `unzip`, `unrar` 명령어로 압축된 파일을 푼다.
    * 압축파일 확장자: `.tar.gz`, `.zip`, `.rar`
    * 압축파일 푸는 종결자 `unpack`
* 스프레드쉬트: [in2csv](http://csvkit.readthedocs.io/)는 표형식 엑셀 데이터를 받아 `csv` 파일로 변환.
    * `$ in2csv ne_1033_data.xlsx | csvcut -c county,item_name,quantity | csvlook | head`
* 데이터베이스: sql2csv
    * `sql2csv --db 'sqlite:///iris.db' --query 'SELECT * FROM iris where petal_length > 6.5' | csvlook`
* 인터넷: [curl](https://curl.haxx.se/)을 활용하여 인터넷 자원을 긁어온다.
    * `curl -s http://www.gutenberg.org/files/13693/13693-t/13693-t.tex -o number-theory.txt`    
* API: [curl](https://curl.haxx.se/) 물론, API 토큰, 비밀키 등을 설정하거나 일일 이용한도가 있을 수도 있다. 특히, [curlicue](https://github.com/decklin/curlicue)를 활용하여 트위터 데이터를 바로 가져와서 활용할 수 있다. 자세한 사항은 [Create Your Own Dataset Consuming Twitter API](http://arjon.es/2015/07/30/create-your-own-dataset-consuming-twitter-api/) 블로그를 참조한다.
    * [RANDOM USER GENERATOR](https://randomuser.me/), `curl -s http://api.randomuser.me | jq '.'`

## 2. 데이터 정제

### 2.1 행 뽑아내기

* 행 위치정보를 기반으로 해서 행 절대번호를 활용하여 추출한다.
    * `head`, `sed`, `awk`
* 패턴을 주고 연관된 행만 추출한다.
    * `grep` 명령어에 정규표현식으로 패턴을 담아 매칭되는 것만 뽑아낸다.
    * 사용례: `grep -i session paper.txt`
* 무작위로 행을 추출한다.
    * `shuf` 명령어를 사용한다. 
    * 사용례: `shuf -n 10 data.csv` 

### 2.2. 값 추출

기본적인 값추출 전략은 `grep` 명령어로 행을 뽑아내고, `cut` 명령어로 구분자를 두거나 고정된 열위치에 해당하는 열에서 값을 추출한다.
`cut` 명령어로 열을 쪼개는데 구분자로 `,`를 사용하고 뽑아내는 열로 `-f` 인자를 두고 3번째 행이후 모두를 지정한다.

~~~ {.shell}
$ `grep -i session paper.txt | cut -d ',' -f3-`
$ `grep -i session paper.txt | cut -c 7-`
~~~

### 2.3. 값 바꾸기

값을 바꾸거나 삭제할 때 사용하는 명령어가 `tr`로 `translate` 번역의 약자다.

공백 ` `을 `*`로 바꾼다.

~~~ {.shell}
$ echo 'We Love Data Science!' | tr ' ' '*'
We*Love*Data*Science!
~~~






## 

[Data Science Toolbox](http://datasciencetoolbox.org/)


> ### 명령라인 터미널 동영상 제작 {.callout}
>
> [asciinema (as-kee-nuh-muh)](https://asciinema.org/) 
> $ asciinema -yt "Start Here !!!"