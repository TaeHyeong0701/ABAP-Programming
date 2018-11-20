*&---------------------------------------------------------------------*
*& Report  Z_TH0701_IN_TABLE_9_SORTDESC
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong
*& Reporting Data: `18.11.20.
*& Subject: Descending sort by salary in zthsoccer and print soccerplayer who received Highest Salary
*&---------------------------------------------------------------------*
REPORT  Z_TH0701_IN_TABLE_9_SORTDESC.
DATA : it_tab TYPE TABLE OF ZTHSOCCER,
      wa_tab LIKE LINE OF it_tab.



*------------------------------------------------------------------------Method1. Internal Table Sort
SELECT *
  from zthsoccer into TABLE it_tab.

 sort it_tab by salary DESCENDING.

LOOP AT it_tab into wa_tab.
  if sy-tabix = 1.
    write : / wa_tab-name.
    ENDIF.
  ENDLOOP.

*------------------------------------------------------------------------Method2. Using Max.
clear wa_tab.
DATA : l_salary TYPE zthsoccer-salary.
SELECT MAX( salary )
  FROM zthsoccer into l_salary.

SELECT *
  FROM ZTHSOCCER into wa_tab
  where salary = l_salary.
ENDSELECT.

 write : / wa_tab-name.