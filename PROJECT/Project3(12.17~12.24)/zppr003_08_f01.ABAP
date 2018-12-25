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
*  SET HANDLER alv_event_handler->handle_toolbar FOR grid.                              " toolbar Register ���.
*  SET HANDLER alv_event_handler->handle_user_command FOR grid.                         " user_command Register ���.

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
  cs_layo-zebra       = 'X'.                                                "�ٺ� ����ǥ��. ���ӵ� ������ �򰥸� ����.
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

  cs_layo-no_toolbar  = space.                                "2. Grid Application Toolbar Control. --> Ȯ�����ش�.

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
  DATA: ls_fcat TYPE lvc_s_fcat. "�ʵ� īŻ�α� Ÿ��

  ls_fcat-fieldname = 'AUFNR'.
  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = 1.
*************************************************************************
* Converexit������ Convers Routine���� �־ ��� ���¸� �����ش�.     *
*************************************************************************
  ls_fcat-convexit = 'ALPHA'.                     " ---> Insert.
  ls_fcat-scrtext_s = '�������'.
  APPEND ls_fcat TO ct_fcat.

*  ls_fcat-scrtext_s = 'OBJID'.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'WERKS'.
  ls_fcat-outputlen = 15.
  ls_fcat-col_pos   = '1'.
  ls_fcat-scrtext_s = '�÷�Ʈ'.
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
  ls_fcat-scrtext_s = '��ǰ�ڵ�'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'VORNR'.
  ls_fcat-outputlen = 14.
  ls_fcat-col_pos   = 1.
    ls_fcat-convexit = 'ALPHA'.
  ls_fcat-scrtext_s = '������ȣ'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.

  ls_fcat-fieldname = 'ARBPL'.
  ls_fcat-outputlen = 8.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '�۾���'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'LTXA1'.
  ls_fcat-outputlen = 25.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '��������'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'GAMNG'.
*  ls_fcat-outputlen = 14.
*************************************************************************
* Q_FIELDNAME�� ���� ���� �����Ͽ�, ���� ������ �����ش�.               *
*************************************************************************
  ls_fcat-qfieldname = 'GMEIN'.
*************************************************************************
* DO_SUM �ʵ带 üũ�Ͽ�, ���� �հ踦 ���ϵ��� ALV�� �����Ѵ�           *
*************************************************************************
  ls_fcat-DO_SUM =  'X'.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '��������'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'GMEIN'.
*  ls_fcat-outputlen = 12.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '����'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'GSTRP'.
*  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '���������'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'GLTRP'.
*  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '����������'.
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
    ASSIGN COMPONENT gv_index OF STRUCTURE wa_tab TO <gv_fs>.   "gt_itab�� gv_index �� �ش�Ǵ� Į������ �ʵ� �ɺ��� �Ҵ����ش�.
    MOVE gt_data-value TO <gv_fs>.                               "gt_data������ Į�������� gt_itab�� gv_index�� �ش��ϴ� �ʵ�ɺ��� ���� ����־��ش�.

    AT END OF row.                                               " ���� �����ٸ�
      APPEND wa_tab to it_tab.                                            " APPEND �ض�.
      CLEAR  wa_tab.
    ENDAT.
  ENDLOOP.

endform.                    " EXCEL_UPLOAD

*----------------------------------------------------------------------*
*        Start new screen                                              *        ---> �ʼ� 2. ��ũ���� ����ȭ�ϴ� ����.
*----------------------------------------------------------------------*
FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR BDCDATA.
  BDCDATA-PROGRAM  = PROGRAM.
  BDCDATA-DYNPRO   = DYNPRO.
  BDCDATA-DYNBEGIN = 'X'.
  APPEND BDCDATA.
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *        ---> �ʼ� 3. �ʵ� �����͸� �Է��ϴ� ����.
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
*  �׼� ����.                                                      *
*  1. ���͸� ���߿� �ƴٰ� �ؼ� ���������� ����Ǵ� ���� �ƴϴ�.   *
*  2. Ʈ����ǵ� ����������.                                       *
********************************************************************
********************************************************************
*  First Screen.                                                   *
********************************************************************
perform bdc_dynpro      using 'SAPLCORU_S' '0100'.                     " CO11N�� �ش��ϴ� ���α׷� ȣ��.


perform bdc_field       using 'BDC_OKCODE'                             " ���͸� �Է�.
                              '/00'.

perform bdc_field       using 'AFRUD-AUFNR'                            " ������� �Է� ����
                              WA_tab-AUFNR.                            " ���ͳ� ���̺� ��������� ������ �Ѵ�.

perform bdc_field       using 'AFRUD-VORNR'                            " ������ȣ �Է��ϴ°� ����
                              WA_tab-VORNR.
********************************************************************
*  Second Screen.                                                  *
********************************************************************
perform bdc_dynpro      using 'SAPLCORU_S' '0100'.                     "  ---> ���͸� ġ�� ���α׷��� �ٽ� ȣ��ȴ�. ��ũ���� �ٽ� ȣ��Ǳ� ������

perform bdc_field       using 'BDC_OKCODE'                             " �����ư
                              '=BU'.

WRITE wa_tab-gamng TO l_qty LEFT-JUSTIFIED.
perform bdc_field       using 'AFRUD-LMNGA'                            " Yield ����  ---> Ÿ�� ������ ����.
                              l_qty.


* <=========================�ð� ���õ� ����=========================>

*perform bdc_field       using 'AFRUD-ISM01'                           " Setup �ð� / ��
*                              record-ISM01_012.
*perform bdc_field       using 'AFRUD-ILE01'
*                              'MIN'.

*perform bdc_field       using 'AFRUD-ISM02'                           " Labor �ð� / ��
*                              record-ISM02_14.
*perform bdc_field       using 'AFRUD-ILE02'
*                              'MIN'.


*    REFRESH MESSTAB.
    CALL TRANSACTION 'CO11N' USING BDCDATA
                     MODE   p_mode                                        " ��� N(BDC�� �����ϴٰ� ������ ������ �Ѿ��)�̳� A(�ϳ��ϳ� �� �����ִ� ��)�� E��
                     UPDATE 'S'                                        " ������Ʈ �ɼ�: S(���ÿ�)��, A(���ڵ� ������ �����ͺ��̽��� ������Ʈ�� ���߿� �ض�)��, L�̳�
                     MESSAGES INTO MESSTAB.
*perform bdc_transaction using 'CO11N'.
ENDLOOP.
endform.                    " BDC_CO11N

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
