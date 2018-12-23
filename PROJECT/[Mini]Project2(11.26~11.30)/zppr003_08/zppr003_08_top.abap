*&---------------------------------------------------------------------*
*& Include ZPPR003_08_TOP                                    Report ZPPR003_08
*&
*&---------------------------------------------------------------------*

REPORT   ZPPR003_08.
************************************************************************
* 인터널 테이블 구조체 선언                                            *
************************************************************************
DATA: BEGIN OF gt_itab OCCURS 0,
       aufnr(100)  TYPE c,
       werks(100)  TYPE c,
       plnbez(100)  TYPE c,
       vornr(100)  TYPE c,
       arbpl(100)  TYPE c,
       ltxa1(100)  TYPE c,
       gamng(100)  TYPE c,
       gmein(100)  TYPE c,
       END OF gt_itab.
DATA : it_tab LIKE TABLE OF gt_itab,
      wa_tab LIKE LINE OF it_tab.

************************************************************************
* 인터널 테이블 구조체 선언*                                           *
************************************************************************
DATA : gv_index     TYPE sy-tabix,
       gv_start_col TYPE i VALUE '1',
       gv_start_row TYPE i VALUE '1',
       gv_end_col   TYPE i VALUE '256',
       gv_end_row   TYPE i VALUE '65526'.

DATA : gt_data TYPE kcde_cells OCCURS 0 WITH HEADER LINE.

FIELD-SYMBOLS : <gv_fs> TYPE ANY.
************************************************************************
* ALV                                                                  *
************************************************************************
DATA : container TYPE REF TO cl_gui_custom_container,
       grid TYPE REF TO cl_gui_alv_grid,
       ok_code TYPE sy-ucomm.

DATA: ls_layo TYPE lvc_s_layo,
     lt_fcat TYPE lvc_t_fcat.



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
* 파라미터                                                             *
************************************************************************
PARAMETERS: p_fname TYPE char128.
PARAMETERS: p_mode TYPE c DEFAULT 'N'.                                                 " 백그라운드 작업.

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
