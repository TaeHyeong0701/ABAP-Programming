***********************************************************************
*Written By: TaeHyeong
*Reporting Date: `18.11.22
*Subject: Convert ALV to EXCEL and Assign path through Click Drill
*&---------------------------------------------------------------------*
*& Include ZSFR001_08_TOP                                    Report ZSFR001_08
*&
*&---------------------------------------------------------------------*
    DATA: file_name TYPE string.
    DATA: file_path TYPE string.
    DATA : result_filename TYPE string.
************************************************************************
*
*                            F01
*
*&---------------------------------------------------------------------*
*&      Form  excel
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM excel.
  CALL METHOD cl_gui_frontend_services=>file_save_dialog                "1. Excel Save Dialog Call
    CHANGING
      path = file_path                                                  "  가. 경로 지정값 반환.(Obligatory)
      fullpath = result_filename                                        "  나. 전체 경로를 반환.(Obligatory)
       filename = file_name.                                            "  다. 파일 명 반환.(Obligatory)
  CALL METHOD cl_gui_frontend_services=>gui_download                    "2. Excel Download Function
    EXPORTING
      filename              = file_name                                 "   가. 파일명 입력.
      write_field_separator = 'X'                                       "   나. 스프레드 시트의 제한이없도록 옵션도 줘봤다.
*      FILETYPE = 'XLS'
    CHANGING
      data_tab              = it_tab.                                   "   다. 데이터가 담긴 인터널테이블을 삽입해준다.


ENDFORM.                    "excel