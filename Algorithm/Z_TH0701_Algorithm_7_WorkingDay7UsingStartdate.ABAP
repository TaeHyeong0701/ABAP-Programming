*&---------------------------------------------------------------------*
*& Report  Z_TH0701_Algorithm_7_WorkingDay7UsingStartdate
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong
*& Reporting Date: '18.12.19
*& Subject: 2018-12-19 텍스트를 2018.12.19로 변경한다
*&---------------------------------------------------------------------*
REPORT Z_TH0701_Algorithm_7_WorkingDay.
*...

form CAL_WORK .
*&--------------------------------------------------------------------&*
*&  STEP 1
*&--------------------------------------------------------------------&*
*&  RP_CAL_DATE_IN_INTERVAL 스탠다드 함수를 활용하여, 시작일을 통해 종료일을 구한다.
*&--------------------------------------------------------------------&*
CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'
EXPORTING
  DATE = begda
  DAYS = 7
  MONTHS = 0
  YEARS = 0
 IMPORTING
   calc_date = endda.

*&--------------------------------------------------------------------&*
*&  STEP 2
*&--------------------------------------------------------------------&*
*&  HOLIDAY_GET 스탠다드 함수를 이용하여, 시작일과 종료일 사이에 있는 공휴일을 계산한다.
*&--------------------------------------------------------------------&*
CALL FUNCTION 'HOLIDAY_GET'
 EXPORTING
*   holiday_calendar =           'KR'
   factory_calendar =           'GB'          " 영국지역 공장 모델의 Factory calendar를 참조한다.
   date_from =                  begda
   date_to =                    endda
  TABLES
    holidays =                   it_holidays.

*&--------------------------------------------------------------------&*
*&  STEP 4
*&--------------------------------------------------------------------&*
*&  루프문을 돌면서 휴일 수를 계산한다.
*&--------------------------------------------------------------------&*
num1 = 0.  " 휴일 계산하는 로직.
LOOP AT it_holidays INTO wa_holidays.
  num1 = num1 + 1.
  ENDLOOP.
*&--------------------------------------------------------------------&*
*&  STEP 5
*&--------------------------------------------------------------------&*
*&  휴일 수만큼 추가로 Working day를 더해준다.
*&--------------------------------------------------------------------&*
num2 = num1.
CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'
EXPORTING
  DATE = endda
  DAYS = num2
  MONTHS = 0
  YEARS = 0
 IMPORTING
   calc_date = endda.


endform.                    " CAL_WORK

*...