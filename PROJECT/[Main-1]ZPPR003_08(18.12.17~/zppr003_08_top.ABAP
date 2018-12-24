*&---------------------------------------------------------------------*
*& Report  ZPPR0003_08
*&
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zppr0003_08_top                         .    " global Data

INCLUDE zppr0003_08_o01                         .  " PBO-Modules
INCLUDE zppr0003_08_i01                         .  " PAI-Modules
INCLUDE zppr0003_08_f01                         .  " FORM-Routines

AT SELECTION-SCREEN.
*    PERFORM f4_Excel.
********************************************************
* SMW0에 있는 엑셀 템플릿을 가져오는 로직.
********************************************************
IF sscrfields-ucomm = 'FC01'.   "템플릿 가져오는 기능.
    PERFORM get_tmplate USING 'ZTEST02'.
ENDIF.

  IF sscrfields-ucomm = 'FC02'. "BDC 체크 로직.
********************************************************
* Case1: 파일패스와 시작일 모두 지정안하였을 경우.
********************************************************
    IF begda IS INITIAL AND filepath IS INITIAL.
      MESSAGE '적절한 파일과 시작일을 지정해주십시오.' TYPE 'I'.
********************************************************
* Case2: 시작일을 지정안했을 경우.
********************************************************
    ELSEIF begda IS INITIAL.
      MESSAGE '시작일을 선택안하셨습니다.' TYPE 'I'.
********************************************************
* Case3: 파일 패스를 지정안했을 경우.
********************************************************
    ELSEIF filepath IS INITIAL.
      MESSAGE '파일을 지정안하셨습니다.' TYPE 'I'.
********************************************************
* Case4. 입력값을 모두 입력하였을 경우,
*   - 가. CAL_WORK를 통해, Working Day 계산.
*   - 나. Sync를 통해, 인터널 테이블의 값 ---> ALV 로 전달.
*   - 다. light_setting을 통해, ALV에서 사용되는 신호등을 설정.
*   - 라. ALV 호출.
********************************************************
    ELSE.    " 시작일과 엑셀 파일 모두 있다면.
********************************************************
* 1. PERFORM cal_work : Working Day 7일을 계산해주는 로직.
* 2. PERFORM sync : BDC에 입력될 데이터들을 ALV 인터널 테이블로 옮겨주는 로직.
* 3. PERFORM light_setting: ALV 상에서, 조건에 따라 신호등을 뿌려주는 로직.
********************************************************
      IF endda IS INITIAL.
********************************************************
* Endda가 초기값(BDC 체크를 안하고 곧바로 실행)이라면, Working day를 계산해주고, 인터널 테이블로 데이터를 보내준다.
********************************************************
        PERFORM excel_upload.
        DELETE it_tab INDEX 1.
        PERFORM cal_work.
        PERFORM sync.
        PERFORM light_setting.
        CALL SCREEN 100.
********************************************************
* Endda가 초기값(BDC 체크를 한 상태라면)이 아니라면, 곧바로 인터널 테이블로 데이터를 보내준다.
********************************************************
      ELSE.
        PERFORM sync.
        PERFORM light_setting.
        CALL SCREEN 100.
      ENDIF.
    ENDIF.
  ENDIF.

********************************************************
* F4기능 삽입.
********************************************************
AT SELECTION-SCREEN ON VALUE-REQUEST FOR filepath.
  PERFORM f4_excel.



********************************************************
* 1. 엑셀 업로드를 하여, 데이터를 인터널테이블에 받는다.
* 2. 첫 번째 행은 칼럼명들이 있으므로 제외시켜준다.
********************************************************
    PERFORM excel_upload.
    DELETE it_tab INDEX 1.
    MESSAGE '파일 업로드가 완료 되었습니다.' TYPE 'S'.


START-OF-SELECTION.
  IF begda IS INITIAL AND filepath IS INITIAL.
    MESSAGE '적절한 파일과 시작일을 지정해주십시오.' TYPE 'I'.
  ELSEIF begda IS INITIAL.
    MESSAGE '시작일을 선택안하셨습니다.' TYPE 'I'.
  ELSEIF filepath IS INITIAL.
    MESSAGE '파일을 지정안하셨습니다.' TYPE 'I'.
  ELSE.
    PERFORM cal_work.
    PERFORM bdc_mf50.
  ENDIF.

  IF sy-subrc = 0.
    MESSAGE 'BDC 프로그램 실행완료' TYPE 'S'.
  ENDIF.