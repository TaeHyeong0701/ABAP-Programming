*&---------------------------------------------------------------------*
*&  Include           Z_TH0701_ALV_2_GRIDALV_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
*& Written by TaeHyeong
*& Reporting Date `18.11.12
*----------------------------------------------------------------------
* New 기능을 활용하여, CREATE OBJECT 구문을 생략할 수 있음을 확인해보자.
* New는 NetWeaver 7.40 이상부터 지원하는 기능임.
* 본인이 다루는 프로그램은 ALV -> Z_TH0701_ALV_2_GRIDALV -> Z_TH0701_ALV_2_GRIDALV_F01 을 변형하여 만들었음.
* ---> 따라서 이 파일 만으로는 구동이 안됨. 
FORM select_data.
  SELECT *
    FROM zthsoccer INTO TABLE it_tab
    UP TO 10 ROWS.
ENDFORM.                    " SELECT_DATA
*&---------------------------------------------------------------------*
*&      Module  INIT_CONT  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module INIT_CONT output.

    IF container IS INITIAL.
*    CREATE OBJECT container                                               " 기존 코딩.
*      EXPORTING
*        container_name = 'THCONT1'.
     CREATE OBJECT grid
     EXPORTING
        i_parent = NEW cl_gui_custom_container( container_name = 'THCONT1' ). "New 구문으로 상위 주석처리된 문구들을 대체하였다.

     CALL METHOD grid->set_table_for_first_display  
     EXPORTING
       i_structure_name = 'ZTHSOCCER'               
       CHANGING
         it_outtab = it_tab.
     ENDIF.



endmodule.                 " INIT_CONT  OUTPUT