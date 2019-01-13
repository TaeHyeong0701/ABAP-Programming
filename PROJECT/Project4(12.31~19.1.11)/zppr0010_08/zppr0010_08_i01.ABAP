*&---------------------------------------------------------------------*
*&  Include           ZPPR0010_08_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN '&BOM'.
            refresh it_reu_tab.
PERFORM get_selected_rows.
IF index_rows is INITIAL.
  MESSAGE '행들을 선택해주세요' TYPE 'I'.
  ELSE.

***********************************************************************
*  BDC 실행한다.
***********************************************************************
      PERFORM bdc_cs01.
        PERFORM display_reuse.
*      LEAVE TO SCREEN 0.
  ENDIF.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'EXIT' OR 'CANCEL'.
      LEAVE PROGRAM.

  ENDCASE.
ENDMODULE.                 " EXIT  INPUT

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
