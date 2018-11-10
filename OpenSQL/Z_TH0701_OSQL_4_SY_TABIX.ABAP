*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_4_SY_TABIX
*&
*&---------------------------------------------------------------------*
*&
*&  SY-TABIX(���ͳ� ���̺� �ε���)�� LOOP AT // SY-INDEX(�Ϲ����� �ε���)�� DO����, WHILE ����
*&
*&---------------------------------------------------------------------*
* SY-TABIX�� �뵵�� ���� Ȯ���ϸ�, Cycle ������ �����غ���!


REPORT  Z_TH0701_OSQL_4_SY_TABIX.

TYPES : BEGIN OF wo_type,
  carrid TYPE s_carr_id,
  connid TYPE s_conn_id,
  fldate TYPE s_date,
  END OF wo_type.
* ����ü�� �����Ѵ�.
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
  WRITE : / sy-tabix,sy-index, wo_sflcrew-carrid, wo_sflcrew-connid, wo_sflcrew-fldate.    "���ͳ� ���̺����� SY-INDEX���, SY-TABIX�� ������ �� �� ����.
ENDLOOP.

WRITE /'DO Cycle'.
DO 5 TIMES.
  WRITE : / sy-index, num1, '�� ° �����Դϴ�.'.
  num1 = num1 + 1.
ENDDO.

num1 = 1.

WRITE /'WHILE Cycle'.
WHILE sy-index LE 3.
WRITE : / sy-index, num1, '�� ° �����Դϴ�.'.
num1 = num1 + 1.
ENDWHILE.