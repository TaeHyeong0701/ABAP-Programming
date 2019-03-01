*&---------------------------------------------------------------------*
*& Report  Z_TH0701_DNTABCHECK
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_DNTABCHECK.

PARAMETERS result TYPE string.

 DATA : tdd02l LIKE dd02l.                         " SAP TABLE ������ ����.

  SELECT * FROM  dd02l                             " SAP TABLE���� ��ȸ.
         INTO tdd02l
         WHERE  tabname  = result                  " ��ȸ�� ���.
             AND    as4local = 'A'                 " ���ÿ� ��Ƽ��Ǿ��°�? A :
         AND   ( tabclass      <> 'INTTAB'         " ���̺� Ÿ��. (INTTAB : ����ü, Ŭ������ ���̺�)
                 AND tabname   <> 'APPEND'         "
                 AND tabclass  <> 'VIEW' ).        "
  ENDSELECT.
    if sy-subrc = 0.
      WRITE : / 'ABAP Dictionary�� ���̺��� �ֽ��ϴ�.'.
    ELSE.
      WRITE : / 'ABAP Dictionary�� ���̺��� �����ϴ�.'.
      ENDIF.

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
