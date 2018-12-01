*&---------------------------------------------------------------------*
*& Report  Z_TH0701_ALV_20_EXCEL_UPLOAD
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong Kim
*& Reporting Date: `18.12.01
*& Subject: Excel Upload ALV
*&---------------------------------------------------------------------*

REPORT   Z_TH0701_ALV_20_EXCEL_UPLOAD.


DATA: BEGIN OF gt_itab OCCURS 0,
       aufnr(100)  TYPE c,
       werks(100)  TYPE c,
       plnbez(100)  TYPE c,
       vornr(100)  TYPE c,
       arbpl(100)  TYPE c,
       ltxa1(100)  TYPE c,
       gamng(100)  TYPE c,
       gmein(100)  TYPE c,
       END OF gt_itab.

DATA : gv_index     TYPE sy-tabix,
       gv_start_col TYPE i VALUE '1',
       gv_start_row TYPE i VALUE '1',
       gv_end_col   TYPE i VALUE '256',
       gv_end_row   TYPE i VALUE '65526'.

DATA : gt_data TYPE kcde_cells OCCURS 0 WITH HEADER LINE.

FIELD-SYMBOLS : <gv_fs> TYPE ANY.


PARAMETERS: p_fname TYPE char128.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_fname.
  CALL FUNCTION 'F4_FILENAME'                             " F4기능(파일위치와 지정파일을 선택할 수 있는. )을 넣는다.
    IMPORTING
      file_name = p_fname.                                " 어떤 디렉터리에 무슨 파일이고 해당파일은뭐다.

START-OF-SELECTION.

  CALL FUNCTION 'KCD_EXCEL_OLE_TO_INT_CONVERT'            
    EXPORTING
      filename                = p_fname                   " 추출한 파일네임을 던져준다.
      i_begin_col             = gv_start_col              " 어느 칼럼부터 읽을 것인가?(1 : 첫 번째 칼럼부터 읽는다.)
      i_begin_row             = gv_start_row              " 첫번째 행부터 읽을 것인가?(1 : 첫 번째 행부터 읽는다.)
      i_end_col               = gv_end_col                " 끝나는 칼럼 지점
      i_end_row               = gv_end_row                " 끝나는 로우 지점.
    TABLES
      intern                  = gt_data                   " 반환 값이 인터널 테이블에 쌓인다.
    EXCEPTIONS
      inconsistent_parameters = 1
      upload_ole              = 2
      OTHERS                  = 3.

  LOOP AT gt_data.
    MOVE gt_data-col TO gv_index.
    ASSIGN COMPONENT gv_index OF STRUCTURE gt_itab TO <gv_fs>.   " gt_itab의 gv_index 에 해당되는 칼럼들을 필드 심볼에 할당해준다.
    MOVE gt_data-value TO <gv_fs>.                               " gt_data엑셀의 칼럼값들을 gt_itab의 gv_index에 해당하는 필드심볼에 값을 집어넣어준다.

    AT END OF row.                                               " 행이 끝난다면
      APPEND gt_itab.                                            " APPEND 해라.
      CLEAR  gt_itab.
    ENDAT.
  ENDLOOP.

  DELETE gt_itab INDEX 1.