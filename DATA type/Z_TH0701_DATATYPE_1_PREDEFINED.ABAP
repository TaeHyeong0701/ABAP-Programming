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
num3 = num_1 * num_2. " Numeric data type �׽�Ʈ�� ���� ���� ���� ����.

chartest = 'taehyoungkim'.
strtest = 'taehyoungkim'.



WRITE : num_1, / , num_2, / , packed_1, / , packed_2, / , num3, / , chartest, / , strtest.

* ===============================================================================================*
* �Ķ���� ��������  8�ڸ����� �����Ѵ�. �̻��, ���� �߻���. ---> "~can be up to 8 characters long."
* char���� ������ length ���� ������ 1�ڸ��� �����Ѵ�. ---> ������ �ڸ��� �Ѵ� ���� �ڸ��� ������ �Է��� ���, ù ��° �ڸ��� ���ڸ� ����Ѵ�.
* string���� ������ length ���� ���̵�, ��ü�� ����Ѵ�.
* LENGTH�� �ڸ� ���� �ǹ��Ѵ�. N, P, C, X������ ������.
* NUMBERIC Ÿ�԰��� ����� '���ڸ�'�� ����Ѵ�.
* P Ÿ���� ���η� DECIMAL�� �������� ������ �Ҽ����� ������� �ʴ´�.