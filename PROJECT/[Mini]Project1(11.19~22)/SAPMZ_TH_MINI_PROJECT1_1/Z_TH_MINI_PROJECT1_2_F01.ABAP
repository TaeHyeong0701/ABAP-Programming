*&---------------------------------------------------------------------*
*&  Include           Z_TH_MINI_PROJECT1_2_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  FETCH_REPORT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fetch_report .
  SELECT *
    FROM zsft00108 INTO CORRESPONDING FIELDS OF TABLE it_tab
    WHERE matnr IN th_matnr
    AND matkl IN th_matkl
    AND mtart IN th_mtart.
*-------------------------------------------------------------------------------mtbez가져오기
  SELECT *
    FROM t134t INTO TABLE it_t134t_tab
    FOR ALL ENTRIES IN it_tab
    WHERE mtart = it_tab-mtart
    AND spras = sy-langu.

  LOOP AT it_tab INTO wa_tab.
    READ TABLE it_t134t_tab INTO wa_t134t_tab WITH KEY mtart = wa_tab-mtart.
    IF sy-subrc = 0.
      wa_tab-mtbez = wa_t134t_tab-mtbez.
    ENDIF.
    MODIFY it_tab FROM wa_tab.
  ENDLOOP.

*-------------------------------------------------------------------------------wgbez가져오기.
  SELECT *
    FROM t023t INTO TABLE it_t023t_tab
    FOR ALL ENTRIES IN it_tab
    WHERE matkl = it_tab-matkl
        AND spras = sy-langu.

  LOOP AT it_tab INTO wa_tab.
    READ TABLE it_t023t_tab INTO wa_t023t_tab WITH KEY matkl = wa_tab-matkl.
    IF sy-subrc = 0.
      wa_tab-wgbez = wa_t023t_tab-wgbez.
    ENDIF.
    MODIFY it_tab FROM wa_tab.
  ENDLOOP.


ENDFORM.                    " FETCH_REPORT
*&---------------------------------------------------------------------*
*&      Module  INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init_screen OUTPUT.
  DATA : alv_event_handler TYPE REF TO alv_event_handler.
  PERFORM exclude_functions CHANGING gt_exclude.                           "3. Grid Application Toolbar Control 실행.



*  IF sort_matnr = 0.
*  SORT it_tab BY matnr ASCENDING.
*  ELSE.
*  SORT it_tab BY matnr DESCENDING.
*  ENDIF.
  CREATE OBJECT container
    EXPORTING
      container_name = 'THCONT1'.
  CREATE OBJECT grid
    EXPORTING
      i_parent = container.
  CREATE OBJECT alv_event_handler.                                " 5. 객체 생성.
  SET HANDLER alv_event_handler->handle_hotspot_click FOR grid.
  SET HANDLER alv_event_handler->handle_toolbar FOR grid.
  SET HANDLER alv_event_handler->handle_user_command FOR grid.
  PERFORM set_grid_layo_100 CHANGING ls_layo.
  PERFORM set_grid_fcat_100 CHANGING lt_fcat.
  CALL METHOD grid->set_table_for_first_display
    EXPORTING
*      i_structure_name = 'HRP1000'
   is_layout = ls_layo
   it_toolbar_excluding = gt_exclude                             "6. Application Toolbar Control 제외된 목록들 포함.
    CHANGING
      it_outtab        = it_tab
      it_fieldcatalog  = lt_fcat.


ENDMODULE.                 " INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'CANCEL' OR 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.               " EXIT  INPUT
ENDMODULE.                 " EXIT  INPUT
*&---------------------------------------------------------------------*
*&      Form  set_grid_layo_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->CS_LAYO    text
*----------------------------------------------------------------------*
FORM set_grid_layo_100  CHANGING cs_layo TYPE lvc_s_layo.
*... ALV-Control: Allgemeine Anzeigeoptionen
  cs_layo-stylefname  = 'X'.

  cs_layo-cwidth_opt  = space.
  cs_layo-zebra       = 'X'.                                                "줄별 음영표시. 연속된 데이터 헷갈림 방지.
  cs_layo-smalltitle  = space.
  cs_layo-graphics    = space.
  cs_layo-frontend    = space.
  cs_layo-template    = space.

*... ALV-Control: Gridcustomizing
  cs_layo-no_colexpd  = space.
  cs_layo-no_hgridln  = space.
  cs_layo-no_vgridln  = space.
  cs_layo-no_rowmark  = space.
  cs_layo-no_headers  = space.
  cs_layo-no_merging  = space.
  cs_layo-grid_title  = space.

  cs_layo-no_toolbar  = space.                                "2. Grid Application Toolbar Control. --> 확인해준다.

  cs_layo-sel_mode    = space.

  cs_layo-box_fname   = space.

  cs_layo-sgl_clk_hd  = space.

