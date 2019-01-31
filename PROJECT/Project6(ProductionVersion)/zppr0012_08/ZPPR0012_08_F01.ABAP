*&---------------------------------------------------------------------*
*&  Include           ZPPR0012_08_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  FETCH_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fetch_data .
  SELECT matnr werks
    FROM zppt0011_08 INTO CORRESPONDING FIELDS OF TABLE it_tab
    WHERE matnr IN s_matnr
    AND werks = s_werks.


  IF sy-subrc <> 0.
************************************************************************
* 조회 조건에 따른 값이 없을 경우.
************************************************************************
    MESSAGE '원하시는 값이 ZPPT0011_08테이블에는 값이 없습니다.' TYPE 'I'.
  ELSE.
************************************************************************
* VERID 값을 추가하여, 데이터 select.
************************************************************************
    SELECT a~matnr a~werks b~verid INTO CORRESPONDING FIELDS OF TABLE it_tab
      FROM zppt0011_08 AS a INNER JOIN mkal AS b
      ON a~matnr = b~matnr
      AND a~werks = b~werks.
  ENDIF.

************************************************************************
* 신호등 넣기 로직.
************************************************************************
  LOOP AT it_tab INTO wa_tab.
    IF wa_tab-verid = '1000'.
      wa_tab-c_light = c_green.
    ELSE.
      wa_tab-c_light = c_red.
    ENDIF.
    MODIFY it_tab FROM wa_tab.
  ENDLOOP.
ENDFORM.                    " FETCH_DATA
*----------------------------------------------------------------------*
*  MODULE init_screen OUTPUT
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
MODULE init_screen OUTPUT.
*  DATA : alv_event_handler TYPE REF TO alv_event_handler.
  IF container IS INITIAL.
************************************************************************
*  1. Container 객체 생성
************************************************************************
    CREATE OBJECT container
      EXPORTING
        container_name = 'THCONT1'.
************************************************************************
*  2. Grid 객체 생성
************************************************************************
    CREATE OBJECT grid
      EXPORTING
        i_appl_events = 'X' "
        i_parent      = container.
************************************************************************
*  3. 레이아웃 설정 및 필드 카탈로그 설정.
************************************************************************
    PERFORM set_grid_layo_100 CHANGING ls_layo.
    PERFORM set_grid_fcat_100 CHANGING lt_fcat.
************************************************************************
*  4. ALV를 ls_layo(커스텀 세팅), it_tab(커스텀 테이블 데이터), lt_fcat(필드카탈로그 목록)을 이용하여 호출한다.
************************************************************************
    IF it_tab IS INITIAL.
      MESSAGE '출력할 값이 없습니다.' TYPE 'I'.
    ELSE.
      CALL METHOD grid->set_table_for_first_display
        EXPORTING
          is_layout       = ls_layo
        CHANGING
          it_outtab       = it_tab
          it_fieldcatalog = lt_fcat.
    ENDIF.
  ENDIF.
ENDMODULE.                 " INIT_SCREEN  OUTPUT

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
  cs_layo-cwidth_opt  = 'X'.                                                " 길이수 최적화로 맞추기.
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

  cs_layo-no_toolbar  = space.                                               "2. Grid Application Toolbar Control. --> 확인해준다.
************************************************************************
*  A로 세팅하여, 멀티플셀렉터 레이아웃을 설정한다.
*  A : multiple row & column selection
*  C : multiple selection listbox
************************************************************************
  cs_layo-sel_mode    = 'A'.

  cs_layo-box_fname   = space.
  cs_layo-sgl_clk_hd  = space.

*... ALV-Control: Summenoptionen
  cs_layo-totals_bef  = space.
  cs_layo-no_totline  = space.
  cs_layo-numc_total  = space.
  cs_layo-no_utsplit  = space.

