*&---------------------------------------------------------------------*
*& Include ZPPR0003_08_TOP                                   Report ZPPR0003_08
*&
*&---------------------------------------------------------------------*
************************************************************************
REPORT   zppr0003_08.
************************************************************************
*  TABLES & TYPE-POOLS
*  1. SSCRFIELDS  ---> 스크린을 설정하는 속성이 있는 테이블.
*  2. WWWDATATAB  ---> DB가 아닌 다른 형식(파일이라던지)를 담아낼 수 있는 테이블 형태의 wwwdatatab
*  3. icon        ---> ICON테이블에 있는 아이콘들을 활용하기 위해서.
************************************************************************
TABLES sscrfields.
TABLES: wwwdatatab.
TYPE-POOLS : icon.
************************************************************************
*  DATA TYPE(가)
*  1. SMWO에서 템플릿을 다운로드하는데 사용할 인터널 테이블 및 WorkArea
*  2. Report Program Toolbar button에서 사용하게될 버튼 변수들
*  3. 종료일 변수
*  4. 엑셀에서 데이터를 가져오기 위한, 인덱스값(추후 엑셀의 칼럼들을 셀 때 사용됨), 전체 크기들을 제어하는 값들.
*  5. 전체 생산 계획에 반영된 자재수 sum
*  6. 엑셀 데이터 형식 구조체
************************************************************************
DATA : it_wwwdatatab TYPE TABLE OF wwwdatatab,
       wa_wwwdatatab LIKE LINE OF it_wwwdatatab.

DATA: ls_sel_button TYPE smp_dyntxt,
      ls_sel_button2 TYPE smp_dyntxt.

DATA : endda TYPE sy-datum.


DATA : gv_index     TYPE sy-tabix,
       gv_start_col TYPE i VALUE '1',
       gv_start_row TYPE i VALUE '1',
       gv_end_col   TYPE i VALUE '256',
       gv_end_row   TYPE i VALUE '65526'.

DATA : sum TYPE i.

DATA : BEGIN OF gs_tab.
DATA : matnr(100) TYPE c,
       werks(100) TYPE c,
       day1(100) TYPE c,
       day2(100) TYPE c,
       day3(100) TYPE c,
       day4(100) TYPE c,
       day5(100) TYPE c,
       day6(100) TYPE c,
       day7(100) TYPE c,
       light TYPE icon-id,
       text TYPE string,
END OF gs_tab.

***************************************************************
*  DATA TYPE(나)
*  1. 엑셀에서 가져올 인터널 테이블&Workarea
*  2. 엑셀에서 데이터를 가져올 셀 데이터 및 필드심볼 선언.
*  3. ALV에 뿌려줄 인터널 테이블&Workarea
***************************************************************
DATA : it_tab LIKE TABLE OF gs_tab,
      wa_tab LIKE LINE OF it_tab.

DATA : gt_data TYPE kcde_cells OCCURS 0 WITH HEADER LINE.  "헤더라인과 같이 인터널테이블 선언.
FIELD-SYMBOLS : <gv_fs> TYPE ANY.                          "Structure


***************************************************************
*  DATA TYPE(다)
*  1. ALV 에 뿌려줄 데이터 선언.
*  2. 신호등에 뿌려줄 상수값들 선언.
*  3. 결과 ALV에 뿌려줄 데이터 구조체 및 인터널테이블 선언.
***************************************************************

DATA : alv_it_tab LIKE TABLE OF gs_tab,
      alv_wa_tab LIKE LINE OF alv_it_tab.

CONSTANTS: c_green TYPE icon-id VALUE '@08@',
c_yellow TYPE icon-id VALUE '@09@',
c_red TYPE icon-id VALUE '@0A@'.


DATA : re_it_tab LIKE TABLE OF gs_tab,         " 결과 ALV 인터널 테이블
      re_wa_tab LIKE LINE OF re_it_tab.        " 결과 ALV 출력 wa.

SELECTION-SCREEN FUNCTION KEY 1.
SELECTION-SCREEN FUNCTION KEY 2.
SELECTION-SCREEN FUNCTION KEY 3.

*----------------------------------------------------------------------*
*   data definition
*----------------------------------------------------------------------*
*       Batchinputdata of single transaction
DATA:   bdcdata LIKE bdcdata    OCCURS 0 WITH HEADER LINE.
*       messages of call transaction
DATA:   messtab LIKE bdcmsgcoll OCCURS 0 WITH HEADER LINE.
*       error session opened (' ' or 'X')
DATA:   e_group_opened.
*       message texts
TABLES: t100.


********************************************************
* ALV 데이터 선언.
********************************************************
DATA: ls_layo TYPE lvc_s_layo,
     lt_fcat TYPE lvc_t_fcat.
DATA : container TYPE REF TO cl_gui_custom_container,
      grid  TYPE REF TO cl_gui_alv_grid,
      ok_code TYPE sy-ucomm.

********************************************************
* 결과 ALV 데이터 선언.
********************************************************
DATA: ls_layo2 TYPE lvc_s_layo,
     lt_fcat2 TYPE lvc_t_fcat.
DATA : container2 TYPE REF TO cl_gui_custom_container,
      grid2  TYPE REF TO cl_gui_alv_grid.
*      ok_code TYPE sy-ucomm.


DATA err_text TYPE string.
*&--------------------------------------------------------------------&*
*&  STEP 2
*&--------------------------------------------------------------------&*
*& 1. 선언한 변수에 ICON과 여러 속성들을 정의해준다.
*&--------------------------------------------------------------------&*
INITIALIZATION.
************************************************************************
* 1. Application Toolbar 버튼 생성.
* 2. 파라미터 및 블록 설정.
************************************************************************
  ls_sel_button-icon_id = icon_xls.
  ls_sel_button-quickinfo = 'TEMPLATE DOWNLOAD'.
  ls_sel_button-icon_text = 'SMW0으로부터 템프릿 가져오기'.
  sscrfields-functxt_01 = ls_sel_button.

  ls_sel_button2-icon_id = icon_check.
  ls_sel_button2-quickinfo = 'Data Check'.
  ls_sel_button2-icon_text = 'BDC 데이터 사전 체크'.
  sscrfields-functxt_02 = ls_sel_button2.

  SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE text-001.
  PARAMETERS filepath TYPE char128.
  SELECTION-SCREEN END OF BLOCK block1.
  SELECTION-SCREEN BEGIN OF BLOCK block2 WITH FRAME TITLE text-002.
  PARAMETERS begda TYPE sy-datum.                                                        " 시작일 파라미터.
  PARAMETERS: p_mode TYPE c DEFAULT 'N'.                                                 " 백그라운드 작업.
  SELECTION-SCREEN END OF BLOCK block2.

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
