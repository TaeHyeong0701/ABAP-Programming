*&---------------------------------------------------------------------*
*&  Include           ZPPR0003_08_F01
*&---------------------------------------------------------------------*
FORM excel_upload .
  CLEAR it_tab.
  CLEAR wa_tab.
  CLEAR re_it_tab.
  CLEAR re_wa_tab.
  CLEAR alv_it_tab.
  CLEAR alv_wa_tab.
***********************************************************************
*  엑셀 데이터 ---> 인터널 테이블(1행, 1칼럼씩)
***********************************************************************
  CALL FUNCTION 'KCD_EXCEL_OLE_TO_INT_CONVERT'
    EXPORTING
      filename                = filepath
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
    MOVE gt_data-col TO gv_index.                                " gt_data-col의 값을 gv_index로 변환한다.

    ASSIGN COMPONENT gv_index OF STRUCTURE wa_tab TO <gv_fs>.    " wa_itab의 gv_index 에 해당되는 칼럼들을 필드 심볼에 할당해준다.

    MOVE gt_data-value TO <gv_fs>.                               " gt_data엑셀의 칼럼값들을 gt_itab의 gv_index에 해당하는 필드심볼에 값을 집어넣어준다.

    AT END OF row.                                               " 행이 끝난다면
*      PERFORM CAL_WORK.
      APPEND wa_tab TO it_tab.                                   " APPEND 해라.
      CLEAR  wa_tab.
    ENDAT.
  ENDLOOP.
ENDFORM.                    " EXCEL_UPLOAD
*&---------------------------------------------------------------------*
*&      Form  f4_excel
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f4_excel.
***********************************************************************
* F4 기능.
***********************************************************************
  CALL FUNCTION 'F4_FILENAME'                             " F4기능을 넣는다.
     IMPORTING
       file_name = filepath.                                " 어떤 디렉터리에 무슨 파일이고 해당파일은뭐다.


ENDFORM.                                                    "f4_excel

*----------------------------------------------------------------------*
*        Start new screen                                              *
*----------------------------------------------------------------------*
FORM bdc_dynpro USING program dynpro.
***********************************************************************
* bdc_dynpro 사용하기 위함.
***********************************************************************
  CLEAR bdcdata.
  bdcdata-program  = program.
  bdcdata-dynpro   = dynpro.
  bdcdata-dynbegin = 'X'.
  APPEND bdcdata.
ENDFORM.                    "BDC_DYNPRO

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM bdc_field USING fnam fval.
*  IF FVAL <> NODATA.
  CLEAR bdcdata.
  bdcdata-fnam = fnam.
  bdcdata-fval = fval.
  SHIFT bdcdata-fnam LEFT DELETING LEADING space.
  APPEND bdcdata.
*  ENDIF.
ENDFORM.                    "BDC_FIELD


*&---------------------------------------------------------------------*
*&      Form  BDC_MF50
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM bdc_mf50 .
*DATA l_qty(10) TYPE c.

  LOOP AT it_tab INTO wa_tab.
    REFRESH messtab.
    REFRESH bdcdata.

    PERFORM bdc_dynpro      USING 'SAPMM61R' '0220'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RM61R-BERID'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=RMPT'.
    PERFORM bdc_field       USING 'RM61R-BERID'
                                  wa_tab-werks.
    PERFORM bdc_field       USING 'RM61R-WERKS'
                                  wa_tab-werks.
    PERFORM bdc_field       USING 'RM61R-MATNR'
                                  wa_tab-matnr.
    PERFORM bdc_field       USING 'RM61R-DTVON'
                                  begda.



    PERFORM bdc_field       USING 'RM61R-DTBIS'
                                  endda.
    PERFORM bdc_field       USING 'RM61R-PERIO'
                                  'T'.
    PERFORM bdc_dynpro      USING 'SAPLMCPA' '0706'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RMCP4-FLD004(03)'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=S+'.

    PERFORM bdc_dynpro      USING 'SAPLMCPA' '0706'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RMCP4-FLD004(03)'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=S+'.

    PERFORM bdc_dynpro      USING 'SAPLMCPA' '0706'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RMCP4-FLD004(03)'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=S+'.

    PERFORM bdc_field       USING 'RMCP4-FLD002(03)'
                                  wa_tab-day1.
    PERFORM bdc_field       USING 'RMCP4-FLD003(03)'
                                  wa_tab-day2.
    PERFORM bdc_field       USING 'RMCP4-FLD004(03)'
                                  wa_tab-day3.
    PERFORM bdc_dynpro      USING 'SAPLMCPA' '0706'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RMCP4-FLD004(03)'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=S+'.
    PERFORM bdc_field       USING 'RMCP4-FLD005(03)'
                                  wa_tab-day4.
    PERFORM bdc_dynpro      USING 'SAPLMCPA' '0706'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RMCP4-FLD004(03)'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=S+'.
    PERFORM bdc_field       USING 'RMCP4-FLD006(03)'
                                  wa_tab-day5.
    PERFORM bdc_dynpro      USING 'SAPLMCPA' '0706'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RMCP4-FLD004(03)'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=S+'.
    PERFORM bdc_field       USING 'RMCP4-FLD007(03)'
                                  wa_tab-day6.
    PERFORM bdc_dynpro      USING 'SAPLMCPA' '0706'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RMCP4-FLD004(03)'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=S+'.
    PERFORM bdc_dynpro      USING 'SAPLMCPA' '0706'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RMCP4-FLD003(03)'.

    PERFORM bdc_field       USING 'RMCP4-FLD008(03)'
                                  wa_tab-day7.

    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=POS7'.
    CALL TRANSACTION 'MF50' USING bdcdata
                     MODE   p_mode                                        " 모든 N(BDC를 수행하다가 오류가 나더라도 넘어가라)이나 A(하나하나 다 보여주는 것)냐 E냐
                     UPDATE 'S'                                        " 업데이트 옵션: S(동시에)냐, A(레코딩 끝나고 데이터베이스에 업데이트를 나중에 해라)냐, L이냐
                     MESSAGES INTO messtab.

