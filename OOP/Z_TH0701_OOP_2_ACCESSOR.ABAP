*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OOP_2_ACCESSOR
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
* 알게된 사실 1. Private는 객체 단계에서도 호출 불가. ---> Public로 선언된 메서드의 implementation에 끼워서 호출해야한다.
*          2. 선언은 Private로 되고, implementation에서 public에 끼워서 호출된 private메서드는 해당 public메서드를 자식에서 호출할 떄 다시 한번 호출된다.
*          3. 메서드의 순서는 구애받지 않는다.
*            ---> 인구를 계산하는 로직이 담긴, display_population이 뒤에 나오고, 이 display_population을 호출하는 기능이 담긴 display_continent가 먼저 나와도 계산된다.
*          4. 메서드 호출부의 importing(실제로는 exporting)부는 필수가 아니다.
*            ---> 선언만 하고 안써도 오류 안난다.
*          5. sub-class에서 super-class의 protected 함수 호출 가능하며, super-class에서도 직접 protected함수를 implement에서 호출 가능.
REPORT  z_th0701_oop_2_accessor.

*----------------------------------------------------------------------*
*       CLASS korea DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS korea DEFINITION.
  PUBLIC SECTION.
    METHODS display_continent.

  PROTECTED SECTION.
    METHODS: display_location.

  PRIVATE SECTION.
    METHODS: display_population
    IMPORTING popul TYPE i
      EXPORTING popul_10000 TYPE i.

ENDCLASS.                    "korea DEFINITION
*----------------------------------------------------------------------*
*       CLASS korea IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS korea IMPLEMENTATION.
  METHOD display_location.
    WRITE : /'한반도'.
  ENDMETHOD.                    "display_location

  METHOD display_continent.
    CALL METHOD display_population( EXPORTING popul = 4000 ).             "Success : Private 메소드에 대해 해당 클래스 내부 implementation부에서의 호출.

    WRITE : /'아시아 대륙'.
  ENDMETHOD.                    "display_continent
  METHOD display_population.
    popul_10000 = popul * 10000.
    WRITE : / popul_10000, ' 인구'.
  ENDMETHOD.                    "display_population



  "display_population

ENDCLASS.                    "korea IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS seoul DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS seoul DEFINITION INHERITING FROM korea.

  PUBLIC SECTION.
    METHODS: display_population_city
    IMPORTING popul_city TYPE i
      EXPORTING popul_10000_city TYPE i.

ENDCLASS.                    "seoul DEFINITION

*----------------------------------------------------------------------*
*       CLASS seoul IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS seoul IMPLEMENTATION.
  METHOD display_population_city.
    CALL METHOD display_location( ).                                             "Success : Protected 메소드에 대해 자식 클래스의 implement부에서의 접근.
    popul_10000_city = popul_city * 10000.
    WRITE : / popul_10000_city, ' 인구'.
  ENDMETHOD.                    "display_population
ENDCLASS.                    "seoul IMPLEMENTATION
DATA : obj1 TYPE REF TO korea,
      obj2 TYPE REF TO seoul.

START-OF-SELECTION.
  CREATE OBJECT obj1.
  CREATE OBJECT obj2.

  CALL METHOD obj1->display_continent( ).    "                                  "Success : Public메소드에 대해 해당 클래스 객체에서 직접 접근.
*  CALL METHOD obj1->display_location( ).                                       "Error : Protected메소드에 대해 해당 클래스 객체에서 직접 접근. 
  CALL METHOD obj2->display_continent.                                          "Success : Public메소드에 대해 자식클래스 객체에서 직접 접근.
  CALL METHOD obj2->display_population_city( EXPORTING popul_city = 1000 ). 
* CALL method obj2->display_location( ).                                        "Error : Protected메소드에 대해 자식클래스 '객체'에서 직접 접근