*&--------------------------------------------------------------------*
*& Written By TaeHyeong
*& Reporting Date : `19.01.04
*&---------------------------------------------------------------------*
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module MODIFY_SCREEN output.
LOOP AT SCREEN.
************************************************************************
* Hide Screen Layout : p_mode (input-field), Text1(text-field)
************************************************************************
  if SCREEN-NAME = 'P_MODE' OR screen-name = 'TEXT1'.
  IF radio2 = 'X'.
************************************************************************
* 조건이 일치하면, input과 output의 스크린 값을 제거하고, invisible을 활성화시켜주면 된다.
************************************************************************
  screen-input = 0.
  screen-output = 0.
  screen-invisible = 1.
  ENDIF.
  ENDIF.
  MODIFY SCREEN.
  ENDLOOP.
endmodule.                 " MODIFY_SCREEN  OUTPUT