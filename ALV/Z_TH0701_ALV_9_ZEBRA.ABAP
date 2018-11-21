*&---------------------------------------------------------------------*
*&      Form  set_grid_layo_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->CS_LAYO    text
*----------------------------------------------------------------------*
*******************************************************************************************************************************
* Written By TaeHyeong                                                                                                                 
* Reporting Date: '18.11.21.                                                                                                              
* Subject: Add color to separate rows .           
*******************************************************************************************************************************
FORM set_grid_layo_100  CHANGING cs_layo TYPE lvc_s_layo.
*... ALV-Control: Allgemeine Anzeigeoptionen
  cs_layo-stylefname  = 'X'.

  cs_layo-cwidth_opt  = space.
  cs_layo-zebra       = 'X'.                                                   "   줄별 음영표시.(연속된 데이터 헷갈림 방지하기 위한 음영표시.)
  cs_layo-smalltitle  = space.
  cs_layo-graphics    = space.
  cs_layo-frontend    = space.
  cs_layo-template    = space.
*....
