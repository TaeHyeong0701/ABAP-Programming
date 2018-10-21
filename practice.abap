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
* �� ���� ���� �Է¹޾ƶ�.
pa_op TYPE c LENGTH 1,
* Length�� ����Ʈ�� 1�̴�. ��� �ᵵ �ǰ�, �Ƚᵵ �ȴ�.
pa_int2 TYPE i.

DATA gv_result TYPE p LENGTH 16 DECIMALS 2.
* ������ ����, �Ҽ��� ���� �� �����ϱ�. PŸ������ ��������.
* 14�ڸ��� ����, 2�ڸ��� �Ҽ��� ���´�.
* DECIMAL�� ©���� ������ �ڵ� �ݿø��̴�.
DATA gv_num TYPE num1.

IF ( pa_op = '+' OR
  pa_op = '-'  OR
  pa_op = '*' OR
  pa_op = '/' AND pa_int2 <> 0 ).
* ������ �����ڸ� ���ð�츸 + pa_int2 �� 0�� �ƴҰ��(������ ������)����  case������ �Ѿ��.
* ���ڰ��� �ĺ��ؾ� �ǹǷ� '' �ٿ���ߵ�.

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
* ���̽��� ���� �ǽ�
  WRITE: 'Result'(res), gv_result.


ELSEIF pa_op = '/' AND pa_int2 = 0.
message 'No division by zero!' TYPE 'E'.
*������ �޽��� ����Ѵ�.

*  WRITE 'No division by zero!'(dbz).
ELSE.
*  WRITE 'Invalid operator!'(iop).
  message 'Invalid operator!' TYPE 'I'.
*  ��ҹ��� �����ؾߵ�! Information â ���.
*  message 'Invalid operator!' TYPE 'W'.
* Warning ���.
ENDIF.
gv_num = ipow( base = 2 exp = 3 ).
WRITE : num.