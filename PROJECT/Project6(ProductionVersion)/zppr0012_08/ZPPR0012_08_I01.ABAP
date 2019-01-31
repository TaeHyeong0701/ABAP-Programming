*&---------------------------------------------------------------------*
*&  Include           ZPPR0012_08_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module USER_COMMAND_0100 input.
  CASE OK_CODE.
    WHEN 'BACK'.
    LEAVE TO SCREEN 0.
    WHEN 'FCK1'.
    PERFORM get_selected_rows.
    PERFORM BDC_C223.
    ENDCASE.
endmodule.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module EXIT input.
CASE OK_CODE.
    WHEN 'EXIT' OR  'CANCEL'.
    LEAVE PROGRAM.
ENDCASE.
endmodule.                 " EXIT  INPUT

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
