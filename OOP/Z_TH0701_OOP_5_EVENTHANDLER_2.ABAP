*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OOP_5_EVNETHANDLER
*----------------------------------------------------------------------*
*& 시나리오 : 배럭클래스와 팩토리 클래스에서 각각 마린 메딕, 탱크를 생산하는 로직을 만든다.(트리거 클래스)
*&        : 트리거 클래스들에서 생산이 될때 마다, 인구클래스에서 현재의 인구수들을 산출해낸다.(핸들러 클래스)
*&
*&---------------------------------------------------------------------*
*& 알게된 사실 1. SET HANDLER의 기능은 핸들러를 레지스터 하는 역할을 하므로, 해당 기능이 CONSTRUCTOR메소드에 삽입이 안되있으면, 별도의 로직을 구현해서 지정을 해주어야 한다.
*&             % 통상적으로, 트리거 클래스에 핸들러클래스는 영향을 받는 관계이므로, CONSTRUCTOR를 지정해주고, 별도의 조건을 핸들러클래스에서 지정하여, 제한적으로 호출하고자하면,
*&               별도 메소드내에 기능을 삽입해주고, 해당 메소드를 호출하는 기능을 구현해주면 된다.
*&          2. 트리거클래스가 다르다면, 핸들러 클래스에서도 set handler(레지스터) 및 method(실제 메소드)의 이름을 다르게하여 지정해주어야 한다.
*&             ex) 배럭 클래스(트리거)의 add_population,팩토리 클래스(트리거)의 add_population  ---> on_add_population(핸들러 클래스)
*&         
*&---------------------------------------------------------------------*

REPORT  z_th0701_oop_5_evnethandler.
DATA : result TYPE i.
DATA : unit TYPE i.
*----------------------------------------------------------------------*
*       CLASS t_barrack DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS t_barrack DEFINITION.
  PUBLIC SECTION.
    METHODS marine_product IMPORTING marine_num TYPE i EXPORTING marine_unit TYPE i.
    METHODS medic_product IMPORTING medic_num TYPE i EXPORTING medic_unit TYPE i.  
    EVENTS add_population.                                                   "트리거 이벤트 등록.
ENDCLASS.                    "t_barrack DEFINITION

*----------------------------------------------------------------------*
*       CLASS t_factory DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS t_factory DEFINITION.
  PUBLIC SECTION.
    METHODS tank_product IMPORTING tank_num TYPE i EXPORTING tank_unit TYPE i. 
    EVENTS add_population.                                                     "트리거 이벤트 등록.

ENDCLASS.                    "t_factory DEFINITION

*----------------------------------------------------------------------*
*       CLASS h_population DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS h_population DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    METHODS on_add_population FOR EVENT add_population OF t_barrack.            "핸들러에서 배럭 트리거 감시.
    METHODS on_add_population_tank FOR EVENT add_population OF t_factory.       "핸들러에서 팩톹리  트리거 감시.
ENDCLASS.                    "h_population DEFINITION

*----------------------------------------------------------------------*
*       CLASS t_barrack IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS t_barrack IMPLEMENTATION.
  METHOD marine_product.
    marine_unit = marine_num * 1.
    RAISE EVENT add_population.                                                  "배럭 트리거의 RAISE EVENT지점1.
  ENDMETHOD.                    "marine_product
  METHOD medic_product.
    medic_unit = medic_num * 2.
    RAISE EVENT add_population.                                                  "배럭 트리거의 RAISE EVENT지점2.
  ENDMETHOD.                    "medic_product
ENDCLASS.                    "t_barrack IMPLEMENTATION
*----------------------------------------------------------------------*
*       CLASS t_factory IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS t_factory IMPLEMENTATION.
  METHOD tank_product.
    tank_unit = tank_num * 3.
    RAISE EVENT add_population.                                                   "팩토리 트리거의 RAISE EVENT지점.
  ENDMETHOD.                    "tank_product
ENDCLASS.                    "t_factory IMPLEMENTATION
*----------------------------------------------------------------------*
*       CLASS h_population IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS h_population IMPLEMENTATION.
  METHOD constructor.
    SET HANDLER me->on_add_population FOR ALL INSTANCES.                           "배럭 트리거에 대한 핸들러 등록.
        SET HANDLER me->on_add_population_tank FOR ALL INSTANCES.                  "팩토리 트리거에 대한 핸들러 등록.
  ENDMETHOD.                    "constructor
  METHOD on_add_population.
    result = result + unit.
    WRITE : /'현재까지 인구수 : ', result.
  ENDMETHOD.                    "on_add_population
    METHOD on_add_population_tank.
    result = result + unit.
    WRITE : /'현재까지 인구수 : ', result.
  ENDMETHOD.                    "on_add_population
ENDCLASS.                    "h_population IMPLEMENTATION

DATA : obj1 TYPE REF TO t_barrack,
      obj2 TYPE REF TO t_factory,
      obj3 TYPE REF TO h_population.

START-OF-SELECTION.


  CREATE OBJECT obj1.
  CREATE OBJECT obj2.
  CREATE OBJECT obj3.

  CALL METHOD obj1->marine_product                   "3명의 인구수가 추가됨
    EXPORTING
      marine_num  = 3
    IMPORTING
      marine_unit = unit.
  
  CALL METHOD obj2->tank_product                       "9개인구수가 추가됨.
    EXPORTING
      tank_num  = 3
    IMPORTING
      tank_unit = unit.
  
    CALL METHOD obj1->medic_product                    "6명의 인구수가 추가됨
    EXPORTING
      medic_num  = 3
    IMPORTING
      medic_unit = unit.