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
FORM select_data.                                " 데이터 추출
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
    CREATE OBJECT container                        " 콘테이너 객체 생성
      EXPORTING
        container_name = 'THCONT1'.                " OBLIGATORY 필드인 container_name을 넣어준다.
     CREATE OBJECT grid.                            " 그리드 객체 생성
     EXPORTING
        i_parent = container.                      " OBLIGATROY 필드인 i_parent를 넣어줘서 해당 컨테이너와 연동한다.

     CALL METHOD grid->set_table_for_first_display  "ABAP Dictionary 혹은 사용자 지정 필드카탈로그를 must로 값을 줘야 그리드가 호출된다.
     EXPORTING
       i_structure_name = 'ZTHSOCCER'               "필드카탈로그 정의 : EXPORTING 의 i_structure_name값은 ABAP Dictionary에 있는 필드카탈로그를 참조하겠다는 뜻.(자동생성)
       CHANGING
         it_outtab = it_tab.
     ENDIF.



endmodule.                 " INIT_CONT  OUTPUT