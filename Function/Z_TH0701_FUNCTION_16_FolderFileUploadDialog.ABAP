*&---------------------------------------------------------------------*
*&  Include           Z_TH0701_FolderFileUploadDialog
*&---------------------------------------------------------------------*
************************************************************************
*  Written By TaeHyeong
*  Reporting Date: `18.12.18
*  Subject: Folder and File both Upload possible
************************************************************************

 CALL METHOD cl_gui_frontend_services=>directory_browse
     CHANGING
       selected_folder = taehyeong_folder
     EXCEPTIONS
       OTHERS          = 0.

  filepath = taehyeong_folder.