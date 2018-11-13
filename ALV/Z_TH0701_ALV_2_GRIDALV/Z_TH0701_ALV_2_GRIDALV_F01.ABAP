*&---------------------------------------------------------------------*
*&  Include           Z_TH0701_ALV_2_GRIDALV_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM select_data.                                " ������ ����
  SELECT *
    FROM zthsoccer INTO TABLE it_tab
    UP TO 10 ROWS.
ENDFORM.                    " SELECT_DATA
*&---------------------------------------------------------------------*
*&      Module  INIT_CONT  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module INIT_CONT output.

    IF container IS INITIAL.
    CREATE OBJECT container                        " �����̳� ��ü ����
      EXPORTING
        container_name = 'THCONT1'.                " OBLIGATORY �ʵ��� container_name�� �־��ش�.
     CREATE OBJECT grid.                            " �׸��� ��ü ����
     EXPORTING
        i_parent = container.                      " OBLIGATROY �ʵ��� i_parent�� �־��༭ �ش� �����̳ʿ� �����Ѵ�.

     CALL METHOD grid->set_table_for_first_display  "ABAP Dictionary Ȥ�� ����� ���� �ʵ�īŻ�α׸� must�� ���� ��� �׸��尡 ȣ��ȴ�.
     EXPORTING
       i_structure_name = 'ZTHSOCCER'               "�ʵ�īŻ�α� ���� : EXPORTING �� i_structure_name���� ABAP Dictionary�� �ִ� �ʵ�īŻ�α׸� �����ϰڴٴ� ��.(�ڵ�����)
       CHANGING
         it_outtab = it_tab.
     ENDIF.



endmodule.                 " INIT_CONT  OUTPUT