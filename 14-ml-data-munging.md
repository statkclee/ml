
## 데이터 전처리 및 정제의 중요성

기계학습 알고리즘이 학습을 얼마나 잘 하느냐는 전적으로 **데이터의 품질** 과 **데이터에 담긴 정보량** 에 달려있다. 따라서, 가능하면 정보를 잃지 않으면서 기계학습 알고리즘이 학습할 환경을 구비하는 것이 핵심이다.

* 데이터에서 결측값을 제거하고, 결측값을 **대치(impute)** 한다.
* 범주형 데이터를 기계학습 알고리즘이 소화할 수 있는 형태로 변형한다.

### 결측값 

결측값(missing value)은 보통 빈칸으로 내버려두거나, `NaN`(Not a Number) 혹은 `NA` (Not Applicable, Not Available)로 표기하여 자리를 차지해 둔다. 결측값을 자동으로 알아서 학습하는 기계학습 알고리즘은 아직 존재하지 않기 때문에 통상 결측값을 제거하거나, EM 알고리즘 등을 통해 대치하는 기법을 많이 사용한다.


```python
import sys
reload(sys)
sys.setdefaultencoding("utf-8")
```

한글을 `pandas`에서 처리하는데... `sys.setdefaultencoding("utf-8")` 설정을 사전에 하고 들어간다.
`csv_dat` 변수에 결측값이 들어간 데이터를 생성하고, 판다스에 넣어 데이터프레임을 생성하고 작업을 진행한다.
결측값은 `NaN`으로 파이썬에서 표시된다.


```python
import pandas as pd
from io import StringIO
csv_dat = '''가열,나열,다열,라열,마열
1.0,2.0,3.0,4.0,3.0
5.0,6.0,,8.0, 4.0
0.0,11.0,12.0,,7.0
1.0,7.5,3.0,7.0,3.0'''
csv_dat = unicode(csv_dat) # 파이썬 2.7 계열인 경우 필요하다.
df = pd.read_csv(StringIO(csv_dat))
df
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>가열</th>
      <th>나열</th>
      <th>다열</th>
      <th>라열</th>
      <th>마열</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.0</td>
      <td>2.0</td>
      <td>3.0</td>
      <td>4.0</td>
      <td>3.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>5.0</td>
      <td>6.0</td>
      <td>NaN</td>
      <td>8.0</td>
      <td>4.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.0</td>
      <td>11.0</td>
      <td>12.0</td>
      <td>NaN</td>
      <td>7.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1.0</td>
      <td>7.5</td>
      <td>3.0</td>
      <td>7.0</td>
      <td>3.0</td>
    </tr>
  </tbody>
</table>
</div>



### 결측값 제거

데이터프레임에 들어있는 값의 현황을 파악하려면, `df.values` 명령어를 사용하고, 결측값 갯수는 `df.isnull().sum()` 명령어로 확인한다.

결측값을 제거하는 메쏘드는 `df.dropna()`가 있고, 행방향 혹은 열방향 기준으로 결측값을 제거할 경우 인자로 `axis=0`, `axis=1`를 `df.dropna(axis=1)`와 같이 넣어준다.

`.dropna()` 메쏘드 인자로 `thresh=3`, `subset=['나열']`, `how='all'`과 같이 추가적인 설정을 통해 결측값 개수와 상황에 따라 제어를 한다.


```python
df.dropna()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>가열</th>
      <th>나열</th>
      <th>다열</th>
      <th>라열</th>
      <th>마열</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.0</td>
      <td>2.0</td>
      <td>3.0</td>
      <td>4.0</td>
      <td>3.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1.0</td>
      <td>7.5</td>
      <td>3.0</td>
      <td>7.0</td>
      <td>3.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.dropna(axis=1)
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>가열</th>
      <th>나열</th>
      <th>마열</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.0</td>
      <td>2.0</td>
      <td>3.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>5.0</td>
      <td>6.0</td>
      <td>4.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.0</td>
      <td>11.0</td>
      <td>7.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1.0</td>
      <td>7.5</td>
      <td>3.0</td>
    </tr>
  </tbody>
</table>
</div>



### 결측값 대치

결측값이 있을 때마다 날려버리게 되면 깔끔하지만, 댓가가 따른다. 결측값 제거에 따라 남아있는 관측점 혹은 변수가 줄어들게 되어 데이터를 통해 수집한 정보가 모두 사라지는 문제점이 있다. 결측값을 대치함으로써 정보를 잃지 않으면서 가능하면 많은 관측점과 변수를 통해 통상 기계학습 알고리즘을 개발한다.

`sklearn.preprocessing` 라이브러리에서 `Imputer` 함수를 사용해서 결측값을 대치하는데, 인자로 `missing_values=`에 결측값 대상을 정의하고, `strategy=`에 평균으로 대치하면 `mean`, 중위값으로 대치하면 `median`, 범주형 자료의 경우는 가장 많은 최빈치로 `most_frequent`를 넣어주고, 행기준이면, `axis=0`, 열기준이면 `axis=1`로 설정한다.

Imputer 클래스는 중요한 두가지 메쏘드를 갖는데, 첫번째 메쏘드가 `.fit` 메쏘드로 데이터프레임을 입력받아 결측값을 채워넣을 적합모형을 생성한다. 이번 경우에는 단순하지만, 평균이 이곳에 해당된다. 두번째 메쏘드는 `.transform` 으로 생성된 적합모형을 적용할 데이터프레임으로 여기서는 결측값이 들어있는 데이터프레임이다. 물론 `.fit`과 `.transform`은 동일한 모양을 가져야만 한다.


```python
from sklearn.preprocessing import Imputer
imp_mean = Imputer(missing_values='NaN', strategy='mean', axis=0)
imp_mean = imp_mean.fit(df)
imp_mean_dat = imp_mean.transform(df.values)
imp_mean_dat
```




    array([[  1.        ,   2.        ,   3.        ,   4.        ,   3.        ],
           [  5.        ,   6.        ,   6.        ,   8.        ,   4.        ],
           [  0.        ,  11.        ,  12.        ,   6.33333333,   7.        ],
           [  1.        ,   7.5       ,   3.        ,   7.        ,   3.        ]])




```python

```
