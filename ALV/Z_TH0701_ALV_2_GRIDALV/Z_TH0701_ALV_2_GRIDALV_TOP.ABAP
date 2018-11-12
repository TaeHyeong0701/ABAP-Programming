*&---------------------------------------------------------------------*
*& Include Z_TH0701_ALV_2_GRIDALV_TOP                        Report Z_TH0701_ALV_2_GRIDALV
*&
*&---------------------------------------------------------------------*

REPORT   Z_TH0701_ALV_2_GRIDALV.
TABLES zthsoccer.
DATA : container TYPE REF TO cl_gui_custom_container,            "컨테이너 선언. ---> cl_gui_custom_container 클래스 참조.
       grid TYPE REF TO cl_gui_alv_grid,                         "그리드 선언.  ---> cl_gui_alv_grid 클래스 참조.
       it_tab TYPE TABLE OF zthsoccer,                           "값을 담아줄 인터널 테이블 변수 선언.
       ok_code TYPE sy-ucomm.                                     "클릭 변수 지정.