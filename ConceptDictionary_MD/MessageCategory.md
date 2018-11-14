 # Message Category
 시스템 에러 발생시, 사용자에게 알려주는 메시지 타입에 대해 공부하였습니다.
 
 
## Message Category
| 텍스트 |의미|다음단계|
|:---:|:---:|:---|
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
![errors](https://user-images.githubusercontent.com/44318904/47720913-52f62880-dc92-11e8-87c9-83864c72b35d.png)
2. 'I'
![errori](https://user-images.githubusercontent.com/44318904/47720985-7d47e600-dc92-11e8-8e06-7b18e5aafd0a.png)
3. 'W'
![errori](https://user-images.githubusercontent.com/44318904/47720985-7d47e600-dc92-11e8-8e06-7b18e5aafd0a.png)
4. 'E'
![errore](https://user-images.githubusercontent.com/44318904/47721029-9486d380-dc92-11e8-934e-e1480d05fc42.png)
5. 'X'
![errorx](https://user-images.githubusercontent.com/44318904/47721070-a8323a00-dc92-11e8-8309-1792bd6d6ad4.png)
6. 'A'
![errors](https://user-images.githubusercontent.com/44318904/47721050-9d77a500-dc92-11e8-8dca-efecbc8ac368.png)

