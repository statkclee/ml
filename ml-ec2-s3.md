---
layout: page
title: 기계학습
subtitle: S3 데이터와 EC2, 스파크 EC2 클러스터
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---


> ## 학습 목표 {.objectives}
>
> * AWS EC2에서 S3 버킷에 저장된 데이터를 데이터분석에 활용한다.
> * AWS 스파크 EC2 클러스터에서 S3 버킷에 저장된 데이터를 데이터분석에 활용한다.



<img src="fig/aws-ec2-s3-link.png" alt="AWS EC2 S3 연결" width="77%" />


## AWS S3 데이터를 EC2 RStudio에서 읽어오기 [^aws-s3-read-write] [^cloudyr-aws-s3]

[^aws-s3-read-write]: [Read and Write Data To and From Amazon S3 Buckets in Rstudio](http://datascience.ibm.com/blog/read-and-write-data-to-and-from-amazon-s3-buckets-in-rstudio/)

[^cloudyr-aws-s3]: [Amazon Simple Storage Service (S3) API Client](https://github.com/cloudyr/aws.s3)


EC2에 RStudio 서버가 설치되면 AWS S3 저장소의 데이터를 불러와서 작업을 해야한다.

### 환경설정 

`aws.s3` 팩키지를 통해 AWS S3와 R이 작업을 할 수 있도록 한다. `devtools::install_github("cloudyr/aws.s3")` 명령어를 통해 팩키지를 설치한다.
`Sys.setenv` 명령어를 통해 `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` 을 설정한다.



~~~{.r}
# aws.s3 설치
devtools::install_github("cloudyr/aws.s3")

library(aws.s3)

# S3 버킷 접근을 위한 키값 설정
Sys.setenv("AWS_ACCESS_KEY_ID" = "xxx",
           "AWS_SECRET_ACCESS_KEY" = "xxx",
           "AWS_DEFAULT_REGION" = "ap-northeast-2")
~~~

### 설정환경 확인

`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`에 부여된 권한에 맞춰 제대로 S3 버킷에 접근할 수 있는지 확인한다.
접근 권한이 있는 모든 S3 버킷 정보가 화면에 출력된다.



~~~{.r}
bucketlist()
~~~

### 설정환경 확인

`get_object` 명령어를 통해 `v-seoul` 버킷 최상위 디렉토리에 있는 `iris.csv` 파일을 불러온다.
바이러니 형태라 사람이 읽을 수 있는 문자형으로 변환시키고 `textConnection` 함수를 통해 `.csv` 파일을 
R에서 작업할 수 있는 데이터프레임 형태로 변환시킨다.


~~~{.r}
iris_dat <- get_object("iris.csv", bucket = "v-seoul")

iris_obj <- rawToChar(iris_dat)  
con <- textConnection(iris_obj)  
iris_df <- read.csv(con)  
close(con)  

iris_df
~~~

## AWS S3 데이터를 스파크 EC2 클러스터 RStudio에서 읽어오기

<img src="fig/aws-ec2-spark-s3-link.png" alt="AWS EC2 스파크 S3 연결" width="77%" />



