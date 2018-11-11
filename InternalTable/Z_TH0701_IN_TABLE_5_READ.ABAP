*&---------------------------------------------------------------------*
*& Report  Z_TH0701_IT_TABLE_5_READ
*&
*&---------------------------------------------------------------------*
*&
*& READ TABLE WITH KEY
*&
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_IT_TABLE_5_READ

DATA : it_sflight TYPE TABLE OF sflight,
      wa_sflight LIKE LINE OF it_sflight,
      wo_sflight LIKE LINE OF it_sflight,
      it_s_sflight TYPE SORTED TABLE OF sflight WITH non-UNIQUE KEY planetype,     
* Ű������ Planetype���� ������.(Planetype������ ������) // non-unique�ϱ� ������ �ߺ��� ����.
      wa_s_sflight LIKE LINE OF it_s_sflight.
SELECT *
  FROM sflight INTO TABLE it_sflight.
  SELECT *                  
  FROM sflight INTO TABLE it_s_sflight.                                             
READ TABLE it_sflight INTO wa_sflight WITH KEY carrid = 'AA'.                       " �Ϲ� �ʵ� ���� �������� ��ȸ��. SELECT���� WHERE���� ����
READ TABLE it_s_sflight INTO wa_S_sflight WITH TABLE KEY planetype = '747-400'.     " TABLE KEY���� �������� ��ȸ��.
* select * FROM it_Sflight into wo_S_Sflight where carrid = 'AA'.                   " SELECT TABLE�� ���ͳ� ���̺��� ������� �� �� ����. ---> READ TABLE�� ����ϴ� ����

WRITE : / wa_sflight-carrid, wa_sflight-connid, wa_sflight-price.
WRITE : / wa_s_sflight-carrid, wa_s_sflight-connid, wa_s_sflight-price.