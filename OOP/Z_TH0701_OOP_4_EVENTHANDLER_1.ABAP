*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OBJECT_3_EVENTHANDLER
*&
*&---------------------------------------------------------------------*
*&
*&
*&
*&---------------------------------------------------------------------*
* 이벤트 핸들러는 private 섹션에도 접근하도록 해준다.
REPORT  z_th0701_object_3_eventhandler.
*----------------------------------------------------------------------*
*       CLASS t_class DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS t_class DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    EVENTS trigger.                                                        "trigger 이벤트 선언.
ENDCLASS.                    "t_class DEFINITION
*----------------------------------------------------------------------*
*       CLASS t_class IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS t_class IMPLEMENTATION.
  METHOD constructor.
    WRITE : / '여기는 trigger 메소드입니다.'.
    RAISE EVENT trigger.                                                   "trigger 이벤트 발생 부분.
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
    METHODS event FOR EVENT trigger OF t_class.                             "Handler쪽에서 trigger 쪽 이벤트 감지를 위한 메서드.(옵저버 역할)
ENDCLASS.                    "h_class DEFINITION

*----------------------------------------------------------------------*
*       CLASS h_class IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS h_class IMPLEMENTATION.

  METHOD constructor.
*        ENDMETHOD.
    SET HANDLER me->event FOR ALL INSTANCES.                              "레지스터(헨들러 등록 및 적용범위설정) // FOR ALL INSTANCES : 모든 인스턴스에 대해 적용하겠다.
  ENDMETHOD.                                            "constructor
  METHOD event.
    WRITE : / '여기는 handlermethod입니다'.
  ENDMETHOD.                                            "event
ENDCLASS.                                               "h_class IMPLEMENTATION

DATA : obj1 TYPE REF TO t_class,
       obj2 TYPE REF TO h_class,
       obj3 TYPE REF TO t_class.

START-OF-SELECTION.
  CREATE OBJECT obj2.                                                     "핸들러 메소드는 먼저 정의한다.
  CREATE OBJECT obj1.                                                     "트리거 메소드는 나중에 정의한다. constructor가 실행되자 마자 호출해야 하므로.
  CREATE OBJECT obj3.                                                     "2차 트리거 메소드