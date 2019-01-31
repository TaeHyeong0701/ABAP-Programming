*&---------------------------------------------------------------------*
*& Report  ZPPR0012_08
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

INCLUDE zppr0012_08_top.    " global Data

INCLUDE zppr0012_08_o01.  " PBO-Modules
INCLUDE zppr0012_08_i01.  " PAI-Modules
INCLUDE zppr0012_08_f01.  " FORM-Routines

START-OF-SELECTION.
clear ch_num.
  PERFORM fetch_data.
  IF radio1 = 'X'.
    ch_num = 1.
  ELSEIF radio2 = 'X'.
    ch_num = 2.
    PERFORM select_check.
  ELSEIF radio3 = 'X'.
    ch_num = 3.
    PERFORM select_not.
  ENDIF.
  CALL SCREEN 100.

*Text elements
*----------------------------------------------------------
* 001 ALL
* 002 CHECK
* 003 NOT


*Selection texts
*----------------------------------------------------------
* RADIO1         ALL
* RADIO2         CHECK
* RADIO3         NOT CHECK
* S_MATNR         자재번호
* S_WERKS         플랜트


*Messages
*----------------------------------------------------------
*
* Message class: Hard coded
*   원하시는 값이 ZPPT0011_08테이블에는 값이 없습니다.

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