*... ALV-Control: Exceptions
*  cs_layo-excp_group  = 'LIGHT'.
  cs_layo-excp_fname  = 'C_LIGHT'.
  cs_layo-excp_fname = space.
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

  ls_fcat-fieldname = 'C_LIGHT'.
  ls_fcat-outputlen = 12.
  ls_fcat-col_pos   = 1.
  ls_fcat-just = 'C'.
  ls_fcat-scrtext_m = '생산버전 여부'.
*  ls_fcat-emphasize = 'C119'.
  APPEND ls_fcat TO ct_fcat.

  ls_fcat-fieldname = 'MATNR'.
  ls_fcat-outputlen = 8.
  ls_fcat-col_pos   = 1.
  ls_fcat-just = 'C'.
  ls_fcat-scrtext_s = 'Material'.
  ls_fcat-emphasize = 'C119'.
  APPEND ls_fcat TO ct_fcat.


  CLEAR ls_fcat.
  ls_fcat-fieldname = 'WERKS'.
  ls_fcat-outputlen = 6.
  ls_fcat-col_pos   = '1'.
  ls_fcat-scrtext_s = '플랜트'.
  ls_fcat-just = 'C'.
  ls_fcat-emphasize = 'C119'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'VERID'.
  ls_fcat-outputlen = 8.
  ls_fcat-col_pos   = 1.
  ls_fcat-just = 'C'.
  ls_fcat-scrtext_m = '생산버전'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

ENDFORM.                           "SET_GRID_FCAT_100
*&---------------------------------------------------------------------*
*&      Form  SELECT_CHECK
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM select_check .
************************************************************************
* 생산 버전이 있는 데이터만 출력.
************************************************************************
  DATA : it_tab1 LIKE TABLE OF gs_tab.
  LOOP AT it_tab INTO wa_tab.
    IF wa_tab-verid = '1000'.
      APPEND wa_tab TO it_tab1.
    ENDIF.
  ENDLOOP.
  CLEAR it_tab.
  LOOP AT it_tab1 INTO wa_tab.
    APPEND wa_tab TO it_tab.
  ENDLOOP.
ENDFORM.                    " SELECT_CHECK
*&---------------------------------------------------------------------*
*&      Form  SELECT_NOT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM select_not .

************************************************************************
* 생산 버전이 없는 데이터만 출력.
************************************************************************
  DATA : it_tab1 LIKE TABLE OF gs_tab.
  LOOP AT it_tab INTO wa_tab.
    IF wa_tab-verid <> '1000'.
      APPEND wa_tab TO it_tab1.
    ENDIF.
  ENDLOOP.
  CLEAR it_tab.
  LOOP AT it_tab1 INTO wa_tab.
    APPEND wa_tab TO it_tab.
  ENDLOOP.
ENDFORM.                    " SELECT_NOT
*&---------------------------------------------------------------------*
*&      Form  BDC_C223
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM bdc_c223 .
***********************************************************************
*  Index_rows 인터널 테이블의 INDEX데이터를 활용하여, 선택한 ROW들의 인덱스값을 인터널 테이블에 대입을해준다.
***********************************************************************
  LOOP AT index_rows INTO index.
    REFRESH messtab.  "최초 값으로 되돌림.
    REFRESH bdcdata.
    CLEAR wa_tab.
    READ TABLE it_tab INTO wa_tab INDEX index-index.
    IF sy-subrc = 0.

* 만약 생산버전이 있다면.
      IF wa_tab-verid = '1000'.
        MESSAGE '선택한 행중에 이미 Production Version이 있는 행들이 있습니다. 확인이 필요합니다.' TYPE 'W'.
      ELSE.
