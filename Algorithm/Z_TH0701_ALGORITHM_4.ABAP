*&---------------------------------------------------------------------*
*& Report  Z_TH0701_GCDLCM
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
*************************************************************************
*Scenario 1. 사용자로부터 2개의 숫자를 입력받는다.
*         2. 2개의 숫자에 대한 최대공약수(GCD) 및 최소공배수(LCM)을 출력한다.
*
*
*************************************************************************
REPORT  z_th0701_gcdlcm.

PARAMETERS : num1 TYPE i,
             num2 TYPE i.

DATA : gcd TYPE i VALUE 1,
      lcm TYPE i VALUE 1,
      number TYPE i,
      iden1 TYPE i,
      iden2 TYPE i.

IF num1 >= num2.
  gcd = num2.
ELSE.
  gcd = num1.
ENDIF.

DO.
  iden1 = num1 MOD gcd.
  iden2 = num2 MOD gcd.
  IF iden1 = 0 AND iden2 = 0.
    EXIT.
  ELSE.
    gcd = gcd - 1.
  ENDIF.
ENDDO.
*****************************************************************************
IF num1 >= num2.
  lcm = num1.
ELSE.
  lcm = num2.
ENDIF.

DO.
  iden1 = lcm MOD num1.
  iden2 = lcm MOD num2.
  IF iden1 = 0 AND iden2 = 0.
    EXIT.
  ELSE.
    lcm = lcm + 1.
  ENDIF.
ENDDO.


WRITE : / '최대공약수는', gcd,'이며, 최소공배수는 ', lcm, '입니다.'.