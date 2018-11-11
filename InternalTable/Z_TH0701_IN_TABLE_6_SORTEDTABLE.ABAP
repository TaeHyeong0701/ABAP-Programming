*&---------------------------------------------------------------------*
*& Report  Z_TH0701_IN_TABLE_6_SORTEDTABLE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
* PreCondition  ---> Sorted table Standard Table�� �������� ��Ȯ�� �� �� �ִ� ���̺��� �����ϰų� �̿�����.
*                    SAP���� ������ ������ ���̺� �𵨵��� �Էµ� ������, ��κ��� �ʵ尪���� Ű������ �����Ǿ� �־,
*                   ������ ���� ���̺�(ZTHPRACTICE)�� �����Ͽ�, ���� ������ ���� ���������� �˾ƺ�����.
*

*
*
REPORT  Z_TH0701_IN_TABLE_6_SORTEDTABLE


DATA : it_g_sflcrew TYPE TABLE OF zthpractice, "���ͳ� ���̺��� TYPE TABLE OF�� �̿��Ͽ� ����.
       wo_g_sflcrew LIKE LINE OF it_g_sflcrew, "WorkArea�� Like Line OF�� �̿��Ͽ� ����.
       it_s_sflcrew TYPE SORTED TABLE OF zthpractice with NON-UNIQUE KEY ADDRESS,
       wo_s_sflcrew LIKE LINE OF it_s_sflcrew.
SELECT *
  FROM zthpractice
  INTO TABLE it_g_sflcrew.
* Standard ������ ���ͳ� ���̺��� zthpractice ���̺��� ������ ����־� �ش�.
SELECT *
  FROM zthpractice
  INTO TABLE it_s_sflcrew.
* Sorted ������ ���ͳ� ���̺��� zthpractice ���̺��� ������ ����־��ش�.

WRITE : / 'Stanadard ����'.
 LOOP AT it_g_sflcrew INTO wo_G_sflcrew.
  write : / wo_g_sflcrew-id, wo_g_sflcrew-pw, wo_g_sflcrew-name, wo_g_sflcrew-phone.
ENDLOOP.
* Standard Table���̺��� ������ ������ �� ���Ǵ� Ű���� ���ؼ� ���ĵ��� Ȯ���� �� ����

WRITE : / 'Sorted ����'.
LOOP AT it_S_sflcrew INTO wo_S_sflcrew.
  write : / wo_S_sflcrew-id, wo_s_sflcrew-pw, wo_S_sflcrew-name, wo_s_sflcrew-phone.
ENDLOOP.
* Sorted Table ���̺��� Non-Unique key �ڿ� ������ �ʵ������ �����͸� ����Ѵ�.