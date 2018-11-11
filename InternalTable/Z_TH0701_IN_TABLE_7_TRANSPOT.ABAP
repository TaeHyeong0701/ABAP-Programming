*&---------------------------------------------------------------------*
*& Report  Z_TH0701_IN_TABLE_7_TRANSPORT
*&
*&---------------------------------------------------------------------*
*& Scenario 1. READ ~ TRANSPORTING Syntax를 활용하여, 특정 칼럼값만 변경해보자.
*&            zthsoccer테이블중 선수명은 '손흥민', 연봉은 '호날두 선수 기준'으로 하는 구조체를 출력해보자.
*&
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_IN_TABLE_7_TRANSPORT.

DATA : it_tab TYPE TABLE OF zthsoccer,
      wa_tab LIKE LINE OF it_tab.

select name salary
  FROM zthsoccer into CORRESPONDING FIELDS OF TABLE it_tab.

  wa_tab-name = '손흥민'.

  READ TABLE it_tab into wa_tab WITH KEY name = '호날두' TRANSPORTING salary.

WRITE : / wa_tab-name, wa_tab-salary.