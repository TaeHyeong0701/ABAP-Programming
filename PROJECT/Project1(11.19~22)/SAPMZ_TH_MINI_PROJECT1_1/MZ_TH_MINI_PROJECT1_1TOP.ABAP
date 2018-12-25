*&---------------------------------------------------------------------*
*& Include MZ_TH_MINI_PROJECT1_1TOP                          Module Pool      SAPMZ_TH_MINI_PROJECT1_1
*&
*&---------------------------------------------------------------------*
************************************************************************
*  Written By TaeHyeong
*  Reporting Date: '18.12.24
*  Development term: '18.11.19~21
************************************************************************
PROGRAM  sapmz_th_mini_project1_1.
************************************************************************
* Tables ---> 스크린 페인터와 연동하기 위하여.
* 1. CBO테이블
* 2. T134T테이블
************************************************************************
TABLES zsft00108.
TABLES t134t.

************************************************************************
* Data
* 1. ok_code    ---> 첫 번째 스크린
* 2. ok_code200 ---> 두 번째 스크린.
* 3. icon삽입을 위한 변수들 생성
************************************************************************
DATA : ok_code TYPE sy-ucomm.
DATA : ok_code200 TYPE sy-ucomm.
DATA : status_200 TYPE i.
DATA : status_200_icon TYPE string.
DATA : th_matnr TYPE mara-matnr.

************************************************************************
*
************************************************************************
DATA : result1_tab TYPE zsft00108. "

DATA : BEGIN OF gs_tab.
        INCLUDE STRUCTURE zsft00108.
DATA : mtbez TYPE t134t-mtbez,
      wgbez  TYPE t023t-wgbez,
      END OF gs_tab.

DATA : it_tab LIKE TABLE OF gs_tab.
DATA : wa_tab LIKE LINE OF it_tab.
DATA : row TYPE i.
*DATA : 100_MATNR TYPE mara-MATNR.
DATA : isinitial TYPE i.
DATA : trans_matnr TYPE matnr.

DATA : it_t134t_tab TYPE TABLE OF t134t,
      wa_t134t_tab LIKE LINE OF it_t134t_tab.
DATA : result_tab LIKE gs_tab.

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
