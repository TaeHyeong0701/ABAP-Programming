*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_6_FORALLENTRIES
*&
*&---------------------------------------------------------------------*
*& 알게된 사실 1. 2개 이상의 테이블을 조인하는데, 동일한 필드명으로 존재하지 않을 때에는 FOR ALL ENTRIES 구문을 사용가능.
*&          2. 다중 SELECT 구문을 사용하지 않으므로, 퍼포먼스 좋다.
*&          3. Syntax : ~ FORALL ENTRIES IN a인터널테이블
*&                        필드1 = a인터널테이블-필드2                          ----> a인터널 테이블의 필드값과 비교해서 b select시 사용.
*&
*&---------------------------------------------------------------------*

REPORT  z_th0701_osql_6_forallentries.

DATA : BEGIN OF gs_tab.
        INCLUDE STRUCTURE zthsoccer.                                               "INCLUDE STRUCTURE 사용시, 해당 구조체 안에, 기존에 존재하는 구조체 형태를 추가할 수 있다.
DATA : player_car TYPE zthsoccer_car-player_car,
     END OF gs_tab.

DATA : it_tab LIKE TABLE OF gs_tab,                                                "객체를 참조하는 것이므로, LIKE구문 사용.
       wa_tab LIKE LINE OF it_tab.

DATA : it_zthsoccer_car TYPE TABLE OF zthsoccer_car,
       wa_zthsoccer_car LIKE LINE OF it_zthsoccer_car.

SELECT *
  FROM zthsoccer INTO TABLE it_tab
  WHERE nation = '아르헨티나'.

*---------------------------------------------------------------------------------- 기존에 있는 인터널 테이블인  it_tab값과 비교해서 해당하는 값들만 넣어준다.
SELECT *
  FROM zthsoccer_car INTO TABLE it_zthsoccer_car
  FOR ALL ENTRIES IN it_tab
  WHERE soccer_name = it_tab-name.

*---------------------------------------------------------------------------------- it_tab의 루프문을 돌리며, 2번째 인터널 테이블의 값을 IT_TAB에 넣어준다.
LOOP AT it_tab INTO wa_tab.
  READ TABLE it_zthsoccer_car INTO wa_zthsoccer_car WITH KEY soccer_name = wa_tab-name. " wa_tab의 name필드값과 동일한 soccer_name 이 있는 레코드를 추출하여
                                                                                    " 구조체에 넣어준다.

*  IF sy-subrc = 0 .  " 값이 있다면.
    wa_tab-player_car = wa_zthsoccer_car-player_car.  "wa_tab의 player_car를 wa_zthsoccer의 player_car로 변형시켜준다.
*  ENDIF.
  MODIFY it_tab FROM wa_tab.                      "it_tab 인터널 테이블을 변경시켜준다.
  CLEAR wa_tab.
 ENDLOOP.

*------------------------------------------------------------------------------------ 완성된 it_tab의 결과들을 확인해보자.
 LOOP AT it_tab INTO wa_tab.
   WRITE : / wa_tab-name, wa_tab-weight, wa_tab-player_car.
 ENDLOOP.