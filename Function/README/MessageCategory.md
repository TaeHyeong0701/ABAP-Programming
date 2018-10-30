 # Message Category
 
 시스템 에러 발생시, 사용자에게 알려주는 메시지 타입에 대해 공부하였습니다.
 
 
## Message Category

 
| 텍스트 |의미|다음단계|

|:---:|:---:|:---:|

| S  |성공했다.|Success|

|I|팝업창으로 알려준다|Success|

|W|Status바에 노란느낌표로 나오는 메시지 출력|Success|

|E|Status바에 빨강느낌표로 나오는 메시지|Fail|

|X|Dump error + 강제종료|Fail|

|A|팝업창 + 강제종료|Fail|

|BC410 패키지|에러 메시지 모음 패키지(Predefined)|-|



## 예시코드

```

IF sysubrc <> 0.
MESSAGE 'Fail' TYPE '<text>'.
ENDIF.


```



## 출력화면
1. 'S'
<<<<<<< HEAD
 
   ![s�ڵ� ����](./image/error_s.png)

2. 'I'

    ![s�ڵ� ����](./image/error_s.png)
3. 'W'
 ![s�ڵ� ����](./image/error_s.png)
4. 'E'
 ![s�ڵ� ����](./image/error_s.png)
5. 'X'
 ![s�ڵ� ����](./image/error_s.png)

6. 'A'
 ![s�ڵ� ����](./image/error_s.png)
=======
   ![s코드 에러](./image/error_s.png)
2. 'I'
    ![s코드 에러](./image/error_s.png)
3. 'W'
 ![s코드 에러](./image/error_s.png)
4. 'E'
 ![s코드 에러](./image/error_s.png)
5. 'X'
 ![s코드 에러](./image/error_s.png)

6. 'A'
 ![s코드 에러](./image/error_s.png)
>>>>>>> 8a5ddd51902ed4aa27089a1b0128d10a7bf37ca9

