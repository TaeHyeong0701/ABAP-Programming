*&---------------------------------------------------------------------*
*&  Include           ZSFR0001_00_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  PRINT_SMARTFORMS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM PRINT_SMARTFORMS .
  DATA: L_DATE(20),
        LS_TAB LIKE LINE OF GT_TAB.

  CONCATENATE SY-DATUM(4) '#' SY-DATUM+4(2) '#' SY-DATUM+6(2) '#'
  INTO L_DATE.

  LS_TAB-MATNR = 'AD-333-300'.
  LS_TAB-MAKTX = 'Purchased Material - Date from Eff'.
  APPEND LS_TAB TO GT_TAB. CLEAR LS_TAB.

  LS_TAB-MATNR = 'AT-999-999'.
  LS_TAB-MAKTX = 'ATOM LEG'.
  APPEND LS_TAB TO GT_TAB. CLEAR LS_TAB.

  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      FORMNAME           = 'ZSF_00_001'
    IMPORTING
      FM_NAME            = FUNC_MOD_NAME
    EXCEPTIONS
      NO_FORM            = 1
      NO_FUNCTION_MODULE = 2
      OTHERS             = 3.

  CONTROL_PARAMETERS-NO_DIALOG = 'X'.
  CONTROL_PARAMETERS-GETOTF = 'X'.
  OUTPUT_OPTIONS-TDIMMED = 'X'.
  OUTPUT_OPTIONS-TDDELETE = 'X'.
  OUTPUT_OPTIONS-TDNEWID = 'X'.
  CONTROL_PARAMETERS-LANGU = '3'.
  CLEAR JOB_OUTPUT_INFO.

  CALL FUNCTION '/1BCDWB/SF00000205' "func_mod_name
    EXPORTING
      CONTROL_PARAMETERS = CONTROL_PARAMETERS
      OUTPUT_OPTIONS     = OUTPUT_OPTIONS
      USER_SETTINGS      = SPACE
      SUBRC              = SUBRC
      DATE1              = L_DATE
    IMPORTING
      JOB_OUTPUT_INFO    = JOB_OUTPUT_INFO
    TABLES
      TAB                = GT_TAB
    EXCEPTIONS
      FORMATTING_ERROR   = 1
      INTERNAL_ERROR     = 2
      SEND_ERROR         = 3
      USER_CANCELED      = 4
      OTHERS             = 5.

*  IF subrc IS INITIAL.
*    PERFORM call_pdf.          "PDF ##
*
*  ELSE.
*    MESSAGE s016(pn) WITH '### ## ### ####.'.
*
*  ENDIF.


ENDFORM.                    " PRINT_SMARTFORMS
*&---------------------------------------------------------------------*
*&      Form  CALL_PDF
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CALL_PDF .
  DATA : LT_DUMMY       TYPE STANDARD TABLE OF DOCS.

  OTF_TAB[] = JOB_OUTPUT_INFO-OTFDATA[].         "####

*  CALL FUNCTION 'CONVERT_OTF'
*    EXPORTING
*      format                = 'PDF'        "FORMAT
*    IMPORTING
*      bin_filesize          = pdf_fsize    "SIZE
*    TABLES
*      otf                   = otf_tab      "####
*      lines                 = pdf_table    "PDF# DATA
*    EXCEPTIONS
*      err_max_linewidth     = 1
*      err_format            = 2
*      err_conv_not_possible = 3
*      OTHERS                = 4.

  CALL FUNCTION 'CONVERT_OTF_2_PDF'   "OTF# PDF# #### ##
      IMPORTING
        BIN_FILESIZE           = PDF_FSIZE
      TABLES
        OTF                    = OTF_TAB
        DOCTAB_ARCHIVE         = LT_DUMMY
        LINES                  = PDF_TABLE
      EXCEPTIONS
        ERR_CONV_NOT_POSSIBLE  = 1
        ERR_OTF_MC_NOENDMARKER = 2
        OTHERS                 = 3.

  PDF_LINE_TAB[] = PDF_TABLE[].

  CALL SCREEN 100.                            "SCREEN 2000# ##

