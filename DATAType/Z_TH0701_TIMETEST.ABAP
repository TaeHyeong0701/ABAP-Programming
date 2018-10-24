*&---------------------------------------------------------------------*
*& Report  Z_TH0701_TIMETEST
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_TIMETEST.
DATA: current_date type d,
      current_time TYPE t,
      headquarters_date type d,
      headquarters_time type t.
current_date = sy-datum. "현재 날짜를 저장하는 시스템 변수 'sy-datum'
current_time = sy-uzeit. "현재 시간을 저장하는 시스템 변수 'sy-uzeit'
headquarters_date = sy-datlo. "클라이언트의 날짜를 저장하는 시스템 변수 'sy-datlo'
headquarters_time = sy-timlo. "클라이언트의 날짜를 저장하는 시스템 변수 'sy-timlo'


WRITE : '현재 로컬날짜는', current_date,'이며', / ,
'현재 로컬시간은', current_time, '입니다.', / ,
'현재 본사의 날짜는', headquarters_date, '이며', / ,
'현재 본사의 시간은', headquarters_time, '입니다.'.