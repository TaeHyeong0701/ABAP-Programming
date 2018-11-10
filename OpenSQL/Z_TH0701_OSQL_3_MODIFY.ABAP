*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_3_MODIFY
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
************************************************************************
* Senario - 1. ���ͳ� ���̺��� Ȱ���Ͽ�, ABAP Dictionary�� �ִ� ���̺��� �����´�.  *
*           2. MODIFY ���ɹ���, APPEND ���ɹ��� Ȱ���Ͽ�, �����͸� �����Ѵ�.       *
*           3. MODIFY�� APPEND�� �������� �˾ƺ���                           *
***************************************************************************************************************************
*!! �˰Ե� ��� -1. ���ͳ� ���̺������� ���̺��� Ű���� ������ ���� �ʴ´�.                                                                
*            ---> MODIFY, APPEND��, Ű���� �ߺ��ǵ�, Ű���� �Է¾��ϵ�, ���̺��� ������ ������ ���̾ �������.
*!! �˰Ե� ��� -2. MODIFY �� ������ �߰���, INDEX�� �������� �ʴ´ٸ� ������ ����.
*!! �˰Ե� ��� -3. MODIFY ��  ������ �߰���, �������� �ε��� ��(Ex. ���� ���̺��� 15���� �ε����� ���µ�, 17��°�� MODIFY�Ѵ�.)���Խ� ������ ����.
*!! �˰Ե� ��� -4. MODIFY �� ������ �߰���, �ش� �ε��� ���� �ִ� ���� ����� �߰��Ѵ�.
*!! �˰Ե� ��� -5. TRANSPORTING filed ���ɾ Ȱ���Ͽ�, ���ǿ� �´� Ư�� �ʵ尪�� ������ ����.
***************************************************************************************************************************
REPORT  Z_TH0701_OSQL_3_MODIFY.
DATA : it_zthsoccer TYPE TABLE OF zthsoccer,
       wo_zthsoccer LIKE LINE OF it_zthsoccer. "���̺� ���� ������ ���� LIKE LINE OF �̿��ؾߵȴ�.

SELECT *
  FROM zthsoccer
  INTO TABLE it_zthsoccer.

WRITE : / '���� ���� ���̺� �����Դϴ�.'.
 LOOP AT it_zthsoccer into wo_zthsoccer.
 WRITE : / wo_zthsoccer-soccer_num, wo_Zthsoccer-name, wo_Zthsoccer-height, wo_Zthsoccer-weight, wo_Zthsoccer-soccer_position, wo_Zthsoccer-nation, wo_Zthsoccer-salary.
 ENDLOOP.


wo_zthsoccer-soccer_num = 100.
wo_Zthsoccer-name = '�ظ�����'.
wo_Zthsoccer-height = 188.
wo_Zthsoccer-weight = 82.
wo_Zthsoccer-soccer_position = 'FW'.
wo_Zthsoccer-nation = '�ױ۷���'.
wo_Zthsoccer-salary = 103.
WRITE : / 'APPEND�� Ȱ���Ͽ�, �츮���� ������ �����͸� �����Ͽ����ϴ�.'.
APPEND wo_Zthsoccer to it_zthsoccer.
 LOOP AT it_zthsoccer into wo_zthsoccer.
 WRITE : / wo_zthsoccer-soccer_num, wo_Zthsoccer-name, wo_Zthsoccer-height, wo_Zthsoccer-weight, wo_Zthsoccer-soccer_position, wo_Zthsoccer-nation, wo_Zthsoccer-salary.
 ENDLOOP.

WO_ZTHSOCCER-SALARY = '1000'.
MODIFY IT_Zthsoccer from wo_zthsoccer
TRANSPORTING salary WHERE name = '�����'.
write: / 'MODIFY�� Ȱ���Ͽ�, ����� ������ �����͸� �����Ͽ����ϴ�.'.
 LOOP AT it_zthsoccer into wo_zthsoccer.
 WRITE : / wo_zthsoccer-soccer_num, wo_Zthsoccer-name, wo_Zthsoccer-height, wo_Zthsoccer-weight, wo_Zthsoccer-soccer_position, wo_Zthsoccer-nation, wo_Zthsoccer-salary.
 ENDLOOP.

wo_zthsoccer-soccer_num = 100.
wo_Zthsoccer-name = '���缺'.
wo_Zthsoccer-height = 180.
wo_Zthsoccer-weight = 70.
wo_Zthsoccer-soccer_position = 'MF'.
wo_Zthsoccer-nation = '���ѹα�'.
wo_Zthsoccer-salary = 23.

MODIFY IT_Zthsoccer from wo_zthsoccer INDEX 16.
write: / 'MODIFY�� Ȱ���Ͽ�, ���缺 ������ �����͸� �������Ͽ����ϴ�.'.
 LOOP AT it_zthsoccer into wo_zthsoccer.
 WRITE : / wo_zthsoccer-soccer_num, wo_Zthsoccer-name, wo_Zthsoccer-height, wo_Zthsoccer-weight, wo_Zthsoccer-soccer_position, wo_Zthsoccer-nation, wo_Zthsoccer-salary.
 ENDLOOP.