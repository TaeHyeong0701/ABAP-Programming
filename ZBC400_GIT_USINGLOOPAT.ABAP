FUNCTION ZBC400_GIT_USINGLOOPAT
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  BC400_S_CONNECTION-CARRID
*"     REFERENCE(IV_CONNID) TYPE  BC400_S_CONNECTION-CONNID
*"  EXPORTING
*"     REFERENCE(ET_FLIGHTS) TYPE  BC400_T_FLIGHTS
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------
*  인터널테이블과 LOOP AT 문.(여러건의 값들을 가져오는 것)
DATA ls_flight type bc400_s_flight. "구조체 workarea 타입으로 선언.
CLEAR et_flights.


SELECT carrid connid fldate seatsmax seatsocc
  FROM sflight
  INTO TABLE et_flights " 조회된 값을 담아준다. 인터널 테이블 et_flight
*  한 번에 인터널테이블로 데이터를 담겠다.
  WHERE carrid = iv_carrid
  AND connid = iv_connid.
*  Import parameter에서 입력한 변수값(iv_carrid, iv_connid)과 비교한다..

  if sy-subrc <> 0.
    RAISE no_data. " 성공하지 않으면 Exception 호출.
    else. "성공했으면은
      loop at et_flights into ls_flight. "인터널테이블(et_flights)의 값들을 루프 실행때마다 한 건 씩WA(ls_flight)에 담아준다.
        "인터널 테이블은 말그대로 테이블(데이터저장소)이기 때문에 계산이 안돌아간다.
          ls_flight-percentage = ls_flight-seatsocc / ls_flight-seatsmax * 100. "percentage값 로직을 WA(ls_flight)에 담아준다.
          MODIFY et_flights from ls_flight index sy-tabix " s_flight 구조체 변수에 있는 percentage값을 인터널테이블(et_flights)를 업데이트 한다.
* 인터널 테이블에서 index는 순번을 말하는 것임(순서대로 입력하겠다.). 시스템이 받은 값을 어디다가 입력할지 알려줘야되기 때문에.
* index sy-tabix(테이블의 순번)는 LOOP AT과 세트로 많이 사용되겠다.
* 한 행으로 이루어진 WA에서 계산된 percentage는 한 행이 끝날때마다 해당행의 값을 이용하여 인터널테이블(et_fligths)의 값을 변경해줘야되.
      TRANSPORTING percentage. "percentage라는 필드값만 바꿔주겠다.
    Endif.
    SORT et_flights BY percentage DESCENDING. "percentage값을 기준으로 내림차순으로 정렬하겠다.
ENDFUNCTION.