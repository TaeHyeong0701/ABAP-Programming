*&---------------------------------------------------------------------*
*&  Include           Z_TH0701_STATICATTRIBUTE_TOP
*&---------------------------------------------------------------------*
CLASS static_practice DEFINITION.                                         " Ŭ���� ���Ǻ�
  PUBLIC SECTION.                                                         " Public���� ������ �ؾ�, ���� object�� static������ ���� ������ �� �� ����.
* PRIVATE SECTION.                                                        " Protected�� �ο� Instance Method�� ����ϰ����Ѵٸ�, �ڽ� Ŭ�������� public���� ó���ؾ���.
    METHODS add_practice IMPORTING iv_num1 TYPE i.
    CLASS-DATA : static_num TYPE i.                                       "Static ����
    DATA : instance_num TYPE i.                                           "Instance ����
ENDCLASS.                    "static_practice DEFINITION
*----------------------------------------------------------------------*
*       CLASS static_practice IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS static_practice IMPLEMENTATION.                                     " Ŭ���� �����
  METHOD add_practice.                                                    "���� Static ������ instance ������ �Է¹޴� ������ ������.
    static_num = iv_num1 + static_num.
    instance_num = iv_num1 + instance_num.
  ENDMETHOD.                    "add_practice
ENDCLASS.                    "static_practice IMPLEMENTATION
DATA : obj1 TYPE REF TO static_practice,                                  " Ŭ���� ��ü ����
      obj2 TYPE REF TO static_practice.                                   " Ŭ���� ��ü ����