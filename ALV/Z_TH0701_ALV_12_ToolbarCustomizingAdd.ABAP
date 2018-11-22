*&---------------------------------------------------------------------*
*& Include ZSFR001_08_TOP                                    Report ZSFR001_08
*&
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*       CLASS alv_event_handler DEFINITION
*----------------------------------------------------------------------*
*                    
*----------------------------------------------------------------------*
CLASS alv_event_handler DEFINITION.
  PUBLIC SECTION.
*...
   METHODS:                                                                
      handle_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING e_object e_interactive,
    handle_user_command FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm.
*...
ENDCLASS.                    "lcl_event_receiver DEFINITION

*----------------------------------------------------------------------*
*       CLASS alv_event_handler IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS alv_event_handler IMPLEMENTATION.
*...

  METHOD handle_toolbar.                                                              "Application Toolbar Button add.

    DATA: ls_toolbar TYPE stb_button.

    CLEAR ls_toolbar.
    MOVE 0 TO ls_toolbar-butn_type.                  "Toolbar button type
    MOVE 'EXCELTH' TO ls_toolbar-function.            "Function code
    MOVE icon_xxl TO ls_toolbar-icon.           "icon*
    MOVE 'Download Excel Format to LOCAL Disk' TO ls_toolbar-quickinfo. "Quickinfo for an icon*
    MOVE ' ' TO ls_toolbar-disabled.                 "Disabled
    APPEND ls_toolbar TO e_object->mt_toolbar.


    CLEAR ls_toolbar.
    MOVE 0 TO ls_toolbar-butn_type.                  "Toolbar button type
    MOVE 'MAINTAINVIEW' TO ls_toolbar-function.            "Function code
    MOVE ICON_MODIFICATION_OVERVIEW TO ls_toolbar-icon.           "icon*
    MOVE 'Insert Data in Maintenance View' TO ls_toolbar-quickinfo. "Quickinfo for an icon*
    MOVE ' ' TO ls_toolbar-disabled.                 "Disabled
    APPEND ls_toolbar TO e_object->mt_toolbar.
  ENDMETHOD.                    "handle_toolbar


  METHOD handle_user_command.                                                          " UserCommand Control

    DATA: lt_rows TYPE lvc_t_row,
          ls_rows TYPE lvc_s_row.


    CASE e_ucomm.
      WHEN 'EXCELTH'.
        PERFORM excel.
        CLEAR e_ucomm.
        when 'MAINTAINVIEW'.
      PERFORM maintain_view.
              CLEAR e_ucomm.
    ENDCASE.
  ENDMETHOD.                    "handle_user_command
*...
ENDCLASS.                    "alv_event_handler IMPLEMENTATION


*&---------------------------------------------------------------------*
*&  Include           ZSFR001_08_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
  CREATE OBJECT alv_event_handler.                                
  SET HANDLER alv_event_handler->handle_hotspot_click FOR grid.
  SET HANDLER alv_event_handler->handle_toolbar FOR grid.                              " toolbar Register 등록.
  SET HANDLER alv_event_handler->handle_user_command FOR grid.                         " user_command Register 등록.