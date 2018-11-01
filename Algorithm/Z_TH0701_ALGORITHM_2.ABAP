*&---------------------------------------------------------------------*
*& Report  Z_TH0701_ALGORITHM_2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*************
*Scenario 1. 당신은 구단주이며, 보유하고 있는 선수는 ZTHSOCCCER에 저장되어 있다.
*         2. 내년에 다른 구단으로 이적이 계획된 선수 '네이마르'가 있다.
*         3. 내년에 당신이 구단에 남아있는 선수들에게 지급해야할 연봉의 총 합계는 얼마인가?
*            단, 현재 데이터베이스에서 '네이마르'선수의 데이터 삭제가 이루어지지 않고 있는 상황이다.
************************************************************************************
REPORT  Z_TH0701_ALGORITHM_2.

DATA : it_zthsoccer type TABLE OF zthsoccer,
      wo_zthsoccer LIKE LINE OF it_zthsoccer,
      sum_salary type p.

SELECT *
  FROM zthsoccer
  INTO TABLE it_zthsoccer
  where name <> '네이마르'.

LOOP AT it_zthsoccer into wo_zthsoccer.
sum_salary = sum_salary + wo_zthsoccer-salary.
ENDLOOP.

write : sum_salary.