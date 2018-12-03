*&---------------------------------------------------------------------*
*& Report  Z_TH0701_CONDENSE
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeongKim
*& Reporting Date: `18.12.03
*& Subject: Verify 'Condense' Command.
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_CONDENSE.

DATA : test1 TYPE string,
      test2 TYPE string,
      test3 TYPE string.
************************************************************************
*    공백이 좌우 측에 포함된 test1 값 설정                             *
************************************************************************
 test1 = '        가나다라마바사ABCDEF          '.
 WRITE : / test1.
 CONDENSE test1.
 WRITE : / test1.
 test2 = '12345'.
 CONCATENATE test1 test2 inTO test3.
 write : / test3.