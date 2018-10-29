*&---------------------------------------------------------------------*
*& Report  Z_TH0701_SORTEDTABLE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
* PreCondition  ---> Sorted table Standard Table의 차이점을 명확히 알 수 있는 테이블을 구현하거나 이용하자.
*                    SAP에서 사전에 정의한 테이블 모델들은 입력된 순서와, 대부분의 필드값들이 키값으로 구현되어 있어서,
*                   본인은 별도 테이블(ZTHPRACTICE)을 구현하여, 정렬 순서에 대해 가시적으로 알아보았음.
*

*
*
REPORT  Z_TH0701_SORTEDTABLE.


DATA : it_g_sflcrew TYPE TABLE OF zthpractice, "인터널 테이블을 TYPE TABLE OF를 이용하여 선언.
       wo_g_sflcrew LIKE LINE OF it_g_sflcrew, "WorkArea를 Like Line OF를 이용하여 선언.
       it_s_sflcrew TYPE SORTED TABLE OF zthpractice with NON-UNIQUE KEY ADDRESS,
       wo_s_sflcrew LIKE LINE OF it_s_sflcrew.
SELECT *
  FROM zthpractice
  INTO TABLE it_g_sflcrew.
* Standard 형식의 인터널 테이블에 zthpractice 테이블의 값들을 집어넣어 준다.
SELECT *
  FROM zthpractice
  INTO TABLE it_s_sflcrew.
* Sorted 형식의 인터널 테이블에 zthpractice 테이블의 값들을 집어넣어준다.

WRITE : / 'Stanadard 형식'.
 LOOP AT it_g_sflcrew INTO wo_G_sflcrew.
  write : / wo_g_sflcrew-id, wo_g_sflcrew-pw, wo_g_sflcrew-name, wo_g_sflcrew-phone.
ENDLOOP.
* Standard Table테이블에 구조를 선언할 떄 사용되는 키값에 의해서 정렬됨을 확인할 수 있음

WRITE : / 'Sorted 형식'.
LOOP AT it_S_sflcrew INTO wo_S_sflcrew.
  write : / wo_S_sflcrew-id, wo_s_sflcrew-pw, wo_S_sflcrew-name, wo_s_sflcrew-phone.
ENDLOOP.
* Sorted Table 테이블은 Non-Unique key 뒤에 지정된 필드순서로 데이터를 출력한다.