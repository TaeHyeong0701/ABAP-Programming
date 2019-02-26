*&---------------------------------------------------------------------*
*&  Include           ZSFR0001_00_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
  CASE OK_CODE.
    WHEN 'BACK'.
      SET SCREEN 0.
  ENDCASE.

ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXIT INPUT.
  CASE OK_CODE.
    WHEN 'EXIT'.
      LEAVE PROGRAM.

    WHEN 'CANC'.
      LEAVE SCREEN.

  ENDCASE.

ENDMODULE.                 " EXIT  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0200 INPUT.
  DATA : LT_LINES TYPE TABLE OF CHAR100,
         LS_LINES TYPE CHAR100,
         LS_TAB2 LIKE LINE OF GT_TAB2,
         LT_TEXT TYPE TABLE OF CHAR50,
         LS_TEXT TYPE CHAR50.

  CLEAR: LT_LINES, LS_LINES, GT_TAB2, LT_TEXT.

  CASE OK_CODE.
    WHEN 'BACK'.
      SET SCREEN 0.

    WHEN 'TEAM'.
      ZSFT00_001-CDATE = P_CDATE.

*#### #### table ##
      SELECT * FROM ZSFT00_001
               INTO TABLE GT_TAB2
              WHERE CDATE = P_CDATE
                AND TEAMS = ZSFT00_001-TEAMS.

      LOOP AT GT_TAB2 INTO LS_TAB2.
        CLEAR: LT_TEXT.
        SPLIT LS_TAB2-TEXT AT CL_ABAP_CHAR_UTILITIES=>NEWLINE
        INTO TABLE LT_TEXT.

      ENDLOOP.

      CALL METHOD G_TEXT->SET_TEXT_AS_R3TABLE
        EXPORTING
          TABLE = LT_TEXT.

    WHEN 'SAVE'.      "##
*### ### #### ##
      CALL METHOD G_TEXT->GET_TEXT_AS_R3TABLE
        IMPORTING
          TABLE  = LT_LINES
        EXCEPTIONS
          OTHERS = 1.

*# ## ### ## ##
      LOOP AT LT_LINES INTO LS_LINES.
        CONCATENATE ZSFT00_001-TEXT
        LS_LINES CL_ABAP_CHAR_UTILITIES=>NEWLINE INTO ZSFT00_001-TEXT.

      ENDLOOP.

*#### ## ##
      ZSFT00_001-LENG = STRLEN( ZSFT00_001-TEXT ).
      APPEND ZSFT00_001 TO GT_TAB2.

*db ##
      MODIFY ZSFT00_001 FROM TABLE GT_TAB2.

      IF SY-SUBRC = 0.
        COMMIT WORK.
        MESSAGE S016 WITH '#######'.

      ELSE.
        ROLLBACK WORK.
        MESSAGE S016 WITH '## # ### #######'.
        EXIT.

      ENDIF.

  ENDCASE.

ENDMODULE.                 " USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0300 INPUT.
  CASE OK_CODE.
    WHEN 'BACK'.
      SET SCREEN 0.

    WHEN 'PREV'.
      PERFORM INTERVAL_DATE USING P_CDATE 1 '-'.

    WHEN 'NEXT'.
      PERFORM INTERVAL_DATE USING P_CDATE 1 '+'.

  ENDCASE.

ENDMODULE.                 " USER_COMMAND_0300  INPUT

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2019. Sap Release 701
