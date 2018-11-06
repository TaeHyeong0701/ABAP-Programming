*&---------------------------------------------------------------------*
*& Report  Z_TH0701_SYSUBRIC
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
* ABAP Dictionary에 정의된 테이블을 가져오며, 값이 없으면, sy-subrc을 활용하여, 디버깅을 용이하도록 활용해보자.
* 디버깅시 값이 없는 값을 조회할 떄, SY-SUBRC값이 4가 됨을 확인할 수 있다.
REPORT  Z_TH0701_SYSUBRIC.

DATA : warning TYPE String.
types : BEGIN OF st_sflcrew,
  carrid type c length 3,
  FLDATE TYPE D,
  EMP_NUM TYPE n LENGTH 10,
  ROLE TYPE c LENGTH 25,
END OF st_sflcrew.

DATA : wo_sflcrew TYPE st_sflcrew.


SELECT carrid fldate emp_num role FROM sflcrew INTO wo_sflcrew
  WHERE CARRID = 'AB'.                                          " ---> AA로 변경하여 조회하면 성공함. : 값이 존재하기 때문.
ENDSELECT.
  IF SY-SUBRC = 0.
  ELSE.
      WRITE : / '해당 하는 항공사의 데이터는 없습니다.'.
  ENDIF.

 SELECT CARRID fldate emp_num role FROM sflcrew INTO wo_sflcrew
   where FLDATE = 99999999.                                      " ---> 20090709로 변경하여 조회하면 성공함. : 값이 존재하기 때문.
 ENDSELECT.
     IF SY-SUBRC = 0.
     ELSE.
     WRITE : / '해당일자에 비행하지 않았습니다.'.
 ENDIF.

* SY-SUBRC = 0 ---> 데이터값이 정상적으로 할당되었을 경우.
* SY-SUBRC = 4 ---> 데이터값이 할당되지 않았을 경우.