***********************************************************************
*  BDC 스타트!
***********************************************************************
      perform bdc_dynpro      using 'SAPLCMFV' '1000'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '=ENTE'.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'MKAL-MATNR'.
        PERFORM bdc_field       USING 'MKAL-WERKS'
                                      wa_tab-werks.
      wa_result-werks = wa_tab-werks.
        PERFORM bdc_field       USING 'MKAL-MATNR'
                                      wa_tab-matnr.
      wa_result-matnr = wa_tab-matnr.
        PERFORM bdc_dynpro      USING 'SAPLCMFV' '1000'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '=ENTE'.
        PERFORM bdc_field       USING 'MKAL-WERKS'
                                      wa_tab-werks.
        PERFORM bdc_field       USING 'MKAL-MATNR'
                                      wa_tab-matnr.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'MKAL_EXPAND-TEXT1(02)'.
        PERFORM bdc_field       USING 'MKAL_EXPAND-MATNR(02)'
                                      wa_tab-matnr.
        PERFORM bdc_field       USING 'MKAL_EXPAND-VERID(02)'
                                      '1000'.
        PERFORM bdc_field       USING 'MKAL_EXPAND-TEXT1(02)'
                                      'VERSION 1000'.
        PERFORM bdc_dynpro      USING 'SAPLCMFV' '1000'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '=PICK'.
        PERFORM bdc_field       USING 'MKAL-WERKS'
                                      wa_tab-werks.
        PERFORM bdc_field       USING 'MKAL-MATNR'
                                      wa_tab-matnr.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'MKAL_EXPAND-VERID(02)'.
        PERFORM bdc_field       USING 'MKAL_EXPAND-ADATU(02)'
                                      sy-datum.
        PERFORM bdc_dynpro      USING 'SAPLCMFV' '2000'.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'MKAL_EXPAND-MDV01'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '=ENTE'.
        PERFORM bdc_field       USING 'MKAL_EXPAND-TEXT1'
                                      'VERSION 1000'.
* 첫 번째 화면 Valid From // Valid To 입력.
        PERFORM bdc_field       USING 'MKAL_EXPAND-ADATU'
                                      sy-datum.
        wa_result-adatu = sy-datum.
        PERFORM bdc_field       USING 'MKAL_EXPAND-BDATU'
                                      '9999.12.31'.
        wa_result-bdatu = '9999.12.31'.
*perform bdc_field       using 'MKAL_EXPAND-PLNTY'
*                              record-PLNTY_014.
*perform bdc_field       using 'MKAL_EXPAND-PLNNR'
*                              record-PLNNR_015.
*perform bdc_field       using 'MKAL_EXPAND-ALNAL'
*                              record-ALNAL_016.
*perform bdc_field       using 'MKAL_EXPAND-STLAL'
*                              record-STLAL_017.
*perform bdc_field       using 'MKAL_EXPAND-STLAN'
*                              record-STLAN_018.
*perform bdc_field       using 'MKAL_EXPAND-MDV01'
*                              record-MDV01_019.
***********************************************************************
* 두번째 화면 전환
***********************************************************************
        PERFORM bdc_dynpro      USING 'SAPLCMFV' '2000'.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'MKAL_EXPAND-VERID'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '=PRFG'.
*perform bdc_field       using 'MKAL_EXPAND-TEXT1'
*                              'Routing'.
*perform bdc_field       using 'MKAL_EXPAND-ADATU'
*                              '9999.12.31'.
*perform bdc_field       using 'MKAL_EXPAND-BDATU'
*                              sy-datum.

        PERFORM bdc_field       USING 'MKAL_EXPAND-PLNTY'
                                      'N'.
        wa_result-plnty = 'N'.
        DATA : s_plnnr TYPE mapl-plnnr.
        SELECT plnnr INTO s_plnnr
          FROM mapl
          WHERE matnr = wa_tab-matnr
          AND plnty = 'N'.
        ENDSELECT.
        PERFORM bdc_field       USING 'MKAL_EXPAND-PLNNR'
              s_plnnr.
        wa_result-plnnr = s_plnnr.

*                              '00010165'.
        PERFORM bdc_field       USING 'MKAL_EXPAND-ALNAL'
                                      '1'.
* Alternative BOM
*perform bdc_field       using 'MKAL_EXPAND-STLAL'
*                              record-STLAL_026.


*perform bdc_field       using 'MKAL_EXPAND-STLAN'
*                              'PC-1'.

