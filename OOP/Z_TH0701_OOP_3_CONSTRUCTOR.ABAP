*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OOP_3_CONSTRUCTOR
*&
*&---------------------------------------------------------------------*
*& 알게된 사실 1. constructor의 매개 파라미터는 create object 객체(파라미터1, 파라미터2)로 넣어준다. CALL METHOD가 아니야. CREATE시 생성이 되기 떄문에.
*&          2. constructor가 있는 superclass를 상속받게 되면 반드시 superclass의 constructor를 호출해주어야 한다.
*&
*&
*&---------------------------------------------------------------------*

REPORT  z_th0701_oop_3_constructor.
DATA: total_mineral TYPE i,
      total_gas TYPE i.
*----------------------------------------------------------------------*
*       CLASS starport DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS starport DEFINITION.
  PUBLIC SECTION.
    METHODS : constructor IMPORTING mineral TYPE i gas TYPE i,
      display_write.
ENDCLASS.                    "starport DEFINITION

*----------------------------------------------------------------------*
*       CLASS starport IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS starport IMPLEMENTATION.
  METHOD constructor.
    total_mineral = mineral.
    total_gas = gas.
  ENDMETHOD.                    "constructor
  METHOD display_write.
    WRITE : / '스타포트는 미네랄: ', total_mineral,'원,', total_gas, '원 들었습니다.'.
  ENDMETHOD.                    "display_write
ENDCLASS.                "starport IMPLEMENTATION
*----------------------------------------------------------------------*
*       CLASS starportaddon DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS starportaddon DEFINITION INHERITING FROM starport.
  PUBLIC SECTION.
    METHODS constructor IMPORTING mineral TYPE i gas TYPE i.
ENDCLASS.                    "starportaddon DEFINITION

*----------------------------------------------------------------------*
*       CLASS starportaddon IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS starportaddon IMPLEMENTATION.
  METHOD constructor.
    CALL METHOD super->constructor
      EXPORTING
        mineral = 150
        gas     = 100.
    total_mineral = total_mineral + mineral.
    total_gas = total_gas + gas.
    WRITE : / '스타포트 에드온은 총 미네랄: ', total_mineral,'원,', total_gas, '원 들었습니다.'.
  ENDMETHOD.                    "constructor
ENDCLASS.                    "starportaddon IMPLEMENTATION




DATA : obj1 TYPE REF TO starport,
      obj2 TYPE REF TO starportaddon.

START-OF-SELECTION.

  CREATE OBJECT obj1
    EXPORTING
      mineral = 150
      gas     = 100.
  CALL METHOD obj1->display_write.
  CREATE OBJECT obj2
    EXPORTING
      mineral = 50
      gas     = 50.