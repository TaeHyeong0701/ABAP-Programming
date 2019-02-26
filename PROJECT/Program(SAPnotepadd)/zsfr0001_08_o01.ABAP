*&---------------------------------------------------------------------*
*&  Include           ZSFR0001_00_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.

  IF G_PDF_CONT IS INITIAL.                 "## CONTAINER ##
    CREATE OBJECT G_PDF_CONT
      EXPORTING
        CONTAINER_NAME = 'PDF_CONT'.
    CREATE OBJECT G_PDF_CONTROL            "CREATE CONTROL
           EXPORTING
               PARENT = G_PDF_CONT.
  ENDIF.
  CALL METHOD G_PDF_CONTROL->LOAD_DATA
    EXPORTING
      SIZE         = PDF_FSIZE
      TYPE         = 'APPLICATION'
      SUBTYPE      = 'PDF'
    IMPORTING
      ASSIGNED_URL = URL               "PDF FILE NAME
    CHANGING
      DATA_TABLE   = PDF_LINE_TAB[].   "####

  CALL METHOD G_PDF_CONTROL->SHOW_DATA       "####
       EXPORTING
           URL          = URL.

* ## flush
*  CALL METHOD cl_gui_cfw=>flush.
*
*  CALL METHOD g_html_control->show_data
*    EXPORTING
*      url = url.

ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0200 OUTPUT.
  SET PF-STATUS '0200'.
  SET TITLEBAR '0200'.

  DATA : LT_LIST TYPE VRM_VALUES,
         LS_LIST TYPE VRM_VALUE,
         L_ID    TYPE VRM_ID,
         LS_T    TYPE CHAR50,
         LT_T    LIKE TABLE OF LS_T.

  REFRESH LT_LIST.

  IF ZSFT00_001-CDATE IS INITIAL.
    ZSFT00_001-CDATE = P_CDATE.

  ENDIF.

*# ## list box
  LS_LIST-KEY  = '1'.
  LS_LIST-TEXT = '#'.
  APPEND LS_LIST TO LT_LIST. CLEAR LS_LIST.

  LS_LIST-KEY  = '2'.
  LS_LIST-TEXT = '#'.
  APPEND LS_LIST TO LT_LIST. CLEAR LS_LIST.

  LS_LIST-KEY  = '3'.
  LS_LIST-TEXT = '#'.
  APPEND LS_LIST TO LT_LIST.  CLEAR LS_LIST.

  LS_LIST-KEY  = '4'.
  LS_LIST-TEXT = '#'.
  APPEND LS_LIST TO LT_LIST. CLEAR LS_LIST.

  LS_LIST-KEY  = '5'.
  LS_LIST-TEXT = '#'.
  APPEND LS_LIST TO LT_LIST. CLEAR LS_LIST.

  L_ID = 'ZSFT00_001-TEAMS'.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      ID     = L_ID
      VALUES = LT_LIST.

*### #### #### ##
  IF G_CONT IS INITIAL.
    CREATE OBJECT G_CONT
      EXPORTING
        CONTAINER_NAME = 'G_CONT'.

    CREATE OBJECT G_TEXT
      EXPORTING
        PARENT = G_CONT.

  ENDIF.

ENDMODULE.                 " STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  STATUS_0300  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_0300 OUTPUT.
  DATA: L_DATE(20).

*### #### ##
  CONCATENATE P_CDATE(4) '#' P_CDATE+4(2) '#'
  P_CDATE+6(2)'#' INTO L_DATE.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0300' WITH L_DATE.

*### #### #### ##
  PERFORM CREATE_CONT.

*### ##
  PERFORM READ_TEXT.

ENDMODULE.                 " STATUS_0300  OUTPUT

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2019. Sap Release 701
