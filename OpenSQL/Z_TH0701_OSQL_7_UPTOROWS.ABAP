*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_7_UPTOROWS
*&
*&---------------------------------------------------------------------*
*& 알게된 사실 1. 한 개의 레코드만 조회하고 싶으면 퍼포먼스상 SINGLE을 명시해주고, 구조체를 받아오는 것이 좋다.
*&          2. 한 개이상의 특정 N개 수의 레코드만 조회하고 싶으면 퍼포먼스상 UP TO N ROWS를 사용해주는 것이 좋다.
*&          3. UP TO N ROWS 구문은 기본적으로 정렬이 이루어진 상태에서 하는 것이 좋다.
*&          4. FROM절 --- UP TO ROWS절 --- WHERE절 ... 순으로 코딩됨.
*&---------------------------------------------------------------------*

REPORT  z_th0701_osql_7_uptorows.

DATA : it_tab TYPE TABLE OF zthsoccer,
       wa_tab LIKE LINE OF it_tab,
       it_tab_uptorow TYPE TABLE OF zthsoccer.
*----------------------------------------------------------------------- 전체 선택
SELECT *
  FROM zthsoccer INTO TABLE it_tab
  WHERE nation = '아르헨티나'.

*----------------------------------------------------------------------- UP TO ROWS 구문 사용 부분 선택
SELECT *
  FROM zthsoccer INTO TABLE it_tab_uptorow
  UP TO 2 ROWS
  WHERE nation = '아르헨티나'.

WRITE : / '전체 선택'.
LOOP AT it_tab INTO wa_tab.
  WRITE : / wa_tab-name, wa_tab-soccer_position, wa_tab-salary.
ENDLOOP.
ULINE.
WRITE : / '기존 정렬된 상태에서 내림차순으로 2개 선택(UP TO 2 ROWS)'.
LOOP AT it_tab_uptorow INTO wa_tab.
  WRITE : / wa_tab-name, wa_tab-soccer_position, wa_tab-salary.
ENDLOOP.