*&---------------------------------------------------------------------*
*& Report  Z_TH0701_PRACTICE1
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong
*& Reporting Date: `18.11.23
*& Subject: Docking Container(Without Layout)
*&---------------------------------------------------------------------*
REPORT  z_th0701_practice3.
*...
DATA : container TYPE REF TO cl_gui_docking_container,                        "---> 1. Docking Container 識情.

*...

  CREATE OBJECT container                                                     "--->2. container 梓端 持失.
    EXPORTING
      REPID = sy-repid
      DYNNR = sy-dynnr
      EXTENSION = 800.