*&---------------------------------------------------------------------*
*& Report  ZBC400_08_COMPUTE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zbc400_08_compute.
* Practice 14
TYPES num1 TYPE i.

PARAMETERS : pa_int1 TYPE i,
* 세 개의 값을 입력받아라.
pa_op TYPE c LENGTH 1,
* Length의 디폴트는 1이다. 고로 써도 되고, 안써도 된다.
pa_int2 TYPE i.

DATA gv_result TYPE p LENGTH 16 DECIMALS 2.
* 나누다 보면, 소수도 나올 수 있으니까. P타입으로 지정하자.
* 14자리의 정수, 2자리의 소수로 나온다.
* DECIMAL로 짤리는 변수는 자동 반올림이다.
DATA gv_num TYPE num1.

IF ( pa_op = '+' OR
  pa_op = '-'  OR
  pa_op = '*' OR
  pa_op = '/' AND pa_int2 <> 0 ).
* 가용한 연산자만 들어올경우만 + pa_int2 가 0이 아닐경우(나누기 때문에)에만  case문으로 넘어가자.
* 문자값을 식별해야 되므로 '' 붙여줘야되.

  CASE pa_op.
    WHEN '+'.
      gv_result = pa_int1 + pa_int2.
    WHEN '-'.
      gv_result = pa_int1 - pa_int2.
    WHEN '*'.
      gv_result = pa_int1 * pa_int2.
    WHEN '/'.
      gv_result = pa_int1 / pa_int2.
  ENDCASE.
* 케이스별 연산 실시
  WRITE: 'Result'(res), gv_result.


ELSEIF pa_op = '/' AND pa_int2 = 0.
message 'No division by zero!' TYPE 'E'.
*에러로 메시지 출력한다.

*  WRITE 'No division by zero!'(dbz).
ELSE.
*  WRITE 'Invalid operator!'(iop).
  message 'Invalid operator!' TYPE 'I'.
*  대소문자 구분해야되! Information 창 출력.
*  message 'Invalid operator!' TYPE 'W'.
* Warning 출력.
ENDIF.
gv_num = ipow( base = 2 exp = 3 ).
WRITE : num.