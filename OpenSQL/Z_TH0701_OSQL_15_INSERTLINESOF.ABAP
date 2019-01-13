*&---------------------------------------------------------------------*
*& Report  Z_TH_INSERT_LINES_OF
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong
*& Reporting Date: `19.1.13
*& Subject: Insert Lines Of 구문을 이용하여, 11번째 줄서부터 20번째 줄까지 입력을 가져오는 연습을 해보자.
*&---------------------------------------------------------------------*

REPORT  Z_TH_INSERT_LINES_OF.

DATA : it_mara1 TYPE TABLE OF mara,
      wa_mara1 LIKE LINE OF it_mara1.

DATA : it_mara2 TYPE TABLE OF mara,
      wa_mara2 LIKE LINE OF it_mara2.
************************************************************************
* 최초 인터널 테이블에 데이터 삽입.
************************************************************************
SELECT matnr mtart mbrsh
  FROM mara into CORRESPONDING FIELDS OF TABLE it_mara1
  UP TO 20 ROWS.

************************************************************************
* 1번 인터널 테이블 ---> 2번 인터널 테이블(11번째 줄~20번째 줄)
************************************************************************
INSERT LINES OF it_mara1 FROM 11 TO 20 INTO TABLE it_MARA2.

************************************************************************
* 1번 인터널 테이블 출력
************************************************************************
LOOP AT it_mara1 INTO wa_mara1.
  WRITE : / sy-tabix, wa_mara1-matnr, wa_mara1-mtart, wa_mara1-mbrsh.
  ENDLOOP.

WRITE : / '이제 11번째 행부터 20번째 행까지 출력될 것입니다.'.
************************************************************************
* 2번 인터널 테이블 출력
************************************************************************
  LOOP AT it_mara2 into wa_mara2.
  WRITE : / sy-tabix, wa_mara2-matnr, wa_mara2-mtart, wa_mara2-mbrsh.
  ENDLOOP.