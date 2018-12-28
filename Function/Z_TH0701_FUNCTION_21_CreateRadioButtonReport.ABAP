*&---------------------------------------------------------------------*
*& Include ZPPR0010_08_TOP                                   Report ZPPR0010_08
*&
*&---------------------------------------------------------------------*
************************************************************************
* Title: 생산 계획 및 생산 마스터 관리
************************************************************************
* DATE          AUTHOR                  DESCRIPTION
************************************************************************
* 2018.12.28    TaeHyeong               Create Radio Button in Report
************************************************************************
REPORT   ZPPR0010_08.

SELECTION-SCREEN BEGIN OF BLOCK block1.
PARAMETERS : Test1 RADIOBUTTON GROUP TH.
PARAMETERS : Test2 RADIOBUTTON GROUP TH.
SELECTION-SCREEN END OF BLOCK block1.


START-OF-SELECTION.
IF Test1 = 'X'.
    WRITE:/ 'TaeHyeong test1 Button Click'.
  ELSEIF Test2 = 'X'.
    WRITE:/ 'TaeHyeong test2 Button Click'.

  ENDIF.


