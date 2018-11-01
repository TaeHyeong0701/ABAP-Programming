*&---------------------------------------------------------------------*
*& Report  Z_TH0701_INTERNALTABLE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
* 본인이 가장 좋아하는 인터널 테이블 방식 ---> Method1.
* 코드를 줄일 수 있는 방식(헤더라인) ---> Method2.

REPORT  Z_TH0701_INTERNALTABLE.

TYPES : BEGIN OF header_str,
  CAR TYPE SFLCREW-CARRID,
  CON TYPE SFLCREW-CONNID,
  FLD TYPE SFLCREW-FLDATE,
  END OF header_str.
* 구조체 선언 ---> Method2에서 이용해보겠음.

* TYPE TABLE OF = TYPE STANDARD TABLE OF
* [Method1]선언 : 코드가 분명해서 추후 유지보수 용이.
DATA : it1_sflcrew TYPE TABLE OF sflcrew, "Internal Table 선언시, ABAP
      wo1_sflcrew LIKE LINE OF it1_sflcrew. "WorkArea

*---------------------------------------------------------------------------------------------------------------------
* [Method2]선언 : 추후 코딩양을 줄일 수 있는 방법이지만, 가독성이 떨어짐. SAP에서는 헤더라인을 사용하지 않을 것을 권고.
DATA : it2_sflcrew TYPE TABLE OF header_str WITH HEADER LINE. "인터널 테이블 선언과 함께 동일한 이름으로 헤더라인 설정됨.

*---------------------------------------------------------------------------------------------------------------------
* 항공사가 AA이면서 비행일은 2009년 7월 9일기준 조회.
* [Method1] insert
SELECT client carrid connid fldate "테이블의 타입을 맞추기위해, ABAP Dictionary 테이블과 매칭을 시켜줬음.
  FROM SFLCREW
  INTO TABLE it1_sflcrew
  WHERE CARRID = 'AA' and
  fldate = '20090709'.
*---------------------------------------------------------------------------------------------------------------------
* [Method2] insert
SELECT carrid connid fldate
  FROM SFLCREW
  INTO TABLE it2_sflcrew
  WHERE CARRID = 'AA' and
  fldate = '20090709'.

*---------------------------------------------------------------------------------------------------------------------
* [Method1] print
WRITE :  '첫 번째 방법입니다.', /.
LOOP AT it1_sflcrew INTO wo1_sflcrew.
WRITE : wo1_sflcrew-Carrid, wo1_sflcrew-connid, wo1_sflcrew-FLDate, /.
ENDLOOP.

*---------------------------------------------------------------------------------------------------------------------

* [Method2] print
WRITE :  '두 번째 방법입니다.', /.
LOOP AT it2_sflcrew.
WRITE : it2_sflcrew-Car, it2_sflcrew-con, it2_sflcrew-FLD, /.
ENDLOOP.
*---------------------------------------------------------------------------------------------------------------------