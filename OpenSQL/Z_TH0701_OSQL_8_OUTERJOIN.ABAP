*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_8_OUTERJOIN
*&
*&---------------------------------------------------------------------*
*& Scenario 1. ZTHSOCCER테이블에는 MATION = '대한민국' 레코드는 2건(손흥민, 기성용).
*&          2. ZTHSOCCER_CAR테이블에는 NATION = '대한민국' 레코드는 1건(손흥민).
*&        ---> 결과로 ZTHSOCCER_CAR에 조인조건에 해당하는 레코드가 없어도 값이 2건 나오는 것을 확인할 수 있다.
*& 알게된 사실 1. LEFT OUTER JOIN시, 왼쪽에 있는 테이블 필드에 대해서만 WHERE 조건을 줄 수 있다.
*&        ---> Error : No fields from the right-hand table of a LEFT OUTER JOIN may appear in the WHERE conditions.
*&---------------------------------------------------------------------*

REPORT  z_th0701_osql_8_outerjoin.

DATA : BEGIN OF gs_tab.
        INCLUDE STRUCTURE zthsoccer.
DATA : player_car TYPE zthc20,
END OF gs_tab.

DATA : it_tab LIKE TABLE OF gs_tab,
       wa_tab LIKE LINE OF it_tab.

SELECT a~name b~player_car INTO CORRESPONDING FIELDS OF TABLE it_tab
  FROM zthsoccer AS a LEFT OUTER JOIN  zthsoccer_car AS b
  ON a~name EQ b~soccer_name
  WHERE a~nation = '대한민국'.


LOOP AT it_tab INTO wa_tab.
  WRITE : / wa_tab-name, wa_tab-player_car.
ENDLOOP.