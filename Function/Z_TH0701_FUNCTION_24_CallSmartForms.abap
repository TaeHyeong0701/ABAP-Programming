*&---------------------------------------------------------------------*
*& Report  Z_THCALLSMARTFORMS
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong
*& Reporting Date : `19.3.3
*&---------------------------------------------------------------------*

REPORT  Z_THCALLSMARTFORMS.


DATA : fm_name TYPE rs38l_fnam,
       it_vbak TYPE TABLE OF vbak.



CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    formname = 'ZTHPRACTICE2'
*    스마트폼 이름
  IMPORTING
    FM_NAME = fm_name
*    스마트폼 이름이 적절한 함수명으로 대체된다.
  EXCEPTIONS
    NO_FORM = 1
    NO_FUNCTION_MODULE = 2
    OTHERS = 3.

CALL FUNCTION fm_name
* 함수명을 이용한 스마트폼 호출
  TABLES
    it_vbak = it_vbak
  EXCEPTIONS
    FORMATTING_ERROR = 1
    INTERNAL_ERROR = 2
    SEND_ERROR = 3
    USER_CANCELED = 4
    OTHERS = 5.

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
