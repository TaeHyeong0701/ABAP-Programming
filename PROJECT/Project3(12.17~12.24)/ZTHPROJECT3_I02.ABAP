*&---------------------------------------------------------------------*
*&  Include           ZPPR0003_08_I02
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module USER_COMMAND_0200 input.
  CLEAR ALV_IT_TAB.
  CLEAR ALV_WA_TAB.
CASE OK_CODE.
  WHEN 'BACK'.
  LEAVE TO SCREEN 0.
    ENDCASE.
endmodule.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module EXIT2 input.
    CLEAR ALV_IT_TAB.
  CLEAR ALV_WA_TAB.
CASE OK_CODE.
  WHEN 'EXIT' or 'CANCEL'.
  LEAVE PROGRAM.
    ENDCASE.
endmodule.                 " EXIT  INPUT

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