***********************************************************************
* 데이터가 담긴 인터널 테이블 ---> 결과 ALV에 뿌려줄 인터널테이블 데이터 이동.
***********************************************************************
  MOVE-CORRESPONDING wa_tab TO re_wa_tab.

    re_wa_tab-light = c_green.
    LOOP AT messtab[] INTO messtab.
***********************************************************************
* messtab의 타입이 E라면.
***********************************************************************
      IF messtab-msgtyp = 'E'.
        re_wa_tab-light = c_red.
***********************************************************************
* MESSAGE_TEXT_BUILD 함수를 통해서, 에러 메시를 받는다.
***********************************************************************
        CALL FUNCTION 'MESSAGE_TEXT_BUILD'
          EXPORTING
            msgid               = messtab-msgid
            msgnr               = messtab-msgnr
          IMPORTING
            message_text_output = re_wa_tab-text.
        EXIT.
      ENDIF.
    ENDLOOP.
***********************************************************************
* 결과 ALV로 데이터 값 전송.
***********************************************************************
    APPEND re_wa_tab TO re_it_tab.
    CLEAR wa_tab.

    ENDLOOP.
  ENDFORM.                                                  " BDC_MF50

*&---------------------------------------------------------------------*
*&      Form  CAL_WORK
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM cal_work .
***********************************************************************
* Working Date 종료일 계산 로직
***********************************************************************
  CALL FUNCTION 'Z_THWORKING_COUNT'
    EXPORTING
      startdate = begda
      workday   = 7
    IMPORTING
      enddate   = endda.
ENDFORM.                    " CAL_WORK

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
FORM set_grid_fcat_100  CHANGING ct_fcat TYPE lvc_t_fcat.
*    CLEAR l_fcat.
  DATA: ls_fcat TYPE lvc_s_fcat. "필드 카탈로그 타입

  ls_fcat-fieldname = 'MATNR'.
  ls_fcat-outputlen = 8.
  ls_fcat-col_pos   = 1.
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
  ls_fcat-emphasize = 'C119'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'LAEDA'.
  ls_fcat-outputlen = 8.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '종료일'.
  ls_fcat-emphasize = 'C119'.
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
  ls_fcat-do_sum =  'X'.
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
ENDFORM.                           "SET_GRID_FCAT_100
*&---------------------------------------------------------------------*
*&      Module  INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init_screen OUTPUT.
  CREATE OBJECT container
    EXPORTING
      container_name = 'THCONT'.
  CREATE OBJECT grid
    EXPORTING
      i_parent = container.

  PERFORM set_grid_layo_100 CHANGING ls_layo.
  PERFORM set_grid_fcat_100 CHANGING lt_fcat.

  CALL METHOD grid->set_table_for_first_display
    CHANGING
      it_outtab       = alv_it_tab
      it_fieldcatalog = lt_fcat.

  CLEAR lt_fcat.
ENDMODULE.                 " INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*&      Form  SYNC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
********************************************************
* 엑셀 데이터 및 날짜 데이터 ---> ALV 데이터 전송.
********************************************************
FORM sync .
  LOOP AT it_tab INTO wa_tab.
    MOVE-CORRESPONDING wa_tab TO alv_wa_tab.
********************************************************
* 날짜 데이터 ---> ALV 데이터 전송.
********************************************************
    APPEND alv_wa_tab TO alv_it_tab.
  ENDLOOP.


ENDFORM.                    "SYNC
*****************************************************************************
*   SMW0상에서 파일을 가져온는 함수.
*****************************************************************************
FORM get_tmplate USING p_template_name.

  SELECT SINGLE *
  INTO CORRESPONDING FIELDS OF wa_wwwdatatab
  FROM wwwdata                          " 사전에 SAP 상에 저장된 파일들을 불러올 수 있는 테이블 wwwdata
  WHERE
    objid = 'ZTEST02'                   " objname used when uploading ---> SMW0상에서 저장된 object name을 쓴다.
    .

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'
    EXPORTING
      key = wa_wwwdatatab.


ENDFORM.                    " GET_TMPL_FROM_SMW0
*&---------------------------------------------------------------------*
*&      Form  check_excel
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM check_excel.
  SEARCH filepath FOR '.XLS'.
  IF sy-subrc <> 0.
    MESSAGE '이것은 엑셀파일 형식이 아닙니다. 다시 선택해주세요' TYPE 'I'.
  ENDIF.
ENDFORM.                    "check_excel

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
