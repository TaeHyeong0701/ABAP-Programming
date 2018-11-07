*&---------------------------------------------------------------------*
*& Report  Z_TH0701_SELECTIONSCREEN_1
*&
*&------------------------------------------------------------------------------------------------------*
*& Scenario 1. 숫자 1과 숫자 2를 받을 수 있는 SELECTION SCREEN을 만들어라.
*&             2. 숫자 1과 숫자 2사이에는 comment 명령어를 이용하여, TO 텍스트를 출력하라.
*&             3. 숫자 1과 숫자 2사이에 있는 값(숫자 1과 숫자2도 포함) 출력하라.
*&------------------------------------------------------------------------------------------------------*

REPORT  Z_TH0701_SELECTIONSCREEN_1.

SELECTION-SCREEN BEGIN OF LINE. "---> 파라미터를 여러 개 묶어서 한 라인으로 생성. 라인에서 SELECT-OPTIONS, SELECTION-SCREEN SKIP n 구문 사용 불가.
SELECTION-SCREEN COMMENT 1(6) text-001. "---> (6) Text object의 dlen을 참조하자.
PARAMETERS : num1 TYPE i.
SELECTION-SCREEN COMMENT 23(2) text-002." FOR FIELD num1.  "---> 22번째 위치부터 2자리를 차지하게 해라.
* For field : the field help or input help for sel is displayed when the user selects the output field using the function keys F1 and F4.
* 16자리로 Parameter 자리 취급함. (숫자는 14자리까지 입력.) 너무 가까이 붙이면 짤릴수도 있다.
*SELECTION-SCREEN POSITION POS_LOW. "---> 이전으로 부터 가장 가까운 위치에 우측에 나열됨.
*SELECTION-SCREEN POSITION POS_HIGH. "---> 이전으로 부터 가장 먼 곳 위치에 우측에 나열됨.
PARAMETERS : num2 TYPE i.
SELECTION-SCREEN END OF LINE.

NEW-LINE. "bar 생성.

*--- 사이값 출력 로직.
DATA num3 type i.
num3 = num1.
DO.
  IF num3 > num2.
    exit.
  else.
    WRITE : num3.
    num3 = num3 + 1.
    endif.
  ENDDO.