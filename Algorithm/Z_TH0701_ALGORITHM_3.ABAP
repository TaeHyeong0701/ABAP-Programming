*&---------------------------------------------------------------------*
*& Report  Z_TH0701_ALGORITHM_2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*************
*Scenario 1. 당신은 구단주이며, 보유하고 있는 선수는 ZTHSOCCCER에 저장되어 있다.
*         2. 내년에 다른 구단으로 이적이 계획된 선수는 현재 연봉순위에서 6번째인 선수이다.
*          Q. 내년에 다른 구단으로 이적을 시킬 선수는 누구인가?
*
************************************************************************************
REPORT  Z_TH0701_ALGORITHM_3.

DATA : it_zthsoccer type TABLE OF zthsoccer,
      wo_zthsoccer LIKE LINE OF it_zthsoccer.

SELECT *
  FROM zthsoccer
  INTO TABLE it_zthsoccer
  ORDER BY SALARY DESCENDING.

LOOP AT it_zthsoccer into wo_zthsoccer.
  IF SY-TABIX = '6'.
    WRITE : / wo_Zthsoccer-name.
  ENDIF.
ENDLOOP.