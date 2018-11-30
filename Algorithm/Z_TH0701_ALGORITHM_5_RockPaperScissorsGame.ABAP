*&---------------------------------------------------------------------*
*& Report  Z_TH0701_RockPaperScissorsGame
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeongKim
*& Reporting Date: `18.11.30
*&---------------------------------------------------------------------*
************************************************************************
*  Rock Paper Scissors Game                                            *
************************************************************************
REPORT  z_th0701_random.
************************************************************************
*  Random Data Declare.
************************************************************************
DATA : rnd LIKE bbseg-wrbtr.

DATA : result1 TYPE p DECIMALS 2 .
DATA : result2 TYPE p DECIMALS 2 .
DATA : result3 TYPE p DECIMALS 2 .

DATA : it_tab TYPE TABLE OF zthsoccer,
      wa_tab LIKE LINE OF it_tab.

PARAMETERS input TYPE string.
************************************************************************
*  1. Call Random                                                      *
************************************************************************
PERFORM generate_rnd.
************************************************************************
*  2. Call Game                                                        *
************************************************************************
PERFORM rockpaperscissors.

************************************************************************
*  RANDOM FUNCTION: GENERATE_RND.                                      *
************************************************************************
FORM generate_rnd.
  CALL FUNCTION 'RANDOM_AMOUNT'
    EXPORTING
      rnd_min    = '0'
      rnd_max    = '0.02'
      valcurr    = 'DEM'                "Decimal Type으로 지정하여준다.
    IMPORTING
      rnd_amount = rnd
    EXCEPTIONS
      OTHERS     = 1.

ENDFORM.          " GENERATE_RND





*WRITE : / result.\
*MOVE-CORRESPONDING rnd to refresh.
*&---------------------------------------------------------------------*
*&      Form  ROCKPAPERSCISSORS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM rockpaperscissors .


************************************************************************
* RND값을 비교하기 위한 데이터 선언.                                   *
************************************************************************
  DATA : scissors TYPE p DECIMALS 2 VALUE '0.00'.
  DATA : rock TYPE p DECIMALS 2 VALUE '0.01'.
  DATA : paper TYPE p DECIMALS 2 VALUE '0.02'.

************************************************************************
* 사용자 입력값을 위한 데이터 선언.                                   *
************************************************************************
  DATA : i_input(2) TYPE C.

  WRITE : / '당신이 낸 것은', input, '입니다.'.

************************************************************************
* 사용자 입력값 확인                                                   *
************************************************************************
  IF rnd EQ scissors.
    i_input = '가위'.
    WRITE : / '컴퓨터는 가위를 냈습니다.'.
  ELSEIF rnd EQ rock.
    i_input = '바위'.
    WRITE : / '컴퓨터는 바위를 냈습니다.'.
  ELSE.
    i_input = '보'.
    WRITE : / '컴퓨터는 보자기를 냈습니다.'.
  ENDIF.


************************************************************************
* 경기결과 판별                                                        *
************************************************************************
  IF input = i_input.
    WRITE : / '경기결과: 무승부'.            " 동일한 경우.
  ELSE.
    IF input = '가위' AND i_input = '바위'.  " 가위 vs 바위
      WRITE : / '경기결과: 패배'.
    ELSEIF input = '가위' AND i_input = '보'. " 가위 vs 보
      WRITE : / '경기결과: 승리'.
    ELSEIF input = '바위' AND i_input = '보'. " 바위 vs 보
      WRITE : / '경기결과: 패배'.
    ELSEIF input = '바위' AND i_input = '가위'. " 바위  vs 가위
      WRITE : / '경기결과: 승리'.
    ELSEIF input = '보' AND i_input = '가위'. " 보 vs 가위
      WRITE : / '경기결과: 패배'.
    ELSEIF input = '보' AND i_input = '바위'. " 보 vs 바위
      WRITE : / '경기결과: 승리'.
    ENDIF.
    ENDIF.
 ENDFORM.                    " ROCKPAPERSCISSORS