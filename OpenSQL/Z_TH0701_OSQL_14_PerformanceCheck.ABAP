*&---------------------------------------------------------------------*
*& Report  Z_TH0701_PerformanceTest
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeongKim
*& Reporting Date: '18.11.29
*&---------------------------------------------------------------------*
************************************************************************
* 퍼포먼스 구동 시간 비교 알고리즘.
* Scenario 1. MARA테이블의 모든 데이터 조회
*          2. WHERE 조건으로 조회시간 단축 결과 확인.
*          3. 구동시간 차이를 계산한다.
************************************************************************
REPORT  z_th0701_exam.

DATA : it_tab TYPE TABLE OF mara,
       wa_tab LIKE LINE OF it_tab.
DATA : temp1 TYPE p DECIMALS 7,
      temp2 TYPE p DECIMALS 7,
      temp3 TYPE p DECIMALS 7.
********************************************************************************
* Time Check 1 Data Declaration                                                *
********************************************************************************
DATA: l_st1 TYPE timestampl.            "  UTC Time Stamp Form (YYYYMMDDhhmmssmmmuu)
DATA: time_char1(32) TYPE c.
********************************************************************************
* Time Check 2 Data Declaration                                                *
********************************************************************************
DATA: l_st2 TYPE timestampl.
DATA: time_char2(32) TYPE c.
********************************************************************************
* Time Check 3 Data Declaration                                                *
********************************************************************************
DATA: l_st3 TYPE timestampl.
DATA: time_char3(32) TYPE c.

********************************************************************************
* Time Check 4 Data Declaration                                                *
********************************************************************************
DATA: l_st4 TYPE timestampl.
DATA: time_char4(32) TYPE c.


********************************************************************************
* Time Check Point 1      //  Before Select Data                               *
********************************************************************************
GET TIME STAMP FIELD l_st1.             " Current Time on UTC.
MOVE l_st1 TO time_char1.                " Move To Char Format
CONDENSE time_char1.                    " 'CONDENSE' Commnad ---> blank Delete.


SELECT *
  FROM mara INTO TABLE it_tab
  WHERE matnr LT '000000000000000700'.
clear it_tab.

IF sy-subrc = 0.
********************************************************************************
* Time Check Point 2      //  After Where Select Data                          *
********************************************************************************
  GET TIME STAMP FIELD l_st2.
  MOVE l_st2 TO time_char2.
  CONDENSE time_char2.
  WRITE:/ 'TIME STAMP : ' , time_char2.
ENDIF.

SELECT *
  FROM mara INTO TABLE it_tab.

IF sy-subrc = 0.
********************************************************************************
* Time Check Point 3      //  After * Select Data                              *
********************************************************************************
  GET TIME STAMP FIELD l_st3.
  MOVE l_st3 TO time_char3.
  CONDENSE time_char3.

ENDIF.


LOOP AT it_tab INTO wa_tab.
*  wa_tab-blanz = wa_tab-blanz + 10.
  IF wa_tab-matnr LT '000000000000000700'.
*    wa_tab-blanz = wa_tab-blanz + 10.
    ENDIF.
  ENDLOOP.
********************************************************************************
* Time Check Point 4      //  Internal Table Action                            *
********************************************************************************
GET TIME STAMP FIELD l_st4.
MOVE l_st4 TO time_char3.
CONDENSE time_char4.


WRITE:/ 'TIME CHECK POINT1(Before Select Data) : ' , time_char1.
WRITE:/ 'TIME CHECK POINT1(After * Select Data) : ' , time_char2.
WRITE:/ 'TIME CHECK POINT1(After Where Select Data) : ' , time_char3.
WRITE:/ 'TIME CHECK POINT1(Internal Table Action) : ' , time_char4.
temp1 = l_st2 - l_st1.
temp2 = l_st3 - l_st2.
temp3 = l_st4 - l_st3.
WRITE : / 'TIME Difference(Between CP1 AND CP2) : ' , temp1.
WRITE : / 'TIME Difference(Between CP2 AND CP3) : ' , temp2.
WRITE : / 'TIME Difference(Between CP2 AND CP3) : ' , temp3.