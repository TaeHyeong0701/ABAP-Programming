*&---------------------------------------------------------------------*
*& Report  Z_TH0701_WRITE
*&
*&---------------------------------------------------------------------*
*&Written by: TaeHyeong
*&Reporting Data: `18.11.16
*&---------------------------------------------------------------------*
* Scenario 1. ZTHSOCCER 테이블에서 10개의 상위 레코드를 가져온다.
*          2. WRITE구문과 COLOR를 이용하여, 색을 강조하여, 출력한다.
*
REPORT  z_th0701_write.

DATA : it_tab TYPE TABLE OF zthsoccer,
      wa_tab LIKE LINE OF it_tab.

SELECT *
  FROM zthsoccer INTO TABLE it_tab
  UP TO 10 ROWS.

FORMAT COLOR 5.                                            " 1~7까지의 칼러들을 지원해준다. 5 = 초록색.
WRITE:/2(10) '선수명', 12(10)'팀명', 22(5)'키', 27(6)'몸무게'.
ULINE.

LOOP AT it_tab INTO wa_tab.
  FORMAT COLOR 2.                                           " 1~7까지의 칼러들을 지원해준다. 2 = 회색.
  WRITE: /2(10) wa_tab-name, 12(10) wa_tab-team, 22(5) wa_tab-height, 27(6) wa_tab-weight.
ENDLOOP.