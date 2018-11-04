*&---------------------------------------------------------------------*
*&  Include           Z_TH0701_TYPE_M_PRACTICE_1_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE click_code.
    WHEN 'PI'. "Physical Information 버튼 키값.
      click_id = 1.

    WHEN 'SI'. "Salary Information 버튼 키값.
      click_id = 2.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  DATA_EXRACT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE data_exract INPUT.
  SELECT SINGLE * FROM zthsoccer
    INTO wo_zthsoccer
    WHERE name = zthsoccer-name.

ENDMODULE.                 " DATA_EXRACT  INPUT