*&---------------------------------------------------------------------*
*& Report  Z_TH0701_ALGORITHM_2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*************
*Scenario 1. ����� �������̸�, �����ϰ� �ִ� ������ ZTHSOCCCER�� ����Ǿ� �ִ�.
*         2. ���⿡ �ٸ� �������� ������ ��ȹ�� ������ ���� ������������ 6��°�� �����̴�.
*          Q. ���⿡ �ٸ� �������� ������ ��ų ������ �����ΰ�?
*
************************************************************************************
REPORT  Z_TH0701_ALGORITHM_3.

DATA : it_zthsoccer type TABLE OF zthsoccer,
      wo_zthsoccer LIKE LINE OF it_zthsoccer.

SELECT *
  FROM zthsoccer
  INTO TABLE it_zthsoccer
  ORDER BY SALARY DESCENDING.

LOOP AT it_zthsoccer into wo_zthsoccer.
  IF SY-TABIX = '6'.
    WRITE : / wo_Zthsoccer-name.
  ENDIF.
ENDLOOP.