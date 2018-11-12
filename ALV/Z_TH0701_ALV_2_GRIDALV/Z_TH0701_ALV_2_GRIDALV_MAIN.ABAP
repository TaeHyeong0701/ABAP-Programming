*&---------------------------------------------------------------------*
*& Report  Z_TH0701_ALV_2_GRIDALV
*&
*&---------------------------------------------------------------------*
*& Writen by TaeHyeong
*& Reporting Data: `18.11.12
*&---------------------------------------------------------------------*
*///////////////////////////////////////////////////////////////////////
* [Setting]
*  1. Screen Painter: Cutsom Container 생성 (Name = 'TH_CONT1')
*  2. Screen: 'BACK' 버튼 기능 구현. ---> 구현하면, 추후 SAP의 초기화면으로 돌아가는 것을 방지할 수 있다. (매번, SE80 치기 귀찮으므로...)
*  3. Screen: ok_code 삽입.
* [INCLUDE]
*  1. F01: 기능 구현 로직 포함.
*  2. O01: 화면 호출 및 Status 생성.
*  3. I01: OK_CODE 로직 처리.
*  4. TOP: 글로벌 변수 선언.
*  5. MAIN: SELECTION SCREEN 및 CALL 스크린 호출문 포함.
*///////////////////////////////////////////////////////////////////////


INCLUDE Z_TH0701_ALV_2_GRIDALV_TOP              .    " global Data

 INCLUDE Z_TH0701_ALV_2_GRIDALV_O01              .  " PBO-Modules
 INCLUDE Z_TH0701_ALV_2_GRIDALV_I01              .  " PAI-Modules
 INCLUDE Z_TH0701_ALV_2_GRIDALV_F01              .  " FORM-Routines


START-OF-SELECTION.
 PERFORM select_data.
 END-OF-SELECTION.
 CALL SCREEN 100.