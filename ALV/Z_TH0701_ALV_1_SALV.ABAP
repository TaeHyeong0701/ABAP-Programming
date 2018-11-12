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

DATA: alv TYPE REF TO cl_salv_table,                                     "cl_salv_table 클래스를 참조한다.
      it_tab type TABLE OF zthsoccer.

SELECT * FROM zthsoccer into TABLE it_tab.                               "인터널 테이블에 값을 넣어준다.


 cl_salv_table=>factory(
  importing r_salv_table = alv                                           " 사전에 정의한 alv를 r_salv_table에 넣어준다.
    changing t_table = it_tab                                            " 인터널 테이블을 삽입해준다.
  ).
 alv->display( ).                                                        " 화면을 뿌려준다.