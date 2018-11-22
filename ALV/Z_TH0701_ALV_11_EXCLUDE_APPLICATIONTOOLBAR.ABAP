*&---------------------------------------------------------------------*
*& Include ZSFR001_08_TOP                                    Report ZSFR001_08
*&
*&---------------------------------------------------------------------*
*...
DATA : gt_exclude  TYPE ui_functions.                                                "1. Grid Application Toolbar Control 타입 선언!
                                                                                     "   ---> 제외하는 값들을 담아줄 인터널 테이블.
*...

*&---------------------------------------------------------------------*
*&      Form  set_grid_layo_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->CS_LAYO    text
*----------------------------------------------------------------------*
*...
  cs_layo-no_toolbar  = SPACE.                                                        "2. Grid Application Toolbar Control. --> 확인해줘서, 스탠다드형을 받아올 수 있게 해준다.
*...

*&---------------------------------------------------------------------*
*&      Module  INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init_screen OUTPUT.
  DATA : alv_event_handler TYPE REF TO alv_event_handler.
  PERFORM EXCLUDE_FUNCTIONS CHANGING GT_EXCLUDE.                                      "3-1. Grid Application Toolbar 제외 로직 실행.

*...

  CALL METHOD grid->set_table_for_first_display
    EXPORTING
   is_layout = ls_layo
   IT_TOOLBAR_EXCLUDING = GT_EXCLUDE                                                  "4. 제외된 목록들을 툴바에서 제외시키는 것을 실행.

*&---------------------------------------------------------------------*
*&      Form  EXCLUDE_FUNCTIONS
*&---------------------------------------------------------------------* 
*       text                                                                          "3-2. 제외테이블(PT_EXCLUDE ---> GT_EXCLUDE) 포함될 목록들 반영시킨다.
*----------------------------------------------------------------------*
*      -->PT_EXCLUDE text
*----------------------------------------------------------------------*

FORM EXCLUDE_FUNCTIONS CHANGING PT_EXCLUDE TYPE UI_FUNCTIONS.                      
 REFRESH: PT_EXCLUDE.                                                                 

  PERFORM APPEND_EXCLUDE_FUNCTIONS TABLES PT_EXCLUDE USING:                         
             CL_GUI_ALV_GRID=>MC_FC_LOC_UNDO,
             CL_GUI_ALV_GRID=>MC_FC_DETAIL,
             CL_GUI_ALV_GRID=>MC_FC_GRAPH,
             CL_GUI_ALV_GRID=>MC_FC_HELP,
             CL_GUI_ALV_GRID=>MC_FC_INFO,
             CL_GUI_ALV_GRID=>MC_FC_REFRESH,
             CL_GUI_ALV_GRID=>MC_FC_SELECT_ALL,
             CL_GUI_ALV_GRID=>MC_FC_DESELECT_ALL,
             CL_GUI_ALV_GRID=>MC_FC_LOC_COPY,
             CL_GUI_ALV_GRID=>MC_FC_HTML,
             CL_GUI_ALV_GRID=>MC_FC_LOC_COPY_ROW,
             CL_GUI_ALV_GRID=>MC_FC_LOC_CUT,
             CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW,
             CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW,
             CL_GUI_ALV_GRID=>MC_FC_LOC_MOVE_ROW,
             CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW,
             CL_GUI_ALV_GRID=>MC_FC_LOC_PASTE,
             CL_GUI_ALV_GRID=>MC_FC_LOC_PASTE_NEW_ROW,
  CL_GUI_ALV_GRID=>MC_MB_EXPORT,
  CL_GUI_ALV_GRID=>MC_FC_PRINT,
  CL_GUI_ALV_GRID=>MC_FC_VIEWS.
ENDFORM.                    "exclude_functions

*&---------------------------------------------------------------------*
*&      Form  append_exclude_functions
*&---------------------------------------------------------------------* 
*       text                                                                          "3-3. 제외 인터널 테이블에 하나하나 씩 추가해준다.
*----------------------------------------------------------------------*
*      -->PT_EXCLUDE text
*----------------------------------------------------------------------*
FORM append_exclude_functions  TABLES pt_table
                                USING p_value.

  DATA ls_exclude TYPE ui_func.
  ls_exclude = p_value.
  APPEND ls_exclude TO pt_table.

ENDFORM.                    " APPEND_EXCLUDE_FUNCTIONS

