*&---------------------------------------------------------------------*
*&  Include           ZPPR003_08_F01
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Module  INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module INIT_SCREEN output.
*  DATA : alv_event_handler TYPE REF TO alv_event_handler.
CREATE OBJECT container
EXPORTING
  container_name = 'THCONT1'.

CREATE OBJECT grid
EXPORTING
  i_parent = container.

 PERFORM set_grid_layo_100 CHANGING ls_layo.
 PERFORM set_grid_fcat_100 CHANGING lt_fcat.
* PERFORM set_grid_sort_100 CHANGING lt_t_sort.

* CREATE OBJECT alv_event_handler.
*  SET HANDLER alv_event_handler->handle_toolbar FOR grid.                              " toolbar Register 등록.
*  SET HANDLER alv_event_handler->handle_user_command FOR grid.                         " user_command Register 등록.

CALL METHOD grid->set_table_for_first_display
CHANGING
  it_outtab = it_tab
  it_fieldcatalog = lt_fcat.
*****************************************************************************
* Default Sort Condition Insert                                             *
*****************************************************************************
*  it_sort = lt_t_sort.

endmodule.                 " INIT_SCREEN  OUTPUT

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
FORM set_grid_fcat_100  CHANGING ct_fcat TYPE lvc_t_fcat.
*    CLEAR l_fcat.
  DATA: ls_fcat TYPE lvc_s_fcat. "필드 카탈로그 타입

  ls_fcat-fieldname = 'AUFNR'.
  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = 1.
*************************************************************************
* Converexit변수에 Convers Routine값을 넣어서 출력 형태를 맞춰준다.     *
*************************************************************************
  ls_fcat-convexit = 'ALPHA'.                     " ---> Insert.
  ls_fcat-scrtext_s = '생산오더'.
  APPEND ls_fcat TO ct_fcat.

*  ls_fcat-scrtext_s = 'OBJID'.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'WERKS'.
  ls_fcat-outputlen = 15.
  ls_fcat-col_pos   = '1'.
  ls_fcat-scrtext_s = '플랜트'.
*  ls_fcat-emphasize = 'C100'.
*  ls_fcat-emphasize = 'C100'.
*  ls_fcat-hotspot = 'X'.
*  ls_fcat-ref_table = 'HRP1000'.
*  ls_fcat-ref_field = 'o'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'PLNBEZ'.
  ls_fcat-outputlen = 10.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '제품코드'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'VORNR'.
  ls_fcat-outputlen = 14.
  ls_fcat-col_pos   = 1.
    ls_fcat-convexit = 'ALPHA'.
  ls_fcat-scrtext_s = '공정번호'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'ARBPL'.
  ls_fcat-outputlen = 8.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '작업장'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'LTXA1'.
  ls_fcat-outputlen = 25.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '공정내역'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'GAMNG'.
*  ls_fcat-outputlen = 14.
*************************************************************************
* Q_FIELDNAME에 단위 값을 적용하여, 수량 단위를 맞춰준다.               *
*************************************************************************
  ls_fcat-qfieldname = 'GMEIN'.
*************************************************************************
* DO_SUM 필드를 체크하여, 최종 합계를 구하도록 ALV를 구현한다           *
*************************************************************************
  ls_fcat-DO_SUM =  'X'.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '오더수량'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'GMEIN'.
*  ls_fcat-outputlen = 12.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '단위'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'GSTRP'.
*  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '생산시작일'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'GLTRP'.
*  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '생산종료일'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
ENDFORM.                           "SET_GRID_FCAT_100
*&---------------------------------------------------------------------*
*&      Form  EXCEL_UPLOAD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form EXCEL_UPLOAD .
  CALL FUNCTION 'KCD_EXCEL_OLE_TO_INT_CONVERT'
    EXPORTING
      filename                = p_fname
      i_begin_col             = gv_start_col
      i_begin_row             = gv_start_row
      i_end_col               = gv_end_col
      i_end_row               = gv_end_row
    TABLES
      intern                  = gt_data
    EXCEPTIONS
      inconsistent_parameters = 1
      upload_ole              = 2
      OTHERS                  = 3.

  LOOP AT gt_data.
    MOVE gt_data-col TO gv_index.
    ASSIGN COMPONENT gv_index OF STRUCTURE wa_tab TO <gv_fs>.   "gt_itab의 gv_index 에 해당되는 칼럼들을 필드 심볼에 할당해준다.
    MOVE gt_data-value TO <gv_fs>.                               "gt_data엑셀의 칼럼값들을 gt_itab의 gv_index에 해당하는 필드심볼에 값을 집어넣어준다.

    AT END OF row.                                               " 행이 끝난다면
      APPEND wa_tab to it_tab.                                            " APPEND 해라.
      CLEAR  wa_tab.
    ENDAT.
  ENDLOOP.

