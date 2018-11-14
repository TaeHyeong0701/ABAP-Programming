*&----------------------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_COLLECT
*&
*&----------------------------------------------------------------------------------*
*& WRITTEN BY: TaeHyeong
*& REPORTING DATA: `18.11.14
*&----------------------------------------------------------------------------------*
*  COLLECT 구문을 이용하여, ZTHSOCCER 테이블에서 HEIGHT이 180이상인 선수들의 이름과 몸무게를 출력하시오.
*
*************************************************************************************
REPORT  z_th0701_osql_collect.
DATA : BEGIN OF gs_tab.
DATA : name TYPE name,
      height TYPE i,
      weight TYPE i,
      END OF gs_tab.
DATA : result TYPE i.

DATA : it_tab LIKE SORTED TABLE OF gs_tab WITH NON-UNIQUE KEY name,
      wa_tab LIKE LINE OF it_tab.

SELECT name height weight
  FROM zthsoccer INTO wa_tab.
  IF wa_tab-height GT 180.
    COLLECT wa_tab INTO it_tab.
  ENDIF.
ENDSELECT.

LOOP AT it_tab INTO wa_tab.
  WRITE : / wa_tab-name, wa_tab-height, wa_tab-weight.
ENDLOOP.