*&---------------------------------------------------------------------*
*& Report  Z_TH0701_DATATYPE_1_PREDEFINED
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT  Z_TH0701_DATATYPE_1_PREDEFINED.
PARAMETERS : num_1 TYPE n LENGTH 4,
num_2 TYPE n LENGTH 4,
packed_1 TYPE p LENGTH 4,
packed_2 TYPE p LENGTH 4 DECIMALS 2.

DATA : num3 TYPE n,
      chartest type c,
      strtest type string.
num3 = num_1 * num_2. " Numeric data type 테스트를 위한 별도 변수 지정.

chartest = 'taehyoungkim'.
strtest = 'taehyoungkim'.



WRITE : num_1, / , num_2, / , packed_1, / , packed_2, / , num3, / , chartest, / , strtest.

* ===============================================================================================*
* 파라미터 변수명은  8자리까지 지원한다. 이상시, 오류 발생함. ---> "~can be up to 8 characters long."
* char형은 별도의 length 지정 없으면 1자리를 지원한다. ---> 지정된 자리를 넘는 여러 자리를 강제로 입력할 경우, 첫 번째 자리의 문자만 출력한다.
* string형은 별도의 length 지정 없이도, 전체를 출력한다.
* LENGTH는 자릿 수를 의미한다. N, P, C, X에서만 지원함.
* NUMBERIC 타입간의 계산은 '끝자리'만 계산한다.
* P 타입은 별로로 DECIMAL을 지정하지 않으면 소수값을 출력하지 않는다.