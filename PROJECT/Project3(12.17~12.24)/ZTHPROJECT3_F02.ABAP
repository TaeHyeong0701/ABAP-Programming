*&---------------------------------------------------------------------*
*&  Include           ZPPR0003_08_F02
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module INIT_SCREEN2 output.
  CREATE OBJECT container2
  EXPORTING
   CONTAINER_NAME = 'THCONT2'.
  CREATE OBJECT grid2
  EXPORTING
  i_parent = container2.

 PERFORM set_grid_layo_200 CHANGING ls_layo2.
 PERFORM set_grid_fcat_200 CHANGING lt_fcat2.

 CALL METHOD grid2->set_table_for_first_display
 CHANGING
  it_outtab = re_it_tab
  it_fieldcatalog = lt_fcat2.

 CLEAR LT_FCAT2.
endmodule.                 " INIT_SCREEN  OUTPUT
FORM set_grid_layo_200  CHANGING cs_layo TYPE lvc_s_layo.
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
*  cs_layo-excp_group  = 'LIGHT'.
  cs_layo-excp_fname  = 'LIGHT'.
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

*... ALV-Control: Eingabef#higkeit
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
FORM set_grid_fcat_200  CHANGING ct_fcat TYPE lvc_t_fcat.
*    CLEAR l_fcat.
  DATA: ls_fcat TYPE lvc_s_fcat. "필드 카탈로그 타입

  ls_fcat-fieldname = 'LIGHT'.
  ls_fcat-outputlen = '5'.
  ls_fcat-col_pos   = 1.
*  ls_fcat-convexit = 'ALPHA'.                     " ---> Insert.
  ls_fcat-scrtext_s = 'BDC데이터 입력 여부.'.
  APPEND ls_fcat TO ct_fcat.

  ls_fcat-fieldname = 'MATNR'.
  ls_fcat-outputlen = 8.
  ls_fcat-col_pos   = 1.
*  ls_fcat-convexit = 'ALPHA'.                     " ---> Insert.
  ls_fcat-scrtext_s = '자재번호'.
  APPEND ls_fcat TO ct_fcat.


  CLEAR ls_fcat.
  ls_fcat-fieldname = 'WERKS'.
  ls_fcat-outputlen = 8.
  ls_fcat-col_pos   = '1'.
  ls_fcat-scrtext_s = '플랜트'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'ERSDA'.
  ls_fcat-outputlen = 8.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '시작일'.
      ls_fcat-EMPHASIZE = 'C119'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'LAEDA'.
  ls_fcat-outputlen = 8.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '종료일'.
      ls_fcat-EMPHASIZE = 'C119'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'DAY1'.
  ls_fcat-outputlen = 5.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '1 작업일'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'DAY2'.
  ls_fcat-outputlen = 5.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '2 작업일'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'DAY3'.
  ls_fcat-DO_SUM =  'X'.
  ls_fcat-outputlen = 5.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '3 작업일'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.


  ls_fcat-fieldname = 'DAY4'.
  ls_fcat-outputlen = 5.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '4 작업일'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'DAY5'.
  ls_fcat-outputlen = 5.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '5 작업일'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'DAY6'.
  ls_fcat-outputlen = 5.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '6 작업일'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'DAY7'.
  ls_fcat-outputlen = 5.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '7 작업일'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'TEXT'.
  ls_fcat-outputlen = 20.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '에러내용'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
ENDFORM.                           "SET_GRID_FCAT_100
*&---------------------------------------------------------------------*
*&      Form  SYNC2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form SYNC2 .
***********************************************************************
* 데이터 전송: 메인 인터널 테이블 ---> 결과 ALV 인터널 테이블.
***********************************************************************
  Loop at it_tab INTO wa_tab.
    MOVE-CORRESPONDING wa_tab to re_wa_Tab.
    APPEND re_wa_tab to re_it_Tab.
    clear re_Wa_tab.
   ENDLOOP.

endform.                    " SYNC2

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
