*&---------------------------------------------------------------------*
*& Include MZ_TH_MINI_PROJECT1_1TOP                          Module Pool      SAPMZ_TH_MINI_PROJECT1_1
*&
*&---------------------------------------------------------------------*

PROGRAM  SAPMZ_TH_MINI_PROJECT1_1.
TABLES ZSFT00108.
TABLES T134T.
DATA : OK_CODE TYPE sy-ucomm.
DATA : OK_CODE200 TYPE sy-ucomm.
DATA : status_200 TYPE i.
DATA : status_200_icon TYPE string.
DATA : th_matnr TYPE mara-matnr.


DATA : result1_tab TYPE ZSFT00108. "

DATA : BEGIN OF gs_tab.
  include STRUCTURE ZSFT00108.
  DATA : MTBEZ TYPE T134T-MTBEZ,
        WGBEZ  TYPE T023T-WGBEZ,
        END OF gs_tab.

DATA : it_tab like TABLE OF gs_tab.
DATA : wa_tab LIKE LINE OF it_tab.
DATA : row TYPE i.
*DATA : 100_MATNR TYPE mara-MATNR.
DATA : isinitial TYPE i.
DATA : trans_matnr TYPE matnr.

DATA : it_t134t_tab TYPE TABLE OF t134t,
      wa_t134t_tab like LINE OF it_t134t_tab.
DATA : result_tab LIKE gs_tab.