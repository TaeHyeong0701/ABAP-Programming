*&---------------------------------------------------------------------*
*& Report  Z_TH0701_MATH
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong
*& Reporting Date: `18.12.04
*& Subject: Round, Ceil, Floor
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_MATH.
DATA : num1 TYPE p DECIMALS 2 VALUE '10.23',
      result TYPE p DECIMALS 2.
*result = num1 ** num2.
CALL FUNCTION 'FIMA_NUMERICAL_VALUE_ROUND'
 EXPORTING  I_RTYPE = '+'                 " 반올림 ' ' ,올림 '+' , 버림 '-' 구분
I_RUNIT = '0.1'                          " 도출한 결과값을 어느자리까지 반영하겠느냐? 0.1 ---> 소수 둘 째자리 수를 기준으로 판단한다.
I_VALUE = num1
IMPORTING E_VALUE_RND = result.

write : result.