*&---------------------------------------------------------------------*
*&  Include           MZ_TH_MINI_PROJECT1_1I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      CLEAR th_matnr.
      CLEAR result_tab.
      LEAVE TO SCREEN 0.
    WHEN 'EXECUTE'(001) OR 'ENTER'.
      PERFORM fetch_data.
      CALL SCREEN 200.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.                 " EXIT  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
************************************************************************
* Gabage 정리.
************************************************************************
      CLEAR result_tab.
      CLEAR th_matnr.
      CLEAR zsft00108.
      LEAVE TO SCREEN 0.
    WHEN 'CHANGE' OR 'SAVE'.
      CLEAR row.
      LOOP AT SCREEN.
        screen-input = 1.
        MODIFY SCREEN.
      ENDLOOP.
      SELECT *
        FROM zsft00108 INTO TABLE it_tab.

      LOOP AT it_tab INTO wa_tab.
************************************************************************
*  새로운 행을 더해준다.
************************************************************************
        row = row + 1.
      ENDLOOP.
************************************************************************
*   새로운 행에 데이터를 삽입해준다.
************************************************************************
      result_tab-seqnr = row + 1.
      result_tab-matnr = zsft00108-matnr.
      result_tab-maktx = zsft00108-maktx.
      result_tab-matkl = zsft00108-matkl.
      result_tab-mtart = zsft00108-mtart.
      result_tab-meins = zsft00108-meins.
      result_tab-ersda = zsft00108-ersda.
      result_tab-laeda = zsft00108-laeda.
      result_tab-ernam = zsft00108-ernam.
      result_tab-aenam = zsft00108-aenam.
      result_tab-mtbez = t134t-mtbez.
*        MESSAGE '데이터가 생성되었습니다.' TYPE 'I'.
*      ENDIF.
      IF isinitial = 0.
        MESSAGE 'Create Data Complete!!' TYPE 'S'.
      ELSE.
        MESSAGE 'Update Data Complete!!' TYPE 'S'.
      ENDIF.
      CLEAR it_tab.
************************************************************************
*   추가한 데이터들을 반영시켜준다.
************************************************************************
      MODIFY zsft00108 FROM result_tab.
      CLEAR wa_tab.
  ENDCASE.
*&-----------------------------------------------------------------
ENDMODULE.                 " USER_COMMAND_0200  INPUT

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
