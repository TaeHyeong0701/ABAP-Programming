*&---------------------------------------------------------------------*
*& Include ZPPR0010_08_TOP                                   Report ZPPR0010_08
*&
*&---------------------------------------------------------------------*
************************************************************************
* Title: 생산 계획 및 생산 마스터 관리
************************************************************************
* DATE          AUTHOR                  DESCRIPTION
************************************************************************
* 2018.12.28    TaeHyeong               Create Radio Button in Report
* 2018.12.31    TaeHyeong               최초 ALV 생성.
* 2019.01.02    TaeHyeong               Scroll BDC 작업.
* 2019.01.03    TaeHyeong               Reuse ALV 생성.
************************************************************************
REPORT   ZPPR0010_08.
************************************************************************
* 자재번호와 플랜트를 MARA와 MARC로 부터 참조받기 위해서 선언함.
************************************************************************
TABLES mara.
TABLES marc.
TABLES mast.

************************************************************************
* 인터널 테이블 구조체 선언
************************************************************************
DATA : BEGIN OF gs_tab.
DATA : matnr type marc-matnr,
       werks TYPE marc-werks,
       stlan type marc-stlan,
       stlnr TYPE mast-stlnr,
END OF gs_tab.

************************************************************************
* 1. WorkArea 및 Internal Table 선언.
************************************************************************
DATA : it_tab LIKE TABLE OF gs_tab,
      wa_tab LIKE LINE OF it_tab.

DATA : it_re_tab LIKE TABLE OF gs_tab,
       wa_re_tab LIKE LINE OF it_re_tab.
****************************************************************
* MAST 테이블 MATNR, WERKS, STLAN, STLNR을 조회하기 위한 조건.
************************************************
DATA : it_mast TYPE TABLE OF mast,
      wa_mast LIKE LINE OF it_mast.
************************************************************************
* BOM ---> WorkArea 및 Internal Table 선언.
************************************************************************
DATA : it_bom Like TABLE of gs_tab,
      wa_bom LIKE LINE OF it_bom.
************************************************************************
* NOT ---> WorkArea 및 Internal Table 선언.
************************************************************************
DATA : it_not like TABLE OF gs_tab,
      wa_not LIKE LINE OF it_not.

************************************************************************
* CBO Ref 테이블
************************************************************************
DATA : it_ref TYPE TABLE OF ZBOMREFTH,
      WA_ref LIKE LINE OF it_ref.
************************************************************************
* ALV 기본 템플릿.
************************************************************************
DATA : container TYPE REF TO cl_gui_custom_container,            "컨테이너 선언. ---> cl_gui_custom_container 클래스 참조.
       grid TYPE REF TO cl_gui_alv_grid,                         "그리드 선언.  ---> cl_gui_alv_grid 클래스 참조.
       ok_code TYPE sy-ucomm.                                     "클릭 변수 지정.
DATA: ls_layo TYPE lvc_s_layo,
     lt_fcat TYPE lvc_t_fcat.
************************************************************************
*  멀티플 셀렉트 로우 값.
************************************************************************
DATA: INDEX_ROWS TYPE LVC_T_ROW,
      index_id TYPE  LVC_T_ROID ,
INDEX LIKE LINE OF INDEX_ROWS.
************************************************************************
*  BDC 모드 입력모드 제어
************************************************************************
DATA : P_MODE TYPE C.
************************************************************************
*  Reuse ALV 에 사용되는 목록들
*  1. LAYOUT 포맷.
*  2. Field Catalog 포맷.(구조체)
*  3. Field Catalog 포맷.(인터널 테이블)
************************************************************************
  DATA : wa_layout TYPE slis_layout_alv .
  DATA : wa_fcat TYPE slis_fieldcat_alv .
  DATA : I_FCAT TYPE SLIS_T_FIELDCAT_ALV .
************************************************************************
*  Reuse ALV 에 사용되는 구조체 / 인터널 테이블 / WA
************************************************************************
  DATA : BEGIN OF rs_tab.
   INCLUDE STRUCTURE gs_tab.
   DATA : c_light TYPE icon-id,
         c_text TYPE string.
  DATA END OF rs_tab.

  DATA : it_reu_tab LIKE TABLE OF rs_tab,
        wa_reu_tab LIKE LINE OF it_reu_tab.

************************************************************************
*  Reuse ALV 에 사용되는 신호등 / 초 // 노  // 빨.
************************************************************************
CONSTANTS: c_green TYPE icon-id VALUE '@08@',
c_yellow TYPE icon-id VALUE '@09@',
c_red TYPE icon-id VALUE '@0A@'.
************************************************************************
*  최종 결과 데이터 CBO테이블 인터널 // WA 선언. // TABLE선언.
************************************************************************
DATA : it_end TYPE TABLE OF ZPPT0010_08,
      wa_end LIKE LINE OF it_end.
TABLES ZPPT0010_08.

************************************************************************
*  에러 메시지 출력을 위한 추가 스펙.  (자재, 최종 텍스트, cnt)
************************************************************************
DATA : err_mat TYPE mara-matnr,
      err_text TYPE string,
      err_cnt TYPE i.
CLASS alv_event_handler DEFINITION.
*  PUBLIC SECTION.
*   METHODS:
*      handle_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
*        IMPORTING e_object e_interactive.
ENDCLASS.             "lcl_event_receiver DEFINITION
CLASS alv_event_handler IMPLEMENTATION.

*  METHOD handle_toolbar.                                                              "Application Toolbar Button add.
*
*    DATA : ls_toolbar TYPE stb_button.
*
*    CLEAR ls_toolbar.
*    MOVE 0 TO ls_toolbar-butn_type.                                     "Toolbar button type
*    MOVE 'EXCELTH' TO ls_toolbar-function.                              "Function code
*    MOVE icon_xxl TO ls_toolbar-icon.                                   "icon*
*    MOVE 'Download Excel Format to LOCAL Disk' TO ls_toolbar-quickinfo. "Quickinfo for an icon*
*    MOVE ' ' TO ls_toolbar-disabled.                                     "Disabled
*    APPEND ls_toolbar TO e_object->mt_toolbar.
*ENDMETHOD.
ENDCLASS.


*----------------------------------------------------------------------*
*   data definition
*----------------------------------------------------------------------*
*       Batchinputdata of single transaction
DATA:   BDCDATA LIKE BDCDATA    OCCURS 0 WITH HEADER LINE.
*       messages of call transaction
DATA:   MESSTAB LIKE BDCMSGCOLL OCCURS 0 WITH HEADER LINE.
*       error session opened (' ' or 'X')
DATA:   E_GROUP_OPENED.
*       message texts
TABLES: T100.
************************************************************************
* 자재번호, 플랜트 선택 스크린 작성.
************************************************************************
SELECTION-SCREEN BEGIN OF BLOCK block1.
 SELECT-OPTIONS : matnr FOR mara-matnr.
 PARAMETERS : s_werks TYPE mast-werks DEFAULT 1200.
SELECTION-SCREEN END OF BLOCK block1.

*************************************************************************
* ALL, BOM CHECK, NOT CHECK  라디오 버튼 출력.
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
