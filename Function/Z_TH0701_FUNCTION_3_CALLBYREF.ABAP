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
*                                                                                                  USING VALUE   --->   ������ ���� ����.   --->   Swap Fail
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
*                                                                                                  CHANGING VALEUE   --->   ������ "�ּ�"���� ����.   --->   Swap Success
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
*                                                                                                    CHANGING  --->   ������ "�ּ�"���� ����.   --->   Swap Success
*----------------------------------------------------------------------*
*      -->P_NUM5  text
*      -->P_NUM6  text
*----------------------------------------------------------------------*
FORM swapbyreference_2  CHANGING p_n1 TYPE i                                   "CHANGING ��ſ� USING ����ص�, Sucess.
                                 p_n2 TYPE i.
  temp = p_n1.
  p_n1 = p_n2.
  p_n2 = temp.
ENDFORM.                    " SWAPBYREFERENCE_2

* ����
* USING�� CHANGING�� �������� USING�� VALUE�� �Բ� ����ϸ�, ���� ����������, CHANGING�� ������� �ּҸ� ������.
* Call By Reference�� ������ ������ ����� �޸��� �ּҰ��� �̿��Ͽ� ��ȯ�� ����������!
* Call By Value�� Ư�� ���α׷�(���⼭�� Perform���� �ش�!)�� ���� �޸� ������ �������� ������ �����ϰ� ����ϴٰ�, Ư�� ���α׷��� ����Ǹ�, ������ �Ҹ��.