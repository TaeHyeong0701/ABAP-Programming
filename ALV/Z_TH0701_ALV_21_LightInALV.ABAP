Z_TH0701_LightInALV


***************************************************************
* TOP                                1. ALV �� ��ȣ���� �ѷ��� ������ ����.
***************************************************************
data : BEGIN OF alv_tab.
INCLUDE STRUCTURE gs_tab.
DATA : ERSDA TYPE D,
      LAEDA TYPE D,
      thlight TYPE icon-id,                  " ��ȣ�� ���� ����.
end of alv_tab.

***************************************************************
* FORM   set_grid_layo_100    2. ���̾ƿ� ���úκп��� excp_fname�� ��ȣ�� �������� �־���.
***************************************************************
*... ALV-Control: Exceptions
*...
  cs_layo-excp_fname  = 'THLIGHT'.     
*...

***************************************************************
* FORM LIGHT_SETTING.  3. ���ǿ� ���� ��ȣ�� ���� ��.
***************************************************************
form LIGHT_SETTING .
LOOP AT alv_it_tab INTO alv_wa_tab.

  DATA : day TYPE string.
  data : th_index TYPE n.
FIELD-SYMBOLS <fsday>.
 DO 7 TIMES.
   clear day.
   day = 'wa_tab-DAY'.
   th_index = sy-index.
   CONCATENATE day th_index INTO day.
  ASSIGN (day) TO <fsday>.
  sum = sum + <fsday>.
   ENDDO.

if sum LT 50.
alv_wa_tab-light = c_green.
ELSEIF sum LT 100.
    alv_wa_tab-light = c_yellow.
ELSE.
      alv_wa_tab-light = c_red.
ENDIF.

clear sum.
MODIFY alv_it_tab FROM alv_wa_tab.
ENDLOOP.
endform.                    " LIGHT_SETTING

***************************************************************
* FORM SET_GRID_FCAT_100   4. �׸��� �������� ��ȣ���� ����� Į���� �������ش�.
***************************************************************
FORM set_grid_fcat_100  CHANGING ct_fcat TYPE lvc_t_fcat.
*    CLEAR l_fcat.
  DATA: ls_fcat TYPE lvc_s_fcat. "�ʵ� īŻ�α� Ÿ��

  ls_fcat-fieldname = 'LIGHT'.
  ls_fcat-outputlen = '5'.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '��޾���'.
  ls_fcat-TOOLTIP = '������ ���� ��� ����'.
  APPEND ls_fcat TO ct_fcat.
*...