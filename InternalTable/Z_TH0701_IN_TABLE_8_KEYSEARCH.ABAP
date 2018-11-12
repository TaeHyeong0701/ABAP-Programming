*&---------------------------------------------------------------------*
*& Report  Z_TH0701_IN_TABLE_8_KEYSEARCH
*&
*&---------------------------------------------------------------------*
*& Scenrio 1. SORTED TABLE�� READ ~ INDEX ���� ERSDA �ʵ�(������)�� �̿��Ͽ�, ���� �ֱٿ� ������� 5��° ���ڵ带 ��ȸ�غ���.
*&         2. STANDRAD TYPE�� MARA ���̺� ���¿��� BINARY SEARCH�� �̿��Ͽ�, matnr = '100-300'�� ���ڵ带 ������ ��ȸ�غ���.
*&---------------------------------------------------------------------*
*& �˰Ե� ��� 1. BINARY SEARCH�� GENERAL TABLE�� ���ؼ��� ������ �� �� ���� ---> STANDARD TABLE TYPE ����ؾߵ�.
*&          2. BINARY SEARCH�� ���� ���� 2�й� �������� ��ȸ�� �ذ��� ������ ��������� �뷮�� �����Ϳ��� �Ϲ����� READ���� �ӵ��� �����ȴ�.
REPORT  z_th0701_in_table_8_keysearch.

DATA : it_s_mara TYPE SORTED TABLE OF mara WITH non-UNIQUE KEY ersda,                      " �ߺ��� ���(���� ���̺��� �̹� �ߺ����� �����ϹǷ�), ERSDA �ʵ� ������ ����
      wa_s_mara LIKE LINE OF it_s_mara,
      it_mara TYPE TABLE OF mara,                                                          " Standard type table
      wa_mara LIKE LINE OF it_mara.

SELECT *
  FROM mara INTO TABLE it_s_mara.

SELECT *
  FROM mara INTO TABLE it_mara.

*---------------------------------------------------------------------------------------- INDEX �̿� SEARCH
READ TABLE it_s_mara into wa_s_mara INDEX 5.
WRITE : wa_s_mara-matnr,wa_s_mara-ersda,wa_s_mara-ernam,wa_s_mara-laeda,wa_s_mara-aenam.

*---------------------------------------------------------------------------------------- KEY �̿� BINARY SEARCH
READ TABLE it_mara into wa_mara WITH KEY matnr = '100-300' BINARY SEARCH.
WRITE : wa_mara-matnr,wa_mara-ersda,wa_mara-ernam,wa_mara-laeda,wa_mara-aenam.