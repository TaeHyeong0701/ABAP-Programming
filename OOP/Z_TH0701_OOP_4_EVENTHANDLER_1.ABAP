*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OBJECT_3_EVENTHANDLER
*&
*&---------------------------------------------------------------------*
*&
*&
*&
*&---------------------------------------------------------------------*
* �̺�Ʈ �ڵ鷯�� private ���ǿ��� �����ϵ��� ���ش�.
REPORT  z_th0701_object_3_eventhandler.
*----------------------------------------------------------------------*
*       CLASS t_class DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS t_class DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    EVENTS trigger.                                                        "trigger �̺�Ʈ ����.
ENDCLASS.                    "t_class DEFINITION
*----------------------------------------------------------------------*
*       CLASS t_class IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS t_class IMPLEMENTATION.
  METHOD constructor.
    WRITE : / '����� trigger �޼ҵ��Դϴ�.'.
    RAISE EVENT trigger.                                                   "trigger �̺�Ʈ �߻� �κ�.
  ENDMETHOD.                    "constructor
ENDCLASS.                    "t_class IMPLEMENTATION
*----------------------------------------------------------------------*
*       CLASS h_class DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS h_class DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    METHODS event FOR EVENT trigger OF t_class.                             "Handler�ʿ��� trigger �� �̺�Ʈ ������ ���� �޼���.(������ ����)
ENDCLASS.                    "h_class DEFINITION

*----------------------------------------------------------------------*
*       CLASS h_class IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS h_class IMPLEMENTATION.

  METHOD constructor.
*        ENDMETHOD.
    SET HANDLER me->event FOR ALL INSTANCES.                              "��������(��鷯 ��� �� �����������) // FOR ALL INSTANCES : ��� �ν��Ͻ��� ���� �����ϰڴ�.
  ENDMETHOD.                                            "constructor
  METHOD event.
    WRITE : / '����� handlermethod�Դϴ�'.
  ENDMETHOD.                                            "event
ENDCLASS.                                               "h_class IMPLEMENTATION

DATA : obj1 TYPE REF TO t_class,
       obj2 TYPE REF TO h_class,
       obj3 TYPE REF TO t_class.

START-OF-SELECTION.
  CREATE OBJECT obj2.                                                     "�ڵ鷯 �޼ҵ�� ���� �����Ѵ�.
  CREATE OBJECT obj1.                                                     "Ʈ���� �޼ҵ�� ���߿� �����Ѵ�. constructor�� ������� ���� ȣ���ؾ� �ϹǷ�.
  CREATE OBJECT obj3.                                                     "2�� Ʈ���� �޼ҵ