*&---------------------------------------------------------------------*
*& Report  ZBC400_08_ZTEST4
*&
*&---------------------------------------------------------------------*
*&Scenario 1. Static 변수와 Instance 변수의 차이점을 알아보자.
*&Result 1. Static 변수 = object별로도 공유되는 공통의 데이터
*&       2. Instance 변수 = 각각의 Instance들에게만 존재하는 데이터
*&---------------------------------------------------------------------*

REPORT  z_th0701_staticattribute.

INCLUDE Z_TH0701_STATICATTRIBUTE_TOP.

START-OF-SELECTION.

  CREATE OBJECT obj1.                   "객체 생성부
  CREATE OBJECT obj2.

  obj1->add_practice( 30 ).             "Static 변수와 Instance 변수에 30을 더해줘라.
  WRITE : / obj1->static_num.           
  WRITE : / obj1->instance_num.
*=======================================Static : 30, Instance : 30.
  obj2->add_practice( 15 ).             "Static 변수와 Instance 변수에 15을 더해줘라.
  WRITE : / obj2->static_num.
  WRITE : / obj2->instance_num.
*=======================================Static : 45, Instance : 15.