*&---------------------------------------------------------------------*
*& Report  ZPRGTEST09
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZPRGTEST09.

*  SAP Tables
TABLES: TRDIR, SEOCLASS, TFDIR, ENLFDIR, DD02L.

* text element structure
TYPES: TTEXTTABLE LIKE TEXTPOOL.
* GUI titles
TYPES: TGUITITLE LIKE D347T.

* Message classes
TYPES: BEGIN OF TMESSAGE,
         ARBGB LIKE T100-ARBGB,
         STEXT LIKE T100A-STEXT,
         MSGNR LIKE T100-MSGNR,
         TEXT  LIKE T100-TEXT,
       END OF TMESSAGE.

* Screen flow.
TYPES: BEGIN OF TSCREENFLOW,
         SCREEN LIKE D020S-DNUM,
         CODE LIKE D022S-LINE,
       END OF TSCREENFLOW.

* Holds a table\structure definition
TYPES: BEGIN OF TDICTTABLESTRUCTURE,
         FIELDNAME LIKE DD03L-FIELDNAME,
         POSITION  LIKE DD03L-POSITION,
         KEYFLAG   LIKE DD03L-KEYFLAG,
         ROLLNAME  LIKE DD03L-ROLLNAME,
         DOMNAME   LIKE DD03L-DOMNAME,
         DATATYPE  LIKE DD03L-DATATYPE,
         LENG      LIKE DD03L-LENG,
         DDTEXT    LIKE DD04T-DDTEXT,
       END OF TDICTTABLESTRUCTURE.

* Holds a tables attributes + its definition
TYPES: BEGIN OF TDICTTABLE,
         TABLENAME    LIKE DD03L-TABNAME,
         TABLETITLE   LIKE DD02T-DDTEXT,
         ISTRUCTURE TYPE TDICTTABLESTRUCTURE OCCURS 0,
       END OF TDICTTABLE.

* Include program names
TYPES: BEGIN OF TINCLUDE,
         INCLUDENAME LIKE TRDIR-NAME,
         INCLUDETITLE LIKE TFTIT-STEXT,
       END OF TINCLUDE.

* Exception class texts
TYPES: BEGIN OF TCONCEPT,
         CONSTNAME TYPE STRING,
         CONCEPT TYPE SOTR_CONC,
       END OF TCONCEPT.

* Method
TYPES: BEGIN OF TMETHOD,
         CMPNAME LIKE VSEOMETHOD-CMPNAME,
         DESCRIPT LIKE VSEOMETHOD-DESCRIPT,
         EXPOSURE LIKE VSEOMETHOD-EXPOSURE,
         METHODKEY TYPE STRING,
       END OF TMETHOD.

* Class
TYPES: BEGIN OF TCLASS,
         SCANNED(1),
         CLSNAME LIKE VSEOCLASS-CLSNAME,
         DESCRIPT LIKE VSEOCLASS-DESCRIPT,
         MSG_ID LIKE VSEOCLASS-MSG_ID,
         EXPOSURE LIKE VSEOCLASS-EXPOSURE,
         STATE LIKE VSEOCLASS-STATE,
         CLSFINAL LIKE VSEOCLASS-CLSFINAL,
         R3RELEASE LIKE VSEOCLASS-R3RELEASE,
         IMETHODS TYPE TMETHOD OCCURS 0,
         IDICTSTRUCT TYPE TDICTTABLE OCCURS 0,
         ITEXTELEMENTS TYPE TTEXTTABLE OCCURS 0,
         IMESSAGES TYPE TMESSAGE OCCURS 0,
         ICONCEPTS TYPE TCONCEPT OCCURS 0,
         TEXTELEMENTKEY TYPE STRING,
         PUBLICCLASSKEY TYPE STRING,
         PRIVATECLASSKEY TYPE STRING,
         PROTECTEDCLASSKEY TYPE STRING,
         TYPESCLASSKEY TYPE STRING,
         EXCEPTIONCLASS TYPE I,
       END OF TCLASS.

* function modules
TYPES: BEGIN OF TFUNCTION,
         FUNCTIONNAME LIKE TFDIR-FUNCNAME,
         FUNCTIONGROUP LIKE ENLFDIR-AREA,
         INCLUDENUMBER LIKE TFDIR-INCLUDE,
         FUNCTIONMAININCLUDE LIKE TFDIR-FUNCNAME,
         FUNCTIONTITLE LIKE TFTIT-STEXT,
         TOPINCLUDENAME LIKE TFDIR-FUNCNAME,
         PROGNAME LIKE TFDIR-PNAME,
         PROGRAMLINKNAME LIKE TFDIR-PNAME,
         MESSAGECLASS LIKE T100-ARBGB,
         ITEXTELEMENTS TYPE TTEXTTABLE OCCURS 0,
         ISELECTIONTEXTS TYPE TTEXTTABLE OCCURS 0,
         IMESSAGES TYPE TMESSAGE OCCURS 0,
         IINCLUDES TYPE TINCLUDE OCCURS 0,
         IDICTSTRUCT TYPE TDICTTABLE OCCURS 0,
         IGUITITLE TYPE TGUITITLE OCCURS 0,
         ISCREENFLOW TYPE TSCREENFLOW OCCURS 0,
       END OF TFUNCTION.

TYPES: BEGIN OF TPROGRAM,
         PROGNAME LIKE TRDIR-NAME,
         PROGRAMTITLE LIKE TFTIT-STEXT,
         SUBC LIKE TRDIR-SUBC,
         MESSAGECLASS LIKE T100-ARBGB,
         IMESSAGES TYPE TMESSAGE OCCURS 0,
         ITEXTELEMENTS TYPE TTEXTTABLE OCCURS 0,
         ISELECTIONTEXTS TYPE TTEXTTABLE OCCURS 0,
         IGUITITLE TYPE TGUITITLE OCCURS 0,
         ISCREENFLOW TYPE TSCREENFLOW OCCURS 0,
         IINCLUDES TYPE TINCLUDE OCCURS 0,
         IDICTSTRUCT TYPE TDICTTABLE OCCURS 0,
       END OF TPROGRAM.

*  Internal tables
*  Dictionary object
DATA: IDICTIONARY TYPE STANDARD TABLE OF TDICTTABLE WITH HEADER LINE.
* Function modules.
DATA: IFUNCTIONS TYPE STANDARD TABLE OF TFUNCTION WITH HEADER LINE.
* Tree display structure.
DATA: ITREEDISPLAY TYPE STANDARD TABLE OF SNODETEXT WITH HEADER LINE.
* Message class data
DATA: IMESSAGES TYPE STANDARD TABLE OF TMESSAGE WITH HEADER LINE.
* Holds a single message class an all of its messages
DATA: ISINGLEMESSAGECLASS TYPE STANDARD TABLE OF TMESSAGE
        WITH HEADER LINE.
* Holds program related data
DATA: IPROGRAMS TYPE STANDARD TABLE OF TPROGRAM WITH HEADER LINE.
* Classes
DATA: ICLASSES TYPE STANDARD TABLE OF TCLASS WITH HEADER LINE.
* Table of paths created on the SAP server
DATA: ISERVERPATHS TYPE STANDARD TABLE OF STRING WITH HEADER LINE.

*-----------------------------------------------------------------------
*  Table prototypes
*-----------------------------------------------------------------------
DATA: DUMIDICTSTRUCTURE TYPE STANDARD TABLE OF TDICTTABLESTRUCTURE.
DATA: DUMITEXTTAB TYPE STANDARD TABLE OF TTEXTTABLE.
DATA: DUMIINCLUDES TYPE STANDARD TABLE OF TINCLUDE.
DATA: DUMIHTML TYPE STANDARD TABLE OF STRING.
DATA: DUMIHEADER TYPE STANDARD TABLE OF STRING .
DATA: DUMISCREEN TYPE STANDARD TABLE OF TSCREENFLOW .
DATA: DUMIGUITITLE TYPE STANDARD TABLE OF TGUITITLE.
DATA: DUMIMETHODS TYPE STANDARD TABLE OF TMETHOD.
DATA: DUMICONCEPTS TYPE STANDARD TABLE OF TCONCEPT.

*-----------------------------------------------------------------------
*   Global objects
*-----------------------------------------------------------------------
DATA: OBJFILE TYPE REF TO CL_GUI_FRONTEND_SERVICES.
DATA: OBJRUNTIMEERROR TYPE REF TO CX_ROOT.

*-----------------------------------------------------------------------
*  Constants
*-----------------------------------------------------------------------
CONSTANTS: VERSIONNO TYPE STRING VALUE '1.3.1'.
CONSTANTS: TABLES TYPE STRING VALUE 'TABLES'.
CONSTANTS: TABLE TYPE STRING VALUE 'TABLE'.
CONSTANTS: LIKE TYPE STRING VALUE 'LIKE'.
CONSTANTS: TYPE TYPE STRING VALUE 'TYPE'.
CONSTANTS: TYPEREFTO TYPE STRING VALUE 'TYPE REF TO'.
CONSTANTS: STRUCTURE TYPE STRING VALUE 'STRUCTURE'.
CONSTANTS: LOWSTRUCTURE TYPE STRING VALUE 'structure'.
CONSTANTS: OCCURS TYPE STRING VALUE 'OCCURS'.
CONSTANTS: FUNCTION TYPE STRING VALUE 'FUNCTION'.
CONSTANTS: CALLFUNCTION TYPE STRING VALUE ' CALL FUNCTION'.
CONSTANTS: MESSAGE TYPE STRING  VALUE 'MESSAGE'.
CONSTANTS: INCLUDE TYPE STRING VALUE 'INCLUDE'.
CONSTANTS: LOWINCLUDE TYPE STRING VALUE 'include'.
CONSTANTS: DESTINATION TYPE STRING VALUE 'DESTINATION'.
CONSTANTS: IS_TABLE TYPE STRING VALUE 'T'.
CONSTANTS: IS_PROGRAM TYPE STRING VALUE 'P'.
CONSTANTS: IS_SCREEN TYPE STRING VALUE 'S'.
CONSTANTS: IS_GUITITLE TYPE STRING VALUE 'G'.
CONSTANTS: IS_DOCUMENTATION TYPE STRING VALUE 'D'.
CONSTANTS: IS_MESSAGECLASS TYPE STRING VALUE 'MC'.
CONSTANTS: IS_FUNCTION TYPE STRING VALUE 'F'.
CONSTANTS: IS_CLASS TYPE STRING VALUE 'C'.
CONSTANTS: IS_METHOD TYPE STRING VALUE 'M'.
CONSTANTS: ASTERIX TYPE STRING VALUE '*'.
CONSTANTS: COMMA TYPE STRING VALUE ','.
CONSTANTS: PERIOD TYPE STRING VALUE '.'.
CONSTANTS: DASH TYPE STRING VALUE '-'.
CONSTANTS: TRUE TYPE I VALUE 1.
CONSTANTS: FALSE TYPE I VALUE 0.
CONSTANTS: LT TYPE STRING VALUE '&lt;'.
CONSTANTS: GT TYPE STRING VALUE '&gt;'.
CONSTANTS: UNIX TYPE STRING VALUE 'UNIX'.
CONSTANTS: NON_UNIX TYPE STRING VALUE 'not UNIX'.
CONSTANTS: BACKGROUND_COLOUR TYPE STRING VALUE '#FFFFE0'.
CONSTANTS: COLOUR_WHITE TYPE STRING VALUE '#FFFFFF'.
CONSTANTS: COLOUR_BLACK TYPE STRING VALUE '#000000'.
CONSTANTS: COLOUR_YELLOW TYPE STRING VALUE '#FFFF00'.
CONSTANTS: COMMENT_COLOUR TYPE STRING VALUE '#0000FF'.
CONSTANTS: HTMLEXTENSION TYPE STRING VALUE 'html'.
CONSTANTS: TEXTEXTENSION TYPE STRING VALUE 'txt'.

*-----------------------------------------------------------------------
*  Global variables
*-----------------------------------------------------------------------
DATA: STATUSBARMESSAGE(100).
DATA: FORCEDEXIT TYPE I VALUE 0.
DATA: STARTTIME LIKE SY-UZEIT.
DATA: RUNTIME LIKE SY-UZEIT.
DATA: DOWNLOADFILEEXTENSION TYPE STRING.
DATA: DOWNLOADFOLDER TYPE STRING.
DATA: SERVERSLASHSEPARATOR TYPE STRING.
DATA: FRONTENDSLASHSEPARATOR TYPE STRING.
DATA: SLASHSEPARATORTOUSE TYPE STRING.
DATA: SERVERFILESYSTEM TYPE FILESYS_D.
DATA: SERVERFOLDER TYPE STRING.
DATA: FRONTENDOPSYSTEM TYPE STRING.
DATA: SERVEROPSYSTEM TYPE STRING.
DATA: CUSTOMERNAMESPACE TYPE STRING.
RANGES: SOPROGRAMNAME FOR TRDIR-NAME.
RANGES: SOAUTHOR FOR USR02-BNAME.
RANGES: SOTABLENAMES FOR DD02L-TABNAME.
RANGES: SOFUNCTIONNAME  FOR TFDIR-FUNCNAME.
RANGES: SOCLASSNAME FOR VSEOCLASS-CLSNAME.
RANGES: SOFUNCTIONGROUP FOR ENLFDIR-AREA.
FIELD-SYMBOLS: <WADICTSTRUCT> TYPE TDICTTABLE.

*-----------------------------------------------------------------------
*  Selection screen declaration
*-----------------------------------------------------------------------
* Author
SELECTION-SCREEN: BEGIN OF BLOCK B1 WITH FRAME TITLE TBLOCK1.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 5(23) TAUTH.
PARAMETERS: PAUTH LIKE USR02-BNAME.   " memory id MAUTH. "HAN
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 5(36) TPMOD.
PARAMETERS: PMOD AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF LINE.

* Local objects
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 5(36) T$TMP.
PARAMETERS: P$TMP AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN: END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME TITLE TBLOCK2.
* Tables
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: RTABLE RADIOBUTTON GROUP R1.
SELECTION-SCREEN COMMENT 5(15) TRTABLE.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(15) TPTABLE.
SELECT-OPTIONS: SOTABLE FOR DD02L-TABNAME.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(79) TTNOTE.
SELECTION-SCREEN END OF LINE.

* Message classes
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: RMESS RADIOBUTTON GROUP R1.
SELECTION-SCREEN COMMENT 5(18) TPMES.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(18) TMNAME.
PARAMETERS: PMNAME LIKE T100-ARBGB MEMORY ID MMNAME.
SELECTION-SCREEN END OF LINE.

* Function modules
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: RFUNC RADIOBUTTON GROUP R1.
SELECTION-SCREEN COMMENT 5(30) TRFUNC.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(15) TPFNAME.
SELECT-OPTIONS: SOFNAME FOR TFDIR-FUNCNAME.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(15) TFGROUP.
SELECT-OPTIONS: SOFGROUP FOR ENLFDIR-AREA.
SELECTION-SCREEN END OF LINE.

* Classes
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: RCLASS RADIOBUTTON GROUP R1.
SELECTION-SCREEN COMMENT 5(30) TRCLASS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(15) TPCNAME.
SELECT-OPTIONS: SOCLASS FOR SEOCLASS-CLSNAME.
SELECTION-SCREEN END OF LINE.

* Programs / includes
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: RPROG RADIOBUTTON GROUP R1 DEFAULT 'X'.
SELECTION-SCREEN COMMENT 5(18) TPROG.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(15) TRPNAME.
SELECT-OPTIONS: SOPROG FOR TRDIR-NAME.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN SKIP.
* Language
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(18) TMLANG.
PARAMETERS: PMLANG LIKE T100-SPRSL DEFAULT '3'.  "SY-LANGU. HAN
SELECTION-SCREEN END OF LINE.

* Package
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(18) TPACK.
PARAMETERS: PPACK LIKE TADIV-DEVCLASS MEMORY ID MPACK.
SELECTION-SCREEN END OF LINE.

* Customer objects
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(27) TCUST.
PARAMETERS: PCUST AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN COMMENT 32(25) TNRANGE.
PARAMETERS: PCNAME TYPE NAMESPACE MEMORY ID MNAMESPACE.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN: END OF BLOCK B2.

* Additional things to download.
SELECTION-SCREEN: BEGIN OF BLOCK B3 WITH FRAME TITLE TBLOCK3.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(33) TPTEXT.
PARAMETERS: PTEXT AS CHECKBOX DEFAULT 'X' MEMORY ID MTEXT.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(33) TMESS.
PARAMETERS: PMESS AS CHECKBOX DEFAULT 'X' MEMORY ID MMESS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(33) TPINC.
PARAMETERS: PINC AS CHECKBOX DEFAULT 'X' MEMORY ID MINC.
SELECTION-SCREEN COMMENT 40(20) TRECC.
PARAMETERS: PRECI AS CHECKBOX DEFAULT 'X' MEMORY ID MRECI.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(33) TPFUNC.
PARAMETERS: PFUNC AS CHECKBOX DEFAULT 'X' MEMORY ID MFUNC.
SELECTION-SCREEN COMMENT 40(20) TRECF.
PARAMETERS: PRECF AS CHECKBOX DEFAULT 'X' MEMORY ID MRECF.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(33) TDOC.
PARAMETERS: PDOC AS CHECKBOX DEFAULT 'X' MEMORY ID MDOC.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(33) TPSCR.
PARAMETERS: PSCR AS CHECKBOX DEFAULT 'X' MEMORY ID MSCR.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(33) TPDICT.
PARAMETERS: PDICT AS CHECKBOX DEFAULT 'X' MEMORY ID MDICT.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(33) TSORTT.
PARAMETERS: PSORTT AS CHECKBOX DEFAULT ' ' MEMORY ID MSORTT.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN: END OF BLOCK B3.

* File details
SELECTION-SCREEN: BEGIN OF BLOCK B4 WITH FRAME TITLE TBLOCK4.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(20) TPHTML.
PARAMETERS: PHTML RADIOBUTTON GROUP G1.  " default 'X'.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 5(29) TCOMM.
PARAMETERS: PCOMM AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 5(29) TBACK.
PARAMETERS: PBACK AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(20) TPTXT.
PARAMETERS: PTXT RADIOBUTTON GROUP G1 DEFAULT 'X'.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN SKIP.

* Download to SAP server
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(25) TSERV.
PARAMETERS: PSERV RADIOBUTTON GROUP G2.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 8(20) TSPATH.
PARAMETERS: PLOGICAL LIKE FILENAME-FILEINTERN MEMORY ID MLOGICAL.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN COMMENT /28(60) TSDPATH.

* Download to PC
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(25) TPC.
PARAMETERS: PPC RADIOBUTTON GROUP G2 DEFAULT 'X'.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 8(20) TPPATH.
*    parameters: pFolder like rlgrap-filename memory id MFOLDER.
PARAMETERS: PFOLDER LIKE RLGRAP-FILENAME DEFAULT 'd:\temp'.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN: END OF BLOCK B4.

* Display options
SELECTION-SCREEN: BEGIN OF BLOCK B5 WITH FRAME TITLE TBLOCK5.
* Display final report
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(33) TREP.
PARAMETERS: PREP AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF LINE.
* Display progress messages
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(33) TPROMESS.
PARAMETERS: PPROMESS AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN: END OF BLOCK B5.

*-----------------------------------------------------------------------
* Display a directory picker window
*-----------------------------------------------------------------------
AT SELECTION-SCREEN ON VALUE-REQUEST FOR PFOLDER.

  DATA: OBJFILE TYPE REF TO CL_GUI_FRONTEND_SERVICES.
  DATA: PICKEDFOLDER TYPE STRING.
  DATA: INITIALFOLDER TYPE STRING.

  IF SY-BATCH IS INITIAL.
    CREATE OBJECT OBJFILE.

    IF NOT PFOLDER IS INITIAL.
      INITIALFOLDER = PFOLDER.
    ELSE.
      OBJFILE->GET_TEMP_DIRECTORY( CHANGING TEMP_DIR = INITIALFOLDER
                                   EXCEPTIONS CNTL_ERROR = 1
                                             ERROR_NO_GUI = 2
                                             NOT_SUPPORTED_BY_GUI = 3 ).
    ENDIF.

    OBJFILE->DIRECTORY_BROWSE( EXPORTING INITIAL_FOLDER = INITIALFOLDER
                               CHANGING SELECTED_FOLDER = PICKEDFOLDER
                               EXCEPTIONS CNTL_ERROR = 1
                                          ERROR_NO_GUI = 2
                                          NOT_SUPPORTED_BY_GUI = 3 ).

    IF SY-SUBRC = 0.
      PFOLDER = PICKEDFOLDER.
    ELSE.
      WRITE: / 'An error has occured picking a folder'.
    ENDIF.
  ENDIF.

*-----------------------------------------------------------------------
AT SELECTION-SCREEN.
*-----------------------------------------------------------------------
  CASE 'X'.
    WHEN PPC.
      IF PFOLDER IS INITIAL.
*       User must enter a path to save to
        MESSAGE E000(OO) WITH 'You must enter a file path'.
      ENDIF.

    WHEN PSERV.
      IF PLOGICAL IS INITIAL.
*       User must enter a logical path to save to
        MESSAGE E000(OO) WITH 'You must enter a logical file name'.
      ENDIF.
  ENDCASE.

*-----------------------------------------------------------------------
AT SELECTION-SCREEN ON PLOGICAL.
*-----------------------------------------------------------------------

  IF NOT PSERV IS INITIAL.
    CALL FUNCTION 'FILE_GET_NAME'
      EXPORTING
        LOGICAL_FILENAME = PLOGICAL
      IMPORTING
        FILE_NAME        = SERVERFOLDER
      EXCEPTIONS
        FILE_NOT_FOUND   = 1
        OTHERS           = 2.
    IF SY-SUBRC = 0.
      IF SERVERFOLDER IS INITIAL.
        MESSAGE E000(OO) WITH
        'No file path returned from logical filename'.
      ELSE.
*       Path to display on the selection screen
        TSDPATH = SERVERFOLDER.
*       Remove the trailing slash off the path as the subroutine
        SHIFT SERVERFOLDER RIGHT DELETING TRAILING SERVERSLASHSEPARATOR.
        SHIFT SERVERFOLDER LEFT DELETING LEADING SPACE.
      ENDIF.
    ELSE.
      MESSAGE E000(OO) WITH 'Logical filename does not exist'.
    ENDIF.
  ENDIF.

* ----------------------------------------------------------------------
AT SELECTION-SCREEN ON VALUE-REQUEST FOR SOPROG-LOW.
* ----------------------------------------------------------------------
  CALL FUNCTION 'REPOSITORY_INFO_SYSTEM_F4'
    EXPORTING
      OBJECT_TYPE           = 'PROG'
      OBJECT_NAME           = SOPROG-LOW
      SUPPRESS_SELECTION    = 'X'
      USE_ALV_GRID          = ''
      WITHOUT_PERSONAL_LIST = ''
    IMPORTING
      OBJECT_NAME_SELECTED  = SOPROG-LOW
    EXCEPTIONS
      CANCEL                = 1.

* ----------------------------------------------------------------------
AT SELECTION-SCREEN ON VALUE-REQUEST FOR SOPROG-HIGH.
* ----------------------------------------------------------------------
  CALL FUNCTION 'REPOSITORY_INFO_SYSTEM_F4'
    EXPORTING
      OBJECT_TYPE           = 'PROG'
      OBJECT_NAME           = SOPROG-HIGH
      SUPPRESS_SELECTION    = 'X'
      USE_ALV_GRID          = ''
      WITHOUT_PERSONAL_LIST = ''
    IMPORTING
      OBJECT_NAME_SELECTED  = SOPROG-HIGH
    EXCEPTIONS
      CANCEL                = 1.

* ----------------------------------------------------------------------
AT SELECTION-SCREEN ON VALUE-REQUEST FOR SOCLASS-LOW.
* ----------------------------------------------------------------------
  CALL FUNCTION 'F4_DD_ALLTYPES'
    EXPORTING
      OBJECT               = SOCLASS-LOW
      SUPPRESS_SELECTION   = 'X'
      DISPLAY_ONLY         = ''
      ONLY_TYPES_FOR_CLIFS = 'X'
    IMPORTING
      RESULT               = SOCLASS-LOW.

* ----------------------------------------------------------------------
AT SELECTION-SCREEN ON VALUE-REQUEST FOR SOCLASS-HIGH.
* ----------------------------------------------------------------------
  CALL FUNCTION 'F4_DD_ALLTYPES'
    EXPORTING
      OBJECT               = SOCLASS-HIGH
      SUPPRESS_SELECTION   = 'X'
      DISPLAY_ONLY         = ''
      ONLY_TYPES_FOR_CLIFS = 'X'
    IMPORTING
      RESULT               = SOCLASS-HIGH.

* ----------------------------------------------------------------------
AT SELECTION-SCREEN ON VALUE-REQUEST FOR SOFNAME-LOW.
* ----------------------------------------------------------------------
  CALL FUNCTION 'REPOSITORY_INFO_SYSTEM_F4'
    EXPORTING
      OBJECT_TYPE           = 'FUNC'
      OBJECT_NAME           = SOFNAME-LOW
      SUPPRESS_SELECTION    = 'X'
      USE_ALV_GRID          = ''
      WITHOUT_PERSONAL_LIST = ''
    IMPORTING
      OBJECT_NAME_SELECTED  = SOFNAME-LOW
    EXCEPTIONS
      CANCEL                = 1.

* ----------------------------------------------------------------------
AT SELECTION-SCREEN ON VALUE-REQUEST FOR SOFNAME-HIGH.
* ----------------------------------------------------------------------
  CALL FUNCTION 'REPOSITORY_INFO_SYSTEM_F4'
    EXPORTING
      OBJECT_TYPE           = 'FUNC'
      OBJECT_NAME           = SOFNAME-HIGH
      SUPPRESS_SELECTION    = 'X'
      USE_ALV_GRID          = ''
      WITHOUT_PERSONAL_LIST = ''
    IMPORTING
      OBJECT_NAME_SELECTED  = SOFNAME-HIGH
    EXCEPTIONS
      CANCEL                = 1.

* ----------------------------------------------------------------------
AT SELECTION-SCREEN ON VALUE-REQUEST FOR SOFGROUP-LOW.
* ----------------------------------------------------------------------
  CALL FUNCTION 'REPOSITORY_INFO_SYSTEM_F4'
    EXPORTING
      OBJECT_TYPE           = 'FUGR'
      OBJECT_NAME           = SOFGROUP-LOW
      SUPPRESS_SELECTION    = 'X'
      USE_ALV_GRID          = ''
      WITHOUT_PERSONAL_LIST = ''
    IMPORTING
      OBJECT_NAME_SELECTED  = SOFGROUP-LOW
    EXCEPTIONS
      CANCEL                = 1.

* ----------------------------------------------------------------------
AT SELECTION-SCREEN ON VALUE-REQUEST FOR SOFGROUP-HIGH.
* ----------------------------------------------------------------------
  CALL FUNCTION 'REPOSITORY_INFO_SYSTEM_F4'
    EXPORTING
      OBJECT_TYPE           = 'FUGR'
      OBJECT_NAME           = SOFGROUP-HIGH
      SUPPRESS_SELECTION    = 'X'
      USE_ALV_GRID          = ''
      WITHOUT_PERSONAL_LIST = ''
    IMPORTING
      OBJECT_NAME_SELECTED  = SOFGROUP-HIGH
    EXCEPTIONS
      CANCEL                = 1.

*-----------------------------------------------------------------------
* initialisation
*-----------------------------------------------------------------------
INITIALIZATION.
* Parameter screen texts.
  TBLOCK1 = 'Author (Optional)'.
  T$TMP   = 'Programs only: include local objects'.
  TBLOCK2 = 'Objects to download'.
  TBLOCK3 =
  'Additional downloads for programs, function modules and classes'.
  TBLOCK4 = 'Download parameters'.
  TBLOCK5 = 'Display options'.
  TAUTH   = 'Author name'.
  TPMOD   = 'Include programs modified by author'.
  TCUST   = 'Only customer objects'.
  TNRANGE = 'Alt customer name range'.
  TRTABLE = 'Tables / Structures'.
  TPTABLE = 'Table name'.
  TTNOTE  =
  'Note: tables are stored under the username of the last person'.
*  who modified them'.
  TRFUNC  = 'Function modules'.
  TPFNAME = 'Function name'.
  TFGROUP = 'Function group'.
  TRCLASS  = 'Classes'.
  TPCNAME = 'Class name'.
  TMESS   = 'Message class'.
  TMNAME  = 'Class name'.
  TMLANG  = 'Language'.
  TPROG   = 'Programs'.
  TRPNAME = 'Program name'.
  TPACK   = 'Package'.
  TPTXT   = 'Text document'.
  TPHTML  = 'HTML document'.
  TCOMM   = 'Highlight comments'.
  TBACK   = 'Include background colour'.
  TPTEXT  = 'Text elements'.
  TPINC   = 'Include programs'.
  TRECC   = 'Recursive search'.
  TPPATH  = 'File path'.
  TSPATH  = 'Logical file name'.
  TPMES   = 'Message classes'.
  TPFUNC  = 'Function modules'.
  TDOC    = 'Function module documentation'.
  TRECF   = 'Recursive search'.
  TPSCR   = 'Screens'.
  TPDICT  = 'Dictionary structures'.
  TSORTT  = 'Sort table fields alphabetically'.
  TSERV   = 'Download to server'.
  TPC     = 'Download to PC'.
  TREP    = 'Display download report'.
  TPROMESS  = 'Display progress messages'.

* Determine the frontend operating system type.
  IF SY-BATCH IS INITIAL.
    PERFORM DETERMINEFRONTENDOPSYSTEM USING FRONTENDSLASHSEPARATOR
FRONTENDOPSYSTEM.
  ENDIF.
  PERFORM DETERMINESERVEROPSYSTEM USING SERVERSLASHSEPARATOR
SERVERFILESYSTEM SERVEROPSYSTEM.

* Determine if the external command exists.  If it doesn't then disable
  PERFORM FINDEXTERNALCOMMAND.

*-----------------------------------------------------------------------
* start-of-selection.
*-----------------------------------------------------------------------
START-OF-SELECTION.

  IF PSERV = 'X'.
    MESSAGE I000(OO) WITH '업로드 금지.......'.
    LEAVE LIST-PROCESSING.
  ENDIF.

  PERFORM CHECKCOMBOBOXES.
  PERFORM FILLSELECTIONRANGES.
  STARTTIME = SY-UZEIT.

* Don't display status messages if we are running in the background
  IF NOT SY-BATCH IS INITIAL.
    PPROMESS = ''.
  ENDIF.

* Fool the HTML routines to stop them hyperlinking anything with a space
  IF PCNAME IS INITIAL.
    CUSTOMERNAMESPACE  = '^'.
  ELSE.
    CUSTOMERNAMESPACE = PCNAME.
  ENDIF.

* Determine which operating slash and download directory to use
  CASE 'X'.
    WHEN PPC.
      SLASHSEPARATORTOUSE = FRONTENDSLASHSEPARATOR.
      DOWNLOADFOLDER = PFOLDER.
    WHEN PSERV.
      SLASHSEPARATORTOUSE = SERVERSLASHSEPARATOR.
      DOWNLOADFOLDER = SERVERFOLDER.
  ENDCASE.

* Main program flow.
  CASE 'X'.
*   Select tables
    WHEN RTABLE.
      PERFORM RETRIEVETABLES USING IDICTIONARY[]
                                   SOTABLENAMES[]
                                   SOAUTHOR[].

*   Select message classes tables
    WHEN RMESS.
      PERFORM RETRIEVEMESSAGECLASS USING IMESSAGES[]
                                         SOAUTHOR[]      "Author
                                         PMNAME
                                         PMLANG
                                         PMOD.

*   Select function modules
    WHEN RFUNC.
      PERFORM RETRIEVEFUNCTIONS USING SOFUNCTIONNAME[]   "Function name
                                      SOFUNCTIONGROUP[]  "Function group
                                      IFUNCTIONS[]
                                      SOAUTHOR[]         "Author
                                      PTEXT
                                      PSCR               "Get screens
                                      PCUST
                                      CUSTOMERNAMESPACE.


      LOOP AT IFUNCTIONS.
*       Find Dict structures, messages, functions, includes etc.
        PERFORM SCANFORADDITIONALFUNCSTUFF USING IFUNCTIONS[]
                                                 PRECI
"Search for includes recursively
                                                 PRECF
"Search for functions recursively
                                                 PINC
"Search for includes
                                                 PFUNC
"Search for functions
                                                 PDICT
"search for dictionary objects
                                                 PMESS
"Search for messages
                                                 PCUST
"Customer data only
                                                 CUSTOMERNAMESPACE.
        "Customer name range
      ENDLOOP.

*   Select Classes
    WHEN RCLASS.
      PERFORM RETRIEVECLASSES USING ICLASSES[]
                                    IFUNCTIONS[]
                                    SOCLASSNAME[]       "Class name
                                    SOAUTHOR[]          "Author
                                    CUSTOMERNAMESPACE
                                    PMOD
                                    PCUST
                                    PMESS               "Find messages
                                    PTEXT               "Text Elements
                                    PDICT
                                    PFUNC               "Get functions
                                    PINC                "Get includes
                                    PRECF
                                    PRECI
                                    'X'
                                    PMLANG.             "Language

      LOOP AT IFUNCTIONS.
*       Find Dict structures, messages, functions, includes etc.
        PERFORM SCANFORADDITIONALFUNCSTUFF USING IFUNCTIONS[]
                                                 PRECI
"Search for includes recursively
                                                 PRECF
"Search for functions recursively
                                                 PINC
"Search for includes
                                                 PFUNC
"Search for functions
                                                 PDICT
"search for dictionary objects
                                                 PMESS
"Search for messages
                                                 PCUST
"Customer data only
                                                 CUSTOMERNAMESPACE.
        "Customer name range
      ENDLOOP.

*   Select programs
    WHEN RPROG.
      PERFORM RETRIEVEPROGRAMS USING IPROGRAMS[]
                                     IFUNCTIONS[]
                                     SOPROGRAMNAME[]    "Program name
                                     SOAUTHOR[]         "Author
                                     CUSTOMERNAMESPACE
                                     PMOD
                                     PCUST
                                     PMESS              "Find messages
                                     PTEXT              "Text Elements
                                     PDICT
                                     PFUNC              "Get functions
                                     PINC               "Get includes
                                     PSCR               "Get screens
                                     PRECF
                                     PRECI
                                     P$TMP              "local objects
                                     PPACK.             "Package
  ENDCASE.

*-----------------------------------------------------------------------
* end-of-selection
*-----------------------------------------------------------------------
END-OF-SELECTION.

  IF FORCEDEXIT = 0.
*   Set the file extension and output type of the file
    IF PTXT IS INITIAL.
      DOWNLOADFILEEXTENSION = HTMLEXTENSION.
    ELSE.
      DOWNLOADFILEEXTENSION = TEXTEXTENSION.
    ENDIF.

*   Decide what to download
    CASE 'X'.
*     Download tables
      WHEN RTABLE.
        IF NOT ( IDICTIONARY[] IS INITIAL ).
          PERFORM DOWNLOADDDSTRUCTURES USING IDICTIONARY[]
                                             DOWNLOADFOLDER
                                             HTMLEXTENSION
                                             SPACE
                                             PSORTT
                                             SLASHSEPARATORTOUSE
                                             PSERV
                                             PPROMESS.

*         Free up any memory used for caching HTML versions of tables
          LOOP AT IDICTIONARY.
            FREE MEMORY ID IDICTIONARY-TABLENAME.
          ENDLOOP.

*         Display donwload report
          IF NOT PREP IS INITIAL.
            GET TIME.
            RUNTIME = SY-UZEIT - STARTTIME.
            PERFORM FILLTREENODETABLES USING IDICTIONARY[]
                                             ITREEDISPLAY[]
                                             RUNTIME.
          ENDIF.

          CLEAR IDICTIONARY[].
        ENDIF.

*     Download message class
      WHEN RMESS.
        IF NOT ( IMESSAGES[] IS INITIAL ).
          SORT IMESSAGES ASCENDING BY ARBGB MSGNR.
          LOOP AT IMESSAGES.
            APPEND IMESSAGES TO ISINGLEMESSAGECLASS.
            AT END OF ARBGB.
              PERFORM DOWNLOADMESSAGECLASS USING ISINGLEMESSAGECLASS[]
                                                 IMESSAGES-ARBGB
                                                 DOWNLOADFOLDER
                                                 DOWNLOADFILEEXTENSION
                                                 PHTML
                                                 SPACE
                                                 PCOMM
                                                 CUSTOMERNAMESPACE
                                                 PINC
                                                 PDICT
                                                 PMESS
                                                 SLASHSEPARATORTOUSE
                                                 PSERV
                                                 PPROMESS.
              CLEAR ISINGLEMESSAGECLASS[].
            ENDAT.
          ENDLOOP.

*         Display download report
          IF NOT PREP IS INITIAL.
            GET TIME.
            RUNTIME = SY-UZEIT - STARTTIME.
            PERFORM FILLTREENODEMESSAGES USING IMESSAGES[]
                                               ITREEDISPLAY[]
                                               RUNTIME.
          ENDIF.

          CLEAR IMESSAGES[].
        ENDIF.

*     Download functions
      WHEN RFUNC.
        IF NOT ( IFUNCTIONS[] IS INITIAL ).
          PERFORM DOWNLOADFUNCTIONS USING IFUNCTIONS[]
                                          DOWNLOADFOLDER
                                          DOWNLOADFILEEXTENSION
                                          SPACE
                                          PDOC
                                          PHTML
                                          PCOMM
                                          CUSTOMERNAMESPACE
                                          PINC
                                          PDICT
                                          TEXTEXTENSION
                                          HTMLEXTENSION
                                          PSORTT
                                          SLASHSEPARATORTOUSE
                                          PSERV
                                          PPROMESS.

*         Free up any memory used for caching HTML versions of tables
          LOOP AT IFUNCTIONS.
            LOOP AT IFUNCTIONS-IDICTSTRUCT ASSIGNING <WADICTSTRUCT>.
              FREE MEMORY ID <WADICTSTRUCT>-TABLENAME.
            ENDLOOP.
          ENDLOOP.

*         Display donwload report
          IF NOT PREP IS INITIAL.
            GET TIME.
            RUNTIME = SY-UZEIT - STARTTIME.
            PERFORM FILLTREENODEFUNCTIONS USING IFUNCTIONS[]
                                                ITREEDISPLAY[]
                                                RUNTIME.
          ENDIF.

          CLEAR IFUNCTIONS[].
        ENDIF.

*     Download Classes
      WHEN RCLASS.
        IF NOT ( ICLASSES[] IS INITIAL ).
          PERFORM DOWNLOADCLASSES USING ICLASSES[]
                                        IFUNCTIONS[]
                                        DOWNLOADFOLDER
                                        DOWNLOADFILEEXTENSION
                                        HTMLEXTENSION
                                        TEXTEXTENSION
                                        PHTML
                                        PCOMM
                                        CUSTOMERNAMESPACE
                                        PINC
                                        PDICT
                                        PDOC
                                        PSORTT
                                        SLASHSEPARATORTOUSE
                                        PSERV
                                        PPROMESS.

*         Free up any memory used for caching HTML versions of tables
          LOOP AT IFUNCTIONS.
            LOOP AT IFUNCTIONS-IDICTSTRUCT ASSIGNING <WADICTSTRUCT>.
              FREE MEMORY ID <WADICTSTRUCT>-TABLENAME.
            ENDLOOP.
          ENDLOOP.

*         Free up any memory used for caching HTML versions of tables
          LOOP AT IPROGRAMS.
            LOOP AT IPROGRAMS-IDICTSTRUCT ASSIGNING <WADICTSTRUCT>.
              FREE MEMORY ID <WADICTSTRUCT>-TABLENAME.
            ENDLOOP.
          ENDLOOP.

*         Display donwload report
          IF NOT PREP IS INITIAL.
            GET TIME.
            RUNTIME = SY-UZEIT - STARTTIME.
            PERFORM FILLTREENODECLASSES USING ICLASSES[]
                                              IFUNCTIONS[]
                                              ITREEDISPLAY[]
                                              RUNTIME.
          ENDIF.

          CLEAR ICLASSES[].
          CLEAR IFUNCTIONS[].
        ENDIF.

*     Download programs
      WHEN RPROG.
        IF NOT ( IPROGRAMS[] IS INITIAL ).
          PERFORM DOWNLOADPROGRAMS USING IPROGRAMS[]
                                         IFUNCTIONS[]
                                         DOWNLOADFOLDER
                                         DOWNLOADFILEEXTENSION
                                         HTMLEXTENSION
                                         TEXTEXTENSION
                                         PHTML
                                         PCOMM
                                         CUSTOMERNAMESPACE
                                         PINC
                                         PDICT
                                         PDOC
                                         PSORTT
                                         SLASHSEPARATORTOUSE
                                         PSERV
                                         PPROMESS.

*         Free up any memory used for caching HTML versions of tables
          LOOP AT IFUNCTIONS.
            LOOP AT IFUNCTIONS-IDICTSTRUCT ASSIGNING <WADICTSTRUCT>.
              FREE MEMORY ID <WADICTSTRUCT>-TABLENAME.
            ENDLOOP.
          ENDLOOP.

*         Free up any memory used for caching HTML versions of tables
          LOOP AT IPROGRAMS.
            LOOP AT IPROGRAMS-IDICTSTRUCT ASSIGNING <WADICTSTRUCT>.
              FREE MEMORY ID <WADICTSTRUCT>-TABLENAME.
            ENDLOOP.
          ENDLOOP.

*         Display donwload report
          IF NOT PREP IS INITIAL.
            GET TIME.
            RUNTIME = SY-UZEIT - STARTTIME.
            PERFORM FILLTREENODEPROGRAMS USING IPROGRAMS[]
                                               IFUNCTIONS[]
                                               ITREEDISPLAY[]
                                               RUNTIME.
          ENDIF.

          CLEAR IPROGRAMS[].
          CLEAR IFUNCTIONS[].
        ENDIF.
    ENDCASE.

    IF NOT PREP IS INITIAL.
      IF NOT ( ITREEDISPLAY[] IS INITIAL ).
        PERFORM DISPLAYTREE USING ITREEDISPLAY[].
      ELSE.
        STATUSBARMESSAGE = 'No items found matching selection criteria'.
        PERFORM DISPLAYSTATUS USING STATUSBARMESSAGE 2.
      ENDIF.
    ENDIF.
  ENDIF.

*--- Memory IDs
* User name
  SET PARAMETER ID 'MAUTH' FIELD PAUTH.
* Message class
  SET PARAMETER ID 'MMNAME' FIELD PMNAME.
* Customer namespace
  SET PARAMETER ID 'MNAMESPACE' FIELD PCNAME.
* Folder
  SET PARAMETER ID 'MFOLDER' FIELD PFOLDER.
* Logical filepath
  SET PARAMETER ID 'MLOGICAL' FIELD PLOGICAL.
* Package
  SET PARAMETER ID 'MPACK' FIELD PPACK.
* Text element checkbox
  SET PARAMETER ID 'MTEXT' FIELD PTEXT.
* Messages checkbox
  SET PARAMETER ID 'MMESS' FIELD PMESS.
* Includes checkbox
  SET PARAMETER ID 'MINC' FIELD PINC.
* Recursive includes checkbox.
  SET PARAMETER ID 'MRECI' FIELD PRECI.
* Functions checkbox
  SET PARAMETER ID 'MFUNC' FIELD PFUNC.
* Recursive functions checkbox
  SET PARAMETER ID 'MRECF' FIELD PRECF.
* Function module documntation checkbox
  SET PARAMETER ID 'MDOC' FIELD PDOC.
* Screens checkbox
  SET PARAMETER ID 'MSCR' FIELD PSCR.
* Dictionary checkbox
  SET PARAMETER ID 'MDICT' FIELD PDICT.
* Sort table ascending checkBox
  SET PARAMETER ID 'MSORTT' FIELD PSORTT.

************************************************************************
***********************************************
***************************************************SUBROUTINES**********
***********************************************
************************************************************************
***********************************************

*-----------------------------------------------------------------------
*  checkComboBoxes...  Check input parameters
*-----------------------------------------------------------------------
FORM CHECKCOMBOBOXES.

  IF PAUTH IS INITIAL.
    CASE 'X'.
      WHEN RTABLE.
        IF SOTABLE[] IS INITIAL.
          STATUSBARMESSAGE =
          'You must enter either a table name or author.'.
        ENDIF.
      WHEN RFUNC.  "HAN_TEST
        IF ( SOFNAME[] IS INITIAL ) AND ( SOFGROUP[] IS INITIAL ).
          IF SOFNAME[] IS INITIAL.
            STATUSBARMESSAGE =
            'You must enter either a function name or author.'.
          ELSE.
            IF SOFGROUP[] IS INITIAL.
              STATUSBARMESSAGE =
  'You must enter either a function group, or an author name.'.
            ENDIF.
          ENDIF.
        ENDIF.
*      when rProg.   "HAN_TEST
*        if soProg[] is initial.
*            statusBarMessage =
*            'You must enter either a program name or author name.'.
*        endif.
    ENDCASE.
  ELSE.
*   Check the user name of the person objects are to be downloaded for
    IF PAUTH = 'SAP*' OR PAUTH = 'SAP'.
      STATUSBARMESSAGE =
      'Sorry cannot download all objects for SAP standard user'.
    ENDIF.
  ENDIF.

  IF NOT STATUSBARMESSAGE IS INITIAL.
    PERFORM DISPLAYSTATUS USING STATUSBARMESSAGE 3.
    FORCEDEXIT = 1.
    STOP.
  ENDIF.
ENDFORM.                    "checkcomboboxes
"checkComboBoxes

*-----------------------------------------------------------------------
* fillSelectionRanges...      for selection routines
*-----------------------------------------------------------------------
FORM FILLSELECTIONRANGES.

  DATA: STRLENGTH TYPE I.

  STRLENGTH = STRLEN( PCNAME ).

  IF NOT PAUTH IS INITIAL.
    SOAUTHOR-SIGN = 'I'.
    SOAUTHOR-OPTION = 'EQ'.
    SOAUTHOR-LOW = PAUTH.
    APPEND SOAUTHOR.
  ENDIF.

* Tables
  IF NOT SOTABLE IS INITIAL.
    SOTABLENAMES[] = SOTABLE[].
*   Add in the customer namespace if we need to
    IF NOT PCNAME IS INITIAL.
      LOOP AT SOTABLENAMES.
        IF SOTABLENAMES-LOW+0(STRLENGTH) <> PCNAME.
          CONCATENATE PCNAME SOTABLENAMES-LOW INTO SOTABLENAMES-LOW.
        ENDIF.

        IF SOTABLENAMES-HIGH+0(STRLENGTH) <> PCNAME.
          CONCATENATE PCNAME SOTABLENAMES-HIGH INTO SOTABLENAMES-HIGH.
        ENDIF.

        MODIFY SOTABLENAMES.
      ENDLOOP.
    ENDIF.
  ENDIF.

* Function names
  IF NOT SOFNAME IS INITIAL.
    SOFUNCTIONNAME[] = SOFNAME[].
*   Add in the customer namespace if we need to
    IF NOT PCNAME IS INITIAL.
      LOOP AT SOFUNCTIONNAME.
        IF SOFUNCTIONNAME-LOW+0(STRLENGTH) <> PCNAME.
          CONCATENATE PCNAME SOFUNCTIONNAME-LOW INTO SOFUNCTIONNAME-LOW.
        ENDIF.

        IF SOFUNCTIONNAME-HIGH+0(STRLENGTH) <> PCNAME.
          CONCATENATE PCNAME SOFUNCTIONNAME-HIGH INTO
          SOFUNCTIONNAME-HIGH.
        ENDIF.

        MODIFY SOFUNCTIONNAME.
      ENDLOOP.
    ENDIF.
  ENDIF.

* Function group
  IF NOT SOFGROUP IS INITIAL.
    SOFUNCTIONGROUP[] = SOFGROUP[].
*   Add in the customer namespace if we need to
    IF NOT PCNAME IS INITIAL.
      LOOP AT SOFUNCTIONNAME.
        IF SOFUNCTIONGROUP-LOW+0(STRLENGTH) <> PCNAME.
          CONCATENATE PCNAME SOFUNCTIONGROUP-LOW INTO
          SOFUNCTIONGROUP-LOW.
        ENDIF.

        IF SOFUNCTIONGROUP-HIGH+0(STRLENGTH) <> PCNAME.
          CONCATENATE PCNAME SOFUNCTIONGROUP-HIGH INTO
          SOFUNCTIONGROUP-HIGH.
        ENDIF.

        MODIFY SOFUNCTIONGROUP.
      ENDLOOP.
    ENDIF.
  ENDIF.

* Class names
  IF NOT SOCLASS IS INITIAL.
    SOCLASSNAME[] = SOCLASS[].
*   Add in the customer namespace if we need to
    IF NOT PCNAME IS INITIAL.
      LOOP AT SOCLASSNAME.
        IF SOCLASSNAME-LOW+0(STRLENGTH) <> PCNAME.
          CONCATENATE PCNAME SOCLASSNAME-LOW INTO SOCLASSNAME-LOW.
        ENDIF.

        IF SOCLASSNAME-HIGH+0(STRLENGTH) <> PCNAME.
          CONCATENATE PCNAME SOCLASSNAME-HIGH INTO SOCLASSNAME-HIGH.
        ENDIF.

        MODIFY SOCLASSNAME.
      ENDLOOP.
    ENDIF.
  ENDIF.

* Program names
  IF NOT SOPROG IS INITIAL.
    SOPROGRAMNAME[] = SOPROG[].
*   Add in the customer namespace if we need to
    IF NOT PCNAME IS INITIAL.
      LOOP AT SOPROGRAMNAME.
        IF SOPROGRAMNAME-LOW+0(STRLENGTH) <> PCNAME.
          CONCATENATE PCNAME SOPROGRAMNAME-LOW INTO SOPROGRAMNAME-LOW.
        ENDIF.

        IF SOPROGRAMNAME-HIGH+0(STRLENGTH) <> PCNAME.
          CONCATENATE PCNAME SOPROGRAMNAME-HIGH INTO SOPROGRAMNAME-HIGH.
        ENDIF.

        MODIFY SOPROGRAMNAME.
      ENDLOOP.
    ENDIF.
  ENDIF.
ENDFORM.                    "fillselectionranges
" fillSelectionRanges

*-----------------------------------------------------------------------
*  retrieveTables...             Search for tables in dictionary
*-----------------------------------------------------------------------
FORM RETRIEVETABLES USING ILOCDICTSTRUCTURE LIKE IDICTIONARY[]
                          SOTABLE LIKE SOTABLE[]
                          SOAUTHOR LIKE SOAUTHOR[].

  DATA: WADICTSTRUCTURE TYPE TDICTTABLE.

  SELECT TABNAME
         FROM DD02L
         INTO WADICTSTRUCTURE-TABLENAME
         WHERE TABNAME IN SOTABLE
           AND TABCLASS <> 'CLUSTER'
           AND TABCLASS <> 'POOL'
           AND TABCLASS <> 'VIEW'
           AND AS4USER IN SOAUTHOR
           AND AS4LOCAL = 'A'.

    PERFORM FINDTABLEDESCRIPTION USING WADICTSTRUCTURE-TABLENAME
                                       WADICTSTRUCTURE-TABLETITLE.

    PERFORM FINDTABLEDEFINITION USING WADICTSTRUCTURE-TABLENAME
                                      WADICTSTRUCTURE-ISTRUCTURE[].

    APPEND WADICTSTRUCTURE TO ILOCDICTSTRUCTURE.
    CLEAR WADICTSTRUCTURE.
  ENDSELECT.
ENDFORM.                    "retrievetables
"retrieveTables

*-----------------------------------------------------------------------
*  findTableDescription...  Search for table description in dictionary
*-----------------------------------------------------------------------
FORM FINDTABLEDESCRIPTION USING VALUE(TABLENAME)
                                      TABLEDESCRIPTION.

  SELECT SINGLE DDTEXT
                FROM DD02T
                INTO TABLEDESCRIPTION
                WHERE TABNAME = TABLENAME
                 AND DDLANGUAGE = SY-LANGU.
ENDFORM.                    "findtabledescription
"findTableDescription

*-----------------------------------------------------------------------
*  findTableDefinition... Find the structure of a table from the SAP
*-----------------------------------------------------------------------
FORM FINDTABLEDEFINITION USING VALUE(TABLENAME)
                               IDICTSTRUCT LIKE DUMIDICTSTRUCTURE[].

  DATA GOTSTATE LIKE DCOBJIF-GOTSTATE.
  DATA: DEFINITION TYPE STANDARD TABLE OF DD03P WITH HEADER LINE.
  DATA: WADICTSTRUCT TYPE TDICTTABLESTRUCTURE.

  CALL FUNCTION 'DDIF_TABL_GET'
    EXPORTING
      NAME          = TABLENAME
      STATE         = 'A'
      LANGU         = SY-LANGU
    IMPORTING
      GOTSTATE      = GOTSTATE
    TABLES
      DD03P_TAB     = DEFINITION
    EXCEPTIONS
      ILLEGAL_INPUT = 1
      OTHERS        = 2.

  IF SY-SUBRC = 0 AND GOTSTATE = 'A'.
    LOOP AT DEFINITION.
      MOVE-CORRESPONDING DEFINITION TO WADICTSTRUCT.
      PERFORM REMOVELEADINGZEROS CHANGING WADICTSTRUCT-POSITION.
      PERFORM REMOVELEADINGZEROS CHANGING WADICTSTRUCT-LENG.
      APPEND WADICTSTRUCT TO IDICTSTRUCT.
    ENDLOOP.
  ENDIF.
ENDFORM.                    "findtabledefinition
"findTableDefinition

*-----------------------------------------------------------------------
*  retrieveMessageClass...   Retrieve a message class from the SAP
*-----------------------------------------------------------------------
FORM RETRIEVEMESSAGECLASS USING ILOCMESSAGES LIKE IMESSAGES[]
                                RANGEAUTHOR LIKE SOAUTHOR[]
                                VALUE(MESSAGECLASSNAME)
                                VALUE(MESSAGECLASSLANG)
                                VALUE(MODIFIEDBY).

  DATA: WAMESSAGE TYPE TMESSAGE.

  IF NOT MESSAGECLASSNAME IS INITIAL.
    SELECT * FROM T100
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCMESSAGES
             WHERE SPRSL = MESSAGECLASSLANG
               AND ARBGB = MESSAGECLASSNAME.

    LOOP AT ILOCMESSAGES INTO WAMESSAGE.
      SELECT SINGLE STEXT
                    FROM T100A                         "#EC CI_BUFFJOIN
                    INTO WAMESSAGE-STEXT
                    WHERE ARBGB = WAMESSAGE-ARBGB.
      MODIFY ILOCMESSAGES FROM WAMESSAGE INDEX SY-TABIX.
    ENDLOOP.
  ELSE.
    IF MODIFIEDBY IS INITIAL.
*     Select by author
      SELECT T100~ARBGB                                "#EC CI_BUFFJOIN
             T100~MSGNR
             T100~TEXT
             T100A~STEXT
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCMESSAGES
             FROM T100
             INNER JOIN T100A ON T100A~ARBGB = T100~ARBGB
             WHERE T100A~MASTERLANG = MESSAGECLASSLANG
               AND T100A~RESPUSER IN RANGEAUTHOR[].
    ELSE.
*     Select also by the last person who modified the message class
      SELECT T100~ARBGB                                "#EC CI_BUFFJOIN
             T100~MSGNR
             T100~TEXT
             T100A~STEXT
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCMESSAGES
             FROM T100
             INNER JOIN T100A ON T100A~ARBGB = T100~ARBGB
             WHERE T100A~MASTERLANG = MESSAGECLASSLANG
               AND T100A~RESPUSER IN RANGEAUTHOR[]
               AND T100A~LASTUSER IN RANGEAUTHOR[].
    ENDIF.
  ENDIF.
ENDFORM.                    "retrievemessageclass
"retrieveMessageClass

*-----------------------------------------------------------------------
*  retrieveFunctions...   Retrieve function modules from SAP DB.  May be
FORM RETRIEVEFUNCTIONS USING SOFNAME LIKE SOFUNCTIONNAME[]
                             SOFGROUP LIKE SOFUNCTIONGROUP[]
                             ILOCFUNCTIONNAMES LIKE IFUNCTIONS[]
                             VALUE(SOLOCAUTHOR) LIKE SOAUTHOR[]
                             VALUE(GETTEXTELEMENTS)
                             VALUE(GETSCREENS)
                             VALUE(CUSTOMERONLY)
                             VALUE(CUSTOMERNAMERANGE).

  RANGES: RANGEFUNCNAME  FOR TFDIR-FUNCNAME.
  RANGES: RANGEFUNCGROUP FOR ENLFDIR-AREA.
  DATA: WAFUNCTIONNAME TYPE TFUNCTION.
  DATA: NOGROUPSFOUND TYPE I VALUE TRUE.
  DATA: PREVIOUSFG TYPE V_FDIR-AREA.

  RANGEFUNCNAME[] = SOFNAME[].
  RANGEFUNCGROUP[] = SOFGROUP[].

  IF NOT SOLOCAUTHOR[] IS INITIAL.
*-- Need to select all function groups by author
    SELECT AREA
           FROM TLIBV
           INTO RANGEFUNCGROUP-LOW
           WHERE UNAME IN SOLOCAUTHOR
             AND AREA IN SOFGROUP[].

      RANGEFUNCGROUP-SIGN = 'I'.
      RANGEFUNCGROUP-OPTION = 'EQ'.
      APPEND RANGEFUNCGROUP.
      NOGROUPSFOUND = FALSE.
    ENDSELECT.
  ELSE.
    NOGROUPSFOUND = FALSE.
  ENDIF.

  IF NOGROUPSFOUND = FALSE.
*   select by function name and/or function group.
    SELECT FUNCNAME AREA
                    FROM V_FDIR
                    INTO (WAFUNCTIONNAME-FUNCTIONNAME,
                          WAFUNCTIONNAME-FUNCTIONGROUP)
                    WHERE FUNCNAME IN RANGEFUNCNAME
                      AND AREA IN RANGEFUNCGROUP
                      AND GENERATED = ''
                      ORDER BY AREA.

      APPEND WAFUNCTIONNAME TO ILOCFUNCTIONNAMES.
    ENDSELECT.
  ENDIF.

  LOOP AT ILOCFUNCTIONNAMES INTO WAFUNCTIONNAME.
    PERFORM RETRIEVEFUNCTIONDETAIL USING WAFUNCTIONNAME-FUNCTIONNAME
                                         WAFUNCTIONNAME-PROGNAME
                                         WAFUNCTIONNAME-INCLUDENUMBER
                                         WAFUNCTIONNAME-FUNCTIONTITLE.

    PERFORM FINDMAINFUNCTIONINCLUDE USING WAFUNCTIONNAME-PROGNAME
                                          WAFUNCTIONNAME-INCLUDENUMBER
                         WAFUNCTIONNAME-FUNCTIONMAININCLUDE.

    PERFORM FINDFUNCTIONTOPINCLUDE USING WAFUNCTIONNAME-PROGNAME
                                         WAFUNCTIONNAME-TOPINCLUDENAME.

*   Find all user defined includes within the function group
    PERFORM SCANFORFUNCTIONINCLUDES USING WAFUNCTIONNAME-PROGNAME
                                          CUSTOMERONLY
                                          CUSTOMERNAMERANGE
                                          WAFUNCTIONNAME-IINCLUDES[].
*   Find main message class
    PERFORM FINDMAINMESSAGECLASS USING WAFUNCTIONNAME-PROGNAME
                                       WAFUNCTIONNAME-MESSAGECLASS.

*   Find any screens declared within the main include
    IF NOT GETSCREENS IS INITIAL.
      IF PREVIOUSFG IS INITIAL OR PREVIOUSFG <>
      WAFUNCTIONNAME-FUNCTIONGROUP.
        PERFORM FINDFUNCTIONSCREENFLOW USING WAFUNCTIONNAME.

*       Search for any GUI texts
        PERFORM RETRIEVEGUITITLES USING WAFUNCTIONNAME-IGUITITLE[]
                                        WAFUNCTIONNAME-PROGNAME.
      ENDIF.
    ENDIF.

    IF NOT GETTEXTELEMENTS IS INITIAL.
*     Find the program texts from out of the database.
      PERFORM RETRIEVEPROGRAMTEXTS USING
      WAFUNCTIONNAME-ISELECTIONTEXTS[]
                                         WAFUNCTIONNAME-ITEXTELEMENTS[]
                                         WAFUNCTIONNAME-PROGNAME.
    ENDIF.

    PREVIOUSFG = WAFUNCTIONNAME-FUNCTIONGROUP.
    MODIFY ILOCFUNCTIONNAMES FROM WAFUNCTIONNAME.
  ENDLOOP.
ENDFORM.                    "retrievefunctions
"retrieveFunctions

*-----------------------------------------------------------------------
FORM RETRIEVEFUNCTIONDETAIL USING VALUE(FUNCTIONNAME)
                                        PROGNAME
                                        INCLUDENAME
                                        TITLETEXT.

  SELECT SINGLE PNAME
                INCLUDE
                FROM TFDIR
                INTO (PROGNAME, INCLUDENAME)
                WHERE FUNCNAME = FUNCTIONNAME.

  IF SY-SUBRC = 0.
    SELECT SINGLE STEXT
                  FROM TFTIT
                  INTO TITLETEXT
                  WHERE SPRAS = SY-LANGU
                    AND FUNCNAME = FUNCTIONNAME.
  ENDIF.
ENDFORM.                    "retrievefunctiondetail
"retrieveFunctionDetail

*-----------------------------------------------------------------------
FORM FINDMAINFUNCTIONINCLUDE USING VALUE(PROGRAMNAME)
                                   VALUE(INCLUDENO)
                                         INTERNALINCLUDENAME.
  DATA: NEWINCLUDENUMBER TYPE STRING.

  CONCATENATE '%U' INCLUDENO INTO NEWINCLUDENUMBER.
  SELECT SINGLE INCLUDE
                FROM D010INC
                INTO INTERNALINCLUDENAME
                WHERE MASTER = PROGRAMNAME
                  AND INCLUDE LIKE NEWINCLUDENUMBER.
ENDFORM.                    "findmainfunctioninclude
"findMainFunctionInclude

*-----------------------------------------------------------------------
FORM FINDFUNCTIONTOPINCLUDE USING VALUE(PROGRAMNAME)
                                        TOPINCLUDENAME.

  SELECT SINGLE INCLUDE
                FROM D010INC
                INTO TOPINCLUDENAME
                WHERE MASTER = PROGRAMNAME
                  AND INCLUDE LIKE '%TOP'.
ENDFORM.                    "findfunctiontopinclude
"findFunctionTopInclude

*-----------------------------------------------------------------------
FORM SCANFORADDITIONALFUNCSTUFF USING ILOCFUNCTIONS LIKE IFUNCTIONS[]
                                      VALUE(RECURSIVEINCLUDES)
                                      VALUE(RECURSIVEFUNCTIONS)
                                      VALUE(SEARCHFORINCLUDES)
                                      VALUE(SEARCHFORFUNCTIONS)
                                      VALUE(SEARCHFORDICTIONARY)
                                      VALUE(SEARCHFORMESSAGES)
                                      VALUE(CUSTOMERONLY)
                                      VALUE(CUSTOMERNAMERANGE).

  DATA: WAFUNCTION TYPE TFUNCTION.
  DATA: WAINCLUDE TYPE TINCLUDE.

  LOOP AT ILOCFUNCTIONS INTO WAFUNCTION.
    IF NOT SEARCHFORINCLUDES IS INITIAL.
*     Search in the main include
      PERFORM SCANFORINCLUDEPROGRAMS USING
      WAFUNCTION-FUNCTIONMAININCLUDE
                                           RECURSIVEINCLUDES
                                           CUSTOMERONLY
                                           CUSTOMERNAMERANGE
                                           WAFUNCTION-IINCLUDES[].

*     Search in the top include
      PERFORM SCANFORINCLUDEPROGRAMS USING WAFUNCTION-TOPINCLUDENAME
                                           RECURSIVEINCLUDES
                                           CUSTOMERONLY
                                           CUSTOMERNAMERANGE
                                           WAFUNCTION-IINCLUDES[].
    ENDIF.

    IF NOT SEARCHFORFUNCTIONS IS INITIAL.
      PERFORM SCANFORFUNCTIONS USING WAFUNCTION-FUNCTIONMAININCLUDE
                                     WAFUNCTION-PROGRAMLINKNAME
                                     RECURSIVEINCLUDES
                                     RECURSIVEFUNCTIONS
                                     CUSTOMERONLY
                                     CUSTOMERNAMERANGE
                                     ILOCFUNCTIONS[].
    ENDIF.

    MODIFY ILOCFUNCTIONS FROM WAFUNCTION.
  ENDLOOP.

* Now we have everthing perhaps we had better find all the dictionary
  IF NOT SEARCHFORDICTIONARY IS INITIAL.
    LOOP AT ILOCFUNCTIONS INTO WAFUNCTION.
      PERFORM SCANFORTABLES USING WAFUNCTION-PROGNAME
                                  CUSTOMERONLY
                                  CUSTOMERNAMERANGE
                                  WAFUNCTION-IDICTSTRUCT[].

      PERFORM SCANFORLIKEORTYPE USING WAFUNCTION-PROGNAME
                                      CUSTOMERONLY
                                      CUSTOMERNAMERANGE
                                      WAFUNCTION-IDICTSTRUCT[].

      LOOP AT WAFUNCTION-IINCLUDES INTO WAINCLUDE.
        PERFORM SCANFORTABLES USING WAINCLUDE-INCLUDENAME
                                    CUSTOMERONLY
                                    CUSTOMERNAMERANGE
                                    WAFUNCTION-IDICTSTRUCT[].

        PERFORM SCANFORLIKEORTYPE USING WAINCLUDE-INCLUDENAME
                                        CUSTOMERONLY
                                        CUSTOMERNAMERANGE
                                        WAFUNCTION-IDICTSTRUCT[].
      ENDLOOP.

      MODIFY ILOCFUNCTIONS FROM WAFUNCTION.
    ENDLOOP.
  ENDIF.

* Now search for all messages
  IF NOT SEARCHFORMESSAGES IS INITIAL.
    LOOP AT ILOCFUNCTIONS INTO WAFUNCTION.
      PERFORM SCANFORMESSAGES USING WAFUNCTION-PROGNAME
                                    WAFUNCTION-MESSAGECLASS
                                    WAFUNCTION-IMESSAGES[].
      MODIFY ILOCFUNCTIONS FROM WAFUNCTION.
    ENDLOOP.
  ENDIF.
ENDFORM.                    "scanforadditionalfuncstuff
"scanForAdditionalFuncStuff

*-----------------------------------------------------------------------
FORM SCANFORCLASSES USING VALUE(CLASSNAME)
                          VALUE(CLASSLINKNAME)
                          VALUE(CUSTOMERONLY)
                          VALUE(CUSTOMERNAMERANGE)
                                ILOCCLASSES LIKE ICLASSES[].

  DATA ILINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: HEAD TYPE STRING.
  DATA: TAIL TYPE STRING.
  DATA: LINELENGTH TYPE I VALUE 0.
  DATA: WALINE TYPE STRING.
  DATA: WACLASS TYPE TCLASS.
  DATA: CASTCLASSNAME TYPE PROGRAM.
  DATA: EXCEPTIONCUSTOMERNAMERANGE TYPE STRING.

* Build the name of the possible cusotmer exception classes
  CONCATENATE CUSTOMERNAMERANGE 'CX_' INTO  EXCEPTIONCUSTOMERNAMERANGE.

* Read the program code from the textpool.
  CASTCLASSNAME = CLASSNAME.
  READ REPORT CASTCLASSNAME INTO ILINES.

  LOOP AT ILINES INTO WALINE.
*   Find custom tables.
    LINELENGTH = STRLEN( WALINE ).
    IF LINELENGTH > 0.
      IF WALINE(1) = ASTERIX.
        CONTINUE.
      ENDIF.

      TRANSLATE WALINE TO UPPER CASE.

      FIND TYPEREFTO IN WALINE IGNORING CASE.
      IF SY-SUBRC = 0.
*       Have found a reference to another class
        SPLIT WALINE AT TYPE INTO HEAD TAIL.
        SHIFT TAIL LEFT DELETING LEADING SPACE.
        SPLIT TAIL AT 'REF' INTO HEAD TAIL.
        SHIFT TAIL LEFT DELETING LEADING SPACE.
        SPLIT TAIL AT 'TO' INTO HEAD TAIL.
        SHIFT TAIL LEFT DELETING LEADING SPACE.
        IF TAIL CS PERIOD.
          SPLIT TAIL AT PERIOD INTO HEAD TAIL.
        ELSE.
          IF TAIL CS COMMA.
            SPLIT TAIL AT COMMA INTO HEAD TAIL.
          ENDIF.
        ENDIF.
      ELSE.
*       Try and find classes which are only referenced through static
        FIND '=>' IN WALINE MATCH OFFSET SY-FDPOS.
        IF SY-SUBRC = 0.
          HEAD = WALINE+0(SY-FDPOS).
          SHIFT HEAD LEFT DELETING LEADING SPACE.
          CONDENSE HEAD.
          FIND 'call method' IN HEAD IGNORING CASE.
          IF SY-SUBRC = 0.
            SHIFT HEAD LEFT DELETING LEADING SPACE.
            SPLIT HEAD AT SPACE INTO HEAD TAIL.
            SPLIT TAIL AT SPACE INTO HEAD TAIL.
*           Should have the class name here
            HEAD = TAIL.
          ELSE.
*           Still have a class name even though it does not have the
            IF WALINE CS '='.
              SPLIT WALINE AT '=' INTO TAIL HEAD.
              SHIFT HEAD LEFT DELETING LEADING SPACE.
              SPLIT HEAD AT '=' INTO HEAD TAIL.
            ENDIF.
            SY-SUBRC = 0.
          ENDIF.
        ENDIF.
      ENDIF.

      IF SY-SUBRC = 0.
        TRY.
            IF HEAD+0(1) = 'Y' OR HEAD+0(1) = 'Z' OR HEAD CS
  CUSTOMERNAMERANGE.
*           We have found a class best append it to our class table if
              READ TABLE ILOCCLASSES INTO WACLASS WITH KEY CLSNAME = HEAD.
              IF SY-SUBRC <> 0.
                IF HEAD+0(3) = 'CX_'
                   OR HEAD+0(4) = 'ZCX_'
                   OR HEAD+0(4) = 'YCX_'
                   OR HEAD CS EXCEPTIONCUSTOMERNAMERANGE.

                  WACLASS-EXCEPTIONCLASS = TRUE.
                ENDIF.

                WACLASS-CLSNAME = HEAD.
                APPEND WACLASS TO ILOCCLASSES.
              ENDIF.
            ENDIF.
          CATCH CX_SY_RANGE_OUT_OF_BOUNDS.
        ENDTRY.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDFORM.                    "scanforclasses
"scanForClasses

*-----------------------------------------------------------------------
FORM SCANFORINCLUDEPROGRAMS USING VALUE(PROGRAMNAME)
                                  VALUE(RECURSIVEINCLUDES)
                                  VALUE(CUSTOMERONLY)
                                  VALUE(CUSTOMERNAMERANGE)
                    ILOCINCLUDES LIKE DUMIINCLUDES[].

  DATA: IINCLUDELINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: ITOKENS TYPE STANDARD TABLE OF STOKES WITH HEADER LINE.
  DATA: IKEYWORDS TYPE STANDARD TABLE OF TEXT20 WITH HEADER LINE.
  DATA: ISTATEMENTS TYPE STANDARD TABLE OF SSTMNT WITH HEADER LINE.
  DATA: WATOKENS TYPE STOKES.
  DATA: WAINCLUDE TYPE TINCLUDE.
  DATA: WAINCLUDEEXISTS TYPE TINCLUDE.
  DATA: MAXLINES TYPE I.
  DATA: NEXTLINE TYPE I.
  DATA: CASTPROGRAMNAME TYPE PROGRAM.

* Read the program code from the textpool.
  CASTPROGRAMNAME = PROGRAMNAME.
  READ REPORT CASTPROGRAMNAME INTO IINCLUDELINES.

  APPEND INCLUDE TO IKEYWORDS.
  SCAN ABAP-SOURCE IINCLUDELINES TOKENS INTO ITOKENS WITH INCLUDES
STATEMENTS INTO ISTATEMENTS KEYWORDS FROM IKEYWORDS.

  CLEAR IINCLUDELINES[].

  MAXLINES = LINES( ITOKENS ).
  LOOP AT ITOKENS WHERE STR = INCLUDE AND TYPE = 'I'.
    NEXTLINE = SY-TABIX + 1.
    IF NEXTLINE <= MAXLINES.
      READ TABLE ITOKENS INDEX NEXTLINE INTO WATOKENS.

*      Are we only to find customer includes?
      IF NOT CUSTOMERONLY IS INITIAL.
        TRY.
            IF WATOKENS-STR+0(1) = 'Y' OR WATOKENS-STR+0(1) = 'Z' OR
 WATOKENS-STR CS CUSTOMERNAMERANGE
               OR WATOKENS-STR+0(2) = 'MZ' OR WATOKENS-STR+0(2) = 'MY'.

            ELSE.
              CONTINUE.
            ENDIF.
          CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
        ENDTRY.
      ENDIF.

      WAINCLUDE-INCLUDENAME = WATOKENS-STR.

*      Best find the program title text as well.
      PERFORM FINDPROGRAMORINCLUDETITLE USING WAINCLUDE-INCLUDENAME
                                              WAINCLUDE-INCLUDETITLE.

*      Don't append the include if we already have it listed
      READ TABLE ILOCINCLUDES INTO WAINCLUDEEXISTS WITH KEY INCLUDENAME
= WAINCLUDE-INCLUDENAME.
      IF SY-SUBRC <> 0.
        APPEND WAINCLUDE TO ILOCINCLUDES.

        IF NOT RECURSIVEINCLUDES IS INITIAL.
*          Do a recursive search for other includes
          PERFORM SCANFORINCLUDEPROGRAMS USING WAINCLUDE-INCLUDENAME
                                               RECURSIVEINCLUDES
                                               CUSTOMERONLY
                                               CUSTOMERNAMERANGE
                                               ILOCINCLUDES[].
        ENDIF.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDFORM.                    "scanforincludeprograms
"scanForIncludePrograms

*-----------------------------------------------------------------------
FORM SCANFORFUNCTIONS USING VALUE(PROGRAMNAME)
                            VALUE(PROGRAMLINKNAME)
                            VALUE(RECURSIVEINCLUDES)
                            VALUE(RECURSIVEFUNCTIONS)
                            VALUE(CUSTOMERONLY)
                            VALUE(CUSTOMERNAMERANGE)
                                  ILOCFUNCTIONS LIKE IFUNCTIONS[].

  DATA: IINCLUDELINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: ITOKENS TYPE STANDARD TABLE OF STOKES WITH HEADER LINE.
  DATA: ISTATEMENTS TYPE STANDARD TABLE OF SSTMNT WITH HEADER LINE.
  DATA: WATOKENS TYPE STOKES.
  DATA: WAFUNCTION TYPE TFUNCTION.
  DATA: WAFUNCTIONCOMPARISON TYPE TFUNCTION.
  DATA: MAXLINES TYPE I.
  DATA: NEXTLINE TYPE I.
  DATA: CASTPROGRAMNAME TYPE PROGRAM.
  DATA: SKIPTHISLOOP TYPE I.

* Read the program code from the textpool.
  CASTPROGRAMNAME = PROGRAMNAME.
  READ REPORT CASTPROGRAMNAME INTO IINCLUDELINES.
  SCAN ABAP-SOURCE IINCLUDELINES TOKENS INTO ITOKENS WITH INCLUDES
STATEMENTS INTO ISTATEMENTS.
  CLEAR IINCLUDELINES[].

  MAXLINES = LINES( ITOKENS ).
  LOOP AT ITOKENS WHERE STR = FUNCTION AND TYPE = 'I'.

    NEXTLINE = SY-TABIX + 1.
    IF NEXTLINE <= MAXLINES.
      READ TABLE ITOKENS INDEX NEXTLINE INTO WATOKENS.

*      Are we only to find customer functions
      SKIPTHISLOOP = FALSE.
      IF NOT CUSTOMERONLY IS INITIAL.
        TRY.
            IF WATOKENS-STR+1(1) = 'Y' OR WATOKENS-STR+1(1) = 'Z' OR
 WATOKENS-STR CS CUSTOMERNAMERANGE.
            ELSE.
              SKIPTHISLOOP = TRUE.
            ENDIF.
          CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
          CLEANUP.
            SKIPTHISLOOP = TRUE.
        ENDTRY.
      ENDIF.

      IF SKIPTHISLOOP = FALSE.
        WAFUNCTION-FUNCTIONNAME = WATOKENS-STR.
        REPLACE ALL OCCURRENCES OF '''' IN WAFUNCTION-FUNCTIONNAME WITH
' '.
        CONDENSE WAFUNCTION-FUNCTIONNAME.

*        Don't add a function if we alread have it listed.
        READ TABLE ILOCFUNCTIONS WITH KEY FUNCTIONNAME =
        WAFUNCTION-FUNCTIONNAME INTO WAFUNCTIONCOMPARISON.
        IF SY-SUBRC <> 0.
*          Add in the link name if the function is linked to a program
          WAFUNCTION-PROGRAMLINKNAME = PROGRAMLINKNAME.

*          Don't download functions which are called through an RFC
          NEXTLINE = SY-TABIX + 2.
          READ TABLE ITOKENS INDEX NEXTLINE INTO WATOKENS.
          IF WATOKENS-STR <> DESTINATION.

*            Find the function group
            SELECT SINGLE AREA FROM V_FDIR INTO
            WAFUNCTION-FUNCTIONGROUP WHERE FUNCNAME =
            WAFUNCTION-FUNCTIONNAME.

            IF SY-SUBRC = 0.
*              Best find the function number as well.
              PERFORM RETRIEVEFUNCTIONDETAIL USING
              WAFUNCTION-FUNCTIONNAME
WAFUNCTION-PROGNAME
    WAFUNCTION-INCLUDENUMBER
        WAFUNCTION-FUNCTIONTITLE.

              PERFORM FINDMAINFUNCTIONINCLUDE USING WAFUNCTION-PROGNAME
                                  WAFUNCTION-INCLUDENUMBER
                                WAFUNCTION-FUNCTIONMAININCLUDE.

              PERFORM FINDFUNCTIONTOPINCLUDE USING WAFUNCTION-PROGNAME
                                     WAFUNCTION-TOPINCLUDENAME.

*              Find main message class
              PERFORM FINDMAINMESSAGECLASS USING WAFUNCTION-PROGNAME
                                   WAFUNCTION-MESSAGECLASS.

              APPEND WAFUNCTION TO ILOCFUNCTIONS.

*              Now lets search a little bit deeper and do a recursive
              IF NOT RECURSIVEINCLUDES IS INITIAL.
                PERFORM SCANFORINCLUDEPROGRAMS USING
                WAFUNCTION-FUNCTIONMAININCLUDE
               RECURSIVEINCLUDES
                                                     CUSTOMERONLY
                                                     CUSTOMERNAMERANGE
                WAFUNCTION-IINCLUDES[].
              ENDIF.

*              Now lets search a little bit deeper and do a recursive
              IF NOT RECURSIVEFUNCTIONS IS INITIAL.
                PERFORM SCANFORFUNCTIONS USING
                WAFUNCTION-FUNCTIONMAININCLUDE
                                               SPACE
                                               RECURSIVEINCLUDES
                                               RECURSIVEFUNCTIONS
                                               CUSTOMERONLY
                                               CUSTOMERNAMERANGE
                                               ILOCFUNCTIONS[].
              ENDIF.
              CLEAR WAFUNCTION.
            ENDIF.
          ENDIF.
        ENDIF.

        CLEAR WAFUNCTION.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDFORM.                    "scanforfunctions
"scanForFunctions

*-----------------------------------------------------------------------
FORM SCANFORFUNCTIONINCLUDES USING POOLNAME
                                   VALUE(CUSTOMERONLY)
                                   VALUE(CUSTOMERNAMERANGE)
                                   ILOCINCLUDES LIKE DUMIINCLUDES[].

  DATA: IINCLUDELINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: ITOKENS TYPE STANDARD TABLE OF STOKES WITH HEADER LINE.
  DATA: IKEYWORDS TYPE STANDARD TABLE OF TEXT20 WITH HEADER LINE.
  DATA: ISTATEMENTS TYPE STANDARD TABLE OF SSTMNT WITH HEADER LINE.
  DATA: WATOKENS TYPE STOKES.
  DATA: WAINCLUDE TYPE TINCLUDE.
  DATA: WAINCLUDEEXISTS TYPE TINCLUDE.
  DATA: MAXLINES TYPE I.
  DATA: NEXTLINE TYPE I.
  DATA: CASTPROGRAMNAME TYPE PROGRAM.

* Read the program code from the textpool.
  CASTPROGRAMNAME = POOLNAME.
  READ REPORT CASTPROGRAMNAME INTO IINCLUDELINES.

  APPEND INCLUDE TO IKEYWORDS.
  SCAN ABAP-SOURCE IINCLUDELINES TOKENS INTO ITOKENS WITH INCLUDES
STATEMENTS INTO ISTATEMENTS KEYWORDS FROM IKEYWORDS.

  CLEAR IINCLUDELINES[].

  MAXLINES = LINES( ITOKENS ).
  LOOP AT ITOKENS WHERE STR = INCLUDE AND TYPE = 'I'.
    NEXTLINE = SY-TABIX + 1.
    IF NEXTLINE <= MAXLINES.
      READ TABLE ITOKENS INDEX NEXTLINE INTO WATOKENS.

      IF WATOKENS-STR CP '*F++'.
*        Are we only to find customer includes?
        IF NOT CUSTOMERONLY IS INITIAL.
          TRY.
              IF WATOKENS-STR+0(2) = 'LY' OR WATOKENS-STR+0(2) = 'LZ' OR
 WATOKENS-STR CS CUSTOMERNAMERANGE.
              ELSE.
                CONTINUE.
              ENDIF.
            CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
          ENDTRY.
        ENDIF.

        WAINCLUDE-INCLUDENAME = WATOKENS-STR.

*        Best find the program title text as well.
        PERFORM FINDPROGRAMORINCLUDETITLE USING WAINCLUDE-INCLUDENAME
                                                WAINCLUDE-INCLUDETITLE.

*        Don't append the include if we already have it listed
        READ TABLE ILOCINCLUDES INTO WAINCLUDEEXISTS WITH KEY
INCLUDENAME = WAINCLUDE-INCLUDENAME.
        IF SY-SUBRC <> 0.
          APPEND WAINCLUDE TO ILOCINCLUDES.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDFORM.                    "scanforfunctionincludes
"scanForFunctionIncludes

*-----------------------------------------------------------------------
FORM FINDPROGRAMORINCLUDETITLE USING VALUE(PROGRAMNAME)
                                           TITLETEXT.

  SELECT SINGLE TEXT
                FROM TRDIRT
                INTO TITLETEXT
                WHERE NAME = PROGRAMNAME
                  AND SPRSL = SY-LANGU.
ENDFORM.                    "findprogramorincludetitle
"findProgramOrIncludeTitle

*-----------------------------------------------------------------------
FORM RETRIEVEPROGRAMS USING ILOCPROGRAM LIKE IPROGRAMS[]
                            ILOCFUNCTIONS LIKE IFUNCTIONS[]
                            RANGEPROGRAM LIKE SOPROGRAMNAME[]
                            RANGEAUTHOR LIKE SOAUTHOR[]
                            VALUE(CUSTNAMERANGE)
                            VALUE(ALSOMODIFIEDBYAUTHOR)
                            VALUE(CUSTOMERPROGSONLY)
                            VALUE(GETMESSAGES)
                            VALUE(GETTEXTELEMENTS)
                            VALUE(GETCUSTDICTSTRUCTURES)
                            VALUE(GETFUNCTIONS)
                            VALUE(GETINCLUDES)
                            VALUE(GETSCREENS)
                            VALUE(RECURSIVEFUNCSEARCH)
                            VALUE(RECURSIVEINCLUDESEARCH)
                            VALUE(GETLOCALOBJECTS)
                            VALUE(PACKAGE).

  DATA: WARANGEPROGRAM LIKE LINE OF RANGEPROGRAM.

  IF RANGEPROGRAM[] IS INITIAL.
*   We are finding all programs by an author
    PERFORM FINDALLPROGRAMSFORAUTHOR USING ILOCPROGRAM[]
                                           RANGEPROGRAM[]
                                           RANGEAUTHOR[]
                                           CUSTNAMERANGE
                                           ALSOMODIFIEDBYAUTHOR
                                           CUSTOMERPROGSONLY
                                           GETLOCALOBJECTS
                                           PACKAGE.
  ELSE.
    READ TABLE RANGEPROGRAM INDEX 1 INTO WARANGEPROGRAM.
    IF WARANGEPROGRAM-LOW CS ASTERIX.
      PERFORM FINDPROGRAMSBYWILDCARD USING ILOCPROGRAM[]
                                           RANGEPROGRAM[]
                                           RANGEAUTHOR[]
                                           CUSTNAMERANGE
                                           CUSTOMERPROGSONLY
                                           GETLOCALOBJECTS
                                           PACKAGE.
    ELSE.
      PERFORM CHECKPROGRAMDOESEXIST USING ILOCPROGRAM[]
                                          RANGEPROGRAM[].
    ENDIF.
  ENDIF.

* Find extra items
  PERFORM SCANFORADDITIONALPROGSTUFF USING ILOCPROGRAM[]
                                           ILOCFUNCTIONS[]
                                           GETTEXTELEMENTS
                                           GETMESSAGES
                                           GETSCREENS
                                           GETCUSTDICTSTRUCTURES
                                           GETFUNCTIONS
                                           GETINCLUDES
                                           CUSTOMERPROGSONLY
                                           CUSTNAMERANGE
                                           RECURSIVEINCLUDESEARCH
                                           RECURSIVEFUNCSEARCH.
ENDFORM.                    "retrieveprograms
"retrievePrograms

*-----------------------------------------------------------------------
FORM SCANFORADDITIONALPROGSTUFF USING ILOCPROGRAM LIKE IPROGRAMS[]
                                      ILOCFUNCTIONS LIKE IFUNCTIONS[]
                                      VALUE(GETTEXTELEMENTS)
                                      VALUE(GETMESSAGES)
                                      VALUE(GETSCREENS)
                                      VALUE(GETCUSTDICTSTRUCTURES)
                                      VALUE(GETFUNCTIONS)
                                      VALUE(GETINCLUDES)
                                      VALUE(CUSTOMERONLY)
                                      VALUE(CUSTOMERNAMERANGE)
                                      VALUE(RECURSIVEINCLUDESEARCH)
                                      VALUE(RECURSIVEFUNCSEARCH).

  DATA: WAPROGRAM TYPE TPROGRAM.
  DATA: WAINCLUDE TYPE TINCLUDE.
  DATA: MYTABIX TYPE SYTABIX.

* Best to find all the includes used in a program first
  IF NOT GETINCLUDES IS INITIAL.
    LOOP AT ILOCPROGRAM INTO WAPROGRAM.
      MYTABIX = SY-TABIX.
      PERFORM SCANFORINCLUDEPROGRAMS USING WAPROGRAM-PROGNAME
                                           RECURSIVEINCLUDESEARCH
                                           CUSTOMERONLY
                                           CUSTOMERNAMERANGE
                                           WAPROGRAM-IINCLUDES[].

      MODIFY ILOCPROGRAM FROM WAPROGRAM INDEX MYTABIX.
    ENDLOOP.
  ENDIF.

* Once we have a list of all the includes we need to loop round them an
  LOOP AT ILOCPROGRAM INTO WAPROGRAM.
    MYTABIX = SY-TABIX.
    PERFORM FINDPROGRAMDETAILS USING WAPROGRAM-PROGNAME
                                     WAPROGRAM-SUBC
                                     WAPROGRAM-PROGRAMTITLE
                                     WAPROGRAM
                                     GETTEXTELEMENTS
                                     GETMESSAGES
                                     GETSCREENS
                                     GETCUSTDICTSTRUCTURES
                                     CUSTOMERONLY
                                     CUSTOMERNAMERANGE.

*   Find any screens
    IF NOT GETSCREENS IS INITIAL.
      PERFORM FINDPROGRAMSCREENFLOW USING WAPROGRAM.
    ENDIF.

    LOOP AT WAPROGRAM-IINCLUDES INTO WAINCLUDE.
      PERFORM FINDPROGRAMDETAILS USING WAINCLUDE-INCLUDENAME
                                       'I'
                                       WAINCLUDE-INCLUDETITLE
                                       WAPROGRAM
                                       GETTEXTELEMENTS
                                       GETMESSAGES
                                       GETSCREENS
                                       GETCUSTDICTSTRUCTURES
                                       CUSTOMERONLY
                                       CUSTOMERNAMERANGE.
    ENDLOOP.

    MODIFY ILOCPROGRAM FROM WAPROGRAM INDEX MYTABIX.
  ENDLOOP.

* Now we have all the program includes and details we need to find extra
  IF NOT GETFUNCTIONS IS INITIAL.
    LOOP AT ILOCPROGRAM INTO WAPROGRAM.
*     Find any functions defined in the code
      PERFORM SCANFORFUNCTIONS USING WAPROGRAM-PROGNAME
                                     WAPROGRAM-PROGNAME
                                     SPACE
                                     SPACE
                                     CUSTOMERONLY
                                     CUSTOMERNAMERANGE
                                     ILOCFUNCTIONS[].
    ENDLOOP.
  ENDIF.

* We have a list of all the functions so lets go and find details and
  PERFORM SCANFORADDITIONALFUNCSTUFF USING ILOCFUNCTIONS[]
                                           RECURSIVEINCLUDESEARCH
                                           RECURSIVEFUNCSEARCH
                                           GETINCLUDES
                                           GETFUNCTIONS
                                           GETCUSTDICTSTRUCTURES
                                           GETMESSAGES
                                           CUSTOMERONLY
                                           CUSTOMERNAMERANGE.
ENDFORM.                    "scanforadditionalprogstuff
"scanForAdditionalProgStuff

*-----------------------------------------------------------------------
FORM FINDPROGRAMDETAILS USING VALUE(PROGRAMNAME)
                              VALUE(PROGRAMTYPE)
                                    PROGRAMTITLE
                                    WAPROGRAM TYPE TPROGRAM
                              VALUE(GETTEXTELEMENTS)
                              VALUE(GETMESSAGES)
                              VALUE(GETSCREENS)
                              VALUE(GETCUSTDICTSTRUCTURES)
                              VALUE(CUSTOMERONLY)
                              VALUE(CUSTOMERNAMERANGE).

  PERFORM FINDPROGRAMORINCLUDETITLE USING PROGRAMNAME
                                          PROGRAMTITLE.

  IF NOT GETTEXTELEMENTS IS INITIAL.
*   Find the program texts from out of the database.
    PERFORM RETRIEVEPROGRAMTEXTS USING WAPROGRAM-ISELECTIONTEXTS[]
                                       WAPROGRAM-ITEXTELEMENTS[]
                                       PROGRAMNAME.
  ENDIF.

* Search for any GUI texts
  IF NOT GETSCREENS IS INITIAL AND
  ( PROGRAMTYPE = 'M' OR PROGRAMTYPE = '1' ).
    PERFORM RETRIEVEGUITITLES USING WAPROGRAM-IGUITITLE[]
                                    PROGRAMNAME.
  ENDIF.

* Find individual messages
  IF NOT GETMESSAGES IS INITIAL.
    IF PROGRAMTYPE = 'M' OR PROGRAMTYPE = '1'.
      PERFORM FINDMAINMESSAGECLASS USING PROGRAMNAME
                                         WAPROGRAM-MESSAGECLASS.
    ENDIF.

    PERFORM SCANFORMESSAGES USING PROGRAMNAME
                                  WAPROGRAM-MESSAGECLASS
                                  WAPROGRAM-IMESSAGES[].
  ENDIF.

  IF NOT GETCUSTDICTSTRUCTURES IS INITIAL.
    PERFORM SCANFORTABLES USING PROGRAMNAME
                                CUSTOMERONLY
                                CUSTOMERNAMERANGE
                                WAPROGRAM-IDICTSTRUCT[].

    PERFORM SCANFORLIKEORTYPE USING PROGRAMNAME
                                    CUSTOMERONLY
                                    CUSTOMERNAMERANGE
                                    WAPROGRAM-IDICTSTRUCT[].
  ENDIF.
ENDFORM.                    "findprogramdetails
"findProgramDetails

*-----------------------------------------------------------------------
FORM FINDALLPROGRAMSFORAUTHOR USING ILOCPROGRAM LIKE IPROGRAMS[]
                                    RANGEPROGRAM LIKE SOPROGRAMNAME[]
                                    RANGEAUTHOR LIKE SOAUTHOR[]
                                    VALUE(CUSTNAMERANGE)
                                    VALUE(ALSOMODIFIEDBYAUTHOR)
                                    VALUE(CUSTOMERPROGSONLY)
                                    VALUE(GETLOCALOBJECTS)
                                    VALUE(PACKAGE).

  DATA: ALTCUSTOMERNAMERANGE TYPE STRING.
  FIELD-SYMBOLS: <WAPROGRAM> TYPE TPROGRAM.
  DATA: GENFLAG TYPE GENFLAG.

* build up the customer name range used for select statements
  CONCATENATE CUSTNAMERANGE '%' INTO ALTCUSTOMERNAMERANGE.

* select by name and author
  IF NOT ALSOMODIFIEDBYAUTHOR IS INITIAL.
*   Programs modified by author
*   Program to search for is an executable program
    IF CUSTOMERPROGSONLY IS INITIAL.
*     Select all programs
      SELECT PROGNAME
             SUBC
             FROM REPOSRC
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCPROGRAM
             WHERE PROGNAME IN RANGEPROGRAM
               AND CNAM IN RANGEAUTHOR
               AND ( SUBC = '1' OR SUBC = 'M' OR SUBC = 'S' ).

    ELSE.
*     Select only customer specific programs
      SELECT PROGNAME
             SUBC
             FROM REPOSRC
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCPROGRAM
             WHERE PROGNAME  IN RANGEPROGRAM
               AND ( PROGNAME LIKE ALTCUSTOMERNAMERANGE
                     OR PROGNAME LIKE 'Z%'
                     OR PROGNAME LIKE 'Y%'
                     OR PROGNAME LIKE 'SAPMZ%'
                     OR PROGNAME LIKE 'SAPMY%')
               AND CNAM IN RANGEAUTHOR
               AND ( SUBC = '1' OR SUBC = 'M' OR SUBC = 'S' ).
    ENDIF.
  ELSE.

*   Programs created by author
    IF CUSTOMERPROGSONLY IS INITIAL.
*     Select all programs
      SELECT PROGNAME
             SUBC
             FROM REPOSRC
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCPROGRAM
             WHERE PROGNAME IN RANGEPROGRAM
               AND ( SUBC = '1' OR SUBC = 'M' OR SUBC = 'S' )
               AND ( CNAM IN RANGEAUTHOR OR UNAM IN RANGEAUTHOR ).
    ELSE.
*     Select only customer specific programs
      SELECT PROGNAME
             SUBC
             FROM REPOSRC
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCPROGRAM
             WHERE PROGNAME IN RANGEPROGRAM
               AND ( PROGNAME LIKE ALTCUSTOMERNAMERANGE
                     OR PROGNAME LIKE 'Z%'
                     OR PROGNAME LIKE 'Y%'
                     OR PROGNAME LIKE 'SAPMZ%'
                     OR PROGNAME LIKE 'SAPMY%')
               AND ( SUBC = '1' OR SUBC = 'M' OR SUBC = 'S' )
               AND ( CNAM IN RANGEAUTHOR OR UNAM IN RANGEAUTHOR ).
    ENDIF.
  ENDIF.

* Delete any programs which are local objects
  IF GETLOCALOBJECTS IS INITIAL.
    LOOP AT ILOCPROGRAM ASSIGNING <WAPROGRAM>.
      SELECT SINGLE GENFLAG
                    FROM TADIV
                    INTO GENFLAG
                    WHERE PGMID = 'R3TR'
                      AND OBJECT = 'PROG'
                      AND OBJ_NAME = <WAPROGRAM>-PROGNAME
                      AND DEVCLASS = '$TMP'.
      IF SY-SUBRC = 0.
        DELETE ILOCPROGRAM.
      ENDIF.
    ENDLOOP.
  ENDIF.

* Delete any programs which are not in the specified package
  IF NOT PACKAGE IS INITIAL.
    IF PACKAGE CS '*'.
      TRANSLATE PACKAGE USING '*%'.
    ENDIF.

    LOOP AT ILOCPROGRAM ASSIGNING <WAPROGRAM>.
      SELECT SINGLE GENFLAG
                    FROM TADIV
                    INTO GENFLAG
                    WHERE PGMID = 'R3TR'
                      AND OBJECT = 'PROG'
                      AND OBJ_NAME = <WAPROGRAM>-PROGNAME
                      AND DEVCLASS LIKE PACKAGE.
      IF SY-SUBRC <> 0.
        DELETE ILOCPROGRAM.
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDFORM.                    "findallprogramsforauthor
"findAllProgramsForAuthor

*-----------------------------------------------------------------------
FORM CHECKPROGRAMDOESEXIST USING ILOCPROGRAM LIKE IPROGRAMS[]
                                 RANGEPROGRAM LIKE SOPROGRAMNAME[].

  DATA: WAPROGRAM TYPE TPROGRAM.

*  Check to see if the program is an executable program
  SELECT SINGLE PROGNAME
                SUBC
                INTO (WAPROGRAM-PROGNAME, WAPROGRAM-SUBC)
                FROM REPOSRC
                WHERE PROGNAME IN RANGEPROGRAM
                  AND ( SUBC = '1' OR
                        SUBC = 'I' OR
                        SUBC = 'M' OR
                        SUBC = 'S' ).

  IF NOT WAPROGRAM-PROGNAME IS INITIAL.
    APPEND WAPROGRAM TO ILOCPROGRAM.
  ENDIF.
ENDFORM.                    "checkprogramdoesexist
"checkProgramDoesExist

*-----------------------------------------------------------------------
FORM FINDPROGRAMSBYWILDCARD USING ILOCPROGRAM LIKE IPROGRAMS[]
                VALUE(RANGEPROGRAM) LIKE SOPROGRAMNAME[]
                                  VALUE(RANGEAUTHOR) LIKE SOAUTHOR[]
                                  VALUE(CUSTNAMERANGE)
                                  VALUE(CUSTOMERPROGSONLY)
                                  VALUE(GETLOCALOBJECTS)
                                  VALUE(PACKAGE).

  DATA: ALTCUSTOMERNAMERANGE TYPE STRING.
  FIELD-SYMBOLS: <WAPROGRAM> TYPE TPROGRAM.
  DATA: GENFLAG TYPE GENFLAG.

  IF CUSTOMERPROGSONLY IS INITIAL.
*   build up the customer name range used for select statements
    IF CUSTNAMERANGE <> '^'.
      CONCATENATE CUSTNAMERANGE '%' INTO ALTCUSTOMERNAMERANGE.

      SELECT PROGNAME
             SUBC
             FROM REPOSRC
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCPROGRAM
             WHERE PROGNAME  IN RANGEPROGRAM
               AND PROGNAME LIKE ALTCUSTOMERNAMERANGE
               AND ( SUBC = '1' OR SUBC = 'M' OR SUBC = 'S' )
               AND ( CNAM IN RANGEAUTHOR OR UNAM IN RANGEAUTHOR ).
    ELSE.
      SELECT PROGNAME
             SUBC
             FROM REPOSRC
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCPROGRAM
             WHERE PROGNAME  IN RANGEPROGRAM
               AND ( SUBC = '1' OR SUBC = 'M' OR SUBC = 'S' )
               AND ( CNAM IN RANGEAUTHOR OR UNAM IN RANGEAUTHOR ).
    ENDIF.
  ELSE.
*   Only customer programs
    IF CUSTNAMERANGE <> '^'.
      CONCATENATE CUSTNAMERANGE '%' INTO ALTCUSTOMERNAMERANGE.

      SELECT PROGNAME
             SUBC
             FROM REPOSRC
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCPROGRAM
             WHERE PROGNAME  IN RANGEPROGRAM
               AND ( PROGNAME LIKE ALTCUSTOMERNAMERANGE
                     OR PROGNAME LIKE 'Z%'
                     OR PROGNAME LIKE 'Y%'
                     OR PROGNAME LIKE 'SAPMZ%'
                     OR PROGNAME LIKE 'SAPMY%')
               AND ( SUBC = '1' OR SUBC = 'M' OR SUBC = 'S' )
               AND ( CNAM IN RANGEAUTHOR OR UNAM IN RANGEAUTHOR ).
    ELSE.
      SELECT PROGNAME
             SUBC
             FROM REPOSRC
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCPROGRAM
             WHERE PROGNAME  IN RANGEPROGRAM
             AND ( PROGNAME LIKE 'Z%'
                   OR PROGNAME LIKE 'Y%'
                   OR PROGNAME LIKE 'SAPMZ%'
                   OR PROGNAME LIKE 'SAPMY%')
             AND ( SUBC = '1' OR SUBC = 'M' OR SUBC = 'S' )
             AND ( CNAM IN RANGEAUTHOR OR UNAM IN RANGEAUTHOR ).
    ENDIF.
  ENDIF.

* Delete any programs which are local objects
  IF GETLOCALOBJECTS IS INITIAL.
    LOOP AT ILOCPROGRAM ASSIGNING <WAPROGRAM>.
      SELECT SINGLE GENFLAG
                    FROM TADIV
                    INTO GENFLAG
                    WHERE PGMID = 'R3TR'
                      AND OBJECT = 'PROG'
                      AND OBJ_NAME = <WAPROGRAM>-PROGNAME
                      AND DEVCLASS = '$TMP'.
      IF SY-SUBRC = 0.
        DELETE ILOCPROGRAM.
      ENDIF.
    ENDLOOP.
  ENDIF.

* Delete any programs which are not in the specified package
  IF NOT PACKAGE IS INITIAL.
    LOOP AT ILOCPROGRAM ASSIGNING <WAPROGRAM>.
      SELECT SINGLE GENFLAG
                    FROM TADIV
                    INTO GENFLAG
                    WHERE PGMID = 'R3TR'
                      AND OBJECT = 'PROG'
                      AND OBJ_NAME = <WAPROGRAM>-PROGNAME
                      AND DEVCLASS <> PACKAGE.
      IF SY-SUBRC = 0.
        DELETE ILOCPROGRAM.
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDFORM.                    "findprogramsbywildcard
"findProgramsByWildcard

*-----------------------------------------------------------------------
FORM RETRIEVEPROGRAMTEXTS USING ILOCSELECTIONTEXTS LIKE DUMITEXTTAB[]
                                ILOCTEXTELEMENTS LIKE DUMITEXTTAB[]
                                VALUE(PROGRAMNAME).

  DATA: ITEXTTABLE TYPE STANDARD TABLE OF TTEXTTABLE WITH HEADER LINE.
  DATA: WATEXTS TYPE TTEXTTABLE.
  DATA: CASTPROGRAMNAME(50).

  MOVE PROGRAMNAME TO CASTPROGRAMNAME.

  READ TEXTPOOL CASTPROGRAMNAME INTO ITEXTTABLE LANGUAGE SY-LANGU.
  DELETE ITEXTTABLE WHERE KEY = 'R'.

* Selection texts.
  LOOP AT ITEXTTABLE WHERE ID = 'S'.
    MOVE ITEXTTABLE-KEY TO WATEXTS-KEY.
    MOVE ITEXTTABLE-ENTRY TO WATEXTS-ENTRY.
    APPEND WATEXTS TO ILOCSELECTIONTEXTS.
    CLEAR WATEXTS.
  ENDLOOP.

* Text elements.
  DELETE ITEXTTABLE WHERE KEY = 'S'.
  LOOP AT ITEXTTABLE WHERE ID = 'I'.
    MOVE ITEXTTABLE-KEY TO WATEXTS-KEY.
    MOVE ITEXTTABLE-ENTRY TO WATEXTS-ENTRY.
    APPEND WATEXTS TO ILOCTEXTELEMENTS.
  ENDLOOP.
ENDFORM.                    "retrieveprogramtexts
"retrieveProgramTexts

*-----------------------------------------------------------------------
FORM RETRIEVEGUITITLES USING ILOCGUITITLE LIKE DUMIGUITITLE[]
                             VALUE(PROGRAMNAME).

  SELECT OBJ_CODE
         TEXT
         FROM D347T
         APPENDING CORRESPONDING FIELDS OF TABLE ILOCGUITITLE
         WHERE PROGNAME = PROGRAMNAME.
ENDFORM.                    "retrieveguititles
"retrieveGUITitles

*-----------------------------------------------------------------------
FORM FINDMAINMESSAGECLASS USING VALUE(PROGRAMNAME)
                                      MESSAGECLASS.

  SELECT SINGLE MSGID
                FROM TRDIRE INTO MESSAGECLASS
                WHERE REPORT = PROGRAMNAME.
ENDFORM.                    "findmainmessageclass
"findMainMessageClass

*-----------------------------------------------------------------------
FORM RETRIEVECLASSES USING ILOCCLASSES LIKE ICLASSES[]
                           ILOCFUNCTIONS LIKE IFUNCTIONS[]
                           RANGECLASS LIKE SOCLASSNAME[]
                           RANGEAUTHOR LIKE SOAUTHOR[]
                           VALUE(CUSTNAMERANGE)
                           VALUE(ALSOMODIFIEDBYAUTHOR)
                           VALUE(CUSTOMERPROGSONLY)
                           VALUE(GETMESSAGES)
                           VALUE(GETTEXTELEMENTS)
                           VALUE(GETCUSTDICTSTRUCTURES)
                           VALUE(GETFUNCTIONS)
                           VALUE(GETINCLUDES)
                           VALUE(RECURSIVEFUNCSEARCH)
                           VALUE(RECURSIVEINCLUDESEARCH)
                           VALUE(RECURSIVECLASSSEARCH)
                           VALUE(LANGUAGE).

  DATA: WARANGECLASS LIKE LINE OF RANGECLASS.

  IF RANGECLASS[] IS INITIAL.
*   We are finding all programs by an author
    PERFORM FINDALLCLASSESFORAUTHOR USING ILOCCLASSES[]
                                           RANGECLASS[]
                                           RANGEAUTHOR[]
                                           CUSTNAMERANGE
                                           ALSOMODIFIEDBYAUTHOR
                                           CUSTOMERPROGSONLY
                                           LANGUAGE.
  ELSE.
    READ TABLE RANGECLASS INDEX 1 INTO WARANGECLASS.
    IF WARANGECLASS-LOW CS ASTERIX.
      PERFORM FINDCLASSESBYWILDCARD USING ILOCCLASSES[]
                                          RANGECLASS[]
                                          RANGEAUTHOR[]
                                          CUSTNAMERANGE
                                          CUSTOMERPROGSONLY
                                          LANGUAGE.
    ELSE.
      PERFORM CHECKCLASSDOESEXIST USING ILOCCLASSES[]
                                        RANGECLASS[].
    ENDIF.
  ENDIF.

* Find extra items
  IF NOT ILOCCLASSES[] IS INITIAL.
    PERFORM SCANFORADDITIONALCLASSSTUFF USING ILOCCLASSES[]
                                              ILOCFUNCTIONS[]
                                              GETTEXTELEMENTS
                                              GETMESSAGES
                                              GETCUSTDICTSTRUCTURES
                                              GETFUNCTIONS
                                              GETINCLUDES
                                              CUSTOMERPROGSONLY
                                              CUSTNAMERANGE
                                              RECURSIVEINCLUDESEARCH
                                              RECURSIVEFUNCSEARCH
                                              RECURSIVECLASSSEARCH.
  ENDIF.
ENDFORM.                    "retrieveclasses
"retrieveClasses

*-----------------------------------------------------------------------
FORM FINDALLCLASSESFORAUTHOR USING ILOCCLASS LIKE ICLASSES[]
                                   RANGECLASS LIKE SOCLASSNAME[]
                                   RANGEAUTHOR LIKE SOAUTHOR[]
                                   VALUE(CUSTNAMERANGE)
                                   VALUE(ALSOMODIFIEDBYAUTHOR)
                                   VALUE(CUSTOMERCLASSESONLY)
                                   VALUE(LANGUAGE).

  DATA: ALTCUSTOMERNAMERANGE(2).

* build up the customer name range used for select statements
  CONCATENATE CUSTNAMERANGE '%' INTO ALTCUSTOMERNAMERANGE.

* select by name and author
  IF NOT ALSOMODIFIEDBYAUTHOR IS INITIAL.
*   Classes modified by author
    IF CUSTOMERCLASSESONLY IS INITIAL.
*     Select all classes
      SELECT CLSNAME DESCRIPT MSG_ID
             FROM VSEOCLASS
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
             WHERE CLSNAME IN RANGECLASS
               AND LANGU = LANGUAGE
               AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR )
               AND VERSION = '1'
               AND ( STATE = '0' OR STATE = '1' ).

      IF SY-SUBRC <> 0.
        SELECT CLSNAME DESCRIPT MSG_ID
               FROM VSEOCLASS
               APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
               WHERE CLSNAME IN RANGECLASS
               AND LANGU = LANGUAGE
                 AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR
)
                 AND VERSION = '0'
                 AND ( STATE = '0' OR STATE = '1' ).
      ENDIF.
    ELSE.
*     Select only customer specific classes
      SELECT CLSNAME DESCRIPT MSG_ID
             FROM VSEOCLASS
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
             WHERE CLSNAME IN RANGECLASS
               AND ( CLSNAME LIKE ALTCUSTOMERNAMERANGE
                     OR CLSNAME LIKE 'Z%'
                     OR CLSNAME LIKE 'Y%')
               AND LANGU = LANGUAGE
               AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR )
               AND VERSION = '1'
               AND ( STATE = '0' OR STATE = '1' ).

      IF SY-SUBRC <> 0.
        SELECT CLSNAME DESCRIPT MSG_ID
               FROM VSEOCLASS
               APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
               WHERE CLSNAME IN RANGECLASS
                 AND ( CLSNAME LIKE ALTCUSTOMERNAMERANGE
                       OR CLSNAME LIKE 'Z%'
                       OR CLSNAME LIKE 'Y%')
                 AND LANGU = LANGUAGE
                 AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR
)
                 AND VERSION = '0'
                 AND ( STATE = '0' OR STATE = '1' ).
      ENDIF.
    ENDIF.
  ELSE.
*   Programs created by author
    IF CUSTOMERCLASSESONLY IS INITIAL.
*     Select all classes
      SELECT CLSNAME DESCRIPT MSG_ID
             FROM VSEOCLASS
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
             WHERE CLSNAME IN RANGECLASS
               AND LANGU = LANGUAGE
               AND AUTHOR IN RANGEAUTHOR
               AND VERSION = '1'
               AND ( STATE = '0' OR STATE = '1' ).

      IF SY-SUBRC <> 0.
        SELECT CLSNAME DESCRIPT MSG_ID
               FROM VSEOCLASS
               APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
               WHERE CLSNAME IN RANGECLASS
                 AND LANGU = LANGUAGE
                 AND AUTHOR IN RANGEAUTHOR
                 AND VERSION = '0'
                 AND ( STATE = '0' OR STATE = '1' ).
      ENDIF.
    ELSE.
*     Select only customer specific classes
      SELECT CLSNAME DESCRIPT MSG_ID
             FROM VSEOCLASS
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
             WHERE CLSNAME IN RANGECLASS
               AND ( CLSNAME LIKE ALTCUSTOMERNAMERANGE
                     OR CLSNAME LIKE 'Z%'
                     OR CLSNAME LIKE 'Y%')
               AND LANGU = LANGUAGE
               AND AUTHOR IN RANGEAUTHOR
               AND VERSION = '1'
               AND ( STATE = '0' OR STATE = '1' ).

      IF SY-SUBRC <> 0.
        SELECT CLSNAME DESCRIPT MSG_ID
               FROM VSEOCLASS
               APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
               WHERE CLSNAME IN RANGECLASS
                 AND ( CLSNAME LIKE ALTCUSTOMERNAMERANGE
                       OR CLSNAME LIKE 'Z%'
                       OR CLSNAME LIKE 'Y%')
                 AND LANGU = LANGUAGE
                 AND AUTHOR IN RANGEAUTHOR
                 AND VERSION = '0'
                 AND ( STATE = '0' OR STATE = '1' ).
      ENDIF.
    ENDIF.
  ENDIF.
ENDFORM.                    "findallclassesforauthor
"findAllClassesForAuthor

*-----------------------------------------------------------------------
FORM FINDCLASSESBYWILDCARD USING ILOCCLASS LIKE ICLASSES[]
                                 RANGECLASS LIKE SOCLASSNAME[]
                                 VALUE(RANGEAUTHOR) LIKE SOAUTHOR[]
                                 VALUE(CUSTNAMERANGE)
                                 VALUE(CUSTOMERCLASSESONLY)
                                 VALUE(LANGUAGE).

  DATA: ALTCUSTOMERNAMERANGE(2).

  IF CUSTOMERCLASSESONLY IS INITIAL.
*   Searching for customer and SAP classes
    IF CUSTNAMERANGE <> '^'.
*     build up the customer name range used for select statements
      CONCATENATE CUSTNAMERANGE '%' INTO ALTCUSTOMERNAMERANGE.

      SELECT CLSNAME DESCRIPT MSG_ID
             FROM VSEOCLASS
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
             WHERE CLSNAME IN RANGECLASS
               AND CLSNAME LIKE CUSTNAMERANGE
               AND LANGU = LANGUAGE
               AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR )
               AND VERSION = '1'
               AND ( STATE = '0' OR STATE = '1' ).
      IF SY-SUBRC <> 0.
        SELECT CLSNAME DESCRIPT MSG_ID
               FROM VSEOCLASS
               APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
               WHERE CLSNAME IN RANGECLASS
                 AND CLSNAME LIKE CUSTNAMERANGE
                 AND LANGU = LANGUAGE
                 AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR
)
                 AND VERSION = '0'
                 AND ( STATE = '0' OR STATE = '1' ).
      ENDIF.
    ELSE.
*     Searching using normal name ranges
      SELECT CLSNAME DESCRIPT MSG_ID
             FROM VSEOCLASS
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
             WHERE CLSNAME IN RANGECLASS
               AND LANGU = LANGUAGE
               AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR )
               AND VERSION = '1'
               AND ( STATE = '0' OR STATE = '1' ).
      IF SY-SUBRC <> 0.
        SELECT CLSNAME DESCRIPT MSG_ID
               FROM VSEOCLASS
               APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
               WHERE CLSNAME IN RANGECLASS
                 AND LANGU = LANGUAGE
                 AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR
)
                 AND VERSION = '0'
                 AND ( STATE = '0' OR STATE = '1' ).
      ENDIF.
    ENDIF.
  ELSE.
*   searching for only customer classes
    IF CUSTNAMERANGE <> '^'.
*     build up the customer name range used for select statements
      CONCATENATE CUSTNAMERANGE '%' INTO ALTCUSTOMERNAMERANGE.

      SELECT CLSNAME DESCRIPT MSG_ID
             FROM VSEOCLASS
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
             WHERE CLSNAME IN RANGECLASS
               AND CLSNAME LIKE CUSTNAMERANGE
               AND LANGU = LANGUAGE
               AND ( CLSNAME LIKE 'ZC%' OR CLSNAME LIKE 'YC%' )
               AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR )
               AND VERSION = '1'
               AND ( STATE = '0' OR STATE = '1' ).
      IF SY-SUBRC <> 0.
        SELECT CLSNAME DESCRIPT MSG_ID
               FROM VSEOCLASS
               APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
               WHERE CLSNAME IN RANGECLASS
                 AND LANGU = LANGUAGE
                 AND ( CLSNAME LIKE 'ZC%' OR CLSNAME LIKE 'YC%' )
                 AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR
)
                 AND VERSION = '0'
                 AND ( STATE = '0' OR STATE = '1' ).
      ENDIF.
    ELSE.
*     Searching using normal name ranges
      SELECT CLSNAME DESCRIPT MSG_ID
             FROM VSEOCLASS
             APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
             WHERE CLSNAME IN RANGECLASS
               AND ( CLSNAME LIKE 'ZC%' OR CLSNAME LIKE 'YC%' )
               AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR )
               AND VERSION = '1'
               AND ( STATE = '0' OR STATE = '1' ).
      IF SY-SUBRC <> 0.
        SELECT CLSNAME DESCRIPT MSG_ID
               FROM VSEOCLASS
               APPENDING CORRESPONDING FIELDS OF TABLE ILOCCLASS
               WHERE CLSNAME IN RANGECLASS
                 AND ( CLSNAME LIKE 'ZC%' OR CLSNAME LIKE 'YC%' )
                 AND ( AUTHOR IN RANGEAUTHOR OR CHANGEDBY IN RANGEAUTHOR
)
                 AND VERSION = '0'
                 AND ( STATE = '0' OR STATE = '1' ).
      ENDIF.
    ENDIF.
  ENDIF.
ENDFORM.                    "findclassesbywildcard
"findClassesByWildcard

*-----------------------------------------------------------------------
FORM CHECKCLASSDOESEXIST USING ILOCCLASS LIKE ICLASSES[]
                               RANGECLASS LIKE SOCLASSNAME[].

  DATA: WACLASS TYPE TCLASS.

  SELECT SINGLE CLSNAME DESCRIPT MSG_ID
         FROM VSEOCLASS
         INTO CORRESPONDING FIELDS OF WACLASS
         WHERE CLSNAME IN RANGECLASS
           AND VERSION = '1'
           AND ( STATE = '0' OR STATE = '1' ).

  IF SY-SUBRC <> 0.
    SELECT SINGLE CLSNAME DESCRIPT MSG_ID
         FROM VSEOCLASS
         INTO CORRESPONDING FIELDS OF WACLASS
         WHERE CLSNAME IN RANGECLASS
           AND VERSION = '0'
           AND ( STATE = '0' OR STATE = '1' ).
  ENDIF.

  IF NOT WACLASS-CLSNAME IS INITIAL.
    APPEND WACLASS TO ILOCCLASS.
  ENDIF.
ENDFORM.                    "checkclassdoesexist
"checkClassDoesExist

*-----------------------------------------------------------------------
FORM SCANFORADDITIONALCLASSSTUFF USING ILOCCLASSES LIKE ICLASSES[]
                                       ILOCFUNCTIONS LIKE IFUNCTIONS[]
                                       VALUE(GETTEXTELEMENTS)
                                       VALUE(GETMESSAGES)
                                       VALUE(GETCUSTDICTSTRUCTURES)
                                       VALUE(GETFUNCTIONS)
                                       VALUE(GETINCLUDES)
                                       VALUE(CUSTOMERONLY)
                                       VALUE(CUSTOMERNAMERANGE)
                                       VALUE(RECURSIVEINCLUDESEARCH)
                                       VALUE(RECURSIVEFUNCSEARCH)
                                       VALUE(RECURSIVECLASSSEARCH).

  DATA: WACLASS TYPE TCLASS.
  DATA: WAMETHOD TYPE TMETHOD.
  DATA: MYTABIX TYPE SYTABIX.
  DATA: SCANNINGFORCLASSES TYPE I VALUE FALSE.
  DATA: CLASSNEWLINES TYPE I VALUE 0.
  DATA: CLASSCURRENTLINES TYPE I VALUE 0.

  LOOP AT ILOCCLASSES INTO WACLASS WHERE SCANNED IS INITIAL.
*  Once we have a list of all the classes we need to loop round them an
    MYTABIX = SY-TABIX.
    PERFORM FINDCLASSDETAILS USING WACLASS-CLSNAME
                                   WACLASS
                                   ILOCFUNCTIONS[]
                                   GETTEXTELEMENTS
                                   GETMESSAGES
                                   GETFUNCTIONS
                                   GETCUSTDICTSTRUCTURES
                                   CUSTOMERONLY
                                   CUSTOMERNAMERANGE.

*   Set the scanned class so we do not check them again when running
    WACLASS-SCANNED = 'X'.
    MODIFY ILOCCLASSES FROM WACLASS INDEX MYTABIX.
  ENDLOOP.

* Now we have all the classes and details we need to find extra classes
  IF NOT RECURSIVECLASSSEARCH IS INITIAL.
    CLASSCURRENTLINES = LINES( ILOCCLASSES ).
    LOOP AT ILOCCLASSES INTO WACLASS.
*     Don't try and find any other details for an exception class
      IF ( WACLASS-CLSNAME NS 'ZCX_' OR WACLASS-CLSNAME NS 'CX_'  ).
*       Find any classes defined in the main class definition
        PERFORM SCANFORCLASSES USING WACLASS-PRIVATECLASSKEY
                                     WACLASS-CLSNAME
                                     CUSTOMERONLY
                                     CUSTOMERNAMERANGE
                                     ILOCCLASSES[].

        PERFORM SCANFORCLASSES USING WACLASS-PUBLICCLASSKEY
                                     WACLASS-CLSNAME
                                     CUSTOMERONLY
                                     CUSTOMERNAMERANGE
                                     ILOCCLASSES[].

        PERFORM SCANFORCLASSES USING WACLASS-PROTECTEDCLASSKEY
                                     WACLASS-CLSNAME
                                     CUSTOMERONLY
                                     CUSTOMERNAMERANGE
                                     ILOCCLASSES[].

        LOOP AT WACLASS-IMETHODS INTO WAMETHOD.
*         Find any classes defined in any of the methods
          PERFORM SCANFORCLASSES USING WAMETHOD-METHODKEY
                                       WACLASS-CLSNAME
                                       CUSTOMERONLY
                                       CUSTOMERNAMERANGE
                                       ILOCCLASSES[].
        ENDLOOP.
      ENDIF.
    ENDLOOP.

*   We have a list of all the classes so lets go and find their details
    CLASSNEWLINES = LINES( ILOCCLASSES ).
    IF CLASSNEWLINES > CLASSCURRENTLINES.
      PERFORM SCANFORADDITIONALCLASSSTUFF USING ILOCCLASSES[]
                                                ILOCFUNCTIONS[]
                                                GETTEXTELEMENTS
                                                GETMESSAGES
                                                GETCUSTDICTSTRUCTURES
                                                GETFUNCTIONS
                                                GETINCLUDES
                                                CUSTOMERONLY
                                                CUSTOMERNAMERANGE
                                                RECURSIVEINCLUDESEARCH
                                                RECURSIVEFUNCSEARCH
                                                RECURSIVECLASSSEARCH.
    ENDIF.
  ENDIF.
ENDFORM.                    "scanforadditionalclassstuff
"scanForAdditionalClassStuff

*-----------------------------------------------------------------------
FORM FINDCLASSDETAILS USING VALUE(CLASSNAME)
                                  WACLASS TYPE TCLASS
                              ILOCFUNCTIONS LIKE IFUNCTIONS[]
                              VALUE(GETTEXTELEMENTS)
                              VALUE(GETMESSAGES)
                              VALUE(GETFUNCTIONS)
                              VALUE(GETCUSTDICTSTRUCTURES)
                              VALUE(CUSTOMERONLY)
                              VALUE(CUSTOMERNAMERANGE).

  DATA: IEMPTYSELECTIONTEXTS TYPE STANDARD TABLE OF TTEXTTABLE.
  DATA: MYTABIX TYPE SYTABIX.
  DATA: WAMETHOD TYPE TMETHOD.

* Build up the keys we will use for finding data
  PERFORM BUILDCLASSKEYS USING WACLASS.

  IF WACLASS-DESCRIPT IS INITIAL.
    PERFORM FINDCLASSDESCRIPTION USING CLASSNAME
                                       WACLASS-DESCRIPT.
  ENDIF.

* Find the class attributes.
  SELECT SINGLE EXPOSURE MSG_ID STATE CLSFINAL R3RELEASE
                FROM VSEOCLASS
                INTO (WACLASS-EXPOSURE, WACLASS-MSG_ID, WACLASS-STATE,
                      WACLASS-CLSFINAL, WACLASS-R3RELEASE)
                WHERE CLSNAME = WACLASS-CLSNAME.

* Don't try and find any other details for an exception class
  IF ( WACLASS-CLSNAME CS 'ZCX_' OR WACLASS-CLSNAME CS 'CX_'  ).
*   Exception texts
    PERFORM FINDEXCEPTIONTEXTS USING WACLASS-PUBLICCLASSKEY
                                     WACLASS-ICONCEPTS[].
    WACLASS-SCANNED = 'X'.
  ELSE.
    IF NOT GETTEXTELEMENTS IS INITIAL.
*     Find the class texts from out of the database.
      PERFORM RETRIEVEPROGRAMTEXTS USING IEMPTYSELECTIONTEXTS[]
                                         WACLASS-ITEXTELEMENTS[]
                                         WACLASS-TEXTELEMENTKEY.
    ENDIF.

*   Find any declared dictionary structures
    IF NOT GETCUSTDICTSTRUCTURES IS INITIAL.
      PERFORM SCANFORTABLES USING WACLASS-PRIVATECLASSKEY
                                  CUSTOMERONLY
                                  CUSTOMERNAMERANGE
                                  WACLASS-IDICTSTRUCT[].

      PERFORM SCANFORTABLES USING WACLASS-PUBLICCLASSKEY
                                  CUSTOMERONLY
                                  CUSTOMERNAMERANGE
                                  WACLASS-IDICTSTRUCT[].

      PERFORM SCANFORTABLES USING WACLASS-PROTECTEDCLASSKEY
                                  CUSTOMERONLY
                                  CUSTOMERNAMERANGE
                                  WACLASS-IDICTSTRUCT[].

      PERFORM SCANFORTABLES USING WACLASS-TYPESCLASSKEY
                                  CUSTOMERONLY
                                  CUSTOMERNAMERANGE
                                  WACLASS-IDICTSTRUCT[].

      PERFORM SCANFORLIKEORTYPE USING WACLASS-PRIVATECLASSKEY
                                      CUSTOMERONLY
                                      CUSTOMERNAMERANGE
                                      WACLASS-IDICTSTRUCT[].

      PERFORM SCANFORLIKEORTYPE USING WACLASS-PUBLICCLASSKEY
                                      CUSTOMERONLY
                                      CUSTOMERNAMERANGE
                                      WACLASS-IDICTSTRUCT[].

      PERFORM SCANFORLIKEORTYPE USING WACLASS-PROTECTEDCLASSKEY
                                      CUSTOMERONLY
                                      CUSTOMERNAMERANGE
                                      WACLASS-IDICTSTRUCT[].

      PERFORM SCANFORLIKEORTYPE USING WACLASS-TYPESCLASSKEY
                                      CUSTOMERONLY
                                      CUSTOMERNAMERANGE
                                      WACLASS-IDICTSTRUCT[].
    ENDIF.


*   Methods
*   Find all the methods for this class
    PERFORM FINDCLASSMETHODS USING CLASSNAME
                                   WACLASS-IMETHODS[].

    LOOP AT WACLASS-IMETHODS[] INTO WAMETHOD.
      MYTABIX = SY-TABIX.
*     Find individual messages
      IF NOT GETMESSAGES IS INITIAL.
        PERFORM SCANFORMESSAGES USING WAMETHOD-METHODKEY
                                      WACLASS-MSG_ID
                                      WACLASS-IMESSAGES[].
      ENDIF.

      IF NOT GETCUSTDICTSTRUCTURES IS INITIAL.
*       Find any declared dictionary structures
        PERFORM SCANFORTABLES USING WAMETHOD-METHODKEY
                                    CUSTOMERONLY
                                    CUSTOMERNAMERANGE
                                    WACLASS-IDICTSTRUCT[].

        PERFORM SCANFORLIKEORTYPE USING WAMETHOD-METHODKEY
                                        CUSTOMERONLY
                                        CUSTOMERNAMERANGE
                                        WACLASS-IDICTSTRUCT[].
      ENDIF.

      IF NOT GETFUNCTIONS IS INITIAL.
        PERFORM SCANFORFUNCTIONS USING WAMETHOD-METHODKEY
                                       WACLASS-CLSNAME
                                       SPACE
                                       SPACE
                                       CUSTOMERONLY
                                       CUSTOMERNAMERANGE
                                       ILOCFUNCTIONS[].
      ENDIF.

      MODIFY WACLASS-IMETHODS FROM WAMETHOD INDEX MYTABIX.
    ENDLOOP.
  ENDIF.
ENDFORM.                    "findclassdetails
"findClassDetails

*-----------------------------------------------------------------------
FORM BUILDCLASSKEYS USING WACLASS TYPE TCLASS.

  DATA: CLASSNAMELENGTH TYPE I.
  DATA: LOOPS TYPE I.

  CLASSNAMELENGTH = STRLEN( WACLASS-CLSNAME ).

  CL_OO_CLASSNAME_SERVICE=>GET_PUBSEC_NAME( EXPORTING CLSNAME
   = WACLASS-CLSNAME
                   RECEIVING RESULT = WACLASS-PUBLICCLASSKEY ).

  CL_OO_CLASSNAME_SERVICE=>GET_PRISEC_NAME( EXPORTING CLSNAME
   = WACLASS-CLSNAME
                   RECEIVING RESULT = WACLASS-PRIVATECLASSKEY ).

  CL_OO_CLASSNAME_SERVICE=>GET_PROSEC_NAME( EXPORTING CLSNAME
   = WACLASS-CLSNAME
                   RECEIVING RESULT = WACLASS-PROTECTEDCLASSKEY ).


* Text element key - length of text element key has to be 32 characters.
  LOOPS = 30 - CLASSNAMELENGTH.
  WACLASS-TEXTELEMENTKEY = WACLASS-CLSNAME.
  DO LOOPS TIMES.
    CONCATENATE WACLASS-TEXTELEMENTKEY '=' INTO WACLASS-TEXTELEMENTKEY.
  ENDDO.
* Save this for later.
  CONCATENATE WACLASS-TEXTELEMENTKEY 'CP' INTO WACLASS-TEXTELEMENTKEY.

* Types Class key - length of class name has to be 32 characters.
  LOOPS = 30 - CLASSNAMELENGTH.
  WACLASS-TYPESCLASSKEY = WACLASS-CLSNAME.
  DO LOOPS TIMES.
    CONCATENATE WACLASS-TYPESCLASSKEY '=' INTO WACLASS-TYPESCLASSKEY.
  ENDDO.
* Save this for later
  CONCATENATE WACLASS-TYPESCLASSKEY 'CT' INTO WACLASS-TYPESCLASSKEY.
ENDFORM.                    "buildclasskeys
"buildClassKeys

*-----------------------------------------------------------------------
FORM FINDCLASSDESCRIPTION USING VALUE(CLASSNAME)
                                      TITLETEXT.

  SELECT SINGLE DESCRIPT
                FROM VSEOCLASS
                INTO TITLETEXT
                WHERE CLSNAME = CLASSNAME
                  AND LANGU = SY-LANGU.
  IF SY-SUBRC <> 0.
    SELECT SINGLE DESCRIPT
                  FROM VSEOCLASS
                  INTO TITLETEXT
                  WHERE CLSNAME = CLASSNAME.
  ENDIF.
ENDFORM.                    "findclassdescription
"findClassDescription

*-----------------------------------------------------------------------
FORM FINDEXCEPTIONTEXTS USING PUBLICCLASSKEY
                              ICONCEPTS LIKE DUMICONCEPTS[].

  DATA: CASTCLASSNAME TYPE PROGRAM.
  DATA: ITEMPLINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: ITOKENS TYPE STANDARD TABLE OF STOKES WITH HEADER LINE.
  DATA: IKEYWORDS TYPE STANDARD TABLE OF TEXT20 WITH HEADER LINE.
  DATA: ISTATEMENTS TYPE STANDARD TABLE OF SSTMNT WITH HEADER LINE.
  DATA: WATOKENS TYPE STOKES.
  DATA: WACURRENTTOKEN TYPE STOKES.
  DATA: WACONCEPT LIKE LINE OF ICONCEPTS.
  DATA: TOKENLENGTH TYPE I.
  DATA: MYROW TYPE I.

  CASTCLASSNAME = PUBLICCLASSKEY.
  READ REPORT CASTCLASSNAME INTO ITEMPLINES.

  APPEND 'CONSTANTS' TO IKEYWORDS.
  SCAN ABAP-SOURCE ITEMPLINES TOKENS INTO ITOKENS STATEMENTS INTO
ISTATEMENTS KEYWORDS FROM IKEYWORDS.

  DELETE ITOKENS WHERE STR = 'CONSTANTS'.
  DELETE ITOKENS WHERE STR = 'VALUE'.
  DELETE ITOKENS WHERE STR = 'TYPE'.

  LOOP AT ITOKENS INTO WATOKENS WHERE STR = 'SOTR_CONC'.
*   The loop before holds the constant name
    MYROW = SY-TABIX - 1.
    READ TABLE ITOKENS INDEX MYROW INTO WACURRENTTOKEN.
    WACONCEPT-CONSTNAME = WACURRENTTOKEN-STR.

*   The loop after holds the constant name
    MYROW = MYROW + 2.
    READ TABLE ITOKENS INDEX MYROW INTO WACURRENTTOKEN.
    TOKENLENGTH = STRLEN( WACURRENTTOKEN-STR ).
    IF TOKENLENGTH = 34.
*     Most likely an exception text.
      REPLACE ALL OCCURRENCES OF '''' IN WACURRENTTOKEN-STR WITH ' ' .
      WACONCEPT-CONCEPT = WACURRENTTOKEN-STR.
      APPEND WACONCEPT TO ICONCEPTS.
    ENDIF.
  ENDLOOP.
ENDFORM.                    "findexceptiontexts

*-----------------------------------------------------------------------
FORM FINDCLASSMETHODS USING VALUE(CLASSNAME)
                            ILOCMETHODS LIKE DUMIMETHODS[].

  DATA: IMETHODS TYPE STANDARD TABLE OF TMETHOD WITH HEADER LINE.

  SELECT CMPNAME DESCRIPT EXPOSURE
         FROM VSEOMETHOD
         INTO CORRESPONDING FIELDS OF TABLE IMETHODS
           WHERE CLSNAME = CLASSNAME
             AND VERSION = '1'
             AND LANGU = SY-LANGU
             AND ( STATE = '0' OR STATE = '1' ).

  IF SY-SUBRC <> 0.
    SELECT CMPNAME DESCRIPT EXPOSURE
           FROM VSEOMETHOD
           INTO CORRESPONDING FIELDS OF TABLE IMETHODS
           WHERE CLSNAME = CLASSNAME
             AND VERSION = '0'
             AND LANGU = SY-LANGU
             AND ( STATE = '0' OR STATE = '1' ).
  ENDIF.

* Find the method key so that we can acces the source code later
  LOOP AT IMETHODS.
    PERFORM FINDMETHODKEY USING CLASSNAME
                                IMETHODS-CMPNAME
                                IMETHODS-METHODKEY.
    MODIFY IMETHODS.
  ENDLOOP.

  ILOCMETHODS[] = IMETHODS[].
ENDFORM.                    "findclassmethods
"findClassMethods

*-----------------------------------------------------------------------
FORM FINDMETHODKEY USING VALUE(CLASSNAME)
                         VALUE(METHODNAME)
                               METHODKEY.

  DATA: METHODID TYPE SEOCPDKEY.
  DATA: LOCMETHODKEY TYPE PROGRAM.

  METHODID-CLSNAME = CLASSNAME.
  METHODID-CPDNAME = METHODNAME.

  CL_OO_CLASSNAME_SERVICE=>GET_METHOD_INCLUDE( EXPORTING MTDKEY =
METHODID
                                               RECEIVING RESULT =
LOCMETHODKEY
                                               EXCEPTIONS
CLASS_NOT_EXISTING = 1

METHOD_NOT_EXISTING = 2 ).

  METHODKEY = LOCMETHODKEY.
ENDFORM.                    "findmethodkey
"findMethodKey

*-----------------------------------------------------------------------
FORM SCANFORMESSAGES USING VALUE(PROGRAMNAME)
                           VALUE(MAINMESSAGECLASS)
                                 ILOCMESSAGES LIKE IMESSAGES[].

  DATA: IINCLUDELINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: ITOKENS TYPE STANDARD TABLE OF STOKES WITH HEADER LINE.
  DATA: ISTATEMENTS TYPE STANDARD TABLE OF SSTMNT WITH HEADER LINE.
  DATA: IKEYWORDS TYPE STANDARD TABLE OF TEXT20 WITH HEADER LINE.
  DATA: WAMESSAGE TYPE TMESSAGE.
  DATA: WAMESSAGECOMPARISON TYPE TMESSAGE.
  DATA: WATOKENS TYPE STOKES.
  DATA: NEXTLINE TYPE I.
  DATA: STRINGLENGTH TYPE I VALUE 0.
  DATA: WORKINGONMESSAGE TYPE I VALUE FALSE.
  DATA: CASTPROGRAMNAME TYPE PROGRAM.

* Read the program code from the textpool.
  CASTPROGRAMNAME = PROGRAMNAME.
  READ REPORT CASTPROGRAMNAME INTO IINCLUDELINES.

  APPEND MESSAGE TO IKEYWORDS.
  SCAN ABAP-SOURCE IINCLUDELINES TOKENS INTO ITOKENS WITH INCLUDES
STATEMENTS INTO ISTATEMENTS KEYWORDS FROM IKEYWORDS.

  CLEAR IINCLUDELINES[].

  LOOP AT ITOKENS.
    IF ITOKENS-STR = MESSAGE.
      WORKINGONMESSAGE = TRUE.
      CONTINUE.
    ENDIF.

    IF WORKINGONMESSAGE = TRUE.
      STRINGLENGTH = STRLEN( ITOKENS-STR ).

*     Message declaration 1
      IF STRINGLENGTH = 4 AND ITOKENS-STR+0(1) CA SY-ABCDE.
        WAMESSAGE-MSGNR = ITOKENS-STR+1(3).
        WAMESSAGE-ARBGB = MAINMESSAGECLASS.
      ELSE.
        IF ITOKENS-STR CS '''' OR ITOKENS-STR CS '`'.
*         Message declaration 2
          TRANSLATE ITOKENS-STR USING ''' '.
          TRANSLATE ITOKENS-STR USING '` '.
          CONDENSE ITOKENS-STR.
          SHIFT ITOKENS-STR LEFT DELETING LEADING SPACE.
          WAMESSAGE-TEXT = ITOKENS-STR.
          WAMESSAGE-ARBGB = 'Hard coded'.
        ELSE.
          IF ITOKENS-STR = 'ID'.
*           Message declaration 3
            NEXTLINE = SY-TABIX + 1.
            READ TABLE ITOKENS INDEX NEXTLINE INTO WATOKENS.
            TRANSLATE WATOKENS-STR USING ''' '.
            CONDENSE ITOKENS-STR.
            SHIFT WATOKENS-STR LEFT DELETING LEADING SPACE.
            IF NOT WATOKENS-STR = 'SY-MSGID'.
              WAMESSAGE-ARBGB = WATOKENS-STR.

              NEXTLINE = NEXTLINE + 4.
              READ TABLE ITOKENS INDEX NEXTLINE INTO WATOKENS.
              TRANSLATE WATOKENS-STR USING ''' '.
              CONDENSE WATOKENS-STR.
              SHIFT WATOKENS-STR LEFT DELETING LEADING SPACE.
              WAMESSAGE-MSGNR = WATOKENS-STR.
            ELSE.
              WORKINGONMESSAGE = FALSE.
            ENDIF.
          ELSE.
            IF STRINGLENGTH >= 5 AND ITOKENS-STR+4(1) = '('.
*              Message declaration 4
              WAMESSAGE-MSGNR = ITOKENS-STR+1(3).
              SHIFT ITOKENS-STR LEFT UP TO '('.
              REPLACE '(' INTO ITOKENS-STR WITH SPACE.
              REPLACE ')' INTO ITOKENS-STR WITH SPACE.
              CONDENSE ITOKENS-STR.
              WAMESSAGE-ARBGB = ITOKENS-STR.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.

*      find the message text
      IF NOT WAMESSAGE-ARBGB IS INITIAL AND NOT WAMESSAGE-MSGNR IS
INITIAL AND WAMESSAGE-TEXT IS INITIAL.
        SELECT SINGLE TEXT
                      FROM T100
                      INTO WAMESSAGE-TEXT
                      WHERE SPRSL = SY-LANGU
                        AND ARBGB = WAMESSAGE-ARBGB
                        AND MSGNR = WAMESSAGE-MSGNR.
      ENDIF.

*      Append the message
      IF NOT WAMESSAGE IS INITIAL.
*        Don't append the message if we already have it listed
        READ TABLE ILOCMESSAGES WITH KEY ARBGB = WAMESSAGE-ARBGB
                                         MSGNR = WAMESSAGE-MSGNR
                                         INTO WAMESSAGECOMPARISON.
        IF SY-SUBRC <> 0.
          APPEND WAMESSAGE TO ILOCMESSAGES.
        ENDIF.
        CLEAR WAMESSAGE.
        WORKINGONMESSAGE = FALSE.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDFORM.                    "scanformessages
"scanForMessages

*-----------------------------------------------------------------------
FORM SCANFORTABLES USING VALUE(PROGRAMNAME)
                         VALUE(CUSTOMERONLY)
                         VALUE(CUSTOMERNAMERANGE)
                               ILOCDICTIONARY LIKE IDICTIONARY[].

  DATA: IINCLUDELINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: ITOKENS TYPE STANDARD TABLE OF STOKES WITH HEADER LINE.
  DATA: ISTATEMENTS TYPE STANDARD TABLE OF SSTMNT WITH HEADER LINE.
  DATA: IKEYWORDS TYPE STANDARD TABLE OF TEXT20 WITH HEADER LINE.
  DATA: WADICTIONARY TYPE TDICTTABLE.
  DATA: WADICTIONARYCOMPARISON TYPE TDICTTABLE.
  DATA: CASTPROGRAMNAME TYPE PROGRAM.

* Read the program code from the textpool.
  CASTPROGRAMNAME = PROGRAMNAME.
  READ REPORT CASTPROGRAMNAME INTO IINCLUDELINES.

  APPEND TABLES TO IKEYWORDS.

  SCAN ABAP-SOURCE IINCLUDELINES TOKENS INTO ITOKENS WITH INCLUDES
STATEMENTS INTO ISTATEMENTS KEYWORDS FROM IKEYWORDS.
  CLEAR IINCLUDELINES[].

  SORT ITOKENS ASCENDING BY STR.
  DELETE ITOKENS WHERE STR = TABLES.

  LOOP AT ITOKENS.
    IF NOT CUSTOMERONLY IS INITIAL.
      TRY.
          IF ( ITOKENS-STR+0(1) <> 'Y' OR ITOKENS-STR+0(1) <> 'Z' OR
  ITOKENS-STR NS CUSTOMERNAMERANGE ).
            CONTINUE.
          ENDIF.
        CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
      ENDTRY.
    ENDIF.

    WADICTIONARY-TABLENAME = ITOKENS-STR.
*   Don't append the object if we already have it listed
    READ TABLE ILOCDICTIONARY INTO WADICTIONARYCOMPARISON WITH KEY
TABLENAME = WADICTIONARY-TABLENAME.
    IF SY-SUBRC <> 0.
      PERFORM FINDTABLEDESCRIPTION USING WADICTIONARY-TABLENAME
                                         WADICTIONARY-TABLETITLE.

      PERFORM FINDTABLEDEFINITION USING WADICTIONARY-TABLENAME
                                        WADICTIONARY-ISTRUCTURE[].

      APPEND WADICTIONARY TO ILOCDICTIONARY.
    ENDIF.
  ENDLOOP.
ENDFORM.                    "scanfortables
"scanForTables

*-----------------------------------------------------------------------
FORM FINDPROGRAMSCREENFLOW USING WAPROGRAM TYPE TPROGRAM.

  DATA: IFLOW TYPE STANDARD TABLE OF TSCREENFLOW WITH HEADER LINE.

  CALL FUNCTION 'DYNPRO_PROCESSINGLOGIC'
    EXPORTING
      REP_NAME  = WAPROGRAM-PROGNAME
    TABLES
      SCR_LOGIC = IFLOW.

  SORT IFLOW ASCENDING BY SCREEN.
  DELETE ADJACENT DUPLICATES FROM IFLOW COMPARING SCREEN.
  IF WAPROGRAM-SUBC <> 'M'.
    DELETE IFLOW WHERE SCREEN >= '1000' AND SCREEN <= '1099'.
  ENDIF.

  LOOP AT IFLOW.
    APPEND IFLOW TO WAPROGRAM-ISCREENFLOW.
  ENDLOOP.
ENDFORM.                    "findprogramscreenflow
"findProgramScreenFlow

*-----------------------------------------------------------------------
FORM FINDFUNCTIONSCREENFLOW USING WAFUNCTION TYPE TFUNCTION.

  DATA: IFLOW TYPE STANDARD TABLE OF TSCREENFLOW WITH HEADER LINE.

  CALL FUNCTION 'DYNPRO_PROCESSINGLOGIC'
    EXPORTING
      REP_NAME  = WAFUNCTION-PROGNAME
    TABLES
      SCR_LOGIC = IFLOW.

  SORT IFLOW ASCENDING BY SCREEN.
  DELETE ADJACENT DUPLICATES FROM IFLOW COMPARING SCREEN.

  LOOP AT IFLOW.
    APPEND IFLOW TO WAFUNCTION-ISCREENFLOW.
  ENDLOOP.
ENDFORM.                    "findfunctionscreenflow
"findFunctionScreenFlow

*-----------------------------------------------------------------------
FORM SCANFORLIKEORTYPE USING VALUE(PROGRAMNAME)
                             VALUE(CUSTOMERONLY)
                             VALUE(CUSTOMERNAMERANGE)
                             ILOCDICTIONARY LIKE IDICTIONARY[].

  DATA ILINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: HEAD TYPE STRING.
  DATA: TAIL TYPE STRING.
  DATA: JUNK TYPE STRING.
  DATA: LINETYPE TYPE STRING.
  DATA: LINELENGTH TYPE I VALUE 0.
  DATA: ENDOFLINE TYPE I VALUE TRUE.
  DATA: WADICTIONARY TYPE TDICTTABLE.
  DATA: WADICTIONARYCOMPARISON TYPE TDICTTABLE.
  DATA: WALINE TYPE STRING.
  DATA: CASTPROGRAMNAME TYPE PROGRAM.

* Read the program code from the textpool.
  CASTPROGRAMNAME = PROGRAMNAME.
  READ REPORT CASTPROGRAMNAME INTO ILINES.

  LOOP AT ILINES INTO WALINE.
*   Find custom tables.
    LINELENGTH = STRLEN( WALINE ).
    IF LINELENGTH > 0.
      IF WALINE(1) = ASTERIX.
        CONTINUE.
      ENDIF.

      TRANSLATE WALINE TO UPPER CASE.

*   Determine the lineType.
      IF ENDOFLINE = TRUE.
        SHIFT WALINE UP TO LIKE.
        IF SY-SUBRC = 0.
          LINETYPE = LIKE.
        ELSE.
          SHIFT WALINE UP TO TYPE.
          IF SY-SUBRC = 0.
            FIND 'BEGIN OF' IN WALINE.
            IF SY-SUBRC <> 0.
              FIND 'END OF' IN WALINE.
              IF SY-SUBRC <> 0.
                FIND 'VALUE' IN WALINE.
                IF SY-SUBRC <> 0.
                  LINETYPE = TYPE.
                ENDIF.
              ENDIF.
            ENDIF.
          ELSE.
            SHIFT WALINE UP TO INCLUDE.
            IF SY-SUBRC = 0.
              SPLIT WALINE AT SPACE INTO JUNK ILINES.
            ENDIF.

            SHIFT WALINE UP TO STRUCTURE.
            IF SY-SUBRC = 0.
              LINETYPE = STRUCTURE.
            ELSE.
              CONTINUE.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        LINETYPE = COMMA.
      ENDIF.

      CASE LINETYPE.
        WHEN LIKE OR TYPE OR STRUCTURE.
*         Work on the appropriate lineType
          SHIFT WALINE UP TO SPACE.
          SHIFT WALINE LEFT DELETING LEADING SPACE.
          IF WALINE CS TABLE.
            SPLIT WALINE AT TABLE INTO HEAD TAIL.
            SPLIT TAIL AT 'OF' INTO HEAD TAIL.
            WALINE = TAIL.
            SHIFT WALINE LEFT DELETING LEADING SPACE.
          ENDIF.

*         Are we only to download SAP dictionary structures.
          IF NOT CUSTOMERONLY IS INITIAL.
            TRY.
                IF WALINE+0(1) = 'Y' OR WALINE+0(1) = 'Z' OR WALINE CS
  CUSTOMERNAMERANGE.
                ELSE.
                  LINETYPE = ''.
                  CONTINUE.
                ENDIF.
              CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
            ENDTRY.
          ENDIF.

          IF WALINE CS COMMA.
            SPLIT WALINE AT COMMA INTO HEAD TAIL.
            IF WALINE CS DASH.
              SPLIT HEAD AT DASH INTO HEAD TAIL.
            ENDIF.
            IF WALINE CS OCCURS.
              SPLIT WALINE AT SPACE INTO HEAD TAIL.
            ENDIF.
          ELSE.
            IF WALINE CS PERIOD.
              SPLIT WALINE AT PERIOD INTO HEAD TAIL.
              IF WALINE CS DASH.
                SPLIT HEAD AT DASH INTO HEAD TAIL.
              ENDIF.
              IF WALINE CS OCCURS.
                SPLIT WALINE AT SPACE INTO HEAD TAIL.
              ENDIF.
            ELSE.
              SPLIT WALINE AT SPACE INTO HEAD TAIL.
              IF WALINE CS DASH.
                SPLIT HEAD AT DASH INTO HEAD TAIL.
              ENDIF.
            ENDIF.
          ENDIF.

          IF NOT HEAD IS INITIAL.
            WADICTIONARY-TABLENAME = HEAD.
*           Don't append the object if we already have it listed
            READ TABLE ILOCDICTIONARY INTO WADICTIONARYCOMPARISON
              WITH KEY TABLENAME = WADICTIONARY-TABLENAME.
            IF SY-SUBRC <> 0.
              PERFORM FINDTABLEDESCRIPTION USING WADICTIONARY-TABLENAME
                    WADICTIONARY-TABLETITLE.

              PERFORM FINDTABLEDEFINITION USING WADICTIONARY-TABLENAME
                     WADICTIONARY-ISTRUCTURE[].

*             Only append if the item is a table and not a structure or
              IF NOT WADICTIONARY-ISTRUCTURE[] IS INITIAL.
                APPEND WADICTIONARY TO ILOCDICTIONARY.
              ENDIF.
            ENDIF.
            CLEAR WADICTIONARY.
          ENDIF.

          LINETYPE = ''.
      ENDCASE.
    ENDIF.
  ENDLOOP.
ENDFORM.                    "scanforlikeortype
"scanForLikeOrType

*-----------------------------------------------------------------------
FORM DISPLAYSTATUS USING VALUE(MESSAGE)
                         VALUE(DELAY).

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
    EXPORTING
      PERCENTAGE = 0
      TEXT       = MESSAGE
    EXCEPTIONS
      OTHERS     = 1.

  IF DELAY > 0.
    WAIT UP TO DELAY SECONDS.
  ENDIF.
ENDFORM.                    "displaystatus
"displayStatus

*-----------------------------------------------------------------------
FORM REMOVELEADINGZEROS CHANGING MYVALUE.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
    EXPORTING
      INPUT  = MYVALUE
    IMPORTING
      OUTPUT = MYVALUE
    EXCEPTIONS
      OTHERS = 1.
ENDFORM.                    "removeleadingzeros
"removeLeadingZeros

*-----------------------------------------------------------------------
* determineFrontendOPSystem.... Determine the frontend operating system
FORM DETERMINEFRONTENDOPSYSTEM USING SEPARATOR
                                     OPERATINGSYSTEM.

  DATA: PLATFORMID TYPE I VALUE 0.

  CREATE OBJECT OBJFILE.

  CALL METHOD OBJFILE->GET_PLATFORM
    RECEIVING
      PLATFORM             = PLATFORMID
    EXCEPTIONS
      CNTL_ERROR           = 1
      ERROR_NO_GUI         = 2
      NOT_SUPPORTED_BY_GUI = 3.
  CASE PLATFORMID.
    WHEN OBJFILE->PLATFORM_WINDOWS95
         OR OBJFILE->PLATFORM_WINDOWS98
         OR OBJFILE->PLATFORM_NT351
         OR OBJFILE->PLATFORM_NT40
         OR OBJFILE->PLATFORM_NT50
         OR OBJFILE->PLATFORM_MAC
         OR OBJFILE->PLATFORM_OS2
         OR 14.      "XP
      SEPARATOR = '\'.
      OPERATINGSYSTEM = NON_UNIX.
    WHEN OTHERS.
      SEPARATOR = '/'.
      OPERATINGSYSTEM = UNIX.
  ENDCASE.
ENDFORM.                    "determinefrontendopsystem
"determineFrontendOpSystem

*-----------------------------------------------------------------------
* determineServerOPSystem.... Determine the server operating system
FORM DETERMINESERVEROPSYSTEM USING SEPARATOR
                                   SERVERFILESYSTEM
                                   SERVEROPSYSTEM.

* Find the file system
  SELECT SINGLE FILESYS
                FROM OPSYSTEM
                INTO SERVERFILESYSTEM
                WHERE OPSYS = SY-OPSYS.

  FIND 'WINDOWS' IN SERVERFILESYSTEM IGNORING CASE.
  IF SY-SUBRC = 0.
    SEPARATOR = '\'.
    SERVEROPSYSTEM = NON_UNIX.
  ELSE.
    FIND 'DOS' IN SERVERFILESYSTEM IGNORING CASE.
    IF SY-SUBRC = 0.
      SEPARATOR = '\'.
      SERVEROPSYSTEM = NON_UNIX.
    ELSE.
      SEPARATOR = '/'.
      SERVEROPSYSTEM = UNIX.
    ENDIF.
  ENDIF.
ENDFORM.                    "determineserveropsystem
"determineServerOpSystem

*-----------------------------------------------------------------------
FORM FINDEXTERNALCOMMAND.

*  <<< HAN
*  call function 'SXPG_COMMAND_CHECK'
*    exporting
*      commandname                      = 'ZMKDIR'
*      operatingsystem                  = sy-opsys
*    exceptions
*      command_not_found                = 1
*      others                           = 0.

  IF SY-SUBRC <> 0.
    LOOP AT SCREEN.
      IF SCREEN-NAME = 'PLOGICAL'.
        SCREEN-INPUT = 0.
        MODIFY SCREEN.
      ENDIF.

      IF SCREEN-NAME = 'PSERV'.
        SCREEN-INPUT = 0.
        MODIFY SCREEN.
      ENDIF.

      IF SCREEN-NAME = 'PPC'.
        SCREEN-INPUT = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.

*    <<<< HAN
*    message s000(oo) with 'Download to server disabled,'
*    'external command ZMKDIR not defined.'.

  ENDIF.
ENDFORM.                    "findexternalcommand

************************************************************************
* downloadDDStructures... download database objects to file
*-----------------------------------------------------------------------
FORM DOWNLOADDDSTRUCTURES USING ILOCDICTIONARY LIKE IDICTIONARY[]
                                VALUE(PATHNAME)
                                VALUE(HTMLFILEEXTENSION)
                                VALUE(SUBDIR)
                                VALUE(SORTTABLESASC)
                                VALUE(SLASHSEPARATOR)
                                VALUE(SAVETOSERVER)
                                VALUE(DISPLAYPROGRESSMESSAGE).

  FIELD-SYMBOLS: <WADICTIONARY> TYPE TDICTTABLE.
  DATA: TABLEFILENAME TYPE STRING.
  DATA: TABLEFILENAMEWITHPATH TYPE STRING.
  DATA: IHTMLTABLE TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: NEWSUBDIRECTORY TYPE STRING.
  DATA: COMPLETESAVEPATH TYPE STRING.

  LOOP AT ILOCDICTIONARY ASSIGNING <WADICTIONARY>.
    PERFORM BUILDFILENAME USING PATHNAME
                                SUBDIR
                                <WADICTIONARY>-TABLENAME
                                SPACE
                                SPACE
                                HTMLFILEEXTENSION
                                IS_TABLE
                                SAVETOSERVER
                                SLASHSEPARATOR
                                TABLEFILENAMEWITHPATH
                                TABLEFILENAME
                                NEWSUBDIRECTORY
                                COMPLETESAVEPATH.

*   Try and import a converted table to memory as it will be much
    IMPORT IHTMLTABLE FROM MEMORY ID <WADICTIONARY>-TABLENAME.
    IF SY-SUBRC <> 0.
      CONCATENATE 'Converting table' <WADICTIONARY>-TABLENAME 'to html'
INTO STATUSBARMESSAGE SEPARATED BY SPACE.
      PERFORM DISPLAYSTATUS USING STATUSBARMESSAGE 0.

      PERFORM CONVERTDDTOHTML USING <WADICTIONARY>-ISTRUCTURE[]
                                    IHTMLTABLE[]
                                    <WADICTIONARY>-TABLENAME
                                    <WADICTIONARY>-TABLETITLE
                                    SORTTABLESASC.

      EXPORT IHTMLTABLE TO MEMORY ID <WADICTIONARY>-TABLENAME.
    ENDIF.

    IF SAVETOSERVER IS INITIAL.
      PERFORM SAVEFILETOPC USING IHTMLTABLE[]
                                 TABLEFILENAMEWITHPATH
                                 TABLEFILENAME
                                 SPACE
                                 SPACE
                                 DISPLAYPROGRESSMESSAGE.
    ELSE.
      PERFORM SAVEFILETOSERVER USING IHTMLTABLE[]
                                     TABLEFILENAMEWITHPATH
                                     TABLEFILENAME
                                     COMPLETESAVEPATH
                                     DISPLAYPROGRESSMESSAGE.
    ENDIF.

    CLEAR IHTMLTABLE[].
  ENDLOOP.
ENDFORM.                    "downloadddstructures
"downloadDDStructures

*-----------------------------------------------------------------------
* downloadMessageClass...
*-----------------------------------------------------------------------
FORM DOWNLOADMESSAGECLASS USING ILOCMESSAGES LIKE IMESSAGES[]
                                VALUE(MESSAGECLASSNAME)
                                VALUE(USERFILEPATH)
                                VALUE(FILEEXTENSION)
                                VALUE(HTMLFILEFLAG)
                                      SUBDIR
                                VALUE(SYNTAXHIGHLIGHTCOMMENTS)
                                VALUE(CUSTOMERNAMERANGE)
                                VALUE(GETINCLUDES)
                                VALUE(GETDICTSTRUCTURES)
                                VALUE(USERHASSELECTEDMESSAGECLASSES)
                                VALUE(SLASHSEPARATOR)
                                VALUE(SAVETOSERVER)
                                VALUE(DISPLAYPROGRESSMESSAGE).

  DATA: HTMLPAGENAME TYPE STRING.
  DATA: NEWFILENAMEONLY TYPE STRING.
  DATA: NEWFILENAMEWITHPATH TYPE STRING.
  DATA: IHTMLTABLE TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: NEWSUBDIRECTORY TYPE STRING.
  DATA: COMPLETESAVEPATH TYPE STRING.

  PERFORM APPENDMESSAGESTOFILE USING ILOCMESSAGES[]
                                     IHTMLTABLE[]
                                     USERHASSELECTEDMESSAGECLASSES.


  CONCATENATE `message class ` MESSAGECLASSNAME INTO HTMLPAGENAME.

  IF HTMLFILEFLAG IS INITIAL.
    APPEND '' TO IHTMLTABLE.
    CONCATENATE '--------------------------------------'
                '--------------------------------------------'
                INTO IHTMLTABLE.
    APPEND IHTMLTABLE.

    PERFORM BUILDFOOTERMESSAGE USING 'TEXT'
                                     IHTMLTABLE.
    APPEND IHTMLTABLE.
  ELSE.
    PERFORM CONVERTCODETOHTML USING IHTMLTABLE[]
                                    HTMLPAGENAME
                                    SPACE
                                    IS_MESSAGECLASS
                                    ''
                                    FALSE
                                    SYNTAXHIGHLIGHTCOMMENTS
                                    FILEEXTENSION
                                    CUSTOMERNAMERANGE
                                    GETINCLUDES
                                    GETDICTSTRUCTURES.
  ENDIF.

  PERFORM BUILDFILENAME USING USERFILEPATH
                              SUBDIR
                              MESSAGECLASSNAME
                              SPACE
                              SPACE
                              FILEEXTENSION
                              IS_MESSAGECLASS
                              SAVETOSERVER
                              SLASHSEPARATOR
                              NEWFILENAMEWITHPATH
                              NEWFILENAMEONLY
                              NEWSUBDIRECTORY
                              COMPLETESAVEPATH.

  IF SAVETOSERVER IS INITIAL.
    PERFORM SAVEFILETOPC USING IHTMLTABLE[]
                               NEWFILENAMEWITHPATH
                               NEWFILENAMEONLY
                               SPACE
                               SPACE
                               DISPLAYPROGRESSMESSAGE.
  ELSE.
*     Save the file to the SAP server
    PERFORM SAVEFILETOSERVER USING IHTMLTABLE[]
                                   NEWFILENAMEWITHPATH
                                   NEWFILENAMEONLY
                                   COMPLETESAVEPATH
                                   DISPLAYPROGRESSMESSAGE.
  ENDIF.
ENDFORM.                    "downloadmessageclass
"downloadMessageClass

*-----------------------------------------------------------------------
*  appendMessagesToFile
*-----------------------------------------------------------------------
FORM APPENDMESSAGESTOFILE USING ILOCMESSAGES LIKE IMESSAGES[]
                                ILOCHTML LIKE DUMIHTML[]
                                VALUE(USERHASSELECTEDMESSAGECLASSES).

  DATA: PREVIOUSMESSAGEID LIKE IMESSAGES-ARBGB.
  FIELD-SYMBOLS: <WAMESSAGE> TYPE TMESSAGE.
  DATA: WAHTML TYPE STRING.

  SORT ILOCMESSAGES ASCENDING BY ARBGB MSGNR.

  IF NOT ILOCMESSAGES[] IS INITIAL.
    IF USERHASSELECTEDMESSAGECLASSES IS INITIAL.
*     Only add these extra lines if we are actually appending them to
      APPEND WAHTML TO ILOCHTML.
      APPEND WAHTML TO ILOCHTML.

      APPEND '*Messages' TO ILOCHTML.
      APPEND
'*----------------------------------------------------------' TO
ILOCHTML.
    ENDIF.

    LOOP AT ILOCMESSAGES ASSIGNING <WAMESSAGE>.
      IF ( <WAMESSAGE>-ARBGB <> PREVIOUSMESSAGEID ).

        IF USERHASSELECTEDMESSAGECLASSES IS INITIAL.
*         Only add this extra lines if we are actually appending them to
          APPEND '*' TO ILOCHTML.
          CONCATENATE `* Message class: ` <WAMESSAGE>-ARBGB INTO WAHTML.
          APPEND WAHTML TO ILOCHTML.
        ENDIF.

        PREVIOUSMESSAGEID = <WAMESSAGE>-ARBGB.
        CLEAR WAHTML.
      ENDIF.

      IF USERHASSELECTEDMESSAGECLASSES IS INITIAL.
*       Only add this extra lines if we are actually appending them to
        CONCATENATE '*' <WAMESSAGE>-MSGNR `   ` <WAMESSAGE>-TEXT INTO
WAHTML.
      ELSE.
        CONCATENATE <WAMESSAGE>-MSGNR `   ` <WAMESSAGE>-TEXT INTO
WAHTML.
      ENDIF.

      APPEND WAHTML TO ILOCHTML.
    ENDLOOP.
  ENDIF.
ENDFORM.                    "appendmessagestofile
"appendMessagesToFile

*-----------------------------------------------------------------------
*  downloadFunctions...       Download function modules to file.
*-----------------------------------------------------------------------
FORM DOWNLOADFUNCTIONS USING ILOCFUNCTIONS LIKE IFUNCTIONS[]
                             VALUE(USERFILEPATH)
                             VALUE(FILEEXTENSION)
                             VALUE(SUBDIR)
                             VALUE(DOWNLOADDOCUMENTATION)
                             VALUE(CONVERTTOHTML)
                             VALUE(SYNTAXHIGHLIGHTCOMMENTS)
                             VALUE(CUSTOMERNAMERANGE)
                             VALUE(GETINCLUDES)
                             VALUE(GETDICTSTRUCT)
                             VALUE(TEXTFILEEXTENSION)
                             VALUE(HTMLFILEEXTENSION)
                             VALUE(SORTTABLESASC)
                             VALUE(SLASHSEPARATOR)
                             VALUE(SAVETOSERVER)
                             VALUE(DISPLAYPROGRESSMESSAGE).

  DATA: MAINSUBDIR TYPE STRING.
  DATA: INCSUBDIR TYPE STRING.
  FIELD-SYMBOLS: <WAFUNCTION> TYPE TFUNCTION.
  FIELD-SYMBOLS: <WAINCLUDE> TYPE TINCLUDE.
  DATA: IEMPTYTEXTELEMENTS TYPE STANDARD TABLE OF TTEXTTABLE.
  DATA: IEMPTYSELECTIONTEXTS TYPE STANDARD TABLE OF TTEXTTABLE.
  DATA: IEMPTYMESSAGES TYPE STANDARD TABLE OF TMESSAGE.
  DATA: IEMPTYGUITITLES TYPE STANDARD TABLE OF TGUITITLE.
  DATA: FUNCTIONDOCUMENTATIONEXISTS TYPE I VALUE FALSE.

  LOOP AT ILOCFUNCTIONS ASSIGNING <WAFUNCTION>.
    IF SUBDIR IS INITIAL.
      INCSUBDIR = <WAFUNCTION>-FUNCTIONNAME.
      MAINSUBDIR = ''.
    ELSE.
      CONCATENATE SUBDIR <WAFUNCTION>-FUNCTIONNAME INTO INCSUBDIR
SEPARATED BY SLASHSEPARATOR.
      MAINSUBDIR = SUBDIR.
    ENDIF.

    IF NOT DOWNLOADDOCUMENTATION IS INITIAL.
      PERFORM DOWNLOADFUNCTIONDOCS USING <WAFUNCTION>-FUNCTIONNAME
                                         <WAFUNCTION>-FUNCTIONTITLE
                                         USERFILEPATH
                                         FILEEXTENSION
                                         CONVERTTOHTML
                                         SLASHSEPARATOR
                                         SAVETOSERVER
                                         DISPLAYPROGRESSMESSAGE
                                         MAINSUBDIR
                                         FUNCTIONDOCUMENTATIONEXISTS.
    ENDIF.

*   Download main source code
    PERFORM READFUNCTIONANDDOWNLOAD USING <WAFUNCTION>-ITEXTELEMENTS[]
                                          <WAFUNCTION>-ISELECTIONTEXTS[]
                                          <WAFUNCTION>-IMESSAGES[]
                                          <WAFUNCTION>-FUNCTIONNAME
                   <WAFUNCTION>-FUNCTIONMAININCLUDE
                                          <WAFUNCTION>-FUNCTIONTITLE
                                          USERFILEPATH
                                          FILEEXTENSION
                                          MAINSUBDIR
                                          CONVERTTOHTML
                                          FUNCTIONDOCUMENTATIONEXISTS
                                          SYNTAXHIGHLIGHTCOMMENTS
                                          CUSTOMERNAMERANGE
                                          GETINCLUDES
                                          GETDICTSTRUCT
                                          SLASHSEPARATOR
                                          SAVETOSERVER
                                          DISPLAYPROGRESSMESSAGE.

*   Download top include
    PERFORM READINCLUDEANDDOWNLOAD USING IEMPTYTEXTELEMENTS[]
                                         IEMPTYSELECTIONTEXTS[]
                                         IEMPTYMESSAGES[]
                                         IEMPTYGUITITLES[]
                                         <WAFUNCTION>-TOPINCLUDENAME
                                         <WAFUNCTION>-FUNCTIONNAME
                                         <WAFUNCTION>-FUNCTIONTITLE
                                         IS_FUNCTION
                                         USERFILEPATH
                                         FILEEXTENSION
                                         MAINSUBDIR
                                         CONVERTTOHTML
                                         SYNTAXHIGHLIGHTCOMMENTS
                                         CUSTOMERNAMERANGE
                                         GETINCLUDES
                                         GETDICTSTRUCT
                                         SLASHSEPARATOR
                                         SAVETOSERVER
                                         DISPLAYPROGRESSMESSAGE.

*   Download screens.
    IF NOT <WAFUNCTION>-ISCREENFLOW[] IS INITIAL.
      PERFORM DOWNLOADSCREENS USING <WAFUNCTION>-ISCREENFLOW[]
                                    <WAFUNCTION>-PROGNAME
                                    USERFILEPATH
                                    TEXTFILEEXTENSION
                                    MAINSUBDIR
                                    SLASHSEPARATOR
                                    SAVETOSERVER
                                    DISPLAYPROGRESSMESSAGE.
    ENDIF.

*   Download GUI titles
    IF NOT <WAFUNCTION>-IGUITITLE[] IS INITIAL.
      PERFORM DOWNLOADGUITITLES USING <WAFUNCTION>-IGUITITLE
                                      USERFILEPATH
                                      TEXTFILEEXTENSION
                                      MAINSUBDIR
                                      SLASHSEPARATOR
                                      SAVETOSERVER
                                      DISPLAYPROGRESSMESSAGE.
    ENDIF.

*   Download all other includes
    LOOP AT <WAFUNCTION>-IINCLUDES ASSIGNING <WAINCLUDE>.
      PERFORM READINCLUDEANDDOWNLOAD USING IEMPTYTEXTELEMENTS[]
                                           IEMPTYSELECTIONTEXTS[]
                                           IEMPTYMESSAGES[]
                                           IEMPTYGUITITLES[]
                                           <WAINCLUDE>-INCLUDENAME
                                           SPACE
                                           <WAINCLUDE>-INCLUDETITLE
                                           IS_PROGRAM
                                           USERFILEPATH
                                           FILEEXTENSION
                                           INCSUBDIR
                                           CONVERTTOHTML
                                           SYNTAXHIGHLIGHTCOMMENTS
                                           CUSTOMERNAMERANGE
                                           GETINCLUDES
                                           GETDICTSTRUCT
                                           SLASHSEPARATOR
                                           SAVETOSERVER
                                           DISPLAYPROGRESSMESSAGE.

    ENDLOOP.

*   Download all dictionary structures
    IF NOT <WAFUNCTION>-IDICTSTRUCT[] IS INITIAL.
      PERFORM DOWNLOADDDSTRUCTURES USING <WAFUNCTION>-IDICTSTRUCT[]
                                         USERFILEPATH
                                         HTMLFILEEXTENSION
                                         INCSUBDIR
                                         SORTTABLESASC
                                         SLASHSEPARATOR
                                         SAVETOSERVER
                                         DISPLAYPROGRESSMESSAGE.
    ENDIF.
  ENDLOOP.
ENDFORM.                    "downloadfunctions
"downloadFunctions

*-----------------------------------------------------------------------
*   readIcludeAndDownload...
*-----------------------------------------------------------------------
FORM READINCLUDEANDDOWNLOAD USING ILOCTEXTELEMENTS LIKE DUMITEXTTAB[]
                                  ILOCSELECTIONTEXTS LIKE DUMITEXTTAB[]
                                  ILOCMESSAGES LIKE IMESSAGES[]
                                  ILOCGUITITLES LIKE DUMIGUITITLE[]
                                  VALUE(PROGRAMNAME)
                                  VALUE(FUNCTIONNAME)
                                  VALUE(SHORTTEXT)
                                  VALUE(OVERIDEPROGTYPE)
                                  VALUE(USERFILEPATH)
                                  VALUE(FILEEXTENSION)
                                  VALUE(ADDITIONALSUBDIR)
                                  VALUE(CONVERTTOHTML)
                                  VALUE(SYNTAXHIGHLIGHTCOMMENTS)
                                  VALUE(CUSTOMERNAMERANGE)
                                  VALUE(GETINCLUDES)
                                  VALUE(GETDICTSTRUCTURES)
                                  VALUE(SLASHSEPARATOR)
                                  VALUE(SAVETOSERVER)
                                  VALUE(DISPLAYPROGRESSMESSAGE).

  DATA: ILINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: LOCALFILENAMEWITHPATH TYPE STRING.
  DATA: LOCALFILENAMEONLY TYPE STRING.
  DATA: NEWSUBDIRECTORY TYPE STRING.
  DATA: OBJECTNAME TYPE STRING.
  DATA: COMPLETESAVEPATH TYPE STRING.

  READ REPORT PROGRAMNAME INTO ILINES.

* Download GUI titles for main program
  IF NOT ILOCGUITITLES[] IS INITIAL.
    PERFORM APPENDGUITITLES USING ILOCGUITITLES[]
                                  ILINES[].
  ENDIF.

* Download text elements for main program
  IF NOT ILOCTEXTELEMENTS[] IS INITIAL.
    PERFORM APPENDTEXTELEMENTS USING ILOCTEXTELEMENTS[]
                                     ILINES[].
  ENDIF.

* Download selection texts for main program
  IF NOT ILOCSELECTIONTEXTS[] IS INITIAL.
    PERFORM APPENDSELECTIONTEXTS USING ILOCSELECTIONTEXTS[]
                                       ILINES[].
  ENDIF.

* Download messages classes for main program.
  IF NOT ILOCMESSAGES[] IS INITIAL.
    PERFORM APPENDMESSAGESTOFILE USING ILOCMESSAGES[]
                                       ILINES[]
                                       SPACE.
  ENDIF.

  IF CONVERTTOHTML IS INITIAL.
    APPEND '' TO ILINES.
    CONCATENATE '--------------------------------------'
                '--------------------------------------------'
                INTO ILINES.
    APPEND ILINES.
    PERFORM BUILDFOOTERMESSAGE USING 'TEXT'
                                     ILINES.
    APPEND ILINES.
  ELSE.
    PERFORM CONVERTCODETOHTML USING ILINES[]
                                    PROGRAMNAME
                                    SHORTTEXT
                                    OVERIDEPROGTYPE
                                    SPACE
                                    SPACE
                                    SYNTAXHIGHLIGHTCOMMENTS
                                    FILEEXTENSION
                                    CUSTOMERNAMERANGE
                                    GETINCLUDES
                                    GETDICTSTRUCTURES.
  ENDIF.

  IF FUNCTIONNAME IS INITIAL.
    OBJECTNAME = PROGRAMNAME.
  ELSE.
    OBJECTNAME = FUNCTIONNAME.
  ENDIF.

  PERFORM BUILDFILENAME USING USERFILEPATH
                              ADDITIONALSUBDIR
                              OBJECTNAME
                              SPACE
                              PROGRAMNAME
                              FILEEXTENSION
                              OVERIDEPROGTYPE
                              SAVETOSERVER
                              SLASHSEPARATOR
                              LOCALFILENAMEWITHPATH
                              LOCALFILENAMEONLY
                              NEWSUBDIRECTORY
                              COMPLETESAVEPATH.

  IF SAVETOSERVER IS INITIAL.
    PERFORM SAVEFILETOPC USING ILINES[]
                               LOCALFILENAMEWITHPATH
                               LOCALFILENAMEONLY
                               SPACE
                               SPACE
                               DISPLAYPROGRESSMESSAGE.
  ELSE.
    PERFORM SAVEFILETOSERVER USING ILINES[]
                                   LOCALFILENAMEWITHPATH
                                   LOCALFILENAMEONLY
                                   COMPLETESAVEPATH
                                   DISPLAYPROGRESSMESSAGE.
  ENDIF.
ENDFORM.                    "readincludeanddownload
"readIncludeAndDownload

*-----------------------------------------------------------------------
*   readClassAndDownload...
*-----------------------------------------------------------------------
FORM READCLASSANDDOWNLOAD USING WALOCCLASS TYPE TCLASS
                                VALUE(CLASSNAME)
                                VALUE(FUNCTIONNAME)
                                VALUE(OVERIDEPROGTYPE)
                                VALUE(USERFILEPATH)
                                VALUE(FILEEXTENSION)
                                VALUE(ADDITIONALSUBDIR)
                                VALUE(CONVERTTOHTML)
                                VALUE(SYNTAXHIGHLIGHTCOMMENTS)
                                VALUE(CUSTOMERNAMERANGE)
                                VALUE(GETINCLUDES)
                                VALUE(GETDICTSTRUCTURES)
                                VALUE(SLASHSEPARATOR)
                                VALUE(SAVETOSERVER)
                                VALUE(DISPLAYPROGRESSMESSAGE).

  DATA: ITEMPLINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: ILINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: LOCALFILENAMEWITHPATH TYPE STRING.
  DATA: LOCALFILENAMEONLY TYPE STRING.
  DATA: NEWSUBDIRECTORY TYPE STRING.
  DATA: OBJECTNAME TYPE STRING.
  DATA: CASTCLASSNAME TYPE PROGRAM.
  DATA: COMPLETESAVEPATH TYPE STRING.

* Build up attribute comments
  APPEND '************************' TO ILINES.
  APPEND '*   Class attributes.  *' TO ILINES.
  APPEND '************************' TO ILINES.
  CASE WALOCCLASS-EXPOSURE.
    WHEN 0.
      APPEND `Instantiation: Private` TO ILINES.
    WHEN 1.
      APPEND `Instantiation: Protected` TO ILINES.
    WHEN 2.
      APPEND `Instantiation: Public` TO ILINES.
  ENDCASE.
  CONCATENATE `Message class: ` WALOCCLASS-MSG_ID INTO ILINES.
  APPEND ILINES.
  CASE WALOCCLASS-STATE.
    WHEN 0.
      APPEND `State: Only Modelled` TO ILINES.
    WHEN 1.
      APPEND `State: Implemented` TO ILINES.
  ENDCASE.
  CONCATENATE `Final Indicator: ` WALOCCLASS-CLSFINAL INTO ILINES.
  APPEND ILINES.
  CONCATENATE `R/3 Release: ` WALOCCLASS-R3RELEASE INTO ILINES.
  APPEND ILINES.
  CLEAR ILINES.
  APPEND ILINES.

  CASTCLASSNAME = WALOCCLASS-PUBLICCLASSKEY.
  READ REPORT CASTCLASSNAME INTO ITEMPLINES.
  IF SY-SUBRC = 0.
    PERFORM REFORMATCLASSCODE USING ITEMPLINES[].

    APPEND '*******************************' TO ILINES.
    APPEND '*   Public section of class.  *' TO ILINES.
    APPEND '*******************************' TO ILINES.

    LOOP AT ITEMPLINES.
      APPEND ITEMPLINES TO ILINES.
    ENDLOOP.
  ENDIF.

  CASTCLASSNAME = WALOCCLASS-PRIVATECLASSKEY.
  READ REPORT CASTCLASSNAME INTO ITEMPLINES.
  IF SY-SUBRC = 0.
    PERFORM REFORMATCLASSCODE USING ITEMPLINES[].

    APPEND ILINES.
    APPEND '********************************' TO ILINES.
    APPEND '*   Private section of class.  *' TO ILINES.
    APPEND '********************************' TO ILINES.

    LOOP AT ITEMPLINES.
      APPEND ITEMPLINES TO ILINES.
    ENDLOOP.
  ENDIF.

  CASTCLASSNAME = WALOCCLASS-PROTECTEDCLASSKEY.
  READ REPORT CASTCLASSNAME INTO ITEMPLINES.
  IF SY-SUBRC = 0.
    PERFORM REFORMATCLASSCODE USING ITEMPLINES[].

    APPEND ILINES.
    APPEND '**********************************' TO ILINES.
    APPEND '*   Protected section of class.  *' TO ILINES.
    APPEND '**********************************' TO ILINES.
    LOOP AT ITEMPLINES.
      APPEND ITEMPLINES TO ILINES.
    ENDLOOP.
  ENDIF.

  CASTCLASSNAME = WALOCCLASS-TYPESCLASSKEY.
  READ REPORT CASTCLASSNAME INTO ITEMPLINES.
  IF SY-SUBRC = 0.
    APPEND ILINES.
    APPEND '**********************************' TO ILINES.
    APPEND '*   Types section of class.      *' TO ILINES.
    APPEND '**********************************' TO ILINES.
    LOOP AT ITEMPLINES.
      APPEND ITEMPLINES TO ILINES.
    ENDLOOP.
  ENDIF.

* Download text elements for this class
  IF NOT WALOCCLASS-ITEXTELEMENTS[] IS INITIAL.
    PERFORM APPENDTEXTELEMENTS USING WALOCCLASS-ITEXTELEMENTS[]
                                     ILINES[].
  ENDIF.

* Download messages classes for this class.
  IF NOT WALOCCLASS-IMESSAGES[] IS INITIAL.
    PERFORM APPENDMESSAGESTOFILE USING WALOCCLASS-IMESSAGES[]
                                       ILINES[]
                                       SPACE.
  ENDIF.

* Download exception texts for this class
  IF NOT WALOCCLASS-ICONCEPTS[] IS INITIAL.
    PERFORM APPENDEXCEPTIONTEXTS USING WALOCCLASS-ICONCEPTS[]
                                       ILINES[].
  ENDIF.


  IF CONVERTTOHTML IS INITIAL.
    APPEND '' TO ILINES.
    CONCATENATE '--------------------------------------'
                '--------------------------------------------'
                INTO ILINES.
    APPEND ILINES.
    PERFORM BUILDFOOTERMESSAGE USING 'TEXT'
                                     ILINES.
    APPEND ILINES.
  ELSE.
    PERFORM CONVERTCLASSTOHTML USING ILINES[]
                                    CLASSNAME
                                    WALOCCLASS-DESCRIPT
                                    OVERIDEPROGTYPE
                                    SYNTAXHIGHLIGHTCOMMENTS
                                    FILEEXTENSION
                                    CUSTOMERNAMERANGE
                                    GETDICTSTRUCTURES.
  ENDIF.

  IF FUNCTIONNAME IS INITIAL.
    OBJECTNAME = CLASSNAME.
  ELSE.
    OBJECTNAME = FUNCTIONNAME.
  ENDIF.

  PERFORM BUILDFILENAME USING USERFILEPATH
                              ADDITIONALSUBDIR
                              OBJECTNAME
                              SPACE
                              CLASSNAME
                              FILEEXTENSION
                              OVERIDEPROGTYPE
                              SAVETOSERVER
                              SLASHSEPARATOR
                              LOCALFILENAMEWITHPATH
                              LOCALFILENAMEONLY
                              NEWSUBDIRECTORY
                              COMPLETESAVEPATH.

  IF SAVETOSERVER IS INITIAL.
    PERFORM SAVEFILETOPC USING ILINES[]
                               LOCALFILENAMEWITHPATH
                               LOCALFILENAMEONLY
                               SPACE
                               SPACE
                               DISPLAYPROGRESSMESSAGE.
  ELSE.
    PERFORM SAVEFILETOSERVER USING ILINES[]
                                   LOCALFILENAMEWITHPATH
                                   LOCALFILENAMEONLY
                                   COMPLETESAVEPATH
                                   DISPLAYPROGRESSMESSAGE.
  ENDIF.
ENDFORM.                    "readclassanddownload
"readClassAndDownload

*-----------------------------------------------------------------------
*   readMethodAndDownload...
*-----------------------------------------------------------------------
FORM READMETHODANDDOWNLOAD USING WALOCMETHOD TYPE TMETHOD
                                VALUE(METHODNAME)
                                VALUE(METHODKEY)
                                VALUE(FUNCTIONNAME)
                                VALUE(OVERIDEPROGTYPE)
                                VALUE(USERFILEPATH)
                                VALUE(FILEEXTENSION)
                                VALUE(ADDITIONALSUBDIR)
                                VALUE(CONVERTTOHTML)
                                VALUE(SYNTAXHIGHLIGHTCOMMENTS)
                                VALUE(CUSTOMERNAMERANGE)
                                VALUE(GETINCLUDES)
                                VALUE(GETDICTSTRUCTURES)
                                VALUE(SLASHSEPARATOR)
                                VALUE(SAVETOSERVER)
                                VALUE(DISPLAYPROGRESSMESSAGE).

  DATA: ILINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: ITEMPLINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: LOCALFILENAMEWITHPATH TYPE STRING.
  DATA: LOCALFILENAMEONLY TYPE STRING.
  DATA: NEWSUBDIRECTORY TYPE STRING.
  DATA: OBJECTNAME TYPE STRING.
  DATA: CASTMETHODKEY TYPE PROGRAM.
  DATA: COMPLETESAVEPATH TYPE STRING.

* Add the method scope to the downloaded file
  APPEND '************************************' TO ILINES.
  APPEND '*   Method attributes.             *' TO ILINES.
  APPEND '************************************' TO ILINES.
  CASE WALOCMETHOD-EXPOSURE.
    WHEN 0.
      APPEND `Instantiation: Private` TO ILINES.
    WHEN 1.
      APPEND `Instantiation: Protected` TO ILINES.
    WHEN 2.
      APPEND `Instantiation: Public` TO ILINES.
  ENDCASE.
  CONCATENATE '--------------------------------------'
              '--------------------------------------------'
              INTO ILINES.
  APPEND ILINES.
  APPEND '' TO ILINES.

  CASTMETHODKEY = WALOCMETHOD-METHODKEY.
  READ REPORT CASTMETHODKEY INTO ITEMPLINES.
  LOOP AT ITEMPLINES.
    APPEND ITEMPLINES TO ILINES.
  ENDLOOP.

  IF CONVERTTOHTML IS INITIAL.
    APPEND '' TO ILINES.
    CONCATENATE '--------------------------------------'
                '--------------------------------------------'
                INTO ILINES.
    APPEND ILINES.
    PERFORM BUILDFOOTERMESSAGE USING 'TEXT'
                                     ILINES.
    APPEND ILINES.
  ELSE.
    PERFORM CONVERTCODETOHTML USING ILINES[]
                                    METHODNAME
                                    WALOCMETHOD-DESCRIPT
                                    OVERIDEPROGTYPE
                                    SPACE
                                    SPACE
                                    SYNTAXHIGHLIGHTCOMMENTS
                                    FILEEXTENSION
                                    CUSTOMERNAMERANGE
                                    GETINCLUDES

                                    GETDICTSTRUCTURES.
  ENDIF.

  IF FUNCTIONNAME IS INITIAL.
    OBJECTNAME = METHODNAME.
  ELSE.
    OBJECTNAME = FUNCTIONNAME.
  ENDIF.

  PERFORM BUILDFILENAME USING USERFILEPATH
                              ADDITIONALSUBDIR
                              OBJECTNAME
                              SPACE
                              METHODNAME
                              FILEEXTENSION
                              OVERIDEPROGTYPE
                              SAVETOSERVER
                              SLASHSEPARATOR
                              LOCALFILENAMEWITHPATH
                              LOCALFILENAMEONLY
                              NEWSUBDIRECTORY
                              COMPLETESAVEPATH.

  IF SAVETOSERVER IS INITIAL.
    PERFORM SAVEFILETOPC USING ILINES[]
                               LOCALFILENAMEWITHPATH
                               LOCALFILENAMEONLY
                               SPACE
                               SPACE
                               DISPLAYPROGRESSMESSAGE.
  ELSE.
    PERFORM SAVEFILETOSERVER USING ILINES[]
                                   LOCALFILENAMEWITHPATH
                                   LOCALFILENAMEONLY
                                   COMPLETESAVEPATH
                                   DISPLAYPROGRESSMESSAGE.
  ENDIF.
ENDFORM.                    "readmethodanddownload
"readMethodAndDownload

*-----------------------------------------------------------------------
*   readFunctionAndDownload...
*-----------------------------------------------------------------------
FORM READFUNCTIONANDDOWNLOAD USING ILOCTEXTELEMENTS LIKE DUMITEXTTAB[]
                                   ILOCSELECTIONTEXTS LIKE DUMITEXTTAB[]
                                   ILOCMESSAGES LIKE IMESSAGES[]
                                   VALUE(FUNCTIONNAME)
                                   VALUE(FUNCTIONINTERNALNAME)
                                   VALUE(SHORTTEXT)
                                   VALUE(USERFILEPATH)
                                   VALUE(FILEEXTENSION)
                                   VALUE(SUBDIR)
                                   VALUE(CONVERTTOHTML)
                                   VALUE(FUNCTIONDOCUMENTATIONEXISTS)
                                   VALUE(SYNTAXHIGHLIGHTCOMMENTS)
                                   VALUE(CUSTOMERNAMERANGE)
                                   VALUE(GETINCLUDES)
                                   VALUE(GETDICTSTRUCTURES)
                                   VALUE(SLASHSEPARATOR)
                                   VALUE(SAVETOSERVER)
                                   VALUE(DISPLAYPROGRESSMESSAGE).

  DATA: ILINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: LOCALFILENAMEWITHPATH TYPE STRING.
  DATA: LOCALFILENAMEONLY TYPE STRING.
  DATA: NEWSUBDIRECTORY TYPE STRING.
  DATA: COMPLETESAVEPATH TYPE STRING.

  READ REPORT FUNCTIONINTERNALNAME INTO ILINES.

* If we found any text elements for this function then we ought to
  IF NOT ILOCTEXTELEMENTS[] IS INITIAL.
    PERFORM APPENDTEXTELEMENTS USING ILOCTEXTELEMENTS[]
                                     ILINES[].
  ENDIF.

* If we found any message classes for this function then we ought to
  IF NOT ILOCMESSAGES[] IS INITIAL.
    PERFORM APPENDMESSAGESTOFILE USING ILOCMESSAGES[]
                                       ILINES[]
                                       SPACE.
  ENDIF.

  IF CONVERTTOHTML IS INITIAL.
    APPEND '' TO ILINES.
    CONCATENATE '--------------------------------------'
                '--------------------------------------------'
                INTO ILINES.
    APPEND ILINES.
    PERFORM BUILDFOOTERMESSAGE USING 'TEXT'
                                     ILINES.
    APPEND ILINES.
  ELSE.
    PERFORM CONVERTFUNCTIONTOHTML USING ILINES[]
                                        FUNCTIONNAME
                                        SHORTTEXT
                                        IS_FUNCTION
                                        FUNCTIONDOCUMENTATIONEXISTS
                                        TRUE
                                        SYNTAXHIGHLIGHTCOMMENTS
                                        FILEEXTENSION
                                        CUSTOMERNAMERANGE
                                        GETINCLUDES
                                        GETDICTSTRUCTURES.
  ENDIF.

  PERFORM BUILDFILENAME USING USERFILEPATH
                              SUBDIR
                              FUNCTIONNAME
                              SPACE
                              SPACE
                              FILEEXTENSION
                              IS_FUNCTION
                              SAVETOSERVER
                              SLASHSEPARATOR
                              LOCALFILENAMEWITHPATH
                              LOCALFILENAMEONLY
                              NEWSUBDIRECTORY
                              COMPLETESAVEPATH.

  IF SAVETOSERVER IS INITIAL.
    PERFORM SAVEFILETOPC USING ILINES[]
                               LOCALFILENAMEWITHPATH
                               LOCALFILENAMEONLY
                               SPACE
                               SPACE
                               DISPLAYPROGRESSMESSAGE.
  ELSE.
    PERFORM SAVEFILETOSERVER USING ILINES[]
                                   LOCALFILENAMEWITHPATH
                                   LOCALFILENAMEONLY
                                   COMPLETESAVEPATH
                                   DISPLAYPROGRESSMESSAGE.
  ENDIF.
ENDFORM.                    "readfunctionanddownload
"readFunctionAndDownload

*-----------------------------------------------------------------------
*  buildFilename...
*-----------------------------------------------------------------------
FORM BUILDFILENAME USING VALUE(USERPATH)
                         VALUE(ADDITIONALSUBDIRECTORY)
                         VALUE(OBJECTNAME)
                         VALUE(MAINFUNCTIONNO)
                         VALUE(INCLUDENAME)
                         VALUE(FILEEXTENSION)
                         VALUE(DOWNLOADTYPE)
                         VALUE(DOWNLOADTOSERVER)
                         VALUE(SLASHSEPARATOR)
                               NEWFILENAMEWITHPATH
                               NEWFILENAMEONLY
                               NEWSUBDIRECTORY
                               COMPLETEPATH.

* If we are running on a non UNIX environment we will need to remove
*forward slashes from the additional path.
  IF DOWNLOADTOSERVER IS INITIAL.
    IF FRONTENDOPSYSTEM = NON_UNIX.
      IF NOT ADDITIONALSUBDIRECTORY IS INITIAL.
        TRANSLATE ADDITIONALSUBDIRECTORY USING '/_'.
        IF ADDITIONALSUBDIRECTORY+0(1) = '_'.
          SHIFT ADDITIONALSUBDIRECTORY LEFT BY 1 PLACES.
        ENDIF.
      ENDIF.
    ENDIF.
  ELSE.
    IF SERVEROPSYSTEM = NON_UNIX.
      IF NOT ADDITIONALSUBDIRECTORY IS INITIAL.
        TRANSLATE ADDITIONALSUBDIRECTORY USING '/_'.
        IF ADDITIONALSUBDIRECTORY+0(1) = '_'.
          SHIFT ADDITIONALSUBDIRECTORY LEFT BY 1 PLACES.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

  CASE DOWNLOADTYPE.
*   Programs
    WHEN IS_PROGRAM.
      IF ADDITIONALSUBDIRECTORY IS INITIAL.
        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME PERIOD
FILEEXTENSION INTO NEWFILENAMEWITHPATH.
        CONCATENATE USERPATH SLASHSEPARATOR INTO COMPLETEPATH.
      ELSE.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
                             SLASHSEPARATOR OBJECTNAME PERIOD
FILEEXTENSION INTO NEWFILENAMEWITHPATH.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY INTO
COMPLETEPATH.
      ENDIF.

*   Function Modules
    WHEN IS_FUNCTION.
      IF ADDITIONALSUBDIRECTORY IS INITIAL.
        FIND 'top' IN INCLUDENAME IGNORING CASE.
        IF SY-SUBRC = 0.
          CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME
                               SLASHSEPARATOR 'Global-' OBJECTNAME
                               PERIOD FILEEXTENSION
                               INTO NEWFILENAMEWITHPATH.
        ELSE.
          IF INCLUDENAME CS MAINFUNCTIONNO AND NOT MAINFUNCTIONNO IS
INITIAL.
            CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME
                                 SLASHSEPARATOR OBJECTNAME
                                 PERIOD FILEEXTENSION
                                 INTO NEWFILENAMEWITHPATH.
          ELSE.
            CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME
                                 SLASHSEPARATOR OBJECTNAME
                                 PERIOD FILEEXTENSION
                                 INTO NEWFILENAMEWITHPATH.
          ENDIF.
        ENDIF.
        NEWSUBDIRECTORY = OBJECTNAME.
        CONCATENATE USERPATH SLASHSEPARATOR INTO COMPLETEPATH.
      ELSE.
        FIND 'top' IN INCLUDENAME IGNORING CASE.
        IF SY-SUBRC = 0.
          CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
                               SLASHSEPARATOR OBJECTNAME
                               SLASHSEPARATOR 'Global-' OBJECTNAME
                               PERIOD FILEEXTENSION
                               INTO NEWFILENAMEWITHPATH.
        ELSE.
          IF INCLUDENAME CS MAINFUNCTIONNO AND NOT MAINFUNCTIONNO IS
INITIAL.
            CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
                                 SLASHSEPARATOR OBJECTNAME
                                 SLASHSEPARATOR OBJECTNAME
                                 PERIOD FILEEXTENSION
                                 INTO NEWFILENAMEWITHPATH.
          ELSE.
            CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
                                 SLASHSEPARATOR OBJECTNAME
                                 SLASHSEPARATOR OBJECTNAME
                                 PERIOD FILEEXTENSION
                                 INTO NEWFILENAMEWITHPATH.
          ENDIF.
        ENDIF.
        CONCATENATE ADDITIONALSUBDIRECTORY SLASHSEPARATOR OBJECTNAME
INTO NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR OBJECTNAME INTO COMPLETEPATH.
      ENDIF.

*   Table definition
    WHEN IS_TABLE.
      IF ADDITIONALSUBDIRECTORY IS INITIAL.
        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME
                             SLASHSEPARATOR 'Dictionary-'
                             OBJECTNAME PERIOD FILEEXTENSION
                             INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME INTO
NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME INTO
COMPLETEPATH.
      ELSE.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
                             SLASHSEPARATOR OBJECTNAME
                             SLASHSEPARATOR 'Dictionary-'
                             OBJECTNAME PERIOD FILEEXTENSION
                             INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR OBJECTNAME INTO NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR OBJECTNAME INTO COMPLETEPATH.
      ENDIF.

*   Program & Function documentation
    WHEN IS_DOCUMENTATION.
      IF ADDITIONALSUBDIRECTORY IS INITIAL.
        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME
                             SLASHSEPARATOR 'Docs-'
                             OBJECTNAME PERIOD
                             FILEEXTENSION
                             INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME INTO
NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME INTO
COMPLETEPATH.
      ELSE.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
                             SLASHSEPARATOR OBJECTNAME
                             SLASHSEPARATOR 'Docs-'
                             OBJECTNAME PERIOD FILEEXTENSION
                             INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR OBJECTNAME INTO NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR OBJECTNAME INTO COMPLETEPATH.
      ENDIF.

*   Screens
    WHEN IS_SCREEN.
      IF ADDITIONALSUBDIRECTORY IS INITIAL.
        CONCATENATE USERPATH SLASHSEPARATOR 'Screens'
                             SLASHSEPARATOR 'screen_'
                             OBJECTNAME PERIOD
                             FILEEXTENSION INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR 'screens' INTO
NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR 'screens' INTO COMPLETEPATH.

      ELSE.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
                             SLASHSEPARATOR 'Screens'
                             SLASHSEPARATOR 'screen_'
                             OBJECTNAME PERIOD
                             FILEEXTENSION INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR 'screens' INTO NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR 'screens' INTO COMPLETEPATH.
      ENDIF.

*   GUI title
    WHEN IS_GUITITLE.
      IF ADDITIONALSUBDIRECTORY IS INITIAL.
        CONCATENATE USERPATH SLASHSEPARATOR 'Screens'
                             SLASHSEPARATOR 'gui_title_'
                             OBJECTNAME PERIOD
                             FILEEXTENSION INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR 'screens' INTO
NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR 'screens' INTO COMPLETEPATH.
      ELSE.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
                             SLASHSEPARATOR 'Screens'
                             SLASHSEPARATOR 'gui_title_'
                             OBJECTNAME PERIOD
                             FILEEXTENSION INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR 'Screens' INTO NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR 'Screens' INTO COMPLETEPATH.
      ENDIF.

*   Message Class
    WHEN IS_MESSAGECLASS.
      IF ADDITIONALSUBDIRECTORY IS INITIAL.
        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME
                             SLASHSEPARATOR 'Message class-'
                             OBJECTNAME PERIOD
                             FILEEXTENSION
                             INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME INTO
NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME INTO
COMPLETEPATH.
      ELSE.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
                             SLASHSEPARATOR OBJECTNAME
                             SLASHSEPARATOR 'Message class-'
                             OBJECTNAME PERIOD FILEEXTENSION
                             INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR OBJECTNAME INTO NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR OBJECTNAME INTO COMPLETEPATH.
      ENDIF.

*   Class definition
    WHEN IS_CLASS.
      IF ADDITIONALSUBDIRECTORY IS INITIAL.
        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME
                             SLASHSEPARATOR 'Class-'
                             OBJECTNAME PERIOD FILEEXTENSION
                             INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME INTO
NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME INTO
COMPLETEPATH.
      ELSE.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
                             SLASHSEPARATOR OBJECTNAME
                             SLASHSEPARATOR 'Class-'
                             OBJECTNAME PERIOD FILEEXTENSION
                             INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR OBJECTNAME INTO NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR OBJECTNAME INTO COMPLETEPATH.
      ENDIF.

*   Class definition
    WHEN IS_METHOD.
      IF ADDITIONALSUBDIRECTORY IS INITIAL.
        CONCATENATE USERPATH SLASHSEPARATOR 'Method-'
                             OBJECTNAME PERIOD FILEEXTENSION
                             INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME INTO
NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR OBJECTNAME INTO
COMPLETEPATH.
      ELSE.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
                             SLASHSEPARATOR 'Method-'
                             OBJECTNAME PERIOD FILEEXTENSION
                             INTO NEWFILENAMEWITHPATH.

        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR OBJECTNAME INTO NEWSUBDIRECTORY.
        CONCATENATE USERPATH SLASHSEPARATOR ADDITIONALSUBDIRECTORY
SLASHSEPARATOR OBJECTNAME INTO COMPLETEPATH.
      ENDIF.
  ENDCASE.

  TRANSLATE COMPLETEPATH TO LOWER CASE.
  CONCATENATE OBJECTNAME PERIOD FILEEXTENSION INTO NEWFILENAMEONLY.
  TRANSLATE NEWFILENAMEONLY TO LOWER CASE.
  TRANSLATE NEWFILENAMEWITHPATH TO LOWER CASE.
  TRANSLATE NEWSUBDIRECTORY TO LOWER CASE.

* If we are running on a non UNIX environment we will need to remove
*incorrect characters from the filename.
  IF DOWNLOADTOSERVER IS INITIAL.
    IF FRONTENDOPSYSTEM = NON_UNIX.
      TRANSLATE NEWFILENAMEONLY USING '/_'.
      TRANSLATE NEWFILENAMEWITHPATH USING '/_'.
      TRANSLATE NEWFILENAMEONLY USING '< '.
      TRANSLATE NEWFILENAMEWITHPATH USING '< '.
      TRANSLATE NEWFILENAMEONLY USING '> '.
      TRANSLATE NEWFILENAMEWITHPATH USING '> '.
      TRANSLATE NEWFILENAMEONLY USING '? '.
      TRANSLATE NEWFILENAMEWITHPATH USING '? '.
      TRANSLATE NEWFILENAMEONLY USING '| '.
      TRANSLATE NEWFILENAMEWITHPATH USING '| '.
      CONDENSE NEWFILENAMEONLY NO-GAPS.
      CONDENSE NEWFILENAMEWITHPATH NO-GAPS.
    ENDIF.
  ELSE.
    IF SERVEROPSYSTEM = NON_UNIX.
      TRANSLATE NEWFILENAMEONLY USING '/_'.
      TRANSLATE NEWFILENAMEWITHPATH USING '/_'.
      TRANSLATE NEWFILENAMEONLY USING '< '.
      TRANSLATE NEWFILENAMEWITHPATH USING '< '.
      TRANSLATE NEWFILENAMEONLY USING '> '.
      TRANSLATE NEWFILENAMEWITHPATH USING '> '.
      TRANSLATE NEWFILENAMEONLY USING '? '.
      TRANSLATE NEWFILENAMEWITHPATH USING '? '.
      TRANSLATE NEWFILENAMEONLY USING '| '.
      TRANSLATE NEWFILENAMEWITHPATH USING '| '.
      CONDENSE NEWFILENAMEONLY NO-GAPS.
      CONDENSE NEWFILENAMEWITHPATH NO-GAPS.
    ENDIF.
  ENDIF.
ENDFORM.                    "buildfilename
"buildFilename

*-----------------------------------------------------------------------
*  saveFileToPc...    write an internal table to a file on the local PC
*-----------------------------------------------------------------------
FORM SAVEFILETOPC USING IDOWNLOAD TYPE STANDARD TABLE
                        VALUE(FILENAMEWITHPATH)
                        VALUE(FILENAME)
                        VALUE(WRITEFIELDSEPARATOR)
                        VALUE(TRUNCATETRAILINGBLANKS)
                        VALUE(DISPLAYPROGRESSMESSAGE).

  DATA: STATUSMESSAGE TYPE STRING.
  DATA: OBJFILE TYPE REF TO CL_GUI_FRONTEND_SERVICES.
  DATA: STRSUBRC TYPE STRING.

  IF NOT DISPLAYPROGRESSMESSAGE IS INITIAL.
    CONCATENATE `Downloading: ` FILENAME INTO STATUSMESSAGE.
    PERFORM DISPLAYSTATUS USING STATUSMESSAGE 0.
  ENDIF.

  CREATE OBJECT OBJFILE.
  CALL METHOD OBJFILE->GUI_DOWNLOAD
    EXPORTING
      FILENAME                = FILENAMEWITHPATH
      FILETYPE                = 'ASC'
      CODEPAGE                = '8500'  "2008.2.21 추가
      WRITE_FIELD_SEPARATOR   = WRITEFIELDSEPARATOR
      TRUNC_TRAILING_BLANKS   = TRUNCATETRAILINGBLANKS
    CHANGING
      DATA_TAB                = IDOWNLOAD[]
    EXCEPTIONS
      FILE_WRITE_ERROR        = 1
      NO_BATCH                = 2
      GUI_REFUSE_FILETRANSFER = 3
      INVALID_TYPE            = 4
      NO_AUTHORITY            = 5
      UNKNOWN_ERROR           = 6
      HEADER_NOT_ALLOWED      = 7
      SEPARATOR_NOT_ALLOWED   = 8
      FILESIZE_NOT_ALLOWED    = 9
      HEADER_TOO_LONG         = 10
      DP_ERROR_CREATE         = 11
      DP_ERROR_SEND           = 12
      DP_ERROR_WRITE          = 13
      UNKNOWN_DP_ERROR        = 14
      ACCESS_DENIED           = 15
      DP_OUT_OF_MEMORY        = 16
      DISK_FULL               = 17
      DP_TIMEOUT              = 18
      FILE_NOT_FOUND          = 19
      DATAPROVIDER_EXCEPTION  = 20
      CONTROL_FLUSH_ERROR     = 21
      NOT_SUPPORTED_BY_GUI    = 22
      ERROR_NO_GUI            = 23.

  IF SY-SUBRC <> 0.
    STRSUBRC = SY-SUBRC.
    CONCATENATE `File save error: ` FILENAME ` sy-subrc: ` STRSUBRC
INTO STATUSMESSAGE.
    PERFORM DISPLAYSTATUS USING STATUSMESSAGE 3.
  ENDIF.
ENDFORM.                    "savefiletopc
"saveFileToPc

*-----------------------------------------------------------------------
*-----------------------------------------------------------------------
FORM SAVEFILETOSERVER USING IDOWNLOAD TYPE STANDARD TABLE
                            VALUE(FILENAMEWITHPATH)
                            VALUE(FILENAME)
                            VALUE(PATH)
                            VALUE(DISPLAYPROGRESSMESSAGE).

  DATA: WADOWNLOAD TYPE STRING.
  DATA: STATUSMESSAGE TYPE STRING.

  IF NOT DISPLAYPROGRESSMESSAGE IS INITIAL.
    CONCATENATE `Downloading: ` FILENAME INTO STATUSMESSAGE.
    PERFORM DISPLAYSTATUS USING STATUSMESSAGE 0.
  ENDIF.

  READ TABLE ISERVERPATHS WITH KEY TABLE_LINE = PATH.
  IF SY-SUBRC <> 0.
    PERFORM CREATESERVERDIRECTORY USING PATH.
    APPEND PATH TO ISERVERPATHS.
  ENDIF.

  OPEN DATASET FILENAMEWITHPATH FOR OUTPUT IN TEXT MODE ENCODING
DEFAULT.
  IF SY-SUBRC = 0.
    LOOP AT IDOWNLOAD INTO WADOWNLOAD.
      TRANSFER WADOWNLOAD TO FILENAMEWITHPATH.
      IF SY-SUBRC <> 0.
        MESSAGE E000(OO) WITH 'Error transferring data to file'.
      ENDIF.
    ENDLOOP.

    CLOSE DATASET FILENAMEWITHPATH.
    IF SY-SUBRC <> 0.
      MESSAGE E000(OO) WITH 'Error closing file'.
    ENDIF.
  ELSE.
*   Unable to create a file
    MESSAGE E000(OO) WITH
    'Error creating file on SAP server' 'check permissions'.
  ENDIF.
ENDFORM.                    "savefiletoserver
"saveFileToServer

*-----------------------------------------------------------------------
* createServerDirectory...
*-----------------------------------------------------------------------
FORM CREATESERVERDIRECTORY USING VALUE(PATH).

*  Parameters for remove command.
  DATA: PARAM1 TYPE SXPGCOLIST-PARAMETERS.
*  Return status
  DATA: FUNCSTATUS TYPE EXTCMDEXEX-STATUS.
*  Command line listing returned by the function
  DATA: ISERVEROUTPUT TYPE STANDARD TABLE OF BTCXPM.
  DATA: WASERVEROUTPUT TYPE BTCXPM.
*  Targetsystem type conversion variable.
  DATA: TARGET TYPE RFCDISPLAY-RFCHOST.
* Operating system
  DATA: OPERATINGSYSTEM TYPE SXPGCOLIST-OPSYSTEM.
*  Head for split command.
  DATA: HEAD TYPE STRING..
  DATA: TAIL TYPE STRING.

  PARAM1 = PATH.
  TARGET = SY-HOST.
  OPERATINGSYSTEM = SY-OPSYS.

  CALL FUNCTION 'SXPG_COMMAND_EXECUTE'
    EXPORTING
      COMMANDNAME                   = 'ZMKDIR'
      ADDITIONAL_PARAMETERS         = PARAM1
      OPERATINGSYSTEM               = OPERATINGSYSTEM
      TARGETSYSTEM                  = TARGET
      STDOUT                        = 'X'
      STDERR                        = 'X'
      TERMINATIONWAIT               = 'X'
    IMPORTING
      STATUS                        = FUNCSTATUS
    TABLES
      EXEC_PROTOCOL                 = ISERVEROUTPUT[]
    EXCEPTIONS
      NO_PERMISSION                 = 1
      COMMAND_NOT_FOUND             = 2
      PARAMETERS_TOO_LONG           = 3
      SECURITY_RISK                 = 4
      WRONG_CHECK_CALL_INTERFACE    = 5
      PROGRAM_START_ERROR           = 6
      PROGRAM_TERMINATION_ERROR     = 7
      X_ERROR                       = 8
      PARAMETER_EXPECTED            = 9
      TOO_MANY_PARAMETERS           = 10
      ILLEGAL_COMMAND               = 11
      WRONG_ASYNCHRONOUS_PARAMETERS = 12
      CANT_ENQ_TBTCO_ENTRY          = 13
      JOBCOUNT_GENERATION_ERROR     = 14
      OTHERS                        = 15.

  IF SY-SUBRC = 0.
*   Although the function succeded did the external command actually
*work
    IF FUNCSTATUS = 'E'.
*     External command returned with an error
      IF SY-OPSYS CS 'Windows NT'.
        READ TABLE ISERVEROUTPUT INDEX 1 INTO WASERVEROUTPUT.
        IF WASERVEROUTPUT-MESSAGE NS 'already exists'.
*         An error occurred creating the directory on the server
          MESSAGE E000(OO) WITH
          'An error occurred creating a directory'.
        ENDIF.
      ELSE.
        READ TABLE ISERVEROUTPUT INDEX 2 INTO WASERVEROUTPUT.
        SPLIT WASERVEROUTPUT-MESSAGE AT SPACE INTO HEAD TAIL.
        SHIFT TAIL LEFT DELETING LEADING SPACE.
        IF TAIL <> 'Do not specify an existing file.'.
*         An error occurred creating the directory on the server
          MESSAGE E000(OO) WITH
          'An error occurred creating a directory'.
        ENDIF.
      ENDIF.
    ENDIF.
  ELSE.
    CASE SY-SUBRC.
      WHEN 1.
*       No permissions to run the command
        MESSAGE E000(OO) WITH
        'No permissions to run external command ZMKDIR'.
      WHEN 2.
*       External command not found
        MESSAGE E000(OO) WITH 'External comand ZMKDIR not found'.

      WHEN OTHERS.
*       Unable to create the directory
        MESSAGE E000(OO) WITH 'An error occurred creating a directory'
                              ', subrc:'
                              SY-SUBRC.
    ENDCASE.
  ENDIF.
ENDFORM.                    "createserverdirectory
"createServerDirectory

*-----------------------------------------------------------------------
* appendTextElements...
*-----------------------------------------------------------------------
FORM APPENDTEXTELEMENTS USING ILOCTEXTELEMENTS LIKE DUMITEXTTAB[]
                              ILOCLINES LIKE DUMIHTML[].

  FIELD-SYMBOLS: <WATEXTELEMENT> TYPE TTEXTTABLE.
  DATA: WALINE TYPE STRING.

  IF LINES( ILOCTEXTELEMENTS ) > 0.
    APPEND '' TO ILOCLINES.

    APPEND '*Text elements' TO ILOCLINES.
    APPEND
'*----------------------------------------------------------' TO
ILOCLINES.
    LOOP AT ILOCTEXTELEMENTS ASSIGNING <WATEXTELEMENT>.
      CONCATENATE '*  ' <WATEXTELEMENT>-KEY <WATEXTELEMENT>-ENTRY INTO
WALINE SEPARATED BY SPACE.
      APPEND WALINE TO ILOCLINES.
    ENDLOOP.
  ENDIF.
ENDFORM.                    "appendtextelements
"appendTextElements

*-----------------------------------------------------------------------
* appendGUITitles...
*-----------------------------------------------------------------------
FORM APPENDGUITITLES USING ILOCGUITITLES LIKE DUMIGUITITLE[]
                           ILOCLINES LIKE DUMIHTML[].

  FIELD-SYMBOLS: <WAGUITITLE> TYPE TGUITITLE.
  DATA: WALINE TYPE STRING.

  IF LINES( ILOCGUITITLES ) > 0.
    APPEND '' TO ILOCLINES.

    APPEND '*GUI Texts' TO ILOCLINES.
    APPEND
'*----------------------------------------------------------' TO
ILOCLINES.
    LOOP AT ILOCGUITITLES ASSIGNING <WAGUITITLE>.
      CONCATENATE '*  ' <WAGUITITLE>-OBJ_CODE '-->' <WAGUITITLE>-TEXT
INTO WALINE SEPARATED BY SPACE.
      APPEND WALINE TO ILOCLINES.
    ENDLOOP.
  ENDIF.
ENDFORM.                    "appendguititles
"appendGUITitles

*-----------------------------------------------------------------------
* appendSelectionTexts...
*-----------------------------------------------------------------------
FORM APPENDSELECTIONTEXTS USING ILOCSELECTIONTEXTS LIKE DUMITEXTTAB[]
                                ILOCLINES LIKE DUMIHTML[].

  FIELD-SYMBOLS: <WASELECTIONTEXT> TYPE TTEXTTABLE.
  DATA: WALINE TYPE STRING.

  IF LINES( ILOCSELECTIONTEXTS ) > 0.
    APPEND '' TO ILOCLINES.
    APPEND '' TO ILOCLINES.

    APPEND '*Selection texts' TO ILOCLINES.
    APPEND
'*----------------------------------------------------------' TO
ILOCLINES.
    LOOP AT ILOCSELECTIONTEXTS ASSIGNING <WASELECTIONTEXT>.
      CONCATENATE '*  ' <WASELECTIONTEXT>-KEY <WASELECTIONTEXT>-ENTRY
INTO WALINE SEPARATED BY SPACE.
      APPEND WALINE TO ILOCLINES.
    ENDLOOP.
  ENDIF.
ENDFORM.                    "appendselectiontexts
"appendSelectionTexts

*-----------------------------------------------------------------------
* appendExceptionTexts...
*-----------------------------------------------------------------------
FORM APPENDEXCEPTIONTEXTS USING ICONCEPTS LIKE DUMICONCEPTS[]
                                ILOCLINES LIKE DUMIHTML[].

  FIELD-SYMBOLS: <WACONCEPT> TYPE TCONCEPT.
  DATA: WALINE TYPE STRING.
  DATA: CONCEPTTEXT TYPE SOTR_TXT.

  IF LINES( ICONCEPTS ) > 0.
    APPEND '' TO ILOCLINES.

    APPEND '*Exception texts' TO ILOCLINES.
    APPEND
'*----------------------------------------------------------' TO
ILOCLINES.
    LOOP AT ICONCEPTS ASSIGNING <WACONCEPT>.
*     Find the text for this concept
      CALL FUNCTION 'SOTR_GET_TEXT_KEY'
        EXPORTING
          CONCEPT                = <WACONCEPT>-CONCEPT
          LANGU                  = SY-LANGU
          SEARCH_IN_SECOND_LANGU = 'X'
*         second_langu           = 'DE'
        IMPORTING
          E_TEXT                 = CONCEPTTEXT
        EXCEPTIONS
          NO_ENTRY_FOUND         = 1
          PARAMETER_ERROR        = 2
          OTHERS                 = 3.

      IF SY-SUBRC = 0.
        CONCATENATE '*  ' <WACONCEPT>-CONSTNAME '-' CONCEPTTEXT  INTO
WALINE SEPARATED BY SPACE.
        APPEND WALINE TO ILOCLINES.
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDFORM.                    "appendexceptiontexts
"appendExceptionTexts

*-----------------------------------------------------------------------
* downloadFunctionDocs...
*-----------------------------------------------------------------------
FORM DOWNLOADFUNCTIONDOCS USING VALUE(FUNCTIONNAME)
                                VALUE(FUNCTIONDESCRIPTION)
                                VALUE(USERFILEPATH)
                                VALUE(FILEEXTENSION)
                                VALUE(CONVERTTOHTML)
                                VALUE(SLASHSEPARATOR)
                                VALUE(SAVETOSERVER)
                                VALUE(DISPLAYPROGRESSMESSAGE)
                                      SUBDIR
                                      DOCUMENTATIONDOWNLOADED.

  DATA: ILINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: IDOCUMENTATION TYPE STANDARD TABLE OF FUNCT WITH HEADER LINE.
  DATA: IEXCEPTIONS TYPE STANDARD TABLE OF RSEXC WITH HEADER LINE.
  DATA: IEXPORT TYPE STANDARD TABLE OF RSEXP WITH HEADER LINE.
  DATA: IPARAMETER TYPE STANDARD TABLE OF RSIMP WITH HEADER LINE.
  DATA: ITABLES TYPE STANDARD TABLE OF RSTBL WITH HEADER LINE.
  DATA: ISCRIPTLINES TYPE STANDARD TABLE OF TLINE WITH HEADER LINE.
  DATA: HTMLPAGENAME TYPE STRING.
  DATA: NEWFILENAMEWITHPATH TYPE STRING.
  DATA: NEWFILENAMEONLY TYPE STRING.
  DATA: OBJECT LIKE DOKHL-OBJECT.
  DATA: STRINGLENGTH TYPE I VALUE 0.
  DATA: NEWSUBDIRECTORY TYPE STRING.
  DATA: WALINE(255).
  DATA: COMPLETESAVEPATH TYPE STRING.

  DOCUMENTATIONDOWNLOADED = FALSE.
  OBJECT = FUNCTIONNAME.

  CALL FUNCTION 'FUNCTION_IMPORT_DOKU'
    EXPORTING
      FUNCNAME           = FUNCTIONNAME
    TABLES
      DOKUMENTATION      = IDOCUMENTATION
      EXCEPTION_LIST     = IEXCEPTIONS
      EXPORT_PARAMETER   = IEXPORT
      IMPORT_PARAMETER   = IPARAMETER
      TABLES_PARAMETER   = ITABLES
    EXCEPTIONS
      ERROR_MESSAGE      = 1
      FUNCTION_NOT_FOUND = 2
      INVALID_NAME       = 3
      OTHERS             = 4.

  CALL FUNCTION 'DOCU_GET'
    EXPORTING
      ID                     = 'FU'
      LANGU                  = SY-LANGU
      OBJECT                 = OBJECT
      TYP                    = 'T'
      VERSION_ACTIVE_OR_LAST = 'L'
    TABLES
      LINE                   = ISCRIPTLINES
    EXCEPTIONS
      NO_DOCU_ON_SCREEN      = 1
      NO_DOCU_SELF_DEF       = 2
      NO_DOCU_TEMP           = 3
      RET_CODE               = 4
      OTHERS                 = 5.

  IF SY-SUBRC = 0 AND NOT ( ISCRIPTLINES[] IS INITIAL ).
    APPEND 'SHORT TEXT' TO ILINES.
    CONCATENATE SPACE FUNCTIONDESCRIPTION INTO FUNCTIONDESCRIPTION
SEPARATED BY SPACE.
    APPEND FUNCTIONDESCRIPTION TO ILINES.
    APPEND SPACE TO ILINES.
    LOOP AT ISCRIPTLINES.
      MOVE ISCRIPTLINES-TDLINE TO ILINES.
      CONCATENATE SPACE ILINES INTO ILINES SEPARATED BY SPACE.
      WHILE ILINES CP '&*' OR ILINES CP '*&'.
        REPLACE '&' INTO ILINES WITH SPACE.
        SHIFT ILINES LEFT DELETING LEADING SPACE.
      ENDWHILE.
      APPEND ILINES.
    ENDLOOP.

    CLEAR ILINES.
    IF NOT ( IDOCUMENTATION[] IS INITIAL ).
      APPEND ILINES.
      APPEND 'PARAMETER DOCUMENTATION' TO ILINES.
      APPEND '-----------------------' TO ILINES.
      APPEND ILINES.

      DESCRIBE FIELD IDOCUMENTATION-PARAMETER LENGTH STRINGLENGTH IN
CHARACTER MODE.
      STRINGLENGTH = STRINGLENGTH + 3.
      LOOP AT IDOCUMENTATION.
        MOVE IDOCUMENTATION-PARAMETER TO WALINE.
        MOVE IDOCUMENTATION-STEXT TO WALINE+STRINGLENGTH.
        APPEND WALINE TO ILINES.
      ENDLOOP.
    ENDIF.

    CONCATENATE `Documentation - ` FUNCTIONNAME INTO HTMLPAGENAME.

    IF CONVERTTOHTML IS INITIAL.
      APPEND ILINES.
      CONCATENATE '--------------------------------------'
                  '--------------------------------------------'
                  INTO ILINES.
      APPEND ILINES.
      APPEND ILINES.
      PERFORM BUILDFOOTERMESSAGE USING 'TEXT'
                                       ILINES.
      APPEND ILINES.
    ELSE.
      PERFORM CONVERTCODETOHTML USING ILINES[]
                                      HTMLPAGENAME
                                      SPACE
                                      IS_DOCUMENTATION
                                      TRUE
                                      SPACE
                                      SPACE
                                      SPACE
                                      SPACE
                                      SPACE
                                      SPACE.
    ENDIF.

    PERFORM BUILDFILENAME USING USERFILEPATH
                                SUBDIR
                                FUNCTIONNAME
                                SPACE
                                SPACE
                                FILEEXTENSION
                                IS_DOCUMENTATION
                                SAVETOSERVER
                                SLASHSEPARATOR
                                NEWFILENAMEWITHPATH
                                NEWFILENAMEONLY
                                NEWSUBDIRECTORY
                                COMPLETESAVEPATH.

    IF SAVETOSERVER IS INITIAL.
      PERFORM SAVEFILETOPC USING ILINES[]
                                 NEWFILENAMEWITHPATH
                                 NEWFILENAMEONLY
                                 SPACE
                                 SPACE
                                 DISPLAYPROGRESSMESSAGE.
    ELSE.
      PERFORM SAVEFILETOSERVER USING ILINES[]
                                     NEWFILENAMEWITHPATH
                                     NEWFILENAMEONLY
                                     COMPLETESAVEPATH
                                     DISPLAYPROGRESSMESSAGE.
    ENDIF.

    DOCUMENTATIONDOWNLOADED = TRUE.
  ENDIF.
ENDFORM.                    "downloadfunctiondocs
"downloadFunctionDocs

*-----------------------------------------------------------------------
*  downloadScreens...
*-----------------------------------------------------------------------
FORM DOWNLOADSCREENS USING ILOCSCREENFLOW LIKE DUMISCREEN[]
                           VALUE(PROGRAMNAME)
                           VALUE(USERFILEPATH)
                           VALUE(TEXTFILEEXTENSION)
                           VALUE(SUBDIR)
                           VALUE(SLASHSEPARATOR)
                           VALUE(SAVETOSERVER)
                           VALUE(DISPLAYPROGRESSMESSAGE).


  TABLES: D020T.
  DATA: HEADER LIKE D020S.
  DATA: IFIELDS TYPE STANDARD TABLE OF D021S WITH HEADER LINE.
  DATA: IFLOWLOGIC TYPE STANDARD TABLE OF D022S WITH HEADER LINE.
  FIELD-SYMBOLS <WASCREEN> TYPE TSCREENFLOW.
  DATA: WACHARHEADER TYPE SCR_CHHEAD.
  DATA: ISCREENCHAR TYPE STANDARD TABLE OF SCR_CHFLD WITH HEADER LINE.
  DATA: IFIELDSCHAR TYPE STANDARD TABLE OF SCR_CHFLD WITH HEADER LINE.
  DATA: STARS TYPE STRING VALUE
  '****************************************************************'.
  DATA: COMMENT1 TYPE STRING VALUE
  '*   This file was generated by Direct Download Enterprise.     *'.
  DATA: COMMENT2 TYPE STRING VALUE
  '*   Please do not change it manually.                          *'.
  DATA: DYNPROTEXT TYPE STRING VALUE '%_DYNPRO'.
  DATA: HEADERTEXT TYPE STRING VALUE '%_HEADER'.
  DATA: PARAMSTEXT TYPE STRING VALUE '%_PARAMS'.
  DATA: DESCRIPTIONTEXT TYPE STRING VALUE '%_DESCRIPTION'.
  DATA: FIELDSTEXT TYPE STRING VALUE '%_FIELDS'.
  DATA: FLOWLOGICTEXT TYPE STRING VALUE '%_FLOWLOGIC'.
  DATA: PROGRAMLENGTH TYPE STRING.
  DATA: NEWSUBDIRECTORY TYPE STRING.
  DATA: NEWFILENAMEWITHPATH TYPE STRING.
  DATA: NEWFILENAMEONLY TYPE STRING.
  DATA: COMPLETESAVEPATH TYPE STRING.

  LOOP AT ILOCSCREENFLOW ASSIGNING <WASCREEN>.
    CALL FUNCTION 'RS_IMPORT_DYNPRO'
      EXPORTING
        DYLANG = SY-LANGU
        DYNAME = PROGRAMNAME
        DYNUMB = <WASCREEN>-SCREEN
      IMPORTING
        HEADER = HEADER
      TABLES
        FTAB   = IFIELDS
        PLTAB  = IFLOWLOGIC.

    CALL FUNCTION 'RS_SCRP_HEADER_RAW_TO_CHAR'
      EXPORTING
        HEADER_INT  = HEADER
      IMPORTING
        HEADER_CHAR = WACHARHEADER
      EXCEPTIONS
        OTHERS      = 1.

*   Add in the top comments for the file
    APPEND STARS TO ISCREENCHAR .
    APPEND COMMENT1 TO ISCREENCHAR.
    APPEND COMMENT2 TO ISCREENCHAR.
    APPEND STARS TO ISCREENCHAR.

*   Screen identification
    APPEND DYNPROTEXT TO ISCREENCHAR.
    APPEND WACHARHEADER-PROG TO ISCREENCHAR.
    APPEND WACHARHEADER-DNUM TO ISCREENCHAR.
    APPEND SY-SAPRL TO ISCREENCHAR.
    DESCRIBE FIELD D020T-PROG LENGTH PROGRAMLENGTH IN CHARACTER MODE.
    CONCATENATE `                ` PROGRAMLENGTH INTO ISCREENCHAR.
    APPEND ISCREENCHAR.

*   Header
    APPEND HEADERTEXT TO ISCREENCHAR.
    APPEND WACHARHEADER TO ISCREENCHAR.

*   Description text
    APPEND DESCRIPTIONTEXT TO ISCREENCHAR.
    SELECT SINGLE DTXT FROM D020T INTO ISCREENCHAR
                       WHERE PROG = PROGRAMNAME
                             AND DYNR = <WASCREEN>-SCREEN
                             AND LANG = SY-LANGU.
    APPEND ISCREENCHAR.

*   Fieldlist text
    APPEND FIELDSTEXT TO ISCREENCHAR.

    CALL FUNCTION 'RS_SCRP_FIELDS_RAW_TO_CHAR'
      TABLES
        FIELDS_INT  = IFIELDS[]
        FIELDS_CHAR = IFIELDSCHAR[]
      EXCEPTIONS
        OTHERS      = 1.

    LOOP AT IFIELDSCHAR.
      MOVE-CORRESPONDING IFIELDSCHAR TO ISCREENCHAR.
      APPEND ISCREENCHAR.
    ENDLOOP.

*   Flowlogic text
    APPEND FLOWLOGICTEXT TO ISCREENCHAR.
*   Flow logic.
    LOOP AT IFLOWLOGIC.
      APPEND IFLOWLOGIC TO ISCREENCHAR.
    ENDLOOP.

    PERFORM BUILDFILENAME USING USERFILEPATH
                                SUBDIR
                                WACHARHEADER-DNUM
                                SPACE
                                SPACE
                                TEXTFILEEXTENSION
                                IS_SCREEN
                                SAVETOSERVER
                                SLASHSEPARATOR
                                NEWFILENAMEWITHPATH
                                NEWFILENAMEONLY
                                NEWSUBDIRECTORY
                                COMPLETESAVEPATH.

    IF SAVETOSERVER IS INITIAL.
*     Save the screen to the local computer
      PERFORM SAVEFILETOPC USING ISCREENCHAR[]
                                 NEWFILENAMEWITHPATH
                                 NEWFILENAMEONLY
                                 'X'
                                 'X'
                                 DISPLAYPROGRESSMESSAGE.
    ELSE.
*     Save the screen to the SAP server
      PERFORM SAVEFILETOSERVER USING ISCREENCHAR[]
                                     NEWFILENAMEWITHPATH
                                     NEWFILENAMEONLY
                                     COMPLETESAVEPATH
                                     DISPLAYPROGRESSMESSAGE.
    ENDIF.

    CLEAR HEADER. CLEAR WACHARHEADER.
    CLEAR ISCREENCHAR[].
    CLEAR IFIELDSCHAR[].
    CLEAR IFIELDS[].
    CLEAR IFLOWLOGIC[].
  ENDLOOP.
ENDFORM.                    "downloadscreens
"downloadScreens

*-----------------------------------------------------------------------
*  downloadGUITitles..
*-----------------------------------------------------------------------
FORM DOWNLOADGUITITLES USING ILOCGUITITLES LIKE DUMIGUITITLE[]
                             VALUE(USERFILEPATH)
                             VALUE(TEXTFILEEXTENSION)
                             VALUE(SUBDIR)
                             VALUE(SLASHSEPARATOR)
                             VALUE(SAVETOSERVER)
                             VALUE(DISPLAYPROGRESSMESSAGE).

  DATA: ILINES TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  FIELD-SYMBOLS: <WAGUITITLE> TYPE TGUITITLE.
  DATA: NEWSUBDIRECTORY TYPE STRING.
  DATA: NEWFILENAMEWITHPATH TYPE STRING.
  DATA: NEWFILENAMEONLY TYPE STRING.
  DATA: COMPLETESAVEPATH TYPE STRING.

  LOOP AT ILOCGUITITLES ASSIGNING <WAGUITITLE>.
    APPEND <WAGUITITLE>-TEXT TO ILINES.

    PERFORM BUILDFILENAME USING USERFILEPATH
                                SUBDIR
                                <WAGUITITLE>-OBJ_CODE
                                SPACE
                                SPACE
                                TEXTFILEEXTENSION
                                IS_GUITITLE
                                SAVETOSERVER
                                SLASHSEPARATOR
                                NEWFILENAMEWITHPATH
                                NEWFILENAMEONLY
                                NEWSUBDIRECTORY
                                COMPLETESAVEPATH.

    IF SAVETOSERVER IS INITIAL.
      PERFORM SAVEFILETOPC USING ILINES[]
                                 NEWFILENAMEWITHPATH
                                 NEWFILENAMEONLY
                                 SPACE
                                 SPACE
                                 DISPLAYPROGRESSMESSAGE.
    ELSE.
      PERFORM SAVEFILETOSERVER USING ILINES[]
                                     NEWFILENAMEWITHPATH
                                     NEWFILENAMEONLY
                                     COMPLETESAVEPATH
                                     DISPLAYPROGRESSMESSAGE.
    ENDIF.

    CLEAR ILINES[].
  ENDLOOP.
ENDFORM.                    "downloadguititles
"downloadGUITitles

*-----------------------------------------------------------------------
*  downloadPrograms..
*-----------------------------------------------------------------------
FORM DOWNLOADPROGRAMS USING ILOCPROGRAM LIKE IPROGRAMS[]
                            ILOCFUNCTIONS LIKE IFUNCTIONS[]
                            VALUE(USERFILEPATH)
                            VALUE(FILEEXTENSION)
                            VALUE(HTMLFILEEXTENSION)
                            VALUE(TEXTFILEEXTENSION)
                            VALUE(CONVERTTOHTML)
                            VALUE(SYNTAXHIGHLIGHTCOMMENTS)
                            VALUE(CUSTOMERNAMERANGE)
                            VALUE(GETINCLUDES)
                            VALUE(GETDICTSTRUCT)
                            VALUE(DOWNLOADDOCUMENTATION)
                            VALUE(SORTTABLESASC)
                            VALUE(SLASHSEPARATOR)
                            VALUE(SAVETOSERVER)
                            VALUE(DISPLAYPROGRESSMESSAGE).


  DATA: IPROGFUNCTIONS TYPE STANDARD TABLE OF TFUNCTION WITH HEADER LINE.
  FIELD-SYMBOLS: <WAPROGRAM> TYPE TPROGRAM.
  FIELD-SYMBOLS: <WAINCLUDE> TYPE TINCLUDE.
  DATA: IEMPTYTEXTELEMENTS TYPE STANDARD TABLE OF TTEXTTABLE.
  DATA: IEMPTYSELECTIONTEXTS TYPE STANDARD TABLE OF TTEXTTABLE.
  DATA: IEMPTYMESSAGES TYPE STANDARD TABLE OF TMESSAGE.
  DATA: IEMPTYGUITITLES TYPE STANDARD TABLE OF TGUITITLE.
  DATA: LOCCONVERTTOHTML(1).
  DATA: LOCFILEEXTENSION TYPE STRING.

  SORT ILOCPROGRAM ASCENDING BY PROGNAME.

  LOOP AT ILOCPROGRAM ASSIGNING <WAPROGRAM>.
*   if the program to download is this program then always download as
*text otherwise you will get a rubbish file
    IF <WAPROGRAM>-PROGNAME = SY-CPROG.
      LOCCONVERTTOHTML = ''.
      LOCFILEEXTENSION = TEXTEXTENSION.
    ELSE.
      LOCCONVERTTOHTML = CONVERTTOHTML.
      LOCFILEEXTENSION = FILEEXTENSION.
    ENDIF.

*   Download the main program
    PERFORM READINCLUDEANDDOWNLOAD USING <WAPROGRAM>-ITEXTELEMENTS[]
                                         <WAPROGRAM>-ISELECTIONTEXTS[]
                                         <WAPROGRAM>-IMESSAGES[]
                                         <WAPROGRAM>-IGUITITLE[]
                                         <WAPROGRAM>-PROGNAME
                                         SPACE
                                         <WAPROGRAM>-PROGRAMTITLE
                                         IS_PROGRAM
                                         USERFILEPATH
                                         LOCFILEEXTENSION
                                         <WAPROGRAM>-PROGNAME
                                         LOCCONVERTTOHTML
                                         SYNTAXHIGHLIGHTCOMMENTS
                                         CUSTOMERNAMERANGE
                                         GETINCLUDES
                                         GETDICTSTRUCT
                                         SLASHSEPARATOR
                                         SAVETOSERVER
                                         DISPLAYPROGRESSMESSAGE.

*   Download screens.
    IF NOT <WAPROGRAM>-ISCREENFLOW[] IS INITIAL.
      PERFORM DOWNLOADSCREENS USING <WAPROGRAM>-ISCREENFLOW[]
                                    <WAPROGRAM>-PROGNAME
                                    USERFILEPATH
                                    TEXTFILEEXTENSION
                                    <WAPROGRAM>-PROGNAME
                                    SLASHSEPARATOR
                                    SAVETOSERVER
                                    DISPLAYPROGRESSMESSAGE.
    ENDIF.

*   Download GUI titles
    IF NOT <WAPROGRAM>-IGUITITLE[] IS INITIAL.
      PERFORM DOWNLOADGUITITLES USING <WAPROGRAM>-IGUITITLE
                                      USERFILEPATH
                                      TEXTFILEEXTENSION
                                      <WAPROGRAM>-PROGNAME
                                      SLASHSEPARATOR
                                      SAVETOSERVER
                                      DISPLAYPROGRESSMESSAGE.
    ENDIF.

*   Download all other includes
    LOOP AT <WAPROGRAM>-IINCLUDES ASSIGNING <WAINCLUDE>.
      PERFORM READINCLUDEANDDOWNLOAD USING IEMPTYTEXTELEMENTS[]
                                           IEMPTYSELECTIONTEXTS[]
                                           IEMPTYMESSAGES[]
                                           IEMPTYGUITITLES[]
                                           <WAINCLUDE>-INCLUDENAME
                                           SPACE
                                           <WAINCLUDE>-INCLUDETITLE
                                           IS_PROGRAM
                                           USERFILEPATH
                                           FILEEXTENSION
                                           <WAPROGRAM>-PROGNAME
                                           CONVERTTOHTML
                                           SYNTAXHIGHLIGHTCOMMENTS
                                           CUSTOMERNAMERANGE
                                           GETINCLUDES
                                           GETDICTSTRUCT
                                           SLASHSEPARATOR
                                           SAVETOSERVER
                                           DISPLAYPROGRESSMESSAGE.

    ENDLOOP.

*   Download all dictionary structures
    IF NOT <WAPROGRAM>-IDICTSTRUCT[] IS INITIAL.
      PERFORM DOWNLOADDDSTRUCTURES USING <WAPROGRAM>-IDICTSTRUCT[]
                                         USERFILEPATH
                                         HTMLFILEEXTENSION
                                         <WAPROGRAM>-PROGNAME
                                         SORTTABLESASC
                                         SLASHSEPARATOR
                                         SAVETOSERVER
                                         DISPLAYPROGRESSMESSAGE.
    ENDIF.

*   Download any functions used by these programs
    LOOP AT ILOCFUNCTIONS INTO IPROGFUNCTIONS WHERE PROGRAMLINKNAME =
<WAPROGRAM>-PROGNAME.
      APPEND IPROGFUNCTIONS.
    ENDLOOP.

    IF NOT IPROGFUNCTIONS[] IS INITIAL.
      PERFORM DOWNLOADFUNCTIONS USING IPROGFUNCTIONS[]
                                      USERFILEPATH
                                      FILEEXTENSION
                                      <WAPROGRAM>-PROGNAME
                                      DOWNLOADDOCUMENTATION
                                      CONVERTTOHTML
                                      SYNTAXHIGHLIGHTCOMMENTS
                                      CUSTOMERNAMERANGE
                                      GETINCLUDES
                                      GETDICTSTRUCT
                                      TEXTFILEEXTENSION
                                      HTMLFILEEXTENSION
                                      SORTTABLESASC
                                      SLASHSEPARATOR
                                      SAVETOSERVER
                                      DISPLAYPROGRESSMESSAGE.
      CLEAR IPROGFUNCTIONS[].
    ENDIF.
  ENDLOOP.
ENDFORM.                    "downloadprograms
"downloadPrograms

*-----------------------------------------------------------------------
*  downloadClasses..
*-----------------------------------------------------------------------
FORM DOWNLOADCLASSES USING ILOCCLASSES LIKE ICLASSES[]
                           ILOCFUNCTIONS LIKE IFUNCTIONS[]
                           VALUE(USERFILEPATH)
                           VALUE(FILEEXTENSION)
                           VALUE(HTMLFILEEXTENSION)
                           VALUE(TEXTFILEEXTENSION)
                           VALUE(CONVERTTOHTML)
                           VALUE(SYNTAXHIGHLIGHTCOMMENTS)
                           VALUE(CUSTOMERNAMERANGE)
                           VALUE(GETINCLUDES)
                           VALUE(GETDICTSTRUCT)
                           VALUE(DOWNLOADDOCUMENTATION)
                           VALUE(SORTTABLESASC)
                           VALUE(SLASHSEPARATOR)
                           VALUE(SAVETOSERVER)
                           VALUE(DISPLAYPROGRESSMESSAGE).


  DATA: ICLASSFUNCTIONS TYPE STANDARD TABLE OF TFUNCTION WITH HEADER LINE.
  FIELD-SYMBOLS: <WACLASS> TYPE TCLASS.
  FIELD-SYMBOLS: <WAMETHOD> TYPE TMETHOD.

  SORT ILOCCLASSES ASCENDING BY CLSNAME.

  LOOP AT ILOCCLASSES ASSIGNING <WACLASS>.
*   Download the class
    PERFORM READCLASSANDDOWNLOAD USING <WACLASS>
                                        <WACLASS>-CLSNAME
                                        SPACE
                                        IS_CLASS
                                        USERFILEPATH
                                        FILEEXTENSION
                                        SPACE
                                        CONVERTTOHTML
                                        SYNTAXHIGHLIGHTCOMMENTS
                                        CUSTOMERNAMERANGE
                                        GETINCLUDES
                                        GETDICTSTRUCT
                                        SLASHSEPARATOR
                                        SAVETOSERVER
                                        DISPLAYPROGRESSMESSAGE.


*   Download all of the methods
    LOOP AT <WACLASS>-IMETHODS ASSIGNING <WAMETHOD>.
      PERFORM READMETHODANDDOWNLOAD USING <WAMETHOD>
                                          <WAMETHOD>-CMPNAME
                                          <WAMETHOD>-METHODKEY
                                          SPACE
                                          IS_METHOD
                                          USERFILEPATH
                                          FILEEXTENSION
                                          <WACLASS>-CLSNAME
                                          CONVERTTOHTML
                                          SYNTAXHIGHLIGHTCOMMENTS
                                          CUSTOMERNAMERANGE
                                          GETINCLUDES
                                          GETDICTSTRUCT
                                          SLASHSEPARATOR
                                          SAVETOSERVER
                                          DISPLAYPROGRESSMESSAGE.

    ENDLOOP.

*   Download all dictionary structures
    IF NOT <WACLASS>-IDICTSTRUCT[] IS INITIAL.
      PERFORM DOWNLOADDDSTRUCTURES USING <WACLASS>-IDICTSTRUCT[]
                                         USERFILEPATH
                                         HTMLFILEEXTENSION
                                         <WACLASS>-CLSNAME
                                         SORTTABLESASC
                                         SLASHSEPARATOR
                                         SAVETOSERVER
                                         DISPLAYPROGRESSMESSAGE.
    ENDIF.

*   Download any functions used by these programs
    LOOP AT ILOCFUNCTIONS INTO ICLASSFUNCTIONS WHERE PROGRAMLINKNAME =
<WACLASS>-CLSNAME.
      APPEND ICLASSFUNCTIONS.
    ENDLOOP.

    IF NOT ICLASSFUNCTIONS[] IS INITIAL.
      PERFORM DOWNLOADFUNCTIONS USING ICLASSFUNCTIONS[]
                                      USERFILEPATH
                                      FILEEXTENSION
                                      <WACLASS>-CLSNAME
                                      DOWNLOADDOCUMENTATION
                                      CONVERTTOHTML
                                      SYNTAXHIGHLIGHTCOMMENTS
                                      CUSTOMERNAMERANGE
                                      GETINCLUDES
                                      GETDICTSTRUCT
                                      TEXTFILEEXTENSION
                                      HTMLFILEEXTENSION
                                      SORTTABLESASC
                                      SLASHSEPARATOR
                                      SAVETOSERVER
                                      DISPLAYPROGRESSMESSAGE.
      CLEAR ICLASSFUNCTIONS[].
    ENDIF.
  ENDLOOP.
ENDFORM.                    "downloadclasses
"downloadClasses

*-----------------------------------------------------------------------
FORM REFORMATCLASSCODE USING ITEMPLINES LIKE DUMIHTML[].

  FIELD-SYMBOLS: <WALINE> TYPE STRING.
  DATA: NEWLINE TYPE STRING.
  DATA: INEWTABLE TYPE STANDARD TABLE OF STRING.
  DATA: FOUNDONE TYPE I VALUE FALSE.

  LOOP AT ITEMPLINES ASSIGNING <WALINE>.
    IF NOT <WALINE> IS INITIAL.
      IF FOUNDONE = FALSE.
        FIND 'data' IN <WALINE> RESPECTING CASE.
        IF SY-SUBRC = 0.
          FOUNDONE = TRUE.
        ENDIF.

        FIND 'constants' IN <WALINE> RESPECTING CASE.
        IF SY-SUBRC = 0.
          FOUNDONE = TRUE.
        ENDIF.

        IF FOUNDONE = TRUE.
          NEWLINE = <WALINE>.

          IF ( NEWLINE CS '.' OR NEWLINE CS '*' ).
            REPLACE '!' IN <WALINE> WITH ''.
            APPEND NEWLINE TO INEWTABLE.
            CLEAR NEWLINE.
            FOUNDONE = FALSE.
          ENDIF.
        ELSE.
          REPLACE '!' IN <WALINE> WITH ''.
          APPEND <WALINE> TO INEWTABLE.
        ENDIF.
      ELSE.
        CONCATENATE NEWLINE <WALINE> INTO NEWLINE SEPARATED BY SPACE.
        IF ( NEWLINE CS '.' OR NEWLINE CS '*' ).
          APPEND NEWLINE TO INEWTABLE.
          CLEAR NEWLINE.
          FOUNDONE = FALSE.
        ENDIF.
      ENDIF.
    ELSE.
      REPLACE '!' IN <WALINE> WITH ''.
      APPEND <WALINE> TO INEWTABLE[].
    ENDIF.
  ENDLOOP.

  ITEMPLINES[] = INEWTABLE[].
ENDFORM.                    "reformatclasscode
"reFormatClassCode


*-----------------------------------------------------------------------
*  convertDDToHTML...   Convert text description to HTML
*-----------------------------------------------------------------------
FORM CONVERTDDTOHTML USING ILOCDICTSTRUCTURE LIKE DUMIDICTSTRUCTURE[]
                           ILOCHTML LIKE DUMIHTML[]
                           VALUE(TABLENAME)
                           VALUE(TABLETITLE)
                           VALUE(SORTTABLESASC).

  DATA: ICOLUMNCAPTIONS TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: WADICTIONARY TYPE TDICTTABLESTRUCTURE.
  DATA: WAHTML TYPE STRING.
  DATA: TITLE TYPE STRING.

  PERFORM BUILDCOLUMNHEADERS USING ICOLUMNCAPTIONS[].

* Add a html header to the table
  CONCATENATE 'Dictionary object-' TABLENAME INTO TITLE SEPARATED BY
SPACE.
  PERFORM ADDHTMLHEADER USING ILOCHTML[]
                              TITLE.

  CONCATENATE '<h2>' TABLENAME '</h2>' INTO WAHTML.
  APPEND WAHTML TO ILOCHTML.
  APPEND '' TO ILOCHTML.

  CONCATENATE '<h3>' TABLETITLE '</h3>' INTO WAHTML.
  APPEND WAHTML TO ILOCHTML.
  APPEND '' TO ILOCHTML.

* Do we need to sort the fields into alphabetical order
  IF NOT SORTTABLESASC IS INITIAL.
    SORT ILOCDICTSTRUCTURE ASCENDING BY FIELDNAME.
  ENDIF.

  PERFORM CONVERTITABTOHTML USING ICOLUMNCAPTIONS[]
                                  ILOCDICTSTRUCTURE[]
                                  ILOCHTML
                                  'X'
                                  COLOUR_BLACK
                                  ''
                                  COLOUR_YELLOW
                                  ''
                                  BACKGROUND_COLOUR
                                  'Arial'
                                  'green'
                                  '1'
                                  '1'.

* Add a html footer to the table
  APPEND '<br>' TO ILOCHTML.
  PERFORM ADDHTMLFOOTER USING ILOCHTML[].
ENDFORM.                    "convertddtohtml
"convertDDToHTML

*-----------------------------------------------------------------------
*  convertITABtoHtml... produces a html table from an internal table
*-----------------------------------------------------------------------
FORM CONVERTITABTOHTML USING ILOCHEADER LIKE DUMIHEADER[]
                             ILOCDICTSTRUCTURE LIKE DUMIDICTSTRUCTURE[]
                             ILOCHTML LIKE DUMIHTML[]
                             VALUE(INCLUDEROWCOUNT)
                             HEADINGBACKCOLOUR
                             HEADINGFONTNAME
                             HEADINGFONTCOLOUR
                             HEADINGFONTSIZE
                             BODYBACKCOLOUR
                             BODYFONTNAME
                             BODYFONTCOLOUR
                             BODYFONTSIZE
                             BORDERSIZE.

* Holds one cell from the internal table
  FIELD-SYMBOLS: <FSFIELD>.
* The value of one cell form the internal table
  DATA: WTEXTCELL TYPE STRING.
* work area for putting the CSV value into
  DATA: WACSVTABLE TYPE STRING.
* Have we used any font tags in the html code
  DATA: USEDAFONTATTRIBUTE TYPE I VALUE 0.
* Work area for HTML table
  DATA: WAHTML TYPE STRING.
* Loop counter for adding row numbers onto the output table
  DATA: LOOPCOUNTER TYPE STRING.
* Work area for header table
  FIELD-SYMBOLS: <WAHEADER> TYPE STRING.
  FIELD-SYMBOLS: <ILOCDICTSTRUCTURE> TYPE TDICTTABLESTRUCTURE.

  CONCATENATE '<table border="' BORDERSIZE '">' INTO WAHTML.
  APPEND WAHTML TO ILOCHTML.

  IF NOT ILOCHEADER[] IS INITIAL.
    APPEND '<tr>' TO ILOCHTML.
  ENDIF.

  LOOP AT ILOCHEADER ASSIGNING <WAHEADER>.
    IF HEADINGBACKCOLOUR IS INITIAL.
      WAHTML = '<th>'.
    ELSE.
      CONCATENATE '<th bgcolor="' HEADINGBACKCOLOUR '">' INTO WAHTML.
    ENDIF.

    IF NOT HEADINGFONTNAME IS INITIAL OR NOT HEADINGFONTCOLOUR IS
INITIAL OR NOT HEADINGFONTSIZE IS INITIAL.
      CONCATENATE WAHTML '<font' INTO WAHTML.

*      Add the font name
      IF NOT HEADINGFONTNAME IS INITIAL.
        CONCATENATE WAHTML ' face ="' INTO WAHTML.
        CONCATENATE WAHTML HEADINGFONTNAME '"' INTO WAHTML.
      ENDIF.

*      Add the font colour
      IF NOT HEADINGFONTCOLOUR IS INITIAL.
        CONCATENATE WAHTML ' color ="' INTO WAHTML.
        CONCATENATE WAHTML HEADINGFONTCOLOUR '"' INTO WAHTML.
      ENDIF.

*      Add the fontsize
      IF NOT HEADINGFONTSIZE IS INITIAL.
        CONCATENATE WAHTML' size ="' INTO WAHTML.
        CONCATENATE WAHTML  HEADINGFONTSIZE '"' INTO WAHTML.
      ENDIF.

      CONCATENATE WAHTML '>' INTO WAHTML.
      USEDAFONTATTRIBUTE = TRUE.
    ENDIF.

*   Add the caption name
    CONCATENATE WAHTML <WAHEADER> INTO WAHTML.

    IF USEDAFONTATTRIBUTE = TRUE.
      CONCATENATE WAHTML '</font>' INTO WAHTML.
      USEDAFONTATTRIBUTE = FALSE.
    ENDIF.

    CONCATENATE WAHTML '</th>' INTO WAHTML.
    APPEND WAHTML TO ILOCHTML.
  ENDLOOP.

  APPEND '</tr>' TO ILOCHTML.
  FREE ILOCHEADER.


*  Line item data
  LOOP AT ILOCDICTSTRUCTURE ASSIGNING <ILOCDICTSTRUCTURE>.

    LOOPCOUNTER = SY-TABIX.

    APPEND '' TO ILOCHTML.
    APPEND '<tr>' TO ILOCHTML.

*   Add the row count
    IF NOT INCLUDEROWCOUNT IS INITIAL.
      IF BODYBACKCOLOUR IS INITIAL.
        WAHTML = '<td>'.
      ELSE.
        CONCATENATE '<td bgcolor="' BODYBACKCOLOUR '">' INTO WAHTML.
      ENDIF.

      IF NOT BODYFONTNAME IS INITIAL OR NOT BODYFONTCOLOUR IS INITIAL OR
NOT BODYFONTSIZE IS INITIAL.
        CONCATENATE WAHTML '<font' INTO WAHTML.

*        Add the font name
        IF NOT BODYFONTNAME IS INITIAL.
          CONCATENATE WAHTML ' face ="' INTO WAHTML.
          CONCATENATE WAHTML BODYFONTNAME '"' INTO WAHTML.
        ENDIF.

*        Add the font colour
        IF NOT BODYFONTCOLOUR IS INITIAL.
          CONCATENATE WAHTML ' color ="' INTO WAHTML.
          CONCATENATE WAHTML BODYFONTCOLOUR '"' INTO WAHTML.
        ENDIF.

*        Add the fontsize
        IF NOT BODYFONTSIZE IS INITIAL.
          CONCATENATE WAHTML ' size ="' INTO WAHTML.
          CONCATENATE WAHTML BODYFONTSIZE '"' INTO WAHTML.
        ENDIF.

        CONCATENATE WAHTML '>' INTO WAHTML.
        USEDAFONTATTRIBUTE = TRUE.
      ENDIF.

*     Add the row number into the table
      CONCATENATE WAHTML LOOPCOUNTER INTO WAHTML.


      IF USEDAFONTATTRIBUTE = TRUE.
        CONCATENATE WAHTML '</font>' INTO WAHTML.
        USEDAFONTATTRIBUTE = FALSE.
      ENDIF.

      CONCATENATE WAHTML '</td>' INTO WAHTML.
      APPEND WAHTML TO ILOCHTML.
    ENDIF.

    DO.
*     Assign each field in the table to the field symbol
      ASSIGN COMPONENT SY-INDEX OF STRUCTURE <ILOCDICTSTRUCTURE> TO
<FSFIELD>.
      IF SY-SUBRC = 0.
        MOVE <FSFIELD> TO WTEXTCELL.

*       Cell data processing
        IF BODYBACKCOLOUR IS INITIAL.
          WAHTML = '<td>'.
        ELSE.
          CONCATENATE '<td bgcolor="' BODYBACKCOLOUR '">' INTO WAHTML.
        ENDIF.

        IF NOT BODYFONTNAME IS INITIAL OR NOT BODYFONTCOLOUR IS INITIAL
OR NOT BODYFONTSIZE IS INITIAL.
          CONCATENATE WAHTML '<font' INTO WAHTML.

*          Add the font name
          IF NOT BODYFONTNAME IS INITIAL.
            CONCATENATE WAHTML ' face ="' INTO WAHTML.
            CONCATENATE WAHTML BODYFONTNAME '"' INTO WAHTML.
          ENDIF.

*          Add the font colour
          IF NOT BODYFONTCOLOUR IS INITIAL.
            CONCATENATE WAHTML ' color ="' INTO WAHTML.
            CONCATENATE WAHTML BODYFONTCOLOUR '"' INTO WAHTML.
          ENDIF.

*          Add the fontsize
          IF NOT BODYFONTSIZE IS INITIAL.
            CONCATENATE WAHTML ' size ="' INTO WAHTML.
            CONCATENATE WAHTML BODYFONTSIZE '"' INTO WAHTML.
          ENDIF.

          CONCATENATE WAHTML '>' INTO WAHTML.
          USEDAFONTATTRIBUTE = TRUE.
        ENDIF.

*       Add the caption name
        IF WTEXTCELL IS INITIAL.
          CONCATENATE WAHTML '&nbsp;' INTO WAHTML.
        ELSE.
          CONCATENATE WAHTML WTEXTCELL INTO WAHTML.
        ENDIF.

        IF USEDAFONTATTRIBUTE = TRUE.
          CONCATENATE WAHTML '</font>' INTO WAHTML.
          USEDAFONTATTRIBUTE = FALSE.
        ENDIF.

        CONCATENATE WAHTML '</td>' INTO WAHTML.
        APPEND WAHTML TO ILOCHTML.
      ELSE.
        EXIT.
      ENDIF.
    ENDDO.

    APPEND '</tr>' TO ILOCHTML.
  ENDLOOP.

  APPEND '</table>' TO ILOCHTML.
ENDFORM.                    "convertitabtohtml
"convertITABtoHtml

*-----------------------------------------------------------------------
*  convertCodeToHtml... Builds an HTML table based upon a text table.
*-----------------------------------------------------------------------
FORM CONVERTCODETOHTML USING ICONTENTS LIKE DUMIHTML[]
                             VALUE(PROGRAMNAME)
                             VALUE(SHORTDESCRIPTION)
                             VALUE(SOURCECODETYPE)
                             VALUE(FUNCTIONDOCUMENTATIONEXISTS)
                             VALUE(ISMAINFUNCTIONINCLUDE)
                             VALUE(SYNTAXHIGHLIGHTCOMMENTS)
                             VALUE(HTMLEXTENSION)
                             VALUE(CUSTOMERNAMERANGE)
                             VALUE(GETINCLUDES)
                             VALUE(GETDICTSTRUCTURES).

  DATA: HTMLTABLE TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: LISTINGNAME TYPE STRING VALUE 'Code listing for:'.
  DATA: DESCRIPTIONNAME TYPE STRING VALUE `Description: `.
  DATA: HEAD(255).
  DATA: TAIL(255).
  DATA: MYTABIX TYPE SYTABIX.
  DATA: NEXTLINE TYPE SYTABIX.
  DATA: HYPERLINKNAME TYPE STRING.
  DATA: COPYOFCURRENTLINE TYPE STRING.
  DATA: CURRENTLINELENGTH TYPE I VALUE 0.
  DATA: COPYLINELENGTH TYPE I VALUE 0.
  DATA: IGNOREFUTURELINES TYPE I VALUE FALSE.
  DATA: FOUNDASTERIX TYPE I VALUE FALSE.
  DATA: LOWERCASELINK TYPE STRING.
  DATA: WANEXTLINE TYPE STRING.
  DATA: WACONTENT(255).

* Add a html header to the table
  PERFORM ADDHTMLHEADER USING HTMLTABLE[]
                              PROGRAMNAME.

  CONCATENATE LISTINGNAME PROGRAMNAME INTO LISTINGNAME SEPARATED BY
SPACE.
  CONCATENATE
  '<font size="3" face = "Arial" color="' COLOUR_BLACK '"><b>'
LISTINGNAME '</b></font>' INTO HTMLTABLE.
  APPEND HTMLTABLE.

  IF NOT SHORTDESCRIPTION IS INITIAL.
    APPEND '<br>' TO HTMLTABLE.
    CONCATENATE DESCRIPTIONNAME SHORTDESCRIPTION INTO DESCRIPTIONNAME
SEPARATED BY SPACE.
    CONCATENATE
    '<font size="3" face = "Arial" color="' COLOUR_BLACK '"><b>'
DESCRIPTIONNAME '</b></font>' INTO HTMLTABLE.
    APPEND HTMLTABLE.
  ENDIF.

  HTMLTABLE = '<hr>'.
  APPEND HTMLTABLE.

  HTMLTABLE = '<pre width="100">'.
  APPEND HTMLTABLE.

  LOOP AT ICONTENTS INTO WACONTENT.
    MYTABIX = SY-TABIX.

    IF NOT ( ICONTENTS IS INITIAL ).
      WHILE ( WACONTENT CS '<' OR WACONTENT CS '>' ).
        REPLACE '<' IN WACONTENT WITH LT.
        REPLACE '>' IN WACONTENT WITH GT.
      ENDWHILE.

      IF WACONTENT+0(1) <> ASTERIX.
        CURRENTLINELENGTH = STRLEN( WACONTENT ).
        COPYOFCURRENTLINE = WACONTENT.

*       Don't hyperlink anything for files of type documentation
        IF SOURCECODETYPE <> IS_DOCUMENTATION.
*         Check for any functions to highlight
          IF ( WACONTENT CS CALLFUNCTION ) AND ( WACONTENT <>
'DESTINATION' ).
            NEXTLINE = MYTABIX + 1.
            READ TABLE ICONTENTS INTO WANEXTLINE INDEX NEXTLINE.
            TRANSLATE WANEXTLINE TO UPPER CASE.
            IF WANEXTLINE NS 'DESTINATION'.
              SHIFT COPYOFCURRENTLINE LEFT DELETING LEADING SPACE.

              COPYLINELENGTH = STRLEN( COPYOFCURRENTLINE ).

              SPLIT COPYOFCURRENTLINE AT SPACE INTO HEAD TAIL.
              SPLIT TAIL AT SPACE INTO HEAD TAIL.
              SPLIT TAIL AT SPACE INTO HEAD TAIL.
*             Function name is now in head
              TRANSLATE HEAD USING ''' '.
              SHIFT HEAD LEFT DELETING LEADING SPACE.

              TRY.
                  IF HEAD+0(1) = 'Y' OR HEAD+0(1) = 'Z' OR HEAD+0(1) =
  'y' OR HEAD+0(1) = 'z' OR HEAD CS CUSTOMERNAMERANGE.
*                 Definately a customer function module
                    HYPERLINKNAME = HEAD.

                    IF SOURCECODETYPE = IS_FUNCTION.
                      COPYOFCURRENTLINE = 'call function <a href ="../'.
                    ELSE.
                      COPYOFCURRENTLINE = 'call function <a href ="'.
                    ENDIF.

                    LOWERCASELINK = HYPERLINKNAME.
                    TRANSLATE LOWERCASELINK TO LOWER CASE.
*                 If we are running on a non UNIX environment we will
*need to remove forward slashes
                    IF FRONTENDOPSYSTEM = NON_UNIX.
                      TRANSLATE LOWERCASELINK USING '/_'.
                    ENDIF.

                    CONCATENATE COPYOFCURRENTLINE
                                LOWERCASELINK     "hyperlinkName
                                '/'
                                LOWERCASELINK     "hyperlinkName
                                PERIOD HTMLEXTENSION '">'
                                ''''
                                HYPERLINKNAME
                                ''''
                                '</a>'
                                TAIL INTO COPYOFCURRENTLINE.

*                 Pad the string back out with spaces
                    WHILE COPYLINELENGTH < CURRENTLINELENGTH.
                      SHIFT COPYOFCURRENTLINE RIGHT BY 1 PLACES.
                      COPYLINELENGTH = COPYLINELENGTH + 1.
                    ENDWHILE.

                    WACONTENT = COPYOFCURRENTLINE.
                  ENDIF.
                CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
              ENDTRY.
            ENDIF.
          ENDIF.
        ENDIF.

*       Check for any customer includes to hyperlink
        IF WACONTENT CS INCLUDE OR WACONTENT CS LOWINCLUDE.
          SHIFT COPYOFCURRENTLINE LEFT DELETING LEADING SPACE.
          COPYLINELENGTH = STRLEN( COPYOFCURRENTLINE ).

          SPLIT COPYOFCURRENTLINE AT SPACE INTO HEAD TAIL.
          SHIFT TAIL LEFT DELETING LEADING SPACE.

          TRY.
              IF ( TAIL+0(1) = 'Y' OR TAIL+0(1) = 'Z' OR TAIL+0(1) = 'y'
  OR TAIL+0(1) = 'z' OR TAIL CS CUSTOMERNAMERANGE OR TAIL+0(2) = 'mz' OR
  TAIL+0(2) = 'MZ' )
                  AND NOT GETINCLUDES IS INITIAL AND  TAIL NS STRUCTURE
  AND TAIL NS LOWSTRUCTURE.

*             Hyperlink for program includes
                CLEAR WACONTENT.
                SHIFT TAIL LEFT DELETING LEADING SPACE.
                SPLIT TAIL AT PERIOD INTO HYPERLINKNAME TAIL.
                COPYOFCURRENTLINE = 'include <a href ="'.

                LOWERCASELINK = HYPERLINKNAME.
                TRANSLATE LOWERCASELINK TO LOWER CASE.

*             If we are running on a non UNIX environment we will need
*to remove forward slashes
                IF FRONTENDOPSYSTEM = NON_UNIX.
                  TRANSLATE LOWERCASELINK USING '/_'.
                ENDIF.

                CONCATENATE COPYOFCURRENTLINE
                            LOWERCASELINK       "hyperlinkName
                            PERIOD HTMLEXTENSION '">'
                            HYPERLINKNAME
                            '</a>'
                            PERIOD TAIL INTO COPYOFCURRENTLINE.

*             Pad the string back out with spaces
                WHILE COPYLINELENGTH < CURRENTLINELENGTH.
                  SHIFT COPYOFCURRENTLINE RIGHT BY 1 PLACES.
                  COPYLINELENGTH = COPYLINELENGTH + 1.
                ENDWHILE.
                WACONTENT = COPYOFCURRENTLINE.
              ELSE.
                IF NOT GETDICTSTRUCTURES IS INITIAL.
*              Hyperlink for structure include e.g. "include structure
*zfred."
                  COPYLINELENGTH = STRLEN( COPYOFCURRENTLINE ).
                  SPLIT COPYOFCURRENTLINE AT SPACE INTO HEAD TAIL.
                  SHIFT TAIL LEFT DELETING LEADING SPACE.
                  SPLIT TAIL AT SPACE INTO HEAD TAIL.

                  TRY.
                      IF TAIL+0(1) = 'Y' OR TAIL+0(1) = 'Z' OR TAIL+0(1) =
     'y' OR TAIL+0(1) = 'z' OR TAIL CS CUSTOMERNAMERANGE.
                        CLEAR WACONTENT.
                        SHIFT TAIL LEFT DELETING LEADING SPACE.
                        SPLIT TAIL AT PERIOD INTO HYPERLINKNAME TAIL.
                        COPYOFCURRENTLINE = 'include structure <a href ='.

                        LOWERCASELINK = HYPERLINKNAME.
                        TRANSLATE LOWERCASELINK TO LOWER CASE.
*                  If we are running on a non UNIX environment we will
*need to remove forward slashes
                        IF FRONTENDOPSYSTEM = NON_UNIX.
                          TRANSLATE LOWERCASELINK USING '/_'.
                        ENDIF.

                        CONCATENATE COPYOFCURRENTLINE
                                    '"'
                                    LOWERCASELINK    "hyperlinkName
                                    '/'
                                    'dictionary-'
                                    LOWERCASELINK    "hyperlinkName
                                    PERIOD HTMLEXTENSION
                                    '">'
                                    HYPERLINKNAME
                                    '</a>'
                                    PERIOD TAIL INTO COPYOFCURRENTLINE.

*                  Pad the string back out with spaces
                        WHILE COPYLINELENGTH < CURRENTLINELENGTH.
                          SHIFT COPYOFCURRENTLINE RIGHT BY 1 PLACES.
                          COPYLINELENGTH = COPYLINELENGTH + 1.
                        ENDWHILE.
                        WACONTENT = COPYOFCURRENTLINE.
                      ENDIF.
                    CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
                  ENDTRY.
                ENDIF.
              ENDIF.
            CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
          ENDTRY.
        ENDIF.
      ELSE.
        IF NOT SYNTAXHIGHLIGHTCOMMENTS IS INITIAL AND WACONTENT+0(1) =
 ASTERIX.
          CONCATENATE '<font color ="' COMMENT_COLOUR '">' INTO HEAD.
          CONCATENATE HEAD WACONTENT '</font>' INTO TAIL.
          WACONTENT = TAIL.
        ENDIF.
      ENDIF.

      HTMLTABLE = WACONTENT.

    ELSE.
      HTMLTABLE = ''.
    ENDIF.
    APPEND HTMLTABLE.
  ENDLOOP.

  HTMLTABLE = '</pre>'.
  APPEND HTMLTABLE.

* Add a html footer to the table
  PERFORM ADDHTMLFOOTER USING HTMLTABLE[].

  ICONTENTS[] = HTMLTABLE[].
ENDFORM.                    "convertcodetohtml
"convertCodeToHtml

*-----------------------------------------------------------------------
*  convertClassToHtml... Builds an HTML table based upon a text table.
*-----------------------------------------------------------------------
FORM CONVERTCLASSTOHTML USING ICONTENTS LIKE DUMIHTML[]
                              VALUE(CLASSNAME)
                              VALUE(SHORTDESCRIPTION)
                              VALUE(SOURCECODETYPE)
                              VALUE(SYNTAXHIGHLIGHTCOMMENTS)
                              VALUE(HTMLEXTENSION)
                              VALUE(CUSTOMERNAMERANGE)
                              VALUE(GETDICTSTRUCTURES).

  DATA: HTMLTABLE TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: LISTINGNAME TYPE STRING VALUE 'Code listing for class:'.
  DATA: DESCRIPTIONNAME TYPE STRING VALUE `Description: `.
  DATA: MYTABIX TYPE SYTABIX.
  DATA: WACONTENT(255).
  DATA: HEAD TYPE STRING.
  DATA: TAIL TYPE STRING.
  DATA: HYPERLINKNAME TYPE STRING.
  DATA: LOWERCASELINK TYPE STRING.
  DATA: COPYOFCURRENTLINE TYPE STRING.
  DATA: CURRENTLINELENGTH TYPE I VALUE 0.
  DATA: COPYLINELENGTH TYPE I VALUE 0.

* Add a html header to the table
  PERFORM ADDHTMLHEADER USING HTMLTABLE[]
                              CLASSNAME.

  CONCATENATE LISTINGNAME CLASSNAME INTO LISTINGNAME SEPARATED BY SPACE.
  CONCATENATE
  '<font size="3" face = "Arial" color="' COLOUR_BLACK '"><b>'
LISTINGNAME '</b></font>' INTO HTMLTABLE.
  APPEND HTMLTABLE.

  IF NOT SHORTDESCRIPTION IS INITIAL.
    APPEND '<br>' TO HTMLTABLE.
    CONCATENATE DESCRIPTIONNAME SHORTDESCRIPTION INTO DESCRIPTIONNAME
SEPARATED BY SPACE.
    CONCATENATE
    '<font size="3" face = "Arial" color="' COLOUR_BLACK '"><b>'
DESCRIPTIONNAME '</b></font>' INTO HTMLTABLE.
    APPEND HTMLTABLE.
  ENDIF.

  HTMLTABLE = '<hr>'.
  APPEND HTMLTABLE.

  HTMLTABLE = '<pre width="100">'.
  APPEND HTMLTABLE.

  LOOP AT ICONTENTS INTO WACONTENT.
    MYTABIX = SY-TABIX.

*   Comments
    IF NOT SYNTAXHIGHLIGHTCOMMENTS IS INITIAL AND
    WACONTENT+0(1) = ASTERIX.
      CONCATENATE
      '<font color ="' COMMENT_COLOUR '">' INTO HEAD.
      CONCATENATE HEAD WACONTENT '</font>' INTO WACONTENT.
      HTMLTABLE = WACONTENT.
    ELSE.
*     Smaller than, greater than signs
      IF NOT ( ICONTENTS IS INITIAL ).
        WHILE ( WACONTENT CS '<' OR WACONTENT CS '>' ).
          REPLACE '<' IN WACONTENT WITH LT.
          REPLACE '>' IN WACONTENT WITH GT.
        ENDWHILE.

*       Dictionary structures
        IF NOT GETDICTSTRUCTURES IS INITIAL.
          FIND 'class' IN WACONTENT IGNORING CASE.
          IF SY-SUBRC <> 0.
*           Hyperlink for dictionary/structure include
            COPYLINELENGTH = STRLEN( WACONTENT ).
            COPYOFCURRENTLINE = WACONTENT.
            SPLIT COPYOFCURRENTLINE AT SPACE INTO HEAD TAIL.
            SHIFT TAIL LEFT DELETING LEADING SPACE.
            SPLIT TAIL AT SPACE INTO HEAD TAIL.

            TRY.
                IF TAIL+0(1) = 'Y' OR TAIL+0(1) = 'Z' OR TAIL+0(1) = 'y'
  OR TAIL+0(1) = 'z' OR TAIL CS CUSTOMERNAMERANGE.
                  CLEAR WACONTENT.
                  SHIFT TAIL LEFT DELETING LEADING SPACE.
                  SPLIT TAIL AT PERIOD INTO HYPERLINKNAME TAIL.
                  COPYOFCURRENTLINE = 'include structure <a href ='.

                  LOWERCASELINK = HYPERLINKNAME.
                  TRANSLATE LOWERCASELINK TO LOWER CASE.
*               If we are running on a non UNIX environment we will need
*to remove forward slashes
                  IF FRONTENDOPSYSTEM = NON_UNIX.
                    TRANSLATE LOWERCASELINK USING '/_'.
                  ENDIF.

                  CONCATENATE COPYOFCURRENTLINE
                              '"'
                              LOWERCASELINK    "hyperlinkName
                              '/'
                              'dictionary-'
                              LOWERCASELINK    "hyperlinkName
                              PERIOD HTMLEXTENSION
                              '">'
                              HYPERLINKNAME
                              '</a>'
                              PERIOD TAIL INTO COPYOFCURRENTLINE.

*               Pad the string back out with spaces
                  WHILE COPYLINELENGTH < CURRENTLINELENGTH.
                    SHIFT COPYOFCURRENTLINE RIGHT BY 1 PLACES.
                    COPYLINELENGTH = COPYLINELENGTH + 1.
                  ENDWHILE.
                  WACONTENT = COPYOFCURRENTLINE.
                ENDIF.
              CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
            ENDTRY.
          ENDIF.
        ENDIF.

        HTMLTABLE = WACONTENT.
      ELSE.
        HTMLTABLE = ''.
      ENDIF.
    ENDIF.

    APPEND HTMLTABLE.
  ENDLOOP.

  HTMLTABLE = '</pre>'.
  APPEND HTMLTABLE.

* Add a html footer to the table
  PERFORM ADDHTMLFOOTER USING HTMLTABLE[].

  ICONTENTS[] = HTMLTABLE[].
ENDFORM.                    "convertclasstohtml
"convertClassToHtml

*-----------------------------------------------------------------------
*  convertFunctionToHtml... Builds an HTML table based upon a text
*-----------------------------------------------------------------------
FORM CONVERTFUNCTIONTOHTML USING ICONTENTS LIKE DUMIHTML[]
                                 VALUE(FUNCTIONNAME)
                                 VALUE(SHORTDESCRIPTION)
                                 VALUE(SOURCECODETYPE)
                                 VALUE(FUNCTIONDOCUMENTATIONEXISTS)
                                 VALUE(ISMAINFUNCTIONINCLUDE)
                                 VALUE(SYNTAXHIGHLIGHTCOMMENTS)
                                 VALUE(HTMLEXTENSION)
                                 VALUE(CUSTOMERNAMERANGE)
                                 VALUE(GETINCLUDES)
                                 VALUE(GETDICTSTRUCTURES).

  DATA: HTMLTABLE TYPE STANDARD TABLE OF STRING WITH HEADER LINE.
  DATA: LISTINGNAME TYPE STRING VALUE 'Code listing for function:'.
  DATA: DESCRIPTIONNAME TYPE STRING VALUE `Description: `.
  DATA: HEAD(255).
  DATA: TAIL(255).
  DATA: MYTABIX TYPE SYTABIX.
  DATA: NEXTLINE TYPE SYTABIX.
  DATA: HYPERLINKNAME TYPE STRING.
  DATA: COPYOFCURRENTLINE TYPE STRING.
  DATA: CURRENTLINELENGTH TYPE I VALUE 0.
  DATA: COPYLINELENGTH TYPE I VALUE 0.
  DATA: IGNOREFUTURELINES TYPE I VALUE FALSE.
  DATA: FOUNDASTERIX TYPE I VALUE FALSE.
  DATA: LOWERCASELINK TYPE STRING.
  DATA: WANEXTLINE TYPE STRING.
  DATA: WACONTENT(255).

* Add a html header to the table
  PERFORM ADDHTMLHEADER USING HTMLTABLE[]
                              FUNCTIONNAME.

  CONCATENATE LISTINGNAME FUNCTIONNAME INTO LISTINGNAME SEPARATED BY
SPACE.
  CONCATENATE
  '<font size="3" face = "Arial" color="' COLOUR_BLACK '"><b>'
LISTINGNAME '</b></font>' INTO HTMLTABLE.
  APPEND HTMLTABLE.

  IF NOT SHORTDESCRIPTION IS INITIAL.
    APPEND '<br>' TO HTMLTABLE.
    CONCATENATE DESCRIPTIONNAME SHORTDESCRIPTION INTO
    DESCRIPTIONNAME SEPARATED BY SPACE.
    CONCATENATE
    '<font size="3" face = "Arial" color="' COLOUR_BLACK '"><b>'
DESCRIPTIONNAME '</b></font>' INTO HTMLTABLE.
    APPEND HTMLTABLE.
  ENDIF.

  HTMLTABLE = '<hr>'.
  APPEND HTMLTABLE.

  HTMLTABLE = '<pre width="100">'.
  APPEND HTMLTABLE.

  LOOP AT ICONTENTS INTO WACONTENT.
    MYTABIX = SY-TABIX.

*   Extra code for adding global and doc hyperlinks to functions
    IF SOURCECODETYPE = IS_FUNCTION AND ISMAINFUNCTIONINCLUDE = TRUE.
      IF SY-TABIX > 1.
        IF WACONTENT+0(1) = ASTERIX AND IGNOREFUTURELINES = FALSE.
          FOUNDASTERIX = TRUE.
        ELSE.
          IF FOUNDASTERIX = TRUE.
*           Lets add our extra HTML lines in here
            APPEND '' TO HTMLTABLE.

*           Global data hyperlink
            IF NOT SYNTAXHIGHLIGHTCOMMENTS IS INITIAL.
              CONCATENATE '<font color ="' COMMENT_COLOUR '">' INTO
COPYOFCURRENTLINE.
            ENDIF.

            CONCATENATE COPYOFCURRENTLINE '*       <a href ="' INTO
COPYOFCURRENTLINE.
            LOWERCASELINK = FUNCTIONNAME.
            TRANSLATE LOWERCASELINK TO LOWER CASE.
*           If we are running on a non UNIX environment we will need to
*remove forward slashes
            IF FRONTENDOPSYSTEM = NON_UNIX.
              TRANSLATE LOWERCASELINK USING '/_'.
            ENDIF.

            CONCATENATE COPYOFCURRENTLINE 'global-' LOWERCASELINK
                        PERIOD HTMLEXTENSION '">'
    'Global data declarations' '</a>' INTO COPYOFCURRENTLINE.

            IF NOT SYNTAXHIGHLIGHTCOMMENTS IS INITIAL.
              CONCATENATE COPYOFCURRENTLINE '</font>' INTO
COPYOFCURRENTLINE.
            ENDIF.

            APPEND COPYOFCURRENTLINE TO HTMLTABLE.

*           Documentation hyperlink.
            IF FUNCTIONDOCUMENTATIONEXISTS = TRUE.
              IF NOT SYNTAXHIGHLIGHTCOMMENTS IS INITIAL.
                CONCATENATE '<font color ="' COMMENT_COLOUR '">' INTO
COPYOFCURRENTLINE.
              ENDIF.

              CONCATENATE COPYOFCURRENTLINE '*       <a href ="' INTO
COPYOFCURRENTLINE.

              LOWERCASELINK = FUNCTIONNAME.
              TRANSLATE LOWERCASELINK TO LOWER CASE.
*             If we are running on a non UNIX environment we will need
*to remove forward slashes
              IF FRONTENDOPSYSTEM = NON_UNIX.
                TRANSLATE LOWERCASELINK USING '/_'.
              ENDIF.

              CONCATENATE COPYOFCURRENTLINE
                          'docs-'
                          LOWERCASELINK  "functionName
                          PERIOD HTMLEXTENSION '">'
                          'Function module documentation'
                          '</a>'
                          INTO COPYOFCURRENTLINE.

              IF NOT PCOMM IS INITIAL.
                CONCATENATE COPYOFCURRENTLINE '</font>' INTO
COPYOFCURRENTLINE.
              ENDIF.
              APPEND COPYOFCURRENTLINE TO HTMLTABLE.
            ENDIF.

            FOUNDASTERIX = FALSE.
            IGNOREFUTURELINES = TRUE.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

*   Carry on as normal
    IF NOT ( ICONTENTS IS INITIAL ).
      WHILE ( WACONTENT CS '<' OR WACONTENT CS '>' ).
        REPLACE '<' IN WACONTENT WITH LT.
        REPLACE '>' IN WACONTENT WITH GT.
      ENDWHILE.

      IF WACONTENT+0(1) <> ASTERIX.
        CURRENTLINELENGTH = STRLEN( WACONTENT ).

*       Don't hyperlink anything for files of type documentation
        IF SOURCECODETYPE <> IS_DOCUMENTATION.
*       Check for any functions to highlight
          IF ( WACONTENT CS CALLFUNCTION ) AND ( WACONTENT <>
'DESTINATION' ).
            NEXTLINE = MYTABIX + 1.
            READ TABLE ICONTENTS INTO WANEXTLINE INDEX NEXTLINE.
            TRANSLATE WANEXTLINE TO UPPER CASE.
            IF WANEXTLINE NS 'DESTINATION'.
              COPYOFCURRENTLINE = WACONTENT.
              SHIFT COPYOFCURRENTLINE LEFT DELETING LEADING SPACE.

              COPYLINELENGTH = STRLEN( COPYOFCURRENTLINE ).

              SPLIT COPYOFCURRENTLINE AT SPACE INTO HEAD TAIL.
              SPLIT TAIL AT SPACE INTO HEAD TAIL.
              SPLIT TAIL AT SPACE INTO HEAD TAIL.
*             Function name is now in head
              TRANSLATE HEAD USING ''' '.
              SHIFT HEAD LEFT DELETING LEADING SPACE.

              TRY.
                  IF HEAD+0(1) = 'Y' OR HEAD+0(1) = 'Z' OR HEAD+0(1) =
  'y' OR HEAD+0(1) = 'z' OR HEAD CS CUSTOMERNAMERANGE.

*                 Definately a customer function module
                    HYPERLINKNAME = HEAD.

                    IF SOURCECODETYPE = IS_FUNCTION.
                      COPYOFCURRENTLINE = 'call function <a href ="../'.
                    ELSE.
                      COPYOFCURRENTLINE = 'call function <a href ="'.
                    ENDIF.

                    LOWERCASELINK = HYPERLINKNAME.
                    TRANSLATE LOWERCASELINK TO LOWER CASE.
*                 If we are running on a non UNIX environment we will
*need to remove forward slashes
                    IF FRONTENDOPSYSTEM = NON_UNIX.
                      TRANSLATE LOWERCASELINK USING '/_'.
                    ENDIF.

                    CONCATENATE COPYOFCURRENTLINE
                                LOWERCASELINK     "hyperlinkName
                                '/'
                                LOWERCASELINK     "hyperlinkName
                                PERIOD HTMLEXTENSION '">'
                                ''''
                                HYPERLINKNAME
                                ''''
                                '</a>'
                                TAIL INTO COPYOFCURRENTLINE.

*                 Pad the string back out with spaces
                    WHILE COPYLINELENGTH < CURRENTLINELENGTH.
                      SHIFT COPYOFCURRENTLINE RIGHT BY 1 PLACES.
                      COPYLINELENGTH = COPYLINELENGTH + 1.
                    ENDWHILE.

                    WACONTENT = COPYOFCURRENTLINE.
                  ENDIF.
                CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
              ENDTRY.
            ENDIF.
          ENDIF.
        ENDIF.

*       Check for any customer includes to hyperlink
        IF WACONTENT CS INCLUDE OR WACONTENT CS LOWINCLUDE.
          COPYOFCURRENTLINE = WACONTENT.

          SHIFT COPYOFCURRENTLINE LEFT DELETING LEADING SPACE.
          COPYLINELENGTH = STRLEN( COPYOFCURRENTLINE ).

          SPLIT COPYOFCURRENTLINE AT SPACE INTO HEAD TAIL.
          SHIFT TAIL LEFT DELETING LEADING SPACE.

          TRY.
              IF ( TAIL+0(1) = 'Y' OR TAIL+0(1) = 'Z' OR TAIL+0(1) = 'y'
  OR TAIL+0(1) = 'z'
                   OR TAIL CS CUSTOMERNAMERANGE OR TAIL+0(2) = 'mz' OR
  TAIL+0(2) = 'MZ' ) AND NOT GETINCLUDES IS INITIAL.

*             Hyperlink for program includes
                CLEAR WACONTENT.
                SHIFT TAIL LEFT DELETING LEADING SPACE.
                SPLIT TAIL AT PERIOD INTO HYPERLINKNAME TAIL.
                COPYOFCURRENTLINE = 'include <a href ="'.

                LOWERCASELINK = HYPERLINKNAME.
                TRANSLATE LOWERCASELINK TO LOWER CASE.
*             If we are running on a non UNIX environment we will need
*to remove forward slashes
                IF FRONTENDOPSYSTEM = NON_UNIX.
                  TRANSLATE LOWERCASELINK USING '/_'.
                ENDIF.

                CONCATENATE COPYOFCURRENTLINE
                            LOWERCASELINK       "hyperlinkName
                            PERIOD HTMLEXTENSION '">'
                            HYPERLINKNAME
                            '</a>'
                            PERIOD TAIL INTO COPYOFCURRENTLINE.

*             Pad the string back out with spaces
                WHILE COPYLINELENGTH < CURRENTLINELENGTH.
                  SHIFT COPYOFCURRENTLINE RIGHT BY 1 PLACES.
                  COPYLINELENGTH = COPYLINELENGTH + 1.
                ENDWHILE.
                WACONTENT = COPYOFCURRENTLINE.
              ELSE.
                IF NOT GETDICTSTRUCTURES IS INITIAL.
*               Hyperlink for structure include
                  COPYLINELENGTH = STRLEN( COPYOFCURRENTLINE ).
                  SPLIT COPYOFCURRENTLINE AT SPACE INTO HEAD TAIL.
                  SHIFT TAIL LEFT DELETING LEADING SPACE.
                  SPLIT TAIL AT SPACE INTO HEAD TAIL.

                  TRY.
                      IF TAIL+0(1) = 'Y' OR TAIL+0(1) = 'Z' OR TAIL+0(1) =
    'y' OR TAIL+0(1) = 'z' OR TAIL CS CUSTOMERNAMERANGE.
                        CLEAR WACONTENT.
                        SHIFT TAIL LEFT DELETING LEADING SPACE.
                        SPLIT TAIL AT PERIOD INTO HYPERLINKNAME TAIL.
                        COPYOFCURRENTLINE = 'include structure <a href ='.

                        LOWERCASELINK = HYPERLINKNAME.
                        TRANSLATE LOWERCASELINK TO LOWER CASE.
*                   If we are running on a non UNIX environment we will
*need to remove forward slashes
                        IF FRONTENDOPSYSTEM = NON_UNIX.
                          TRANSLATE LOWERCASELINK USING '/_'.
                        ENDIF.

                        CONCATENATE COPYOFCURRENTLINE
                                    '"'
                                    LOWERCASELINK    "hyperlinkName
                                    '/'
                                    'dictionary-'
                                    LOWERCASELINK    "hyperlinkName
                                    PERIOD HTMLEXTENSION
                                    '">'
                                    HYPERLINKNAME
                                    '</a>'
                                    PERIOD TAIL INTO COPYOFCURRENTLINE.

*                   Pad the string back out with spaces
                        WHILE COPYLINELENGTH < CURRENTLINELENGTH.
                          SHIFT COPYOFCURRENTLINE RIGHT BY 1 PLACES.
                          COPYLINELENGTH = COPYLINELENGTH + 1.
                        ENDWHILE.
                        WACONTENT = COPYOFCURRENTLINE.
                      ENDIF.
                    CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
                  ENDTRY.
                ENDIF.
              ENDIF.
            CATCH CX_SY_RANGE_OUT_OF_BOUNDS INTO OBJRUNTIMEERROR.
          ENDTRY.
        ENDIF.
      ELSE.
        IF NOT SYNTAXHIGHLIGHTCOMMENTS IS INITIAL AND WACONTENT+0(1) =
 ASTERIX.
          CONCATENATE '<font color ="' COMMENT_COLOUR '">' INTO HEAD.
          CONCATENATE HEAD WACONTENT '</font>' INTO TAIL.
          WACONTENT = TAIL.
        ENDIF.
      ENDIF.

      HTMLTABLE = WACONTENT.

    ELSE.
      HTMLTABLE = ''.
    ENDIF.
    APPEND HTMLTABLE.
  ENDLOOP.

  HTMLTABLE = '</pre>'.
  APPEND HTMLTABLE.

* Add a html footer to the table
  PERFORM ADDHTMLFOOTER USING HTMLTABLE[].

  ICONTENTS[] = HTMLTABLE[].
ENDFORM.                    "convertfunctiontohtml
"convertFunctionToHtml

*-----------------------------------------------------------------------
*  buildColumnHeaders... build table column names
*-----------------------------------------------------------------------
FORM BUILDCOLUMNHEADERS USING ILOCCOLUMNCAPTIONS LIKE DUMIHTML[].

  APPEND 'Row' TO ILOCCOLUMNCAPTIONS.
  APPEND 'Field name' TO ILOCCOLUMNCAPTIONS.
  APPEND 'Position' TO ILOCCOLUMNCAPTIONS.
  APPEND 'Key' TO ILOCCOLUMNCAPTIONS.
  APPEND 'Data element' TO ILOCCOLUMNCAPTIONS.
  APPEND 'Domain' TO ILOCCOLUMNCAPTIONS.
  APPEND 'Datatype' TO ILOCCOLUMNCAPTIONS.
  APPEND 'Length' TO ILOCCOLUMNCAPTIONS.
  APPEND 'Domain text' TO ILOCCOLUMNCAPTIONS.
ENDFORM.                    "buildcolumnheaders
"buildColumnHeaders

*-----------------------------------------------------------------------
* addHTMLHeader...  add a html formatted header to our output table
*-----------------------------------------------------------------------
FORM ADDHTMLHEADER USING ILOCHEADER LIKE DUMIHTML[]
                         VALUE(TITLE).

  DATA: WAHEADER TYPE STRING.

  APPEND '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">' TO
ILOCHEADER.
  APPEND '<html>' TO ILOCHEADER.
  APPEND '<head>' TO ILOCHEADER.

  CONCATENATE '<title>' TITLE '</title>' INTO WAHEADER.
  APPEND WAHEADER TO ILOCHEADER.

  APPEND '</head>' TO ILOCHEADER.

  IF NOT PBACK IS INITIAL.
    CONCATENATE '<body bgcolor="' BACKGROUND_COLOUR '">' INTO WAHEADER.
  ELSE.
    CONCATENATE '<body bgcolor="' COLOUR_WHITE '">' INTO WAHEADER.
  ENDIF.

  APPEND WAHEADER TO ILOCHEADER.
ENDFORM.                    "addhtmlheader
"addHTMLHeader

*-----------------------------------------------------------------------
* addHTMLFooter...  add a html formatted footer to our output table
*-----------------------------------------------------------------------
FORM ADDHTMLFOOTER USING ILOCFOOTER LIKE DUMIHTML[].

  DATA: FOOTERMESSAGE TYPE STRING.
  DATA: WAFOOTER TYPE STRING.

  PERFORM BUILDFOOTERMESSAGE USING 'HTML'
                                   FOOTERMESSAGE.

  APPEND '<hr>' TO ILOCFOOTER.
  CONCATENATE '<font size="2" face = "Sans Serif">' FOOTERMESSAGE INTO
WAFOOTER.
  APPEND WAFOOTER TO ILOCFOOTER.
  APPEND '</font>' TO ILOCFOOTER.
  APPEND '</body>' TO ILOCFOOTER.
  APPEND '</html>' TO ILOCFOOTER.
ENDFORM.                    "addhtmlfooter
"addHTMLFooter

*-----------------------------------------------------------------------
* buildFooterMessage...Returns a footer message based on the output file
FORM BUILDFOOTERMESSAGE USING FILETYPE
                              RETURNMESSAGE.

  IF FILETYPE = 'HTML'.
    CONCATENATE `Extracted by Direct Download Enterprise version `
  VERSIONNO ` - E.G.Mellodew. 1998-2005 UK. Sap Release ` SY-SAPRL
                INTO RETURNMESSAGE.
  ELSE.
    CONCATENATE `Extracted by Direct Download Enterprise version `
  VERSIONNO ` - E.G.Mellodew. 1998-2005 UK. Sap Release ` SY-SAPRL
                INTO RETURNMESSAGE.
  ENDIF.
ENDFORM.                    "buildfootermessage
"buildFooterMessage

************************************************************************
***********************************************

*-----------------------------------------------------------------------
*  fillTreeNodeTables...
*-----------------------------------------------------------------------
FORM FILLTREENODETABLES USING ILOCDICTIONARY LIKE IDICTIONARY[]
                              ILOCTREEDISPLAY LIKE ITREEDISPLAY[]
                              VALUE(RUNTIME).

  DATA: TABLELINES TYPE I.
  DATA: WATREEDISPLAY LIKE SNODETEXT.
  FIELD-SYMBOLS: <WADICTIONARY> TYPE TDICTTABLE.
  DATA: TABLELINESSTRING TYPE STRING.
  DATA: RUNTIMECHAR(10).
  DATA: SUBLEVEL TYPE STRING.

  TABLELINES = LINES( ILOCDICTIONARY ).
  TABLELINESSTRING = TABLELINES.

  IF TABLELINES = 1.
    CONCATENATE TABLELINESSTRING 'table downloaded'
    INTO WATREEDISPLAY-TEXT2 SEPARATED BY SPACE.
  ELSE.
    CONCATENATE TABLELINESSTRING 'tables downloaded'
    INTO WATREEDISPLAY-TEXT2 SEPARATED BY SPACE.
  ENDIF.

  WRITE RUNTIME TO RUNTIMECHAR.
  CONCATENATE WATREEDISPLAY-TEXT2 '- runtime' RUNTIMECHAR
  INTO WATREEDISPLAY-TEXT2 SEPARATED BY SPACE.

* include header display record.
  WATREEDISPLAY-TLEVEL = '1'.
  WATREEDISPLAY-TLENGTH2  = 60.
  WATREEDISPLAY-TCOLOR2    = 1.
  APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.

  LOOP AT ILOCDICTIONARY ASSIGNING <WADICTIONARY>.
    WATREEDISPLAY-TLEVEL = '2'.
    WATREEDISPLAY-TEXT2 = <WADICTIONARY>-TABLENAME.
    WATREEDISPLAY-TCOLOR2    = 3.
    WATREEDISPLAY-TLENGTH3   = 80.
    WATREEDISPLAY-TCOLOR3    = 3.
    WATREEDISPLAY-TPOS3      = 60.
    CONCATENATE 'Dictionary:' <WADICTIONARY>-TABLETITLE
    INTO WATREEDISPLAY-TEXT3 SEPARATED BY SPACE.

    APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
  ENDLOOP.
ENDFORM.                    "filltreenodetables
"fillTreeNodeTables

*-----------------------------------------------------------------------
*  fillTreeNodeMessages...
*-----------------------------------------------------------------------
FORM FILLTREENODEMESSAGES USING ILOCMESSAGES LIKE IMESSAGES[]
                                ILOCTREEDISPLAY LIKE ITREEDISPLAY[]
                                VALUE(RUNTIME).

  DATA: TABLELINES TYPE I.
  DATA: WATREEDISPLAY LIKE SNODETEXT.
  FIELD-SYMBOLS: <WAMESSAGE> TYPE TMESSAGE.
  DATA: TABLELINESSTRING TYPE STRING.
  DATA: RUNTIMECHAR(10).

  SORT ILOCMESSAGES ASCENDING BY ARBGB.

  LOOP AT ILOCMESSAGES ASSIGNING <WAMESSAGE>.
    AT NEW ARBGB.
      TABLELINES = TABLELINES + 1.
    ENDAT.
  ENDLOOP.
  TABLELINESSTRING = TABLELINES.

  IF TABLELINES = 1.
    CONCATENATE TABLELINESSTRING 'message class downloaded'
    INTO WATREEDISPLAY-TEXT2 SEPARATED BY SPACE.
  ELSE.
    CONCATENATE TABLELINESSTRING 'message classes downloaded'
    INTO WATREEDISPLAY-TEXT2 SEPARATED BY SPACE.
  ENDIF.

  WRITE RUNTIME TO RUNTIMECHAR.
  CONCATENATE WATREEDISPLAY-TEXT2 '- runtime' RUNTIMECHAR
  INTO WATREEDISPLAY-TEXT2 SEPARATED BY SPACE.

* include header display record.
  WATREEDISPLAY-TLEVEL = '1'.
  WATREEDISPLAY-TLENGTH2 = 60.
  WATREEDISPLAY-TCOLOR2 = 1.
  APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.

  LOOP AT ILOCMESSAGES ASSIGNING <WAMESSAGE>.
    AT NEW ARBGB.
      WATREEDISPLAY-TLEVEL = '2'.
      WATREEDISPLAY-TEXT2 = <WAMESSAGE>-ARBGB.
      WATREEDISPLAY-TCOLOR2    = 5.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 5.
      WATREEDISPLAY-TPOS3      = 60.
      WATREEDISPLAY-TEXT3 = <WAMESSAGE>-STEXT.
      CONCATENATE 'Message class:'  WATREEDISPLAY-TEXT3
      INTO WATREEDISPLAY-TEXT3 SEPARATED BY SPACE.
      APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
    ENDAT.
  ENDLOOP.
ENDFORM.                    "filltreenodemessages
"fillTreeNodeMessages

*-----------------------------------------------------------------------
*  fillTreeNodeFunctions...
*-----------------------------------------------------------------------
FORM FILLTREENODEFUNCTIONS USING ILOCFUNCTIONS LIKE IFUNCTIONS[]
                                 ILOCTREEDISPLAY LIKE ITREEDISPLAY[]
                                 VALUE(RUNTIME).

  DATA: TABLELINES TYPE I.
  DATA: WATREEDISPLAY LIKE SNODETEXT.
  FIELD-SYMBOLS: <WAFUNCTION> TYPE TFUNCTION.
  FIELD-SYMBOLS: <WASCREEN> TYPE TSCREENFLOW.
  FIELD-SYMBOLS: <WAGUITITLE> TYPE TGUITITLE.
  FIELD-SYMBOLS: <WADICTIONARY> TYPE TDICTTABLE.
  FIELD-SYMBOLS: <WAINCLUDE> TYPE TINCLUDE.
  FIELD-SYMBOLS: <WAMESSAGE> TYPE TMESSAGE.
  DATA: TABLELINESSTRING TYPE STRING.
  DATA: RUNTIMECHAR(10).

  SORT ILOCFUNCTIONS ASCENDING BY FUNCTIONNAME.

  TABLELINES = LINES( ILOCFUNCTIONS ).
  TABLELINESSTRING = TABLELINES.

  IF TABLELINES = 1.
    CONCATENATE TABLELINESSTRING ` function downloaded`
    INTO WATREEDISPLAY-TEXT2.
  ELSE.
    CONCATENATE TABLELINESSTRING ` functions downloaded`
    INTO WATREEDISPLAY-TEXT2.
  ENDIF.

  WRITE RUNTIME TO RUNTIMECHAR.

  CONCATENATE WATREEDISPLAY-TEXT2 ` - runtime ` RUNTIMECHAR
  INTO WATREEDISPLAY-TEXT2.
* include header display record.
  WATREEDISPLAY-TLEVEL = '1'.
  WATREEDISPLAY-TLENGTH2  = 60.
  WATREEDISPLAY-TCOLOR2    = 1.
  APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.

* Lets fill the detail in
  LOOP AT ILOCFUNCTIONS ASSIGNING <WAFUNCTION>.
    WATREEDISPLAY-TLEVEL = 2.
    WATREEDISPLAY-TEXT2 = <WAFUNCTION>-FUNCTIONNAME.
    WATREEDISPLAY-TCOLOR2    = 7.
    WATREEDISPLAY-TLENGTH3   = 80.
    WATREEDISPLAY-TCOLOR3    = 7.
    WATREEDISPLAY-TPOS3      = 60.
    CONCATENATE `Function: ` <WAFUNCTION>-FUNCTIONNAME INTO
WATREEDISPLAY-TEXT3.
    APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.

*   Screens.
    LOOP AT <WAFUNCTION>-ISCREENFLOW ASSIGNING <WASCREEN>.
      WATREEDISPLAY-TLEVEL = '2'.
      WATREEDISPLAY-TEXT2 = <WASCREEN>-SCREEN.
      WATREEDISPLAY-TCOLOR2    = 6.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 6.
      WATREEDISPLAY-TPOS3      = 60.
      WATREEDISPLAY-TEXT3 = 'Screen'.
      APPEND WATREEDISPLAY TO ITREEDISPLAY.
    ENDLOOP.

*   GUI Title.
    LOOP AT <WAFUNCTION>-IGUITITLE ASSIGNING <WAGUITITLE>.
      WATREEDISPLAY-TLEVEL = '2'.
      WATREEDISPLAY-TEXT2 = <WAGUITITLE>-OBJ_CODE.
      WATREEDISPLAY-TCOLOR2    = 6.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 6.
      WATREEDISPLAY-TPOS3      = 60.
      WATREEDISPLAY-TEXT3 = 'GUI Title'.
      APPEND WATREEDISPLAY TO ITREEDISPLAY.
    ENDLOOP.

*   Fill in the tree with include information
    LOOP AT <WAFUNCTION>-IINCLUDES ASSIGNING <WAINCLUDE>.
      WATREEDISPLAY-TLEVEL = 3.
      WATREEDISPLAY-TEXT2 =  <WAINCLUDE>-INCLUDENAME.
      WATREEDISPLAY-TCOLOR2    = 4.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 4.
      WATREEDISPLAY-TPOS3      = 60.
      CONCATENATE `Include:   ` <WAINCLUDE>-INCLUDETITLE
      INTO WATREEDISPLAY-TEXT3.
      APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
    ENDLOOP.

*   fill in the tree with dictionary information
    LOOP AT <WAFUNCTION>-IDICTSTRUCT ASSIGNING <WADICTIONARY>.
      WATREEDISPLAY-TLEVEL = 3.
      WATREEDISPLAY-TEXT2 =  <WADICTIONARY>-TABLENAME.
      WATREEDISPLAY-TCOLOR2    = 3.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 3.
      WATREEDISPLAY-TPOS3      = 60.
      CONCATENATE `Dictionary:` <WADICTIONARY>-TABLETITLE
      INTO WATREEDISPLAY-TEXT3.
      APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
    ENDLOOP.

*   fill in the tree with message information
    SORT <WAFUNCTION>-IMESSAGES[] ASCENDING BY ARBGB.
    LOOP AT <WAFUNCTION>-IMESSAGES ASSIGNING <WAMESSAGE>.
      AT NEW ARBGB.
        WATREEDISPLAY-TLEVEL = 3.
        WATREEDISPLAY-TEXT2 = <WAMESSAGE>-ARBGB.
        WATREEDISPLAY-TCOLOR2    = 5.
        WATREEDISPLAY-TLENGTH3   = 80.
        WATREEDISPLAY-TCOLOR3    = 5.
        WATREEDISPLAY-TPOS3      = 60.

*       Select the message class text if we do not have it already
        IF <WAMESSAGE>-STEXT IS INITIAL.
          SELECT SINGLE STEXT FROM T100A
                              INTO <WAMESSAGE>-STEXT
                              WHERE ARBGB = <WAMESSAGE>-ARBGB.
        ENDIF.

        WATREEDISPLAY-TEXT3 = <WAMESSAGE>-STEXT.
        CONCATENATE `Message class: `  WATREEDISPLAY-TEXT3
        INTO WATREEDISPLAY-TEXT3.
        APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
      ENDAT.
    ENDLOOP.
  ENDLOOP.
ENDFORM.                    "filltreenodefunctions
"fillTreeNodeFunctions

*-----------------------------------------------------------------------
*  fillTreeNodePrograms
*-----------------------------------------------------------------------
FORM FILLTREENODEPROGRAMS USING ILOCPROGRAMS LIKE IPROGRAMS[]
                                ILOCFUNCTIONS LIKE IFUNCTIONS[]
                                ILOCTREEDISPLAY LIKE ITREEDISPLAY[]
                                VALUE(RUNTIME).

  DATA: TABLELINES TYPE I.
  DATA: WATREEDISPLAY LIKE SNODETEXT.
  FIELD-SYMBOLS: <WAPROGRAM> TYPE TPROGRAM.
  FIELD-SYMBOLS: <WASCREEN> TYPE TSCREENFLOW.
  FIELD-SYMBOLS: <WAFUNCTION> TYPE TFUNCTION.
  FIELD-SYMBOLS: <WADICTIONARY> TYPE TDICTTABLE.
  FIELD-SYMBOLS: <WAINCLUDE> TYPE TINCLUDE.
  FIELD-SYMBOLS: <WAMESSAGE> TYPE TMESSAGE.
  DATA: TABLELINESSTRING TYPE STRING.
  DATA: RUNTIMECHAR(10).

  TABLELINES = LINES( ILOCPROGRAMS ).
  TABLELINESSTRING = TABLELINES.

  IF TABLELINES = 1.
    CONCATENATE TABLELINESSTRING ` program downloaded`
    INTO WATREEDISPLAY-TEXT2.
  ELSE.
    CONCATENATE TABLELINESSTRING ` programs downloaded`
    INTO WATREEDISPLAY-TEXT2.
  ENDIF.

  WRITE RUNTIME TO RUNTIMECHAR.

  CONCATENATE WATREEDISPLAY-TEXT2 ` - runtime ` RUNTIMECHAR
  INTO WATREEDISPLAY-TEXT2.
* include header display record.
  WATREEDISPLAY-TLEVEL = '1'.
  WATREEDISPLAY-TLENGTH2  = 60.
  WATREEDISPLAY-TCOLOR2    = 1.
  APPEND WATREEDISPLAY TO ITREEDISPLAY.

  LOOP AT ILOCPROGRAMS ASSIGNING <WAPROGRAM>.
*   Main programs.
    WATREEDISPLAY-TLEVEL = '2'.
    WATREEDISPLAY-TEXT2 = <WAPROGRAM>-PROGNAME.
    WATREEDISPLAY-TCOLOR2    = 1.
*   Description
    WATREEDISPLAY-TLENGTH3   = 80.
    WATREEDISPLAY-TCOLOR3    = 1.
    WATREEDISPLAY-TPOS3      = 60.
    CONCATENATE `Program: ` <WAPROGRAM>-PROGRAMTITLE
    INTO WATREEDISPLAY-TEXT3.
    APPEND WATREEDISPLAY TO ITREEDISPLAY.
*   Screens.
    LOOP AT <WAPROGRAM>-ISCREENFLOW ASSIGNING <WASCREEN>.
      WATREEDISPLAY-TLEVEL = '3'.
      WATREEDISPLAY-TEXT2 = <WASCREEN>-SCREEN.
      WATREEDISPLAY-TCOLOR2    = 6.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 6.
      WATREEDISPLAY-TPOS3      = 60.
      WATREEDISPLAY-TEXT3 = 'Screen'.
      APPEND WATREEDISPLAY TO ITREEDISPLAY.
    ENDLOOP.
*   fill in the tree with message information
    SORT <WAPROGRAM>-IMESSAGES[] ASCENDING BY ARBGB.
    LOOP AT <WAPROGRAM>-IMESSAGES ASSIGNING <WAMESSAGE>.
      AT NEW ARBGB.
        WATREEDISPLAY-TLEVEL = 3.
        WATREEDISPLAY-TEXT2 = <WAMESSAGE>-ARBGB.
        WATREEDISPLAY-TCOLOR2    = 5.
        WATREEDISPLAY-TLENGTH3   = 80.
        WATREEDISPLAY-TCOLOR3    = 5.
        WATREEDISPLAY-TPOS3      = 60.

*       Select the message class text if we do not have it already
        IF <WAMESSAGE>-STEXT IS INITIAL.
          SELECT SINGLE STEXT FROM T100A
                              INTO <WAMESSAGE>-STEXT
                              WHERE ARBGB = <WAMESSAGE>-ARBGB.
        ENDIF.

        WATREEDISPLAY-TEXT3 = <WAMESSAGE>-STEXT.
        CONCATENATE `Message class: `  WATREEDISPLAY-TEXT3
        INTO WATREEDISPLAY-TEXT3.
        APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
      ENDAT.
    ENDLOOP.
*   Fill in the tree with include information
    LOOP AT <WAPROGRAM>-IINCLUDES ASSIGNING <WAINCLUDE>.
      WATREEDISPLAY-TLEVEL = 3.
      WATREEDISPLAY-TEXT2 =  <WAINCLUDE>-INCLUDENAME.
      WATREEDISPLAY-TCOLOR2    = 4.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 4.
      WATREEDISPLAY-TPOS3      = 60.
      CONCATENATE `Include:   ` <WAINCLUDE>-INCLUDETITLE
      INTO WATREEDISPLAY-TEXT3.
      APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
    ENDLOOP.
*   fill in the tree with dictionary information
    LOOP AT <WAPROGRAM>-IDICTSTRUCT ASSIGNING <WADICTIONARY>.
      WATREEDISPLAY-TLEVEL = 3.
      WATREEDISPLAY-TEXT2 =  <WADICTIONARY>-TABLENAME.
      WATREEDISPLAY-TCOLOR2    = 3.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 3.
      WATREEDISPLAY-TPOS3      = 60.
      CONCATENATE `Dictionary:    ` <WADICTIONARY>-TABLETITLE
      INTO WATREEDISPLAY-TEXT3.
      APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
    ENDLOOP.

*   Function Modules
    LOOP AT ILOCFUNCTIONS ASSIGNING <WAFUNCTION>
    WHERE PROGRAMLINKNAME = <WAPROGRAM>-PROGNAME.
      WATREEDISPLAY-TLEVEL = 3.
      WATREEDISPLAY-TEXT2 = <WAFUNCTION>-FUNCTIONNAME.
      WATREEDISPLAY-TCOLOR2    = 7.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 7.
      WATREEDISPLAY-TPOS3      = 60.
      CONCATENATE `Function:      ` <WAFUNCTION>-FUNCTIONNAME
      INTO WATREEDISPLAY-TEXT3.
      APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.

*     Fill in the tree with include information
      LOOP AT <WAFUNCTION>-IINCLUDES ASSIGNING <WAINCLUDE>.
        WATREEDISPLAY-TLEVEL = 4.
        WATREEDISPLAY-TEXT2 =  <WAINCLUDE>-INCLUDENAME.
        WATREEDISPLAY-TCOLOR2    = 4.
        WATREEDISPLAY-TLENGTH3   = 80.
        WATREEDISPLAY-TCOLOR3    = 4.
        WATREEDISPLAY-TPOS3      = 60.
        CONCATENATE `Include:       ` <WAINCLUDE>-INCLUDETITLE
        INTO WATREEDISPLAY-TEXT3.
        APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
      ENDLOOP.

*     fill in the tree with dictionary information
      LOOP AT <WAFUNCTION>-IDICTSTRUCT ASSIGNING <WADICTIONARY>.
        WATREEDISPLAY-TLEVEL = 4.
        WATREEDISPLAY-TEXT2 =  <WADICTIONARY>-TABLENAME.
        WATREEDISPLAY-TCOLOR2    = 3.
        WATREEDISPLAY-TLENGTH3   = 80.
        WATREEDISPLAY-TCOLOR3    = 3.
        WATREEDISPLAY-TPOS3      = 60.
        CONCATENATE `Dictionary:    ` <WADICTIONARY>-TABLETITLE
        INTO WATREEDISPLAY-TEXT3.
        APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
      ENDLOOP.

*     fill in the tree with message information
      SORT <WAFUNCTION>-IMESSAGES[] ASCENDING BY ARBGB.
      LOOP AT <WAFUNCTION>-IMESSAGES ASSIGNING <WAMESSAGE>.
        AT NEW ARBGB.
          WATREEDISPLAY-TLEVEL = 4.
          WATREEDISPLAY-TEXT2 = <WAMESSAGE>-ARBGB.
          WATREEDISPLAY-TCOLOR2    = 5.
          WATREEDISPLAY-TLENGTH3   = 80.
          WATREEDISPLAY-TCOLOR3    = 5.
          WATREEDISPLAY-TPOS3      = 60.

*         Select the message class text if we do not have it already
          IF <WAMESSAGE>-STEXT IS INITIAL.
            SELECT SINGLE STEXT FROM T100A
                                INTO <WAMESSAGE>-STEXT
                                WHERE ARBGB = <WAMESSAGE>-ARBGB.
          ENDIF.

          WATREEDISPLAY-TEXT3 = <WAMESSAGE>-STEXT.
          CONCATENATE `Message class:  `  WATREEDISPLAY-TEXT3
          INTO WATREEDISPLAY-TEXT3.
          APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
        ENDAT.
      ENDLOOP.
    ENDLOOP.
  ENDLOOP.
ENDFORM.                    "filltreenodeprograms
"fillTreeNodePrograms

*-----------------------------------------------------------------------
*  fillTreeNodeClasses
*-----------------------------------------------------------------------
FORM FILLTREENODECLASSES USING ILOCCLASSES LIKE ICLASSES[]
                               ILOCFUNCTIONS LIKE IFUNCTIONS[]
                               ILOCTREEDISPLAY LIKE ITREEDISPLAY[]
                               VALUE(RUNTIME).

  DATA: TABLELINES TYPE I.
  DATA: WATREEDISPLAY LIKE SNODETEXT.
  FIELD-SYMBOLS: <WACLASS> TYPE TCLASS.
  FIELD-SYMBOLS: <WAMETHOD> TYPE TMETHOD.
  FIELD-SYMBOLS: <WAFUNCTION> TYPE TFUNCTION.
  FIELD-SYMBOLS: <WADICTIONARY> TYPE TDICTTABLE.
  FIELD-SYMBOLS: <WAINCLUDE> TYPE TINCLUDE.
  FIELD-SYMBOLS: <WAMESSAGE> TYPE TMESSAGE.
  DATA: TABLELINESSTRING TYPE STRING.
  DATA: RUNTIMECHAR(10).

  TABLELINES = LINES( ILOCCLASSES ).
  TABLELINESSTRING = TABLELINES.

  IF TABLELINES = 1.
    CONCATENATE TABLELINESSTRING ` class downloaded`
    INTO WATREEDISPLAY-TEXT2.
  ELSE.
    CONCATENATE TABLELINESSTRING ` classes downloaded`
    INTO WATREEDISPLAY-TEXT2.
  ENDIF.

  WRITE RUNTIME TO RUNTIMECHAR.

  CONCATENATE WATREEDISPLAY-TEXT2 ` - runtime ` RUNTIMECHAR
  INTO WATREEDISPLAY-TEXT2.
* include header display record.
  WATREEDISPLAY-TLEVEL = '1'.
  WATREEDISPLAY-TLENGTH2  = 60.
  WATREEDISPLAY-TCOLOR2    = 1.
  APPEND WATREEDISPLAY TO ITREEDISPLAY.

  LOOP AT ILOCCLASSES ASSIGNING <WACLASS>.
*   Main Class.
    WATREEDISPLAY-TLEVEL = '2'.
    WATREEDISPLAY-TEXT2 = <WACLASS>-CLSNAME.
    WATREEDISPLAY-TCOLOR2    = 1.
*   Description
    WATREEDISPLAY-TLENGTH3   = 80.
    WATREEDISPLAY-TCOLOR3    = 1.
    WATREEDISPLAY-TPOS3      = 60.
    CONCATENATE `Class:    ` <WACLASS>-DESCRIPT
    INTO WATREEDISPLAY-TEXT3.
    APPEND WATREEDISPLAY TO ITREEDISPLAY.

*   fill in the tree with method information
    LOOP AT <WACLASS>-IMETHODS[] ASSIGNING <WAMETHOD>.
      WATREEDISPLAY-TLEVEL = 3.
      WATREEDISPLAY-TEXT2 =  <WAMETHOD>-CMPNAME.
      WATREEDISPLAY-TCOLOR2    = 2.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 2.
      WATREEDISPLAY-TPOS3      = 60.
      CONCATENATE `Method:   ` <WAMETHOD>-DESCRIPT
      INTO WATREEDISPLAY-TEXT3.
      APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
    ENDLOOP.

*   fill in the tree with message information
    SORT <WACLASS>-IMESSAGES[] ASCENDING BY ARBGB.
    LOOP AT <WACLASS>-IMESSAGES ASSIGNING <WAMESSAGE>.
      AT NEW ARBGB.
        WATREEDISPLAY-TLEVEL = 3.
        WATREEDISPLAY-TEXT2 = <WAMESSAGE>-ARBGB.
        WATREEDISPLAY-TCOLOR2    = 5.
        WATREEDISPLAY-TLENGTH3   = 80.
        WATREEDISPLAY-TCOLOR3    = 5.
        WATREEDISPLAY-TPOS3      = 60.

*       Select the message class text if we do not have it already
        IF <WAMESSAGE>-STEXT IS INITIAL.
          SELECT SINGLE STEXT FROM T100A
                              INTO <WAMESSAGE>-STEXT
                              WHERE ARBGB = <WAMESSAGE>-ARBGB.
        ENDIF.

        WATREEDISPLAY-TEXT3 = <WAMESSAGE>-STEXT.
        CONCATENATE `Message class: `  WATREEDISPLAY-TEXT3
        INTO WATREEDISPLAY-TEXT3.
        APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
      ENDAT.
    ENDLOOP.

*   fill in the tree with dictionary information
    LOOP AT <WACLASS>-IDICTSTRUCT ASSIGNING <WADICTIONARY>.
      WATREEDISPLAY-TLEVEL = 3.
      WATREEDISPLAY-TEXT2 =  <WADICTIONARY>-TABLENAME.
      WATREEDISPLAY-TCOLOR2    = 3.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 3.
      WATREEDISPLAY-TPOS3      = 60.
      CONCATENATE `Dictionary:    ` <WADICTIONARY>-TABLETITLE
      INTO WATREEDISPLAY-TEXT3.
      APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
    ENDLOOP.

*   Function Modules
    LOOP AT ILOCFUNCTIONS ASSIGNING <WAFUNCTION>
    WHERE PROGRAMLINKNAME = <WACLASS>-CLSNAME.
      WATREEDISPLAY-TLEVEL = 3.
      WATREEDISPLAY-TEXT2 = <WAFUNCTION>-FUNCTIONNAME.
      WATREEDISPLAY-TCOLOR2    = 7.
      WATREEDISPLAY-TLENGTH3   = 80.
      WATREEDISPLAY-TCOLOR3    = 7.
      WATREEDISPLAY-TPOS3      = 60.
      CONCATENATE `Function:      ` <WAFUNCTION>-FUNCTIONNAME
      INTO WATREEDISPLAY-TEXT3.
      APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.

*     Fill in the tree with include information
      LOOP AT <WAFUNCTION>-IINCLUDES ASSIGNING <WAINCLUDE>.
        WATREEDISPLAY-TLEVEL = 4.
        WATREEDISPLAY-TEXT2 =  <WAINCLUDE>-INCLUDENAME.
        WATREEDISPLAY-TCOLOR2    = 4.
        WATREEDISPLAY-TLENGTH3   = 80.
        WATREEDISPLAY-TCOLOR3    = 4.
        WATREEDISPLAY-TPOS3      = 60.
        CONCATENATE `Include:       ` <WAINCLUDE>-INCLUDETITLE
        INTO WATREEDISPLAY-TEXT3.
        APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
      ENDLOOP.

*     fill in the tree with dictionary information
      LOOP AT <WAFUNCTION>-IDICTSTRUCT ASSIGNING <WADICTIONARY>.
        WATREEDISPLAY-TLEVEL = 4.
        WATREEDISPLAY-TEXT2 =  <WADICTIONARY>-TABLENAME.
        WATREEDISPLAY-TCOLOR2    = 3.
        WATREEDISPLAY-TLENGTH3   = 80.
        WATREEDISPLAY-TCOLOR3    = 3.
        WATREEDISPLAY-TPOS3      = 60.
        CONCATENATE `Dictionary:    ` <WADICTIONARY>-TABLETITLE
        INTO WATREEDISPLAY-TEXT3.
        APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
      ENDLOOP.

*     fill in the tree with message information
      SORT <WAFUNCTION>-IMESSAGES[] ASCENDING BY ARBGB.
      LOOP AT <WAFUNCTION>-IMESSAGES ASSIGNING <WAMESSAGE>.
        AT NEW ARBGB.
          WATREEDISPLAY-TLEVEL = 4.
          WATREEDISPLAY-TEXT2 = <WAMESSAGE>-ARBGB.
          WATREEDISPLAY-TCOLOR2    = 5.
          WATREEDISPLAY-TLENGTH3   = 80.
          WATREEDISPLAY-TCOLOR3    = 5.
          WATREEDISPLAY-TPOS3      = 60.

*         Select the message class text if we do not have it already
          IF <WAMESSAGE>-STEXT IS INITIAL.
            SELECT SINGLE STEXT FROM T100A
                                INTO <WAMESSAGE>-STEXT
                                WHERE ARBGB = <WAMESSAGE>-ARBGB.
          ENDIF.

          WATREEDISPLAY-TEXT3 = <WAMESSAGE>-STEXT.
          CONCATENATE `Message class:  `  WATREEDISPLAY-TEXT3
          INTO WATREEDISPLAY-TEXT3.
          APPEND WATREEDISPLAY TO ILOCTREEDISPLAY.
        ENDAT.
      ENDLOOP.
    ENDLOOP.
  ENDLOOP.
ENDFORM.                    "filltreenodeclasses
"fillTreeNodeClasses

*-----------------------------------------------------------------------
* displayTree...
*-----------------------------------------------------------------------
FORM DISPLAYTREE USING ILOCTREEDISPLAY LIKE ITREEDISPLAY[].

  DATA: WATREEDISPLAY TYPE SNODETEXT.

* build up the tree from the internal table node
  CALL FUNCTION 'RS_TREE_CONSTRUCT'
    TABLES
      NODETAB            = ITREEDISPLAY
    EXCEPTIONS
      TREE_FAILURE       = 1
      ID_NOT_FOUND       = 2
      WRONG_RELATIONSHIP = 3
      OTHERS             = 4.

* get the first index and expand the whole tree
  READ TABLE ILOCTREEDISPLAY INTO WATREEDISPLAY INDEX 1.
  CALL FUNCTION 'RS_TREE_EXPAND'
    EXPORTING
      NODE_ID   = WATREEDISPLAY-ID
      ALL       = 'X'
    EXCEPTIONS
      NOT_FOUND = 1
      OTHERS    = 2.

* now display the tree
  CALL FUNCTION 'RS_TREE_LIST_DISPLAY'
    EXPORTING
      CALLBACK_PROGRAM      = SY-CPROG
      CALLBACK_USER_COMMAND = 'CB_USER_COMMAND'
      CALLBACK_TEXT_DISPLAY = 'CB_text_DISPLAY'
      CALLBACK_TOP_OF_PAGE  = 'TOP_OF_PAGE'
    EXCEPTIONS
      OTHERS                = 1.
ENDFORM.                    "displaytree
"displayTree

*-----------------------------------------------------------------------
*  topOfPage... for tree display routines.
*-----------------------------------------------------------------------
FORM TOPOFPAGE.

ENDFORM.                    "topofpage


*Messages
*----------------------------------------------------------
*
* Message class: OO
*000   & & & &

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
