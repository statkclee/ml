---
layout: page
title: 기계학습
subtitle: EMR 스파크 클러스터 - wadal
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---


> ## 학습 목표 {.objectives}
>
> * 단속적으로 필요시 대량 EMR 클러스터를 구축하여 S3 데이터를 분석한다.
> * AWS EMR 스파크 클러스터를 설치한다.




## AWS EMR 서비스

AWS EC2 인스턴스를 활용하여 스파크 클러스터를 구축하는 것은 데이터를 분석하거나 기계학습 알고리즘을 개발하는 개발자입장에서 어려운 것은 아니지만,
상당한 시간과 노력을 들여야 하고 항시 하둡을 비롯한 스파크 등 컴퓨팅, 네트워크 환경이 바뀜에 따라 꾸준히 학습해가는 과정이 필요하다.

따라서, 데이터 분석과 기계학습 알고리즘에 전념을 하고자 한다면 대용량 데이터를 손쉽게 처리할 수 있는 AWS EMR 서비스가 가능한 해법으로 크게 두가지 방식이 존재한다.

- AWS EMR GUI [^aws-emr-rstudio]
- AWS EMR CLI: [와달(wadal)](https://github.com/haje01/wadal)

[^aws-emr-rstudio]: [Using sparklyr with an Apache Spark cluster](http://spark.rstudio.com/examples-emr.html)

AWS EMR GUI를 활용하여 스파크 클러스터를 구축하는 방식은 [Using sparklyr with an Apache Spark cluster](http://spark.rstudio.com/examples-emr.html) 메뉴얼을 참조한다.

## [와달(wadal)](https://github.com/haje01/wadal)

와달은 매번 AWS EMR GUI를 통해 매번 스파크 EMR 클러스터를 생성하는 것을 자동화하고자 웹젠 기술이사로 계신 김정주 TD님이 오픈소스 프로젝트로 진행하고 있다.
스파크 EC2 클러스터를 구축하고자 하는 경우 기존 spark-ec2를 계승한 [부싯돌(flintrock)](https://github.com/nchammas/flintrock) 프로젝트와 유사할 수 있으나,
두가지 점에서 차이가 나는데 하나는 AWS EMR에 초점을 두고 있고, 상시 스파크 클러스터를 운영하는 것이 아니라 단속적으로 필요시마다 껐다 켰다를 할 수 있다는 점이다.

즉, 대용량 데이터를 한번에 일시적으로 처리할 경우 적절한 방식이라고 볼 수 있다.

### 와달 설치

와달 설치는 [GitHub wadal](https://github.com/haje01/wadal) 저장소를 클론하여 가져온다.


~~~{.r}
$ git clone git@github.com:haje01/wadal.git
~~~

### 사전 준비(EC2 Pair, S3 버킷)

**EC2 Pair**를 준비하고 EMR 관련 설정을 올릴 수 있는 애셋을 S3 버킷에 준비한다.
EMR 클러스터가 준비되면 분석코드와 중간 데이터를 저장할 수 있는 S3 버킷도 함께 준비한다.


### EMR 프로파일 설정

다음으로 AWS EMR 프로파일을 텍스트 편집기를 활용하여 작성한다.
와달을 설치하면 wadal 디렉토리 내부에 `profile.template`이 있어 이를 열고 필요한 설정을 한다.
처음 AWS EMR 클러스터를 와달을 이용하여 생성하는 경우, 당혹스러울 수도 있으니 먼저 AWS EMR GUI 방식으로 먼저 설치해보고 
와달 CLI 방식을 진행하는 것을 추천한다.


~~~{.r}
export PLATFORM=YOUR-PLATFORM ex) py or r
export CLUSTER_NAME="YOUR-CLUSTER-NAME"
export AWS_REGION=YOUR-AWS-REGION
export AWS_EMR_LABEL=EMR-LABEL ex)emr-5.0.0
export AWS_EMR_SUBNET=EMR-VPC-SUBNET ex)subnet-a55xxxxx
export NUM_TASK_INSTANCE=3
export TASK_SPOT_BID_PRICE=TASK-SPOT-INSTANCE-BID-PRICE ex)0.06
export EC2_TYPE=EC2-INSTANCE-TYPE ex)m3.xlarge
export EC2_KEY_PAIR_NAME=EC2-KEY-PAIR-NAME
export EC2_KEY_PAIR_PATH="EC2-KEY-PAIR-PATH(include .pem)"
export AWS_S3_ACCESS_KEY=AWS-S3-ACCESS-KEY-FOR-NOTEBOOK-SYNC
export AWS_S3_SECRET_KEY=AWS-S3-SECRET-KEY-FOR-NOTEBOOK-SYNC
export INIT_ASSET_DIR_S3=S3-URL-FOR-INIT-ASSET
export NOTEBOOK_S3_BUCKET=YOUR-S3-BUCKET-TO-STORE-NOTEBOOKS
~~~

### 와달 기동

모든 준비가 완료되었다면, 와달 명령어를 통해 AWS EMR 스파크 클러스터를 생성시킬 수 있다.


~~~{.r}
$ cp profile.template profiles/mypro # 프로파일 템프릿을 `profiles` 폴더로 이동 후 프로파일을 작성한다.
$ bin/upload_assets mypro            # 작성한 프로파일을 S3 버킷으로 올린다. 최소 1회만 수행하면 된다.
$ bin/create_cluster mypro           # mypro 라는 AWS EMR 클러스터를 생성시킨다.
$ bin/state mypro                    # mypro 클러스터 생성과정을 살펴본다.
$ bin/terminate mypro                # mypro 클러스터 제거
~~~

R 을 분석언어로 실행할 경우 약 15분 정도 시간이 소요된다. R, RStudio 서버, `sparklyr` 설치에 시간이 많이 소요된다.
AWS EMR 스파크 클러스터를 생성시킨 후에 분석작업이 완료되면 `mypro` 클러스터를 `terminate` 명령어로 종료시킨다.

네트워크 등 여러 사정상 전달이 되지 않는 경우가 있는지 AWS EMR 콘솔 화면에서 정확히 클러스터가 삭제되었는지 확인한다.
