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