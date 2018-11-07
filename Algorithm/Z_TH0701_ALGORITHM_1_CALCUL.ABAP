*&---------------------------------------------------------------------*
*& Report  Z_TH0701_ALGORITHM_1_CALCUL
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_ALGORITHM_1_CALCUL.
TYPES title(30) type c.
DATA test TYPE title.
PARAMETERS : num1 type P,
             num2 TYPE P,
*            num1, num2 --->변수를 PARAMETERS를 이용하여, 출력 받음.
             operator type c. "operator ---> 산술연산자 입력을 위한 변수

DATA result type P DECIMALS 2.
* 계산 결과를 받기 위한 변수 지정 ---> DECIMAL을 이용한, 소수점 자리수 출력 조정 가능.

test = '사칙연산 계산기'.
write : test.

PERFORM calcul using num1 num2 changing result."PERFORM 구문을 이용한, 계산기 서브루틴 호출.
WRITE : result.
*&---------------------------------------------------------------------*
*&      Form  CALCUL
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
* CALCUL 서브루틴 로직 시작.
form CALCUL using n1 type p
                  n2 type P
*                 n1, n2의 매개변수를 받아오기.
      changing n3 type P.
*                 n3 라는 OUTPUT 변수 선언하기.
* USING과 CHANGING의 차이.
if operator = '+'.
   n3 = n1 + n2.
* 더하기 계산 로직.

ELSEIF operator = '-'.
  n3 = n1 - n2.
* 빼기 계산 로직.
elseif operator = '*'.
    n3 = n1 * n2.
* 곱하기 계산 로직.
elseif operator = '/'.
  n3 = n1 / n2.
* 나누기 계산 로직.
ELSE.
  write : '계산 로직에 해당하지 않는 명령입니다.'.
ENDIF.
endform.