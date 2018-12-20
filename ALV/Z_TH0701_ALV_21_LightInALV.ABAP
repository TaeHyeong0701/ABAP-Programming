Z_TH0701_LightInALV


***************************************************************
* TOP                                1. ALV 에 신호등을 뿌려줄 데이터 선언.
***************************************************************
data : BEGIN OF alv_tab.
INCLUDE STRUCTURE gs_tab.
DATA : ERSDA TYPE D,
      LAEDA TYPE D,
      thlight TYPE icon-id,                  " 신호등 변수 선언.
end of alv_tab.

***************************************************************
* FORM   set_grid_layo_100    2. 레이아웃 세팅부분에서 excp_fname에 신호등 변수값을 넣어줌.
***************************************************************
*... ALV-Control: Exceptions
*...
  cs_layo-excp_fname  = 'THLIGHT'.     
*...

***************************************************************
* FORM LIGHT_SETTING.  3. 조건에 따른 신호등 설정 폼.
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
* FORM SET_GRID_FCAT_100   4. 그리드 설정에서 신호등을 출력할 칼럼을 선언해준다.
***************************************************************
FORM set_grid_fcat_100  CHANGING ct_fcat TYPE lvc_t_fcat.
*    CLEAR l_fcat.
  DATA: ls_fcat TYPE lvc_s_fcat. "필드 카탈로그 타입

  ls_fcat-fieldname = 'LIGHT'.
  ls_fcat-outputlen = '5'.
  ls_fcat-col_pos   = 1.
  ls_fcat-scrtext_s = '긴급업무'.
  ls_fcat-TOOLTIP = '물량에 따른 긴급 여부'.
  APPEND ls_fcat TO ct_fcat.
*...