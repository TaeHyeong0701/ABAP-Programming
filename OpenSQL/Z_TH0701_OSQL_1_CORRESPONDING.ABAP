FUNCTION Z_TH0701_OSQL_1_CORRESPONDING.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  BC400_S_CONNECTION-CARRID
*"     REFERENCE(IV_CONNID) TYPE  BC400_S_CONNECTION-CONNID
*"  EXPORTING
*"     REFERENCE(ES_CONNECTION) TYPE  BC400_S_CONNECTION
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------
  SELECT SINGLE fltime carrid connid cityfrom airpfrom
    cityto airpto deptime arrtime
*    9���� �ʵ� ���� ��ȸ�ϰڴ�.
*    [�ɼ�]* : ��� �ʵ带 �������ڴ�.
*              INTO ��� ���̺��� ������ ���� ������ ������ ����. --> corresponding field of �� �ذ��Ѵ�.
    FROM spfli
*    ��� �����ðų�? --> ���̺��� �Է� // SPFLI ���̺����� �������ڴ�.
    INTO CORRESPONDING FIELDS OF es_connection
*    es_connection�� �ְڴ�.
    WHERE carrid = iv_carrid
    AND connid = iv_connid.
*    ���ǿ� �´� ���̺��� �������ڴ�.
*   carrid(SPFLI���̺� ��)�ʵ尪 = iv_carrid(Import �Ķ���Ͱ�.)
*   connid(SPFLI ���̺� ��) �ʵ尪 = iv_connid(Import �Ķ���Ͱ�.)
*   SELECT ������ ������ "."�� ����ش�.
   IF sy-subrc <> 0. " SY-SUBRIC �� 0�� �ƴϸ�, ��, ���������� ������ �ȵǸ�,
     RAISE no_data. " RAISE�� �̿��ؼ� EXCEPTIONȣ���Ѵ�.
     ENDIF.
     ENDFUNCTION.