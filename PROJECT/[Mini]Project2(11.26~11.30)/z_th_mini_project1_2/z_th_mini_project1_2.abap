*&---------------------------------------------------------------------*
*& Report  Z_TH_MINI_PROJECT1_2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

INCLUDE Z_TH_MINI_PROJECT1_2_TOP               .    " global Data

INCLUDE Z_TH_MINI_PROJECT1_2_O01                .  " PBO-Modules
 INCLUDE Z_TH_MINI_PROJECT1_2_I01                .  " PAI-Modules
 INCLUDE Z_TH_MINI_PROJECT1_2_F01                .  " FORM-Routines

 START-OF-SELECTION.
PERFORM fetch_report.
CALL SCREEN 100.

*GUI Texts
*----------------------------------------------------------
* SUBJECT --> 자재정보 변경 신청 현황

*Text elements
*----------------------------------------------------------
* 001 조회조건
* 002 추가조건
* 003 자재번호
* 004 자재그룹
* 005 자재유형
* 006 변경일
* 007 변경자

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
