*&---------------------------------------------------------------------*
*& Report  Z_TH0701_FUNCTION_9_JUSTIFIED
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong Kim
*& Reporting Date: `18.12.2
*& Subject: Justified를 이용하여 앞의 5글자와 뒤의 5글자를 출력하라!
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_FUNCTION_9_JUSTIFIED.

DATA : bef_data(10) TYPE n,
      left_data(5) type n,                        " 앞의 5글자를 출력하게될 변수.
      right_data(5) TYPE n.                      " 뒤의 5글자를 출력하게될 변수.

bef_data = 1234567890.
WRITE bef_data to left_data LEFT-JUSTIFIED.
WRITE bef_data to right_data RIGHT-JUSTIFIED.
write : / bef_data.
WRITE : / left_data.                              " 12345 출력
WRITE : / right_data.                            " 67890 출력
