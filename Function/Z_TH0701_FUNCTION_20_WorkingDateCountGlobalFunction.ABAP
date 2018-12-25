FUNCTION Z_THWORKING_COUNT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(STARTDATE) TYPE  SY-DATUM
*"     REFERENCE(WORKDAY) TYPE  NUM1 DEFAULT 0
*"  EXPORTING
*"     REFERENCE(ENDDATE) TYPE  SY-DATUM
*"----------------------------------------------------------------------
************************************************************************
* Written By TaeHyeong
* Reporting Date: `18.12.24
* Subject: 글로벌 함수로, 시작일과 워킹데이날짜를 입력받아서 주말과 공휴일을 제외한 실제 종료일을 구하는 함수.
************************************************************************
DATA : plandate type d.
data : max TYPE i.
data : count TYPE i.
data : TH_DAYNR TYPE HRVSCHED-DAYNR,
       h_check TYPE c.
plandate = startdate.
max = workday.
WHILE count < max.

  CALL FUNCTION 'RH_GET_DATE_DAYNAME'        "주말을 구하는 함수.
       EXPORTING
               LANGU = SY-LANGU
               DATE  = PLANDATE              "입력된 변수임
       IMPORTING
               DAYNR  = TH_DAYNR.


  IF TH_DAYNR = '6' OR TH_DAYNR = '7'.        "주말이라면
        plandate = plandate + 1.
  ELSE.                                       " 평일이라면
   CALL FUNCTION 'HOLIDAY_CHECK_AND_GET_INFO'  "대한민국 공휴일을 체크한다.
  EXPORTING
  DATE = plandate
  HOLIDAY_CALENDAR_ID = 'KR'
  IMPORTING
  HOLIDAY_FOUND = h_check.


  IF h_check = 'X'.                          " 평일인데 공휴일이라면.
    plandate = plandate + 1.
  ELSE.                                      " 평일인데 공휴일이 아니라면.  ---> 즉 WORKING DAY라면.
    count = count + 1.
    plandate = plandate + 1.
  ENDIF.

  ENDIF.




ENDWHILE.

  enddate = plandate - 1 .

ENDFUNCTION.