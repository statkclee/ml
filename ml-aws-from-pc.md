---
layout: page
title: 기계학습
subtitle: PC에서 바라본 AWS
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---


> ## 학습 목표 {.objectives}
>
> * PC에서 AWS S3 접속 환경을 설정한다.
> * PC에 S3 데이터 분석과 기계학습 알고리즘 개발 환경을 구축한다.



## 데이터 분석을 위한 AWS 시나리오

데이터 분석을 위한 AWS 시나리오는 여러가지가 존재한다. 가장 먼저 떠오르는 작업 방식은 

- AWS S3 데이터를 가져와서 로컬 PC에서 분석하는 시나리오

탐색적 데이터 분석에 적합한 방식으로 S3 적재된 데이터를 CLI나 GUI를 활용하여 꺼내와서 로컬 PC에서 분석한다.

<img src="fig/aws-s3-pc.png" alt="AWS S3 데이터 가져오기" width="77%" />

### 환경설정 

`AWS Commmand Line Interface` (AWS CLI)를 운영체제에 설치를 하고 파이썬을 설치한다. 
중요한 것은 `aws --version` 명령어를 쳤을 때 환경저보가 출력되어야 한다. 


~~~{.r}
C:\Windows\System32> aws --version
aws-cli/1.11.64 Python/3.4.3 Windows/7 botocore/1.5.27
~~~

- AWS CLI 툴체인 설치 
    - [AWS CLI 윈도우즈 설치](http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-windows.html)
    - [파이썬 3.X 설치](https://www.python.org/downloads/release/python-343/)
    - 파이썬 PIP: `pip install --upgrade --user awscli`
- 환경설정
    - 윈도우 단축키 <font face=Wingdings>ÿ</font> + R 단축키를 누르고 나서 `cmd` 명령어를 쳤을 때 `aws --version` 명령어가 실행되려면,
    환경변수로 **경로(Path)**가 파이썬 AWS CLI 모두 추가되어야 한다.

### S3 접근 설정

S3 버킷에 접근하기 위해서는 AWS에서 발급한 토큰이 필요하다. 
통상 AWS Access Key와 AWS Secret Access Key 즉 접근키와 접근비번으로 구성된다.

`ap-northeast-2` 지역명(Region Name)은 [AWS Regions and Endpoints](http://docs.aws.amazon.com/general/latest/gr/rande.html)에서 확인이 가능하다.
데이터센터가 위치한 지역과 동일하게 생각하는 것도 한 방법이다. 즉, 데이터센터가 위치한 지역에 있는 특정 컴퓨터에 S3 형태로 데이터가 저장되어 있다.

- AWS Access Key ID : ****************
- AWS Secret Access Key : ****************
- Default region name : ap-northeast-2
- Default output format [None]:

상기 정보를 CLI의 경우 `asw configure` 명령어를 실행하고 채워넣거나, S3 브라우저 GUI를 사용하는 경우 메뉴를 찾아 입력시키면 S3에 접속할 수 있다.

### 데이터 분석 환경

AWS S3 버킷 인증키와 S3버킷에서 데이터를 로컬 PC로 가져올 준비가 완료되면 다음으로 데이터를 분석할 환경을 갖춰야 한다.
가장 많이 사용되는 데이터 분석 언어는 R과 파이썬이다. 물론 이 언어를 데이터 분석 엔진으로 사용을 하지만 개발환경을 갖추어 사용하는 것이 대부분이다.
R의 경우 RStudio, 파이썬의 경우 쥬피터가 데이터 분석(과학) 통합개발환경이 된다.

<img src="fig/aws-s3-pc-data-analysis.png" alt="AWS S3 데이터 PC 분석환경" width="77%" />

기계학습과 연관된 과학컴퓨팅을 목적으로 파이썬을 사용하는 경우 [아나콘다(ANACONDA)](https://www.continuum.io/Downloads)를 설치하면 편하다.
파이썬 외에도 기계학습, 데이터 과학을 위해서 분석해야 되는 경우 다수 팩키지를 설치해야 하는데 충돌이나 설치가 되지 않는 문제를 개발사에서 
해결하여 제공하기 때문에 성가신 문제는 넘어가고 데이터 분석과 알고리즘 개발에 전념할 수 있다.

### 통합개발환경(IDE) 설치 

파이썬의 경우 CLI 상에서 `pip install Jupyter` 명령어를 실행하면 간단히 쥬피터가 설치된다.
쥬피터 설치가 완료되면 `jupyter notebook` 명령어를 실행시키면 웹브라우져가 실행되고 데이터를 분석할 수 있는 준비가 모두 완료된다.

> ### `Microsoft Visual C++ 10.0 is required (Unable to find vcvarsall.bat)` 오류 {.callout}
> 
> - `pip install Jupyter` 설치하면서 오류가 발생되면 **Visual C++ Studio 2010 Express**를 설치한다.
> - 필요시 `c:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin` 디렉토리로 이동하여 `vcvars32.bat`을 실행한다.

R을 데이터분석환경을 사용하는 경우 [RStudio](https://www.rstudio.com/)를 다운로드 받아 설치한다.

### S3와 통합개발환경 RStudio, 쥬피터 데이터 동기화

PC에서 S3 데이터를 다운로드 받아 RStudio 혹은 아나콘다 쥬피터 노트북으로 통해 데이터를 분석하거나 알고리즘을 개발하는 경우 
특정 디렉토리를 작업 폴더로 지정하는 것이 프로젝트로 관리 측면에서 편리성이 있다.

<img src="fig/aws-s3-sync-pc.png" alt="AWS S3 데이터 동기화" width="57%" />


- S3와 PC 디렉토리 동기화: `aws s3 sync . s3://버킷명` 명령어를 통해 현재 작업디렉토리와 S3 버킷을 동기화한다.
- PC 디렉토리와 RStudio, 쥬피터 노트북 동기화: RStudio의 경우 프로젝트를 생성하여 특정 디렉토리를 동기화한다. 쥬피터 노트북의 경우 
작업 디렉토리로 이동하여 `jupyter notebook` 실행 명령어를 사용하던가, 쥬피터 노트북 실행 아이콘을 우클릭하여 시작 경로를 설정한다.


