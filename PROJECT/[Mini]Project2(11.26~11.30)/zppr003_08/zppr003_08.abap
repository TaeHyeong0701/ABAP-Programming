*&---------------------------------------------------------------------*
*& Report  ZPPR003_08
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

INCLUDE ZPPR003_08_TOP                          .    " global Data

 INCLUDE ZPPR003_08_O01                          .  " PBO-Modules
 INCLUDE ZPPR003_08_I01                          .  " PAI-Modules
INCLUDE ZPPR003_08_F01                          .  " FORM-Routines
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_fname.
  CALL FUNCTION 'F4_FILENAME'                             " F4기능을 넣는다.
    IMPORTING
      file_name = p_fname.                                " 어떤 디렉터리에 무슨 파일이고 해당파일은뭐다.

START-OF-SELECTION.
PERFORM excel_upload.
PERFORM bdc_co11n.

  DELETE it_tab INDEX 1.
  CALL SCREEN 100.


*Selection texts
*----------------------------------------------------------
* P_FNAME         파일명

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
