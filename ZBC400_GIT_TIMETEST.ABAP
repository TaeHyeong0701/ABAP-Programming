*&---------------------------------------------------------------------*
*& Report  ZBC400_GIT_TIMETEST
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZBC400_GIT_TIMETEST.
DATA: current_date type d,
      current_time TYPE t,
      headquarters_date type d,
      headquarters_time type t.
current_date = sy-datum.
current_time = sy-uzeit.
headquarters_date = sy-datlo.
headquarters_time = sy-timlo.


WRITE : '현재 로컬날짜는', current_date,'이며', / ,
'현재 로컬시간은', current_time, '입니다.', / ,
'현재 본사의 날짜는', headquarters_date, '이며', / ,
'현재 본사의 시간은', headquarters_time, '입니다.'.