*&---------------------------------------------------------------------*
*& Include Z_TH0701_COLOR_ROW2_TOP                           Report Z_TH0701_COLOR_ROW2
*&
*&---------------------------------------------------------------------*

REPORT   Z_TH0701_COLOR_ROW2.
DATA : BEGIN OF gs_tab.
        INCLUDE STRUCTURE pa0001.
DATA: stext TYPE stext,
      ddtext TYPE dd07t-ddtext,
      linecolor(4) TYPE C,                " 1. 칼러 변수 선언.
      END OF gs_tab,
      gt_tab LIKE TABLE OF gs_tab.


*&---------------------------------------------------------------------*
*&  Include           Z_TH0701_COLOR_ROW2_F01
*&---------------------------------------------------------------------*
  LOOP AT it_tab INTO wa_tab.
modi_row = sy-tabix MOD 2.
  *case modi_row.
    when 1.
    wa_tab-color = 'C210'.
      when 0.
      wa_tab-color = 'C200'.
      ENDcase.

      MODIFY it_tab FROM wa_tab.
  ENDLOOP.


*&---------------------------------------------------------------------*
*&      Form  set_grid_layo
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->CS_LAYO    text
*----------------------------------------------------------------------*

*... ALV-Control: Farben
    cs_layo-info_fname  = 'LINECOLOR'.          "3. info_fname(lvc_s_layo 에서 해당 로우의 색깔을 컨트롤하는 필드에 칼러 변수를 삽입)
    cs_layo-ctab_fname  = space.

*&---------------------------------------------------------------------*
*&      Module  INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
  CALL METHOD grid->set_table_for_first_display
    EXPORTING
    is_layout = ls_layo                                  "4. 설정된 필드카탈로그 레이아웃을 호출.
    CHANGING
      it_fieldcatalog = lt_fcat
      it_outtab       = it_tab.
