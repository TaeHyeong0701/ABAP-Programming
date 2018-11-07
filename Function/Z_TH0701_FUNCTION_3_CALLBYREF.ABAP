*&---------------------------------------------------------------------*
*& Report  Z_TH0701_FUNCTION_3_CALLBYREF
*&
*&---------------------------------------------------------------------*
*&
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_FUNCTION_3_CALLBYREF.

DATA : num1 TYPE i,
      num2 TYPE i,
      num3 TYPE i,
      num4 TYPE i,
      num5 TYPE i,
      num6 TYPE i,
      temp TYPE i.

num1 = 10.
num2 = 20.

num3 = 10.
num4 = 20.

num5 = 10.
num6 = 20.
PERFORM swapbyvalue USING num1 num2.
PERFORM swapbyreference_1 CHANGING num3 num4.                               
PERFORM swapbyreference_2 CHANGING num5 num6.
WRITE : num1, num2, /
        num3, num4, /
        num5, num6.
*&---------------------------------------------------------------------*
*&      Form  SWAPBYVALUE
*&---------------------------------------------------------------------*
*                                                                                                  USING VALUE   --->   데이터 값을 참조.   --->   Swap Fail
*----------------------------------------------------------------------*
*      -->P_N1  text
*      -->P_N2  text
*----------------------------------------------------------------------*
FORM swapbyvalue  USING value(p_n1) TYPE i
                          value(p_n2) TYPE i.
  temp = p_n1.
  p_n1 = p_n2.
  p_n2 = temp.
ENDFORM.                    " SWAPBYVALUE
*&---------------------------------------------------------------------*
*&      Form  SWAPBYREFERENCE
*&---------------------------------------------------------------------*
*                                                                                                  CHANGING VALEUE   --->   데이터 "주소"값을 참조.   --->   Swap Success
*----------------------------------------------------------------------*
*      -->P_N1  text
*      -->P_N2  text
*----------------------------------------------------------------------*
FORM swapbyreference_1  CHANGING value(p_n1) TYPE i
                            value(p_n2) TYPE i.
  temp = p_n1.
  p_n1 = p_n2.
  p_n2 = temp.
ENDFORM.                    " SWAPBYREFERENCE
*&---------------------------------------------------------------------*
*&      Form  SWAPBYREFERENCE_2
*&---------------------------------------------------------------------*
*                                                                                                    CHANGING  --->   데이터 "주소"값을 참조.   --->   Swap Success
*----------------------------------------------------------------------*
*      -->P_NUM5  text
*      -->P_NUM6  text
*----------------------------------------------------------------------*
FORM swapbyreference_2  CHANGING p_n1 TYPE i                                   "CHANGING 대신에 USING 사용해도, Sucess.
                                 p_n2 TYPE i.
  temp = p_n1.
  p_n1 = p_n2.
  p_n2 = temp.
ENDFORM.                    " SWAPBYREFERENCE_2

* 정리
* USING과 CHANGING의 차이점은 USING은 VALUE와 함께 사용하면, 값을 참조하지만, CHANGING은 상관없이 주소를 참조함.
* Call By Reference는 변수가 실제로 저장된 메모리의 주소값을 이용하여 변환에 성공하지만!
* Call By Value는 특정 프로그램(여기서는 Perform문에 해당!)의 별도 메모리 공간에 변수값을 끌고와 저장하고 사용하다가, 특정 프로그램이 종료되면, 값들이 소멸됨.