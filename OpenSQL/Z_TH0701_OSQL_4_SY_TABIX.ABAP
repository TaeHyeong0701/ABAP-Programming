*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_4_SY_TABIX
*&
*&---------------------------------------------------------------------*
*&
*&  SY-TABIX(인터널 테이블 인덱스)와 LOOP AT // SY-INDEX(일반적인 인덱스)와 DO구문, WHILE 구문
*&
*&---------------------------------------------------------------------*
* SY-TABIX의 용도에 대해 확인하며, Cycle 구문을 연습해보자!


REPORT  Z_TH0701_OSQL_4_SY_TABIX.

TYPES : BEGIN OF wo_type,
  carrid TYPE s_carr_id,
  connid TYPE s_conn_id,
  fldate TYPE s_date,
  END OF wo_type.
* 구조체를 선언한다.
DATA wo_sflcrew TYPE wo_type.
DATA it_sflcrew TYPE TABLE OF wo_type.
DATA num1 TYPE i.
num1 = 1.

SELECT carrid connid fldate FROM sflcrew
  INTO TABLE it_sflcrew
  WHERE carrid = 'AA' AND
  fldate = '20090709'.

WRITE 'LOOP AT Cycle'.
LOOP AT it_sflcrew INTO wo_sflcrew.
  WRITE : / sy-tabix,sy-index, wo_sflcrew-carrid, wo_sflcrew-connid, wo_sflcrew-fldate.    "인터널 테이블에서 SY-INDEX대신, SY-TABIX가 사용됨을 알 수 있음.
ENDLOOP.

WRITE /'DO Cycle'.
DO 5 TIMES.
  WRITE : / sy-index, num1, '번 째 실행입니다.'.
  num1 = num1 + 1.
ENDDO.

num1 = 1.

WRITE /'WHILE Cycle'.
WHILE sy-index LE 3.
WRITE : / sy-index, num1, '번 째 실행입니다.'.
num1 = num1 + 1.
ENDWHILE.