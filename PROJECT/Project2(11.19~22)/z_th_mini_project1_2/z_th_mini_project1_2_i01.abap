*&---------------------------------------------------------------------*
*&  Include           Z_TH_MINI_PROJECT1_2_I01
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

    WHEN 'MAINTAIN'.
      PERFORM maintain_view.
* --------------------------------------------------------------------- Find Function Start.
    WHEN '%SC'.
      CALL METHOD grid->set_function_code
        CHANGING
          c_ucomm = ok_code.
* --------------------------------------------------------------------- Find Function END.
    WHEN 'ASCENDING'.
      sort_matnr = 0.
    WHEN 'DESCENDING'.
      sort_matnr = 1.
  ENDCASE.

ENDMODULE.                 " USER_COMMAND_0100  INPUT

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