ENDFORM.                    " CALL_PDF
*&---------------------------------------------------------------------*
*&      Form  CREATE_CONT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CREATE_CONT .
  IF CONT1 IS INITIAL.
    CREATE OBJECT CONT1
      EXPORTING
        CONTAINER_NAME = 'CONT1'.

    CREATE OBJECT TEXT1
      EXPORTING
        PARENT = CONT1.

    CALL METHOD TEXT1->SET_READONLY_MODE
      EXPORTING
        READONLY_MODE          = 1
      EXCEPTIONS
        ERROR_CNTL_CALL_METHOD = 1
        INVALID_PARAMETER      = 2
        OTHERS                 = 3.

    CALL METHOD: TEXT1->SET_TOOLBAR_MODE
      EXPORTING TOOLBAR_MODE = '0'.

    CALL METHOD: TEXT1->SET_STATUSBAR_MODE
      EXPORTING STATUSBAR_MODE = '0'.

  ENDIF.

  IF CONT2 IS INITIAL.
    CREATE OBJECT CONT2
      EXPORTING
        CONTAINER_NAME = 'CONT2'.

    CREATE OBJECT TEXT2
      EXPORTING
        PARENT = CONT2.

    CALL METHOD TEXT2->SET_READONLY_MODE
      EXPORTING
        READONLY_MODE          = 1
      EXCEPTIONS
        ERROR_CNTL_CALL_METHOD = 1
        INVALID_PARAMETER      = 2
        OTHERS                 = 3.

    CALL METHOD: TEXT2->SET_TOOLBAR_MODE
      EXPORTING TOOLBAR_MODE = '0'.

    CALL METHOD: TEXT2->SET_STATUSBAR_MODE
      EXPORTING STATUSBAR_MODE = '0'.

  ENDIF.

  IF CONT3 IS INITIAL.
    CREATE OBJECT CONT3
      EXPORTING
        CONTAINER_NAME = 'CONT3'.

    CREATE OBJECT TEXT3
      EXPORTING
        PARENT = CONT3.

    CALL METHOD TEXT3->SET_READONLY_MODE
      EXPORTING
        READONLY_MODE          = 1
      EXCEPTIONS
        ERROR_CNTL_CALL_METHOD = 1
        INVALID_PARAMETER      = 2
        OTHERS                 = 3.

    CALL METHOD: TEXT3->SET_TOOLBAR_MODE
      EXPORTING TOOLBAR_MODE = '0'.

    CALL METHOD: TEXT3->SET_STATUSBAR_MODE
      EXPORTING STATUSBAR_MODE = '0'.

  ENDIF.

  IF CONT4 IS INITIAL.
    CREATE OBJECT CONT4
      EXPORTING
        CONTAINER_NAME = 'CONT4'.

    CREATE OBJECT TEXT4
      EXPORTING
        PARENT = CONT4.

    CALL METHOD TEXT4->SET_READONLY_MODE
      EXPORTING
        READONLY_MODE          = 1
      EXCEPTIONS
        ERROR_CNTL_CALL_METHOD = 1
        INVALID_PARAMETER      = 2
        OTHERS                 = 3.

    CALL METHOD: TEXT4->SET_TOOLBAR_MODE
      EXPORTING TOOLBAR_MODE = '0'.

    CALL METHOD: TEXT4->SET_STATUSBAR_MODE
      EXPORTING STATUSBAR_MODE = '0'.

  ENDIF.

  IF CONT5 IS INITIAL.
    CREATE OBJECT CONT5
      EXPORTING
        CONTAINER_NAME = 'CONT5'.

    CREATE OBJECT TEXT5
      EXPORTING
        PARENT = CONT5.

    CALL METHOD TEXT5->SET_READONLY_MODE
      EXPORTING
        READONLY_MODE          = 1
      EXCEPTIONS
        ERROR_CNTL_CALL_METHOD = 1
        INVALID_PARAMETER      = 2
        OTHERS                 = 3.

    CALL METHOD: TEXT5->SET_STATUSBAR_MODE
      EXPORTING STATUSBAR_MODE = '0'.

    CALL METHOD: TEXT5->SET_TOOLBAR_MODE
      EXPORTING TOOLBAR_MODE = '0'.

  ENDIF.

ENDFORM.                    " CREATE_CONT
*&---------------------------------------------------------------------*
*&      Form  READ_TEXT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM READ_TEXT .
  DATA : LS_TAB2 LIKE LINE OF GT_TAB2,
         LT_TEXT TYPE TABLE OF CHAR50,
         LS_TEXT TYPE CHAR50.
  CLEAR LT_TEXT.
  ZSFT00_001-CDATE = P_CDATE.

*#### #### table ##
  SELECT * FROM ZSFT00_001
           INTO TABLE GT_TAB2
          WHERE CDATE = P_CDATE.

  CALL METHOD TEXT1->SET_TEXT_AS_R3TABLE
    EXPORTING
      TABLE = LT_TEXT.

  CALL METHOD TEXT2->SET_TEXT_AS_R3TABLE
    EXPORTING
      TABLE = LT_TEXT.

  CALL METHOD TEXT3->SET_TEXT_AS_R3TABLE
    EXPORTING
      TABLE = LT_TEXT.

  CALL METHOD TEXT4->SET_TEXT_AS_R3TABLE
    EXPORTING
      TABLE = LT_TEXT.

  CALL METHOD TEXT5->SET_TEXT_AS_R3TABLE
    EXPORTING
      TABLE = LT_TEXT.

  LOOP AT GT_TAB2 INTO LS_TAB2.
    CLEAR: LT_TEXT.
    SPLIT LS_TAB2-TEXT AT CL_ABAP_CHAR_UTILITIES=>NEWLINE
    INTO TABLE LT_TEXT.

    CASE LS_TAB2-TEAMS.
      WHEN '1'.
        CALL METHOD TEXT1->SET_TEXT_AS_R3TABLE
          EXPORTING
            TABLE = LT_TEXT.

      WHEN '2'.
        CALL METHOD TEXT2->SET_TEXT_AS_R3TABLE
          EXPORTING
            TABLE = LT_TEXT.

      WHEN '3'.
        CALL METHOD TEXT3->SET_TEXT_AS_R3TABLE
          EXPORTING
            TABLE = LT_TEXT.

      WHEN '4'.
        CALL METHOD TEXT4->SET_TEXT_AS_R3TABLE
          EXPORTING
            TABLE = LT_TEXT.

      WHEN '5'.
        CALL METHOD TEXT5->SET_TEXT_AS_R3TABLE
          EXPORTING
            TABLE = LT_TEXT.

      WHEN OTHERS.
    ENDCASE.

  ENDLOOP.

ENDFORM.                    " READ_TEXT
*&---------------------------------------------------------------------*
*&      Form  INTERVAL_DATE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_P_CDATE  text
*      -->P_1      text
*      -->P_0191   text
*----------------------------------------------------------------------*
FORM INTERVAL_DATE  USING    P_CDATE P_INT P_SIGN.
  CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'
    EXPORTING
      DATE      = P_CDATE
      DAYS      = P_INT
      MONTHS    = 0
      SIGNUM    = P_SIGN
      YEARS     = 0
    IMPORTING
      CALC_DATE = P_CDATE.

ENDFORM.                    " INTERVAL_DATE

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2019. Sap Release 701
