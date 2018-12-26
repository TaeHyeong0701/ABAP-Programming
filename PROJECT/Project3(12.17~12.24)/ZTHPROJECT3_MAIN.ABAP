*&---------------------------------------------------------------------*
*& Report  ZPPR0003_08
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong
*& Reporting Date: `18.12.26
*& Subject: ���� ��ȹ ���� ���α׷�.  (x) MF50
*&---------------------------------------------------------------------*

INCLUDE zppr0003_08_top                         .    " global Data
INCLUDE zppr0003_08_o01                         .  " PBO-Modules
INCLUDE zppr0003_08_i01                         .  " PAI-Modules
INCLUDE zppr0003_08_f01                         .  " FORM-Routines
INCLUDE zppr0003_08_f02                         .  " 2��° ALV ��.
INCLUDE zppr0003_08_i02                         .   " 2��° ALV ��.
AT SELECTION-SCREEN.
********************************************************
* SMW0�� �ִ� ���� ���ø��� �������� ����.
********************************************************
IF sscrfields-ucomm = 'FC01'.   "���ø� �������� ���.
    PERFORM get_tmplate USING 'ZTEST02'.
ENDIF.

  IF sscrfields-ucomm = 'FC02'. "BDC üũ ����.
********************************************************
* Case1: �����н��� ������ ��� �������Ͽ��� ���.
********************************************************
    IF begda IS INITIAL AND filepath IS INITIAL.
      MESSAGE '������ ���ϰ� �������� �������ֽʽÿ�.' TYPE 'I'.
********************************************************
* Case2: �������� ���������� ���.
********************************************************
    ELSEIF begda IS INITIAL.
      MESSAGE '�������� ���þ��ϼ̽��ϴ�.' TYPE 'I'.
********************************************************
* Case3: ���� �н��� ���������� ���.
********************************************************
    ELSEIF filepath IS INITIAL.
      MESSAGE '������ �������ϼ̽��ϴ�.' TYPE 'I'.
********************************************************
* Case4: �Է°��� ��� �Է��Ͽ��� ���,
*        ��. CAL_WORK�� ����, Working Day ���.
*        ��. Sync�� ����, ���ͳ� ���̺��� �� ---> ALV �� ����.
*        ��. light_setting�� ����, ALV���� ���Ǵ� ��ȣ���� ����.
*        ��. ALV ȣ��.
********************************************************
    ELSE.    " �����ϰ� ���� ���� ��� �ִٸ�.
********************************************************
* 1. PERFORM cal_work : Working Day 7���� ������ִ� ����.
* 2. PERFORM sync : BDC�� �Էµ� �����͵��� ALV ���ͳ� ���̺��� �Ű��ִ� ����.
* 3. PERFORM light_setting: ALV �󿡼�, ���ǿ� ���� ��ȣ���� �ѷ��ִ� ����.
********************************************************
      IF endda IS INITIAL.
********************************************************
* Endda�� �ʱⰪ(BDC üũ�� ���ϰ� ��ٷ� ����)�̶��, Working day�� ������ְ�, ���ͳ� ���̺��� �����͸� �����ش�.
********************************************************
        PERFORM excel_upload.
        DELETE it_tab INDEX 1.
        PERFORM cal_work.
        PERFORM sync.
        CALL SCREEN 100.
********************************************************
* Endda�� �ʱⰪ(BDC üũ�� �� ���¶��)�� �ƴ϶��, ��ٷ� ���ͳ� ���̺��� �����͸� �����ش�.
********************************************************
      ELSE.
        PERFORM sync.
        CALL SCREEN 100.
      ENDIF.
    ENDIF.
  ENDIF.

********************************************************
* F4��� ����.
********************************************************
AT SELECTION-SCREEN ON VALUE-REQUEST FOR filepath.
  PERFORM f4_excel.

********************************************************
* ���� ���� üũ ����.
********************************************************
  PERFORM check_excel.
********************************************************
*  ���� ���ε带 �Ͽ�, �����͸� ���ͳ����̺��� �޴´�.
*  ù ��° ���� Į�������� �����Ƿ� ���ܽ����ش�.
********************************************************
    PERFORM excel_upload.
    DELETE it_tab INDEX 1.
    MESSAGE '���� ���ε尡 �Ϸ� �Ǿ����ϴ�.' TYPE 'S'.


START-OF-SELECTION.
  IF begda IS INITIAL AND filepath IS INITIAL.
    MESSAGE '������ ���ϰ� �������� �������ֽʽÿ�.' TYPE 'I'.
  ELSEIF begda IS INITIAL.
    MESSAGE '�������� ���þ��ϼ̽��ϴ�.' TYPE 'I'.
  ELSEIF filepath IS INITIAL.
    MESSAGE '������ �������ϼ̽��ϴ�.' TYPE 'I'.
  ELSE.
********************************************************
* �����ϰ� ������ �����Ͽ��� ��쿡�� BDC ���������.
********************************************************
    PERFORM cal_work.
    PERFORM bdc_mf50.

  ENDIF.
********************************************************
* BDC���� �Ϸ�!
********************************************************
  IF sy-subrc = 0.
    MESSAGE 'BDC ���α׷� ����Ϸ�' TYPE 'S'.
  ENDIF.

  CALL SCREEN 200.

*GUI Texts
*----------------------------------------------------------
* TH1 --> ���� ��ȹ ��� Result ALV
* XTH --> 3�� BDC ������ Ȯ��

*Text elements
*----------------------------------------------------------
* 001 File Path
* 002 BDC Program Setting


*Selection texts
*----------------------------------------------------------
* BEGDA         ������ ����
* FILEPATH         ���ϰ��
* P_MODE         BDC ��� ����


*Messages
*----------------------------------------------------------
*
* Message class: Hard coded
*   �̰��� �������� ������ �ƴմϴ�. �ٽ� �������ּ���

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701