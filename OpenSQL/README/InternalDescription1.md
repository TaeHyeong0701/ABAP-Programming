 # INTERNAL TABLE
 ## [Overview]
 
 ABAP 프로그래밍의 두드러지는 장점으로 설명할 수 있는 Internal Table에 대해 공부했습니다.
인터널 테이블이란, 데이터베이스의 테이블을 가져와서 조작(연산, 정렬 등등)할 수 있게 해주는 Local Memory 공간이라고 보면 됩니다.

## 구조
 | Header Line(Work Area, Structure) |
|:---:|
|TABLE - row1|
|TABLE - row2|
|..|
|TABLE - rown|

 ### ***1. 장점***
 - 테이블의 조작을 특정 메모리에 올려놓고 편리하게 해준다. (테이블 변수(Variable)라고 생각하면 됩니다.)
 - 정적으로 사용하는 여타 다른 방식보다 메모리를 덜 잡아먹는다.
 - DB로의 접근을 줄여준다.고로, DB I/O의 부하를 현저히 감소. --->  ___Efficient Performance !___
 ### ***2. 유의사항*** 
- 인터널테이블은 Local 내에서만 구동됨.
- 헤더라인이 있는 것과 없는 것의 차이점을 명확히 인지하셔야 사용이 용이함.
- Data Type 유의! 특히 ABAP Dictionary 참조할 때, 일부 필드 순서 때문에 타입이 매칭안되는 경우를 많이 경험함.  ---> ___Be Careful Data Type___
- SAP사에서 비추천하는 방식임.
   - 코드를 일부 줄일 수 있으나, 추후 코드의 가독성(유지보수 측면)을 떨어뜨릴 위험이 높다고 생각함
## [Work Area Type Define]
    DATA : it1_sflcrew TYPE TABLE OF sflcrew, 
            wo1_sflcrew LIKE LINE OF it1_sflcrew. 

## [With HeaderLine Type Define]
    DATA : it2_sflcrew TYPE TABLE OF header_str WITH HEADER LINE.
    

>  > 학습 자료 : SAP_ABAPFUNDMENTAL, Easy ABAP
