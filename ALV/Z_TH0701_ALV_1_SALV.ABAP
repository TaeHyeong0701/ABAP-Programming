*&---------------------------------------------------------------------*
*& Report  Z_TH0701_11_08_ALV_1
*&
*&---------------------------------------------------------------------*
*& 작성자: TaeHyeong Kim
*& 작성일시: `2018.11.12
*&---------------------------------------------------------------------*
* SALV. SIMPLE TEST
*
*----------------------------------------------------------------------
REPORT  Z_TH0701_ALV_1_SALV.

DATA: alv TYPE REF TO cl_salv_table,
      it_tab type TABLE OF zthsoccer.

SELECT * FROM zthsoccer into TABLE it_tab.


 cl_salv_table=>factory(
  importing r_salv_table = alv
    changing t_table = it_tab
  ).
 alv->display( ).
 alv->display( ).
