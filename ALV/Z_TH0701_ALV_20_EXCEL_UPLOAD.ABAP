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
  CALL FUNCTION 'F4_FILENAME'                             " F4���(������ġ�� ���������� ������ �� �ִ�. )�� �ִ´�.
    IMPORTING
      file_name = p_fname.                                " � ���͸��� ���� �����̰� �ش�����������.

START-OF-SELECTION.

  CALL FUNCTION 'KCD_EXCEL_OLE_TO_INT_CONVERT'            
    EXPORTING
      filename                = p_fname                   " ������ ���ϳ����� �����ش�.
      i_begin_col             = gv_start_col              " ��� Į������ ���� ���ΰ�?(1 : ù ��° Į������ �д´�.)
      i_begin_row             = gv_start_row              " ù��° ����� ���� ���ΰ�?(1 : ù ��° ����� �д´�.)
      i_end_col               = gv_end_col                " ������ Į�� ����
      i_end_row               = gv_end_row                " ������ �ο� ����.
    TABLES
      intern                  = gt_data                   " ��ȯ ���� ���ͳ� ���̺��� ���δ�.
    EXCEPTIONS
      inconsistent_parameters = 1
      upload_ole              = 2
      OTHERS                  = 3.

  LOOP AT gt_data.
    MOVE gt_data-col TO gv_index.
    ASSIGN COMPONENT gv_index OF STRUCTURE gt_itab TO <gv_fs>.   " gt_itab�� gv_index �� �ش�Ǵ� Į������ �ʵ� �ɺ��� �Ҵ����ش�.
    MOVE gt_data-value TO <gv_fs>.                               " gt_data������ Į�������� gt_itab�� gv_index�� �ش��ϴ� �ʵ�ɺ��� ���� ����־��ش�.

    AT END OF row.                                               " ���� �����ٸ�
      APPEND gt_itab.                                            " APPEND �ض�.
      CLEAR  gt_itab.
    ENDAT.
  ENDLOOP.

  DELETE gt_itab INDEX 1.