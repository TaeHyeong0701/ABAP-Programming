*&---------------------------------------------------------------------*
*& Report  Z_TH0701_DESCRIBE
*&
*&---------------------------------------------------------------------*
*& Written By: TaeHyeong
*& Reporting Data: `18.11.16
*&---------------------------------------------------------------------*
* MARA 테이블의 레코드 라인수를 조회해보자. USING DESCRIBE TABLE
************************************************************************

REPORT  Z_TH0701_DESCRIBE.

DATA : it_tab TYPE TABLE OF mara ,
      wa_tab LIKE LINE OF it_tab.
DATA : line_count TYPE i.

select *
  from mara into table it_tab.

 DESCRIBE TABLE it_tab LINES line_count.    "라인 값을 가져온다.

 FORMAT COLOR  7.
 WRITE :  3(6) '테이블', 13(10) '라인수'.

  FORMAT COLOR  3.
  NEW-LINE.
  WRITE : 3(6) 'mara', 10(10) line_count.