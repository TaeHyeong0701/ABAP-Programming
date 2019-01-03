*&---------------------------------------------------------------------*
*& Include ZPPR0010_08_TOP                                   Report ZPPR0010_08
*&
*&---------------------------------------------------------------------*
************************************************************************
* Title: ���� ��ȹ �� ���� ������ ����
************************************************************************
* DATE          AUTHOR                  DESCRIPTION
************************************************************************
* 2018.12.28    TaeHyeong               Create Radio Button in Report
* 2018.12.31    TaeHyeong               ���� ALV ����.
* 2019.01.02    TaeHyeong               Scroll BDC �۾�.
* 2019.01.03    TaeHyeong               Reuse ALV ����.
************************************************************************

*...

************************************************************************
*  Reuse ALV �� ���Ǵ� ��ϵ�
*  1. LAYOUT ����.
*  2. Field Catalog ����.(����ü)
*  3. Field Catalog ����.(���ͳ� ���̺�)
************************************************************************
  DATA : wa_layout TYPE slis_layout_alv .
  DATA : wa_fcat TYPE slis_fieldcat_alv .
  DATA : I_FCAT TYPE SLIS_T_FIELDCAT_ALV .


*&---------------------------------------------------------------------*
*&  Include           ZPPR0010_08_F01
*&---------------------------------------------------------------------*

*...

*&---------------------------------------------------------------------*
*&      Form  F1000_LAYOUT_INIT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_I_LAYOUT  text
*----------------------------------------------------------------------*
************************************************************************
* Reuse ALV ���̾ƿ� ���� ����.
************************************************************************
FORM create_layout .
  wa_layout-zebra = 'X' .
*  wa_layout-colwidth_optimize = 'X' .
  wa_layout-edit = 'X' .
*  wa_layout-no_vline = 'X' .
*  wa_layout-no_hline = 'X' .
ENDFORM.                    "CREATE_LAYOUT
************************************************************************
* Reuse ALV �ʵ� īŻ�α� ���� ����.
************************************************************************
FORM CREATE_FCAT .

  DATA : V_POS TYPE i.
  V_POS = 1 .
************************************************************************
* Col_Pos ��ġ ���� �ϳ��� �÷��ָ�, �ʵ�īŻ�α׵��� �����Ѵ�.
************************************************************************
  WA_FCAT-COL_POS = V_POS.
  WA_FCAT-FIELDNAME = 'C_LIGHT' .
  WA_FCAT-SELTEXT_M = 'BDC�Է°��' .

  WA_FCAT-outputlen = 15.
*  WA_FCAT-col_pos   = 1.

  WA_FCAT-HOTSPOT = 'X' .
  APPEND WA_FCAT TO I_FCAT .
  CLEAR WA_FCAT .

  WA_FCAT-COL_POS = V_POS.
  WA_FCAT-FIELDNAME = 'MATNR' .
  WA_FCAT-SELTEXT_M = 'Material' .

  WA_FCAT-outputlen = 8.
*  WA_FCAT-col_pos   = 1.

  WA_FCAT-HOTSPOT = 'X' .
  APPEND WA_FCAT TO I_FCAT .
  CLEAR WA_FCAT .

  V_POS = V_POS + 1.
  WA_FCAT-COL_POS = V_POS .
  WA_FCAT-FIELDNAME = 'WERKS' .
  WA_FCAT-SELTEXT_M = '�÷�Ʈ' .

  WA_FCAT-outputlen = 8.
*  WA_FCAT-col_pos   = 1.

  APPEND WA_FCAT TO I_FCAT .
  CLEAR WA_FCAT .


  V_POS = V_POS + 1.
  WA_FCAT-COL_POS = V_POS .
  WA_FCAT-FIELDNAME = 'STLAN' .
  WA_FCAT-SELTEXT_M = 'BOM usg' .

  WA_FCAT-outputlen = 8.
*  WA_FCAT-col_pos   = 1.

  APPEND WA_FCAT TO I_FCAT .
  CLEAR WA_FCAT .


  V_POS = V_POS + 1.
  WA_FCAT-COL_POS = V_POS .
  WA_FCAT-FIELDNAME = 'STLNR' .
  WA_FCAT-SELTEXT_M = 'BOM' .

  WA_FCAT-outputlen = 8.
*  WA_FCAT-col_pos   = 1.

  APPEND WA_FCAT TO I_FCAT .
  CLEAR WA_FCAT .

  V_POS = V_POS + 1.
  WA_FCAT-COL_POS = V_POS .
  WA_FCAT-FIELDNAME = 'C_TEXT' .
  WA_FCAT-SELTEXT_M = 'BDC�����޽���' .

  WA_FCAT-outputlen = 25.
*  WA_FCAT-col_pos   = 1.

  APPEND WA_FCAT TO I_FCAT .
  CLEAR WA_FCAT .

  ENDFORM.                    " CREATE_FCAT
FORM display_reuse .
  PERFORM create_layout .
  PERFORM CREATE_FCAT .
************************************************************************
* Reuse ALV ȣ�� �ϱ� ���� ���� ����Ʈ ���α׷� ���� �޾Ƴ��´�. 
************************************************************************
  DATA: l_program TYPE sy-repid.
  l_program = sy-repid.
  
  DELETE it_tab INDEX 2.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
     EXPORTING
************************************************************************
* 1. ���� ����Ʈ ���α׷����� // wa_layout ���̾ƿ� // I_FCAT�ʵ�īŻ�α׸� �̿��ؼ�, 
************************************************************************
       i_callback_program = l_program
       is_layout          = wa_layout
      it_fieldcat        = I_FCAT
*      it_events          = i_events
************************************************************************
* 2. it_reu_tab ���̺��� �����͸� Reuse ALV�� �ѷ��ش�.
************************************************************************
     TABLES
       t_outtab           = it_reu_Tab
     EXCEPTIONS
       program_error      = 1
       OTHERS             = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                    " DISPLAY_REUSE

