*&---------------------------------------------------------------------*
*& Include ZSFR0001_00_TOP                                   Report ZSFR0001_00
*&
*&---------------------------------------------------------------------*

REPORT   zsfr0001_00 MESSAGE-ID pn.

TYPE-POOLS vrm.

TABLES: zsft00_001.

DATA: func_mod_name       TYPE rs38l_fnam,              "FILE NAME
      subrc               LIKE sy-subrc,                "RETURN CODE
      ok_code             LIKE sy-ucomm,                "OKCODE
      url(255),                                         "PDF FILE NAME
      g_pdf_cont          TYPE REF TO cl_gui_custom_container,  "OBJECT ONTAINER
      g_pdf_control       TYPE REF TO cl_gui_html_viewer,       "OBJECT CONTROL
      control_parameters  TYPE ssfctrlop,               "Smart Forms: ontrolSTRUCTURE
      output_options      TYPE ssfcompop,               "Smart Composer OPTIONS
      job_output_info     TYPE ssfcrescl,
      otf_tab             LIKE itcoo OCCURS 0 WITH HEADER LINE,   "OTF Structure
      pdf_fsize           TYPE  i,
      pdf_table           TYPE  rcl_bag_tline.          "Standard Table Type for TLINE

DATA: BEGIN OF pdf_line_tab OCCURS 0,
        line(134),
      END OF pdf_line_tab,
      gt_tab  TYPE zsfs00_001t,
      gt_tab2 TYPE TABLE OF zsft00_001.

DATA: g_cont  TYPE REF TO cl_gui_custom_container,
      g_text  TYPE REF TO cl_gui_textedit,
      cont1   TYPE REF TO cl_gui_custom_container,
      text1   TYPE REF TO cl_gui_textedit,
      cont2   TYPE REF TO cl_gui_custom_container,
      text2   TYPE REF TO cl_gui_textedit,
      cont3   TYPE REF TO cl_gui_custom_container,
      text3   TYPE REF TO cl_gui_textedit,
      cont4   TYPE REF TO cl_gui_custom_container,
      text4   TYPE REF TO cl_gui_textedit,
      cont5   TYPE REF TO cl_gui_custom_container,
      text5   TYPE REF TO cl_gui_textedit.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS: p_cdate TYPE zsft00_001-cdate OBLIGATORY.
SELECTION-SCREEN END   OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS : p_inp RADIOBUTTON GROUP rg1 DEFAULT 'X'.
SELECTION-SCREEN COMMENT 4(30) text-c01.
PARAMETERS : p_dis RADIOBUTTON GROUP rg1.
SELECTION-SCREEN COMMENT 38(30) text-c02.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END   OF BLOCK b2.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2019. Sap Release 701
