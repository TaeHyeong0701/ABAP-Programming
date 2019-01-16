*&---------------------------------------------------------------------*
*& Include ZPPR0011_08_TOP                                   Report ZPPR0011_08
*&
*&---------------------------------------------------------------------*

REPORT   ZPPR0011_08.
************************************************************************
* 1. MARA: MATNR을 셀렉션 옵션스에서 사용하기 위해.
* 2. MAPL: PLNTY을 셀렉션 옵션스에서 사용하기 위해.
************************************************************************
TABLES MARA.
TABLES MAPL.
TABLES icon.
*************************************************************************
* 구조체 및 인터널 테이블 선언.
*************************************************************************
DATA : BEGIN OF gs_tab.
DATA : MATNR TYPE mara-matnr,
      werks TYPE mapl-werks,
      plnty TYPE mapl-plnty,
      plnnr TYPE mapl-plnnr,
      plnal TYPE mapl-plnal,
      c_light TYPE icon-id,
END OF gs_tab.
************************************************************************
*  멀티플 셀렉트 로우 값.
************************************************************************
DATA: INDEX_ROWS TYPE LVC_T_ROW,
      index_id TYPE  LVC_T_ROID ,
INDEX LIKE LINE OF INDEX_ROWS.


DATA : it_tab LIKE TABLE OF gs_tab,
      wa_tab LIKE LINE OF it_tab.
************************************************************************
*  ALV에 사용되는 신호등 / 초 // 노  // 빨.
************************************************************************
CONSTANTS: c_green TYPE icon-id VALUE '@08@',
c_yellow TYPE icon-id VALUE '@09@',
c_red TYPE icon-id VALUE '@0A@'.
************************************************************************
* ALV 기본 템플릿.
************************************************************************
DATA : container TYPE REF TO cl_gui_custom_container,            "컨테이너 선언. ---> cl_gui_custom_container 클래스 참조.
       grid TYPE REF TO cl_gui_alv_grid,                         "그리드 선언.  ---> cl_gui_alv_grid 클래스 참조.
       ok_code TYPE sy-ucomm.                                     "클릭 변수 지정.
DATA: ls_layo TYPE lvc_s_layo,
     lt_fcat TYPE lvc_t_fcat.

************************************************************************
* BAPI 글로벌 변수. LIST_USAGE(1), LIST_STATUS(4), 결과 인터널 테이블 및 workarea
************************************************************************
DATA:
      gv_group       TYPE bapi1012_tsk_c-task_list_group value 1,  "1
      gv_gr_counter  TYPE  bapi1012_tsk_c-group_counter value 4,   "4
      IT_RET TYPE TABLE OF BAPIRET2,
      wa_ret LIKE LINE OF it_ret.       "
*gv_test_run    TYPE bapiflag,

************************************************************************
* BAPI OP(Operation 동작) 글로벌 인터널 / WorkArea  PLANT(1200), Control key(PP01), Description(test material)
************************************************************************
data : IT_OP TYPE TABLE OF BAPI1012_OPR_C,
      wa_op LIKE LINE OF it_op.
*************************************************************************
** BAPI task 글로벌 인터널 / WorkArea
*************************************************************************
DATA : it_task TYPE TABLE OF bapi1012_tsk_c,
      wa_task LIKE LINE OF it_task.
************************************************************************
* BAPI it_mat_task 글로벌 인터널 / WorkArea ---> 최초 material, plant, valid_from 설정.
************************************************************************
data : IT_MAT_TASK_ALLO TYPE TABLE OF BAPI1012_MTK_C ,
       wa_mat_task_allo LIKE LINE OF it_mat_task_allo.
************************************************************************
* BAPI it_inspchar 글로벌 인터널 / WorkArea ---> 마지막 Labor ?  Machine ?
************************************************************************
*DATA : it_inspchar TYPE TABLE OF bapi1012_cha_c,
*      wa_inspchar like LINE OF it_inspchar.
************************************************************************
* 결과 저장용 테이블.
************************************************************************
DATA : it_result TYPE TABLE OF ZPPT0011_08,
       wa_result LIKE LINE OF it_result.

DATA : ch_num TYPE i.
DATA : ch_true TYPE i.
************************************************************************
* selection-options
************************************************************************
SELECT-OPTIONS: S_MATNR FOR MARA-MATNR.
PARAMETERS : S_werks TYPE mapl-werks DEFAULT 1200.
*************************************************************************
* ALL, (Routing) check, NOT CHECK  라디오 버튼 출력.
*************************************************************************
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS : radio1 RADIOBUTTON GROUP TH.
SELECTION-SCREEN COMMENT 3(10) text-001 FOR FIELD radio1.
PARAMETERS : radio2 RADIOBUTTON GROUP TH.
SELECTION-SCREEN COMMENT 16(10) text-002 FOR FIELD radio2.
PARAMETERS : radio3 RADIOBUTTON GROUP TH.
SELECTION-SCREEN COMMENT 29(10) text-003 FOR FIELD radio3.
SELECTION-SCREEN END OF LINE.

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
