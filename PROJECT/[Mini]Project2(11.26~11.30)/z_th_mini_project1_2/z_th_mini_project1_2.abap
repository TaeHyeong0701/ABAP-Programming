*&---------------------------------------------------------------------*
*& Report  Z_TH_MINI_PROJECT1_2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

INCLUDE Z_TH_MINI_PROJECT1_2_TOP               .    " global Data

INCLUDE Z_TH_MINI_PROJECT1_2_O01                .  " PBO-Modules
 INCLUDE Z_TH_MINI_PROJECT1_2_I01                .  " PAI-Modules
 INCLUDE Z_TH_MINI_PROJECT1_2_F01                .  " FORM-Routines

 START-OF-SELECTION.
PERFORM fetch_report.
CALL SCREEN 100.

*GUI Texts
*----------------------------------------------------------
* SUBJECT --> �������� ���� ��û ��Ȳ

*Text elements
*----------------------------------------------------------
* 001 ��ȸ����
* 002 �߰�����
* 003 �����ȣ
* 004 ����׷�
* 005 ��������
* 006 ������
* 007 ������

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
