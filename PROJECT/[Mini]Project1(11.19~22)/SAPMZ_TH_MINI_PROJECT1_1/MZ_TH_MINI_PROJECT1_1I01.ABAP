*&---------------------------------------------------------------------*
*&  Include           MZ_TH_MINI_PROJECT1_1I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module USER_COMMAND_0100 input.
  CASE ok_code.
    WHEN 'BACK'.
      CLEAR th_matnr.
      CLEAR result_tab.
      LEAVE TO SCREEN 0.
    WHEN 'EXECUTE'(001) OR 'ENTER'.
      PERFORM fetch_data.
      CALL SCREEN 200.
  ENDCASE.
endmodule.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module EXIT input.
  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
  ENDCASE.

endmodule.                 " EXIT  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module USER_COMMAND_0200 input.
  CASE ok_code.
    WHEN 'BACK'.
      CLEAR result_tab.
      CLEAR th_matnr.
      clear zsft00108.
      LEAVE TO SCREEN 0.
    WHEN 'CHANGE' or 'SAVE'.
      CLEAR row.
      LOOP AT SCREEN.
        screen-input = 1.
        MODIFY SCREEN.
      ENDLOOP.
      SELECT *
        FROM zsft00108 INTO TABLE it_tab.

      LOOP AT it_tab INTO wa_tab.
        row = row + 1.
      ENDLOOP.

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
      MODIFY zsft00108 FROM result_tab.
      CLEAR wa_tab.
  ENDCASE.
*&-----------------------------------------------------------------
endmodule.                 " USER_COMMAND_0200  INPUT