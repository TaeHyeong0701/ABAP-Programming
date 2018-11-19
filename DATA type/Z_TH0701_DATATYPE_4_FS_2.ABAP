*&---------------------------------------------------------------------*
*& Report  Z_TH0701_DATATYPE_3_FS_2
*&
*&---------------------------------------------------------------------*
*& Written by TaeHyeong
*& Reporting data: `18.11.13
*&---------------------------------------------------------------------*
* Scenario 1. GLT1���̺����� TSL1 ~ TSL16 ������ 1~20ROW����, ����϶�.
*          2. �� ���� �Ұ踦 ���϶�.
*          3. ���� �հ迡�� SUM������ ���� ���϶�
***********************************************************************
REPORT  z_th0701_datatype_3_fs_2.

DATA : it_tab TYPE TABLE OF glt1,
      wa_tab LIKE LINE OF it_tab.
DATA : target(12) TYPE C.               "WA-TAB-TSL00 ---> 12�ڸ�.
DATA : num(2) TYPE N.                   "����. Numeric2 Ÿ������ �����ϸ� ���� ���ͳ����̺� ���������� �˾Ƽ� ��ȯ��. ex) 8 ---> 08
DATA : result TYPE WERTV8.              "TSL Ÿ��.
DATA : GROUP_RESULT TYPE WERTV8.        "TSL Ÿ��.
FIELD-SYMBOLS <fs>.                     "�ʵ尪�� ���� �ʵ�ɺ�(������)�� �����ϰڴ�.

START-OF-SELECTION.
  SELECT *
    FROM glt1 INTO CORRESPONDING FIELDS OF TABLE it_tab
    UP TO 20 ROWS.                        " 1~20row ���� ���� �޾ƿ�.

END-OF-SELECTION.

  LOOP AT it_tab INTO wa_tab.
    ULINE.
    WRITE :  sy-tabix, '���Դϴ�.'.
    IF sy-subrc <> 0.
      EXIT.
    ELSE.
      CLEAR RESULT.                      "Ŭ�����Ͽ�, �� ���� �������ش�.
      DO 16 TIMES.
       num = sy-index.
       CONCATENATE 'WA_TAB-TSL' num INTO target.
       ASSIGN (target) to <fs>.
       WRITE : <fs>.
       result = result + <fs>.
      ENDDO.
      ULINE.
      WRITE : / '�̹����� �Ұ�:', RESULT.
      GROUP_RESULT = GROUP_RESULT + RESULT.
    ENDIF.

  ENDLOOP.
      WRITE : / '1~20���ڵ� ���� TSL00���� �Ѱ�:', GROUP_RESULT.