*... ALV-Control: Summenoptionen
  cs_layo-totals_bef  = space.
  cs_layo-no_totline  = space.
  cs_layo-numc_total  = space.
  cs_layo-no_utsplit  = space.

*... ALV-Control: Exceptions
*  cs_layo-excp_group  = gs_test-excp_group.
*  cs_layo-excp_fname  = 'LIGHTS'.
*  cs_layo-excp_rolln  = space.
*  cs_layo-excp_conds  = gs_test-excp_condense.
*  cs_layo-excp_led    = gs_test-excp_led.

*... ALV-Control: Steuerung Interaktion
  cs_layo-detailinit  = space.
  cs_layo-detailtitl  = space.
  cs_layo-keyhot      = space.
  cs_layo-no_keyfix   = space.
  cs_layo-no_author   = space.
  CLEAR cs_layo-s_dragdrop.

*... ALV-Control: Farben
  cs_layo-info_fname  = space.
  cs_layo-ctab_fname  = space.

*... ALV-Control: Eingabefahigkeit
  cs_layo-edit        = space.
  cs_layo-edit_mode   = space.

  cs_layo-no_rowins   = space.
  cs_layo-no_rowmove  = space.

*... ALV-Control: Web-Optionen
  cs_layo-weblook     = space.
  cs_layo-webstyle    = space.
  cs_layo-webrows     = space.
  cs_layo-webxwidth   = space.
  cs_layo-webxheight  = space.
ENDFORM.                    " SET_GRID_LAYO_100
*&---------------------------------------------------------------------*
*&      Form  set_grid_fcat_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->CT_FCAT    text
*----------------------------------------------------------------------*
FORM set_grid_fcat_100  CHANGING ct_fcat TYPE lvc_t_fcat.
*    CLEAR l_fcat.
  DATA: ls_fcat TYPE lvc_s_fcat. "필드 카탈로그 타입

  ls_fcat-fieldname = 'MATNR'.
  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '자재번호'.
  ls_fcat-emphasize = 'C100'.
  ls_fcat-hotspot = 'X'.
*  ls_fcat-ref_table = 'HRP1000'.
*  ls_fcat-ref_field = 'o'.

*  ls_fcat-scrtext_s = 'OBJID'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'MAKTX'.
  ls_fcat-outputlen = 15.
  ls_fcat-col_pos   = '1'.
  ls_fcat-scrtext_s = '자재이름'.
  ls_fcat-emphasize = 'C100'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'MTART'.
  ls_fcat-outputlen = 6.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '자재유형'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'MTBEZ'.
  ls_fcat-outputlen = 14.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '자재유형명'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'MATKL'.
  ls_fcat-outputlen = 8.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '자재그룹'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'WGBEZ'.
  ls_fcat-outputlen = 12.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '자재그룹명'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'ERSDA'.
*  ls_fcat-outputlen = 14.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '생성일'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'ERNAM'.
*  ls_fcat-outputlen = 12.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '생성자'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'LAEDA'.
*  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '변경일'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'AENAM'.
*  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '변경자'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
ENDFORM.                           "SET_GRID_FCAT_100

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
*       text
*----------------------------------------------------------------------*
*      -->PT_EXCLUDE text
*----------------------------------------------------------------------*
FORM append_exclude_functions  TABLES pt_table
                                USING p_value.

  DATA ls_exclude TYPE ui_func.
  ls_exclude = p_value.
  APPEND ls_exclude TO pt_table.

ENDFORM.                    " APPEND_EXCLUDE_FUNCTIONS
************************************************************************
*
*                            F01
*
*&---------------------------------------------------------------------*
*&      Form  excel
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM excel.
  CALL METHOD cl_gui_frontend_services=>file_save_dialog                "
    CHANGING
      path = file_path                                                  "
      fullpath = result_filename                                        "
       filename = file_name.                                            "
  CALL METHOD cl_gui_frontend_services=>gui_download                    "
    EXPORTING
      filename              = file_name                                 "
      write_field_separator = 'X'                                       "
*      FILETYPE = 'XLS'
    CHANGING
      data_tab              = it_tab.                                   "


ENDFORM.                    "excel

FORM maintain_view.
  CALL TRANSACTION 'Z_TH_MINI_TVIEW'.

ENDFORM.