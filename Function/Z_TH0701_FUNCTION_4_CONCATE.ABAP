*&---------------------------------------------------------------------*
*& Report  Z_TH0701_FUCTION_4_CONCATE
*&
*&---------------------------------------------------------------------*
*& Written by TaeHyeong
*& Reporting date: `18.11.12
*&---------------------------------------------------------------------*
* 본인의 이름을 입력받아서, 기존에 있는 '나의이름:' 과 합친 문자열 형태를 출력해보자.
REPORT  z_th0701_fuction_4_concate.

DATA result TYPE char30.

PARAMETERS name TYPE char10.

START-OF-SELECTION.
  CONCATENATE '나의 이름:' name INTO result.
  write : / result.