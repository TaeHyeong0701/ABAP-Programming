*&---------------------------------------------------------------------*
*& Report  Z_TH0701_FUCTION_4_CONCATE
*&
*&---------------------------------------------------------------------*
*& Written by TaeHyeong
*& Reporting date: `18.11.12
*&---------------------------------------------------------------------*
* ������ �̸��� �Է¹޾Ƽ�, ������ �ִ� '�����̸�:' �� ��ģ ���ڿ� ���¸� ����غ���.
REPORT  z_th0701_fuction_4_concate.

DATA result TYPE char30.

PARAMETERS name TYPE char10.

START-OF-SELECTION.
  CONCATENATE '���� �̸�:' name INTO result.               " ��� 1. CONCATENATE ������� ��ġ��.
*  RESULT(6) = '���� �̸�:'.                                 " ��� 2. ���� ��ġ�� �̿��Ͽ�, ��ġ��.
*  RESULT+6(10) = name.                                    
  write : / result.