* Production Line 선택.
        PERFORM bdc_field       USING 'MKAL_EXPAND-MDV01'
                                      'PC-1'.
        PERFORM bdc_dynpro      USING 'SAPMSSY0' '0120'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '=RW'.
        PERFORM bdc_dynpro      USING 'SAPLCMFV' '2000'.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'MKAL_EXPAND-VERID'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '=CLOS'.
*perform bdc_field       using 'MKAL_EXPAND-TEXT1'
*                              record-TEXT1_029.
*perform bdc_field       using 'MKAL_EXPAND-ADATU'
*                              '9999.12.31'.
*perform bdc_field       using 'MKAL_EXPAND-BDATU'
*                              SY-DATUM.
*perform bdc_field       using 'MKAL_EXPAND-PLNTY'
*                              record-PLNTY_032.
*perform bdc_field       using 'MKAL_EXPAND-PLNNR'
*                              record-PLNNR_033.
*perform bdc_field       using 'MKAL_EXPAND-ALNAL'
*                              record-ALNAL_034.
*perform bdc_field       using 'MKAL_EXPAND-STLAL'
*                              record-STLAL_035.
*perform bdc_field       using 'MKAL_EXPAND-STLAN'
*                              record-STLAN_036.
*perform bdc_field       using 'MKAL_EXPAND-MDV01'
*                              record-MDV01_037.
        PERFORM bdc_dynpro      USING 'SAPLCMFV' '1000'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '=SAVE'.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'MKAL-WERKS'.
        PERFORM bdc_field       USING 'MKAL-WERKS'
                                      wa_tab-werks.
        PERFORM bdc_field       USING 'MKAL-MATNR'
                                      wa_tab-matnr.
* STLAL 삽입. STLAN 삽입.
        select stlal STLAN  into CORRESPONDING FIELDS OF wa_result
          FROM mast
          WHERE matnr = wa_tab-matnr.
          ENDSELECT.
        CALL TRANSACTION 'C223' USING bdcdata
                         MODE   p_mode                                     " 모든 N(BDC를 수행하다가 오류가 나더라도 넘어가라)이나 A(하나하나 다 보여주는 것)냐 E냐
                         UPDATE 'S'                                        " 업데이트 옵션: S(동시에)냐, A(레코딩 끝나고 데이터베이스에 업데이트를 나중에 해라)냐, L이냐
                         MESSAGES INTO messtab.
        modify ZPPT0012_08 FROM wa_result.
        CLEAR wa_result.
        ENDIF.


      ENDIF.
***********************************************************************
*  BDC 종료!
***********************************************************************
    ENDLOOP.
    PERFORM refresh_alv .
    IF sy-subrc = 0.
      MESSAGE 'BDC 생성 완료' TYPE 'S'.
    ENDIF.

  ENDFORM.                                                  " BDC_C223

*&---------------------------------------------------------------------*
*&      Form  GET_SELECTED_ROWS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM get_selected_rows.
************************************************************************
* index_rows에 해당하는 로우값이 담긴.
************************************************************************
*  CLEAR index_rows.
  CLEAR index.
  REFRESH index_rows.
*  clear index_id.
  CALL METHOD grid->get_selected_rows
    IMPORTING
      et_index_rows = index_rows
      et_row_no     = index_id.

ENDFORM.                    "GET_SELECTED_ROWS
FORM refresh_alv .
  DATA ls_stable TYPE lvc_s_stbl.
  clear it_Tab.
      PERFORM fetch_data.
  IF ch_num = 2.
    PERFORM select_check.
  ELSEIF ch_num = 3.
    PERFORM select_not.
  endif.
************************************************************************
* REFRESH 함수 호출
************************************************************************
  CALL METHOD grid->refresh_table_display
    EXPORTING
      is_stable = ls_stable
    EXCEPTIONS
      finished  = 1
      OTHERS    = 1.
ENDFORM.                    " REFRESH_ALV

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
