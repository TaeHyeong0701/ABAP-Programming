*&---------------------------------------------------------------------*
*& Report  ZBC400_08_REP_A_TH
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZBC400_08_REP_A_TH.

type-pools: icon, col.
* 아이콘, 색상등 관련한 변수타입을 정의하는 것이 type-pools 임.

CONSTANTS: gc_limit_red type s_flghtocc value 98,
gc_limit_yellow type s_flghtocc value 75.
* 상수 2개를 선언한다.

DATA: gt_flights type bc400_t_flights, " 인터널 테이블 선언
      gs_flight type bc400_s_flight. " structure 선언.

PARAMETERS:
pa_car type bc400_s_flight-carrid. " 구조체 타입 중 carrid로 타입을 선언한다.
* [옵션] OBLIGATORY : 필수로 입력시킨다.

SELECT-OPTIONS:
so_con FOR gs_flight-connid." 선택화면을 만들어주는 SELECT-OPTIONS을 이용하고, 타입은 구조체 변수중에 connid를 이용해 so_con 선택변수를 선언함.
* [옵션] NO-EXTENSION을 옵션으로 가져가면, 범위를 여러값으로로 확장하진 않겠다.
* [옵션] NO INTERVALS : 범위를 두지 않겠다.
* [옵션] NO-EXTENSION + NO INTERVALS도 활용 가능.

 SELECT carrid connid fldate seatsmax seatsocc
 FROM sflight
 INTO TABLE gt_flights
 WHERE carrid  = pa_car "파라미터는 단일 필드이기 때문에 비교시 '=' 활용 가능하지만,
 AND connid IN so_con. "SELECT-OPTIONS는 반드시 'IN'을 활용해야된다.

loop at gt_flights into gs_flight. "인터널 테이블의 값을 한 행, 한 행 읽어서 구조체에 넣겠다.
  new-line.
  gs_flight-percentage = gs_flight-seatsocc / gs_flight-seatsmax * 100.
  if gs_flight-percentage >= gc_limit_red.
    write icon_red_light as icon.
    elseif gs_flight-percentage >= gc_limit_yellow. "percentage가 yellow보다 크다면
      write icon_green_light as icon.
      endif.
      write : gs_flight-carrid COLOR col_key,
      gs_flight-connid COLOR COL_KEY,
      gs_flight-fldate color col_key, "color는 색깔을 입히기 위한, WRITE의 옵션중 하나이다.
      gs_flight-seatsmax,
      gs_flight-seatsocc,
      gs_flight-percentage.
endloop.
* SELECT-OPTIONS는 인터널 테이블과 같이 여러건의 데이터가 들어가는 것을 확인할 수 있다.
* RANGE 변수는 선택화면을 만들어주지 않지만, SELECT-OPTIONS는 선택화면을 만들어준다.