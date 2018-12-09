*&---------------------------------------------------------------------*
*& Report  Z_TH0701_FUCTION_13_PROGRAM
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeongKim
*& Reporting Date: `18.12.09
*& Subject: Active Local Program (Activate NotePad and Save Notepad File )
*&          메모장 프로그램을 호출하여, 특정위치에 특정 파일명으로 저장하는 프로그램을 만들어보자!
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_FUCTION_13_PROGRAM.

**************************************************************************
*   저장 하고 싶은 파일명을 입력받는 파라미터 값
**************************************************************************
PARAMETERS NewFile type string.

**************************************************************************
*   로컬 프로그램 호출
**************************************************************************
CALL FUNCTION 'WS_EXECUTE'
EXPORTING
  cd = 'C:\Users\xdkvl\OneDrive\바탕 화면\GITHUB\ABAP-Programming\Function'   " 저장 위치
  COMMANDLINE = NewFile                                                     " 파일명 전송
  PROGRAM = '%windir%\system32\notepad.exe'.                                " 메모장 프로그램 호출