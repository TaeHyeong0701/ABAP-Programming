*&---------------------------------------------------------------------*
*& Include Z_TH_MINI_PROJECT1_2_TOP                          Report Z_TH_MINI_PROJECT1_2
*&
*&---------------------------------------------------------------------*

REPORT   Z_TH_MINI_PROJECT1_2 .

*data : matnr TYPE ZSFT00108-matnr.
TABLES : zsft00108.
DATA : sort_matnr TYPE i.
DATA : gt_exclude  TYPE ui_functions.                                                "1. Grid Application Toolbar Control Å¸ÀÔ ¼±¾ð!


DATA : p_e_ucomm TYPE sy-ucomm.
*-----------------------------------------------------------------------------exc
DATA: lv_file TYPE filetable,
      rc TYPE i.
DATA: file_path TYPE string.
DATA : result_filename TYPE string.
DATA: file_name TYPE string.
DATA: lr_columns    TYPE REF TO cl_salv_columns_table,
      lr_column     TYPE REF TO cl_salv_column_table.
DATA: r_salv TYPE REF TO cl_salv_table.
*PARAMETERS: p_file TYPE string DEFAULT 'C:/'.
*-----------------------------------------------------------------------------exc
*DATA : CL_CFX_TEXT_FINDER TYPE REF TO CL_CFX_TEXT_FINDER.
*--------------------------------------------------------------------------------
FIELD-SYMBOLS <filename>.

DATA : BEGIN OF gs_tab.
        INCLUDE STRUCTURE zsft00108.
DATA : mtbez TYPE t134t-mtbez,
      wgbez TYPE t023t-wgbez,
*      icon(4) type c,
      linecolor(4) TYPE c,
      colum_color(4) TYPE c,
      END OF gs_tab.

DATA : it_tab LIKE TABLE OF gs_tab,
      wa_tab LIKE LINE OF it_tab.

DATA : container TYPE REF TO cl_gui_custom_container,
       grid TYPE REF TO cl_gui_alv_grid,
       ok_code TYPE sy-ucomm.
DATA: ls_layo TYPE lvc_s_layo,
     lt_fcat TYPE lvc_t_fcat.

DATA : it_t134t_tab TYPE TABLE OF t134t,
      wa_t134t_tab LIKE LINE OF it_t134t_tab,
      it_t023t_tab TYPE TABLE OF t023t,
      wa_t023t_tab LIKE LINE OF it_t023t_tab.

SELECTION-SCREEN BEGIN OF BLOCK block-1 WITH FRAME TITLE text-001.
SELECTION-SCREEN: BEGIN OF LINE,
COMMENT (8) text-003.
  SELECT-OPTIONS: th_matnr FOR zsft00108-matnr.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
COMMENT (8) text-004.
  SELECT-OPTIONS:  th_matkl FOR zsft00108-matkl .
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
COMMENT (8) text-005.
  SELECT-OPTIONS: th_mtart FOR zsft00108-mtart .
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK block-1.

SELECTION-SCREEN BEGIN OF BLOCK block-2 WITH FRAME TITLE text-002.
SELECTION-SCREEN: BEGIN OF LINE,
COMMENT (8) text-006.
  SELECT-OPTIONS: th_laeda FOR zsft00108-mtart  .
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN: BEGIN OF LINE,

COMMENT (8) text-007.
  SELECT-OPTIONS: th_aenam FOR zsft00108-mtart  .
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK block-2.
*----------------------------------------------------------------------*
*       CLASS alv_event_handler DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS alv_event_handler DEFINITION.
  PUBLIC SECTION.
    METHODS: handle_hotspot_click FOR EVENT hotspot_click OF
                            cl_gui_alv_grid
                            IMPORTING e_column_id
                                               es_row_no.
    METHODS:
      handle_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING e_object e_interactive,
    handle_user_command FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm.


ENDCLASS.                    "lcl_event_receiver DEFINITION

*----------------------------------------------------------------------*
*       CLASS alv_event_handler IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS alv_event_handler IMPLEMENTATION.
  METHOD: handle_hotspot_click.
    PERFORM handle_click USING e_column_id
                                           es_row_no.
  ENDMETHOD.                    "handle_hotspot_click
  METHOD handle_toolbar.

    DATA: ls_toolbar TYPE stb_button.

    CLEAR ls_toolbar.
    MOVE 0 TO ls_toolbar-butn_type.                  "Toolbar button type
    MOVE 'EXCELTH' TO ls_toolbar-function.            "Function code
    MOVE icon_xls TO ls_toolbar-icon.           "icon*
    MOVE 'Download Excel Format to LOCAL Disk' TO ls_toolbar-quickinfo. "Quickinfo for an icon*
    MOVE ' ' TO ls_toolbar-disabled.                 "Disabled
    MOVE '¿¢¼¿´Ù¿î' TO ls_toolbar-TEXT.
    APPEND ls_toolbar TO e_object->mt_toolbar.


    CLEAR ls_toolbar.
    MOVE 0 TO ls_toolbar-butn_type.                  "Toolbar button type
    MOVE 'MAINTAINVIEW' TO ls_toolbar-function.            "Function code
    MOVE ICON_MODIFICATION_OVERVIEW TO ls_toolbar-icon.           "icon*
    MOVE 'Insert Data in Maintenance View' TO ls_toolbar-quickinfo. "Quickinfo for an icon*
    MOVE ' ' TO ls_toolbar-disabled.                 "Disabled
    APPEND ls_toolbar TO e_object->mt_toolbar.
  ENDMETHOD.                    "handle_toolbar
  METHOD handle_user_command.                        "

    DATA: lt_rows TYPE lvc_t_row,
          ls_rows TYPE lvc_s_row.


    CASE e_ucomm.
      WHEN 'EXCELTH'.
        PERFORM excel.
        CLEAR e_ucomm.
        when 'MAINTAINVIEW'.
      PERFORM maintain_view.
              CLEAR e_ucomm.
                    WHEN 'EXCELTH'.
        PERFORM excel.
    ENDCASE.
  ENDMETHOD.                    "handle_user_command
ENDCLASS.                    "alv_event_handler IMPLEMENTATION
*&---------------------------------------------------------------------*
*&      Form  handle_click
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_COLUMN   text
*      -->PS_ROW_NO  text
*----------------------------------------------------------------------*
FORM handle_click  USING    p_column
                        ps_row_no TYPE lvc_s_roid.
  READ TABLE it_tab INTO wa_tab INDEX ps_row_no-row_id.

  IF p_column = 'MATNR'.
    SET PARAMETER ID 'ZTHMATNR' FIELD wa_tab.
    CALL TRANSACTION 'ZSAPMZSF002_08'.
  ENDIF.

ENDFORM.                    " HANDLE_CLICK
*&---------------------------------------------------------------------*
**&      Form  MAINTAIN_VIEW
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*form MAINTAIN_VIEW .
**CALL TRANSACTION ZSAPMZSFV003_08.
*endform.                    " MAINTAIN_VIEW

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
