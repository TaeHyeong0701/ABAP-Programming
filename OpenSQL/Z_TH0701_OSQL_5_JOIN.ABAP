*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_5_JOIN
*&
*&---------------------------------------------------------------------*
*& 알게된 사실 1. 조인시에 가장 오류가 많이 나는 에러는 인터널 테이블 형태에 대한 덤프오류였음  ---> corresponding fileds of 명령어를 사용하여, 부분 필드 선택시 타입을 일치시켜준다.
*&          2. Alias 명을 사용한다고 하더라도 테이블내의 유일 명칭이면 as 없이도 호출됨.
*&          3. 기존의 범용적인 DB Syntax는  '-'을 이용하여, 필드들을 가져오지만, ABAP의 JOIN 구문에서는 '~'을 이용한다.
*&---------------------------------------------------------------------*

REPORT  z_th0701_osql_5_join.

DATA : BEGIN OF gs_tab.
        INCLUDE STRUCTURE zthsoccer.                                     "INCLUDE STRUCTURE 사용시, 해당 구조체 안에, 기존에 존재하는 구조체 형태를 추가할 수 있다.
data : player_Car TYPE zthsoccer_Car-player_Car,
     END OF gs_tab.

DATA : it_tab LIKE TABLE OF gs_tab,                                      "객체를 참조하는 것이므로, LIKE구문 사용.
       wa_tab LIKE LINE OF it_tab.

*---------------[1. Method: 정식 테이블 명칭 사용 방법.]-------------------------------------------------------------------------------------------------------------*
*SELECT name weight player_car INTO CORRESPONDING FIELDS OF TABLE it_tab  "부분 선택을 하고자 하면, CORRESPONDING FILEDS OF (TABLE)을 사용하여,
*                                                                         "---> 인터널 테이블과 INPUT시키려는 필드들과 일치시켜준다.
*  FROM zthsoccer INNER JOIN zthsoccer_car                                "(INNER) JOIN 선언
*  ON zthsoccer~name = zthsoccer_car~soccer_name                          " JOIN 조건.
*  WHERE zthsoccer~nation = '대한민국'.                                      " WHERE 조건.

*----------------[2. Method: Alias 명 사용 방법.]-----------------------------------------------------------------------------------------------------------------*
SELECT a~name a~weight b~player_Car INTO CORRESPONDING FIELDS OF TABLE it_tab
  FROM zthsoccer as a INNER JOIN zthsoccer_car as b
  on a~name = b~soccer_name
  where a~nation = '아르헨티나'.


LOOP AT it_tab INTO wa_tab.
  WRITE : / wa_tab-name, wa_tab-weight, wa_tab-player_Car.
ENDLOOP.