endform.                    " EXCEL_UPLOAD

*----------------------------------------------------------------------*
*        Start new screen                                              *        ---> 필수 2. 스크린의 동기화하는 로직.
*----------------------------------------------------------------------*
FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR BDCDATA.
  BDCDATA-PROGRAM  = PROGRAM.
  BDCDATA-DYNPRO   = DYNPRO.
  BDCDATA-DYNBEGIN = 'X'.
  APPEND BDCDATA.
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *        ---> 필수 3. 필드 데이터를 입력하는 로직.
*----------------------------------------------------------------------*
FORM BDC_FIELD USING FNAM FVAL.
*  IF FVAL <> NODATA.
    CLEAR BDCDATA.
    BDCDATA-FNAM = FNAM.
    BDCDATA-FVAL = FVAL.
    APPEND BDCDATA.
*  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  BDC_CO11N
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form BDC_CO11N .

DATA l_qty(10) TYPE c.
loop at it_tab into wa_Tab.
      REFRESH messtab.
    REFRESH bdcdata.


********************************************************************
*  액션 로직.                                                      *
*  1. 엔터를 나중에 쳤다고 해서 순차적으로 저장되는 것은 아니다.   *
*  2. 트랜잭션도 마찬가지다.                                       *
********************************************************************
********************************************************************
*  First Screen.                                                   *
********************************************************************
perform bdc_dynpro      using 'SAPLCORU_S' '0100'.                     " CO11N에 해당하는 프로그램 호출.


perform bdc_field       using 'BDC_OKCODE'                             " 엔터를 입력.
                              '/00'.

perform bdc_field       using 'AFRUD-AUFNR'                            " 생산오더 입력 유지
                              WA_tab-AUFNR.                            " 인터널 테이블에 생산오더가 들어가도록 한다.

perform bdc_field       using 'AFRUD-VORNR'                            " 공정번호 입력하는것 유지
                              WA_tab-VORNR.
********************************************************************
*  Second Screen.                                                  *
********************************************************************
perform bdc_dynpro      using 'SAPLCORU_S' '0100'.                     "  ---> 엔터를 치면 프로그램을 다시 호출된다. 스크린이 다시 호출되기 때문에

perform bdc_field       using 'BDC_OKCODE'                             " 저장버튼
                              '=BU'.

WRITE wa_tab-gamng TO l_qty LEFT-JUSTIFIED.
perform bdc_field       using 'AFRUD-LMNGA'                            " Yield 수량  ---> 타입 뻑나서 뺏음.
                              l_qty.


* <=========================시간 관련된 값들=========================>

*perform bdc_field       using 'AFRUD-ISM01'                           " Setup 시간 / 분
*                              record-ISM01_012.
*perform bdc_field       using 'AFRUD-ILE01'
*                              'MIN'.

*perform bdc_field       using 'AFRUD-ISM02'                           " Labor 시간 / 분
*                              record-ISM02_14.
*perform bdc_field       using 'AFRUD-ILE02'
*                              'MIN'.


*    REFRESH MESSTAB.
    CALL TRANSACTION 'CO11N' USING BDCDATA
                     MODE   p_mode                                        " 모든 N(BDC를 수행하다가 오류가 나더라도 넘어가라)이나 A(하나하나 다 보여주는 것)냐 E냐
                     UPDATE 'S'                                        " 업데이트 옵션: S(동시에)냐, A(레코딩 끝나고 데이터베이스에 업데이트를 나중에 해라)냐, L이냐
                     MESSAGES INTO MESSTAB.
*perform bdc_transaction using 'CO11N'.
ENDLOOP.
endform.                    " BDC_CO11N

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
