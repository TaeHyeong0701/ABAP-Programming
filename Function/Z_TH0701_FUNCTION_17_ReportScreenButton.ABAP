*&---------------------------------------------------------------------*
*& Report  Z_TH0701_BUTTON
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong 
*& Reporting Date: '18.12.19
*& Subject: 레포트 프로그램 내부에서 Application toolbar쪽 button을 출력한다.(스크린을 이용하지 않고)
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_FUNCTION_17_ReportScreenButton.

*&--------------------------------------------------------------------&*
*& 1. SSCRFIELDS라는 셀렉션 스크린관련된 정보가 담긴 SSCRFILEDS를 참조한다.
*& 2. type-pools : icon 을 사용하여, SAP icon을 참조한다.
*& 3. Menu Painter타입으로 변수를 선언해준다.
*&--------------------------------------------------------------------&*
TABLES SSCRFIELDS.
type-pools : icon.
DATA: LS_SEL_BUTTON TYPE SMP_DYNTXT.


SELECTION-SCREEN FUNCTION KEY 1. "button on the application toolbar

*&--------------------------------------------------------------------&*
*&  STEP 2
*&--------------------------------------------------------------------&*
*& 1. 선언한 변수에 ICON과 여러 속성들을 정의해준다.
*&--------------------------------------------------------------------&*
INITIALIZATION.
LS_SEL_BUTTON-ICON_ID = ICON_XLS.
LS_SEL_BUTTON-QUICKINFO = 'TEMPLATE DOWNLOAD'.
LS_SEL_BUTTON-ICON_TEXT = 'TEMPLATE DOWNLOAD'.
SSCRFIELDS-FUNCTXT_01 = LS_SEL_BUTTON.
*&--------------------------------------------------------------------&*
*&  STEP 3
*&--------------------------------------------------------------------&*
*& 1. 셀렉션 스크린 출력 및 로직 부분 이어서 작성.
*&--------------------------------------------------------------------&*
PARAMETERS to_day TYPE SY-DATUM.
*...