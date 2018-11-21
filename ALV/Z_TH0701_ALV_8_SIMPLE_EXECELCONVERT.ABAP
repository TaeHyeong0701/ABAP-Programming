*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*******************************************************************************************************************************
* Written By TaeHyeong                                                                                                                 |
* Reporting Date: '18.11.21.                                                                                                              |
* Subject: Convert From ALV Data to EXCEL Format and Simple Excel Download From ALV to C Drive.           |
*******************************************************************************************************************************
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXCEL'.
*----------------------------------------------------------------------- Simple Excel Download From ALV to C Drive(Local Drive)
      CALL FUNCTION 'SAP_CONVERT_TO_XLS_FORMAT'
        EXPORTING
          i_field_seperator = '#'
          i_line_header     = 'X'
          i_filename        = 'C:\TaeHyeongpractice.xls'
          i_appl_keep       = ''
        TABLES                                                                    " Table include ALVdata.
          i_tab_sap_data    = it_tab
        EXCEPTIONS                                                              "Exception Ã³¸®
          conversion_failed = 1
          OTHERS            = 2.
  ENDCASE.

ENDMODULE.                 " USER_COMMAND_0100  INPUT