*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_5_JOIN
*&
*&---------------------------------------------------------------------*
*& �˰Ե� ��� 1. ���νÿ� ���� ������ ���� ���� ������ ���ͳ� ���̺� ���¿� ���� ������������  ---> corresponding fileds of ���ɾ ����Ͽ�, �κ� �ʵ� ���ý� Ÿ���� ��ġ�����ش�.
*&          2. Alias ���� ����Ѵٰ� �ϴ��� ���̺����� ���� ��Ī�̸� as ���̵� ȣ���.
*&          3. ������ �������� DB Syntax��  '-'�� �̿��Ͽ�, �ʵ���� ����������, ABAP�� JOIN ���������� '~'�� �̿��Ѵ�.
*&---------------------------------------------------------------------*

REPORT  z_th0701_osql_5_join.

DATA : BEGIN OF gs_tab.
        INCLUDE STRUCTURE zthsoccer.                                     "INCLUDE STRUCTURE ����, �ش� ����ü �ȿ�, ������ �����ϴ� ����ü ���¸� �߰��� �� �ִ�.
data : player_Car TYPE zthsoccer_Car-player_Car,
     END OF gs_tab.

DATA : it_tab LIKE TABLE OF gs_tab,                                      "��ü�� �����ϴ� ���̹Ƿ�, LIKE���� ���.
       wa_tab LIKE LINE OF it_tab.

*---------------[1. Method: ���� ���̺� ��Ī ��� ���.]-------------------------------------------------------------------------------------------------------------*
*SELECT name weight player_car INTO CORRESPONDING FIELDS OF TABLE it_tab  "�κ� ������ �ϰ��� �ϸ�, CORRESPONDING FILEDS OF (TABLE)�� ����Ͽ�,
*                                                                         "---> ���ͳ� ���̺��� INPUT��Ű���� �ʵ��� ��ġ�����ش�.
*  FROM zthsoccer INNER JOIN zthsoccer_car                                "(INNER) JOIN ����
*  ON zthsoccer~name = zthsoccer_car~soccer_name                          " JOIN ����.
*  WHERE zthsoccer~nation = '���ѹα�'.                                      " WHERE ����.

*----------------[2. Method: Alias �� ��� ���.]-----------------------------------------------------------------------------------------------------------------*
SELECT a~name a~weight b~player_Car INTO CORRESPONDING FIELDS OF TABLE it_tab
  FROM zthsoccer as a INNER JOIN zthsoccer_car as b
  on a~name = b~soccer_name
  where a~nation = '�Ƹ���Ƽ��'.


LOOP AT it_tab INTO wa_tab.
  WRITE : / wa_tab-name, wa_tab-weight, wa_tab-player_Car.
ENDLOOP.