*&---------------------------------------------------------------------*
*&  Include           Z_TH0701_STATICATTRIBUTE_TOP
*&---------------------------------------------------------------------*
CLASS static_practice DEFINITION.                                         " 클래스 정의부
  PUBLIC SECTION.                                                         " Public으로 선언을 해야, 추후 object별 static변수에 별도 접근을 할 수 있음.
* PRIVATE SECTION.                                                        " Protected된 부에 Instance Method를 사용하고자한다면, 자식 클래스에서 public으로 처리해야함.
    METHODS add_practice IMPORTING iv_num1 TYPE i.
    CLASS-DATA : static_num TYPE i.                                       "Static 변수
    DATA : instance_num TYPE i.                                           "Instance 변수
ENDCLASS.                    "static_practice DEFINITION
*----------------------------------------------------------------------*
*       CLASS static_practice IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS static_practice IMPLEMENTATION.                                     " 클래스 실행부
  METHOD add_practice.                                                    "각각 Static 변수와 instance 변수를 입력받는 값으로 더해줌.
    static_num = iv_num1 + static_num.
    instance_num = iv_num1 + instance_num.
  ENDMETHOD.                    "add_practice
ENDCLASS.                    "static_practice IMPLEMENTATION
DATA : obj1 TYPE REF TO static_practice,                                  " 클래스 객체 참조
      obj2 TYPE REF TO static_practice.                                   " 클래스 객체 참조