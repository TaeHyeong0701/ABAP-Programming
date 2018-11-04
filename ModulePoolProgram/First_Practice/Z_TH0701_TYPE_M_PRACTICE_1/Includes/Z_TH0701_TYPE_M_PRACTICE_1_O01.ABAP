*&---------------------------------------------------------------------*
*&  Include           Z_TH0701_TYPE_M_PRACTICE_1_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_screen OUTPUT.
  MOVE-CORRESPONDING wo_zthsoccer TO zthsoccer.
  IF click_id = '1'.
    CALL SCREEN 120
    STARTING AT 10 10
    ENDING AT 50 30.

  ELSEIF click_id = '2'.
    CALL SCREEN 130
    STARTING AT 10 10
    ENDING AT 50 20.
  ENDIF.
ENDMODULE.                 " MODIFY_SCREEN  OUTPUT