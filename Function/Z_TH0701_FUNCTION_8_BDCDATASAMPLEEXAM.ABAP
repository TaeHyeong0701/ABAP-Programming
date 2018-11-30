*&---------------------------------------------------------------------*
*&                                  TOP
*&
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*   data definition                                                             ---> 필수 1. BDC DATA Definition 부 // BDC include BDCRECX1에서 복사함.
*----------------------------------------------------------------------*
*       Batchinputdata of single transaction
DATA:   BDCDATA LIKE BDCDATA    OCCURS 0 WITH HEADER LINE.
*       messages of call transaction
DATA:   MESSTAB LIKE BDCMSGCOLL OCCURS 0 WITH HEADER LINE.
*       error session opened (' ' or 'X')
DATA:   E_GROUP_OPENED.
*       message texts
TABLES: T100.

*&---------------------------------------------------------------------*
*&                                  F01
*&
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*        Start new screen                                              *        ---> 필수 2. 스크린의 동기화하는 로직.
*----------------------------------------------------------------------*
FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR BDCDATA.
  BDCDATA-PROGRAM  = PROGRAM.
  BDCDATA-DYNPRO   = DYNPRO.
  BDCDATA-DYNBEGIN = 'X'.
  APPEND BDCDATA.
ENDFORM.
*----------------------------------------------------------------------*
*        Insert field                                                  *        ---> 필수 3. 필드 데이터를 입력하는 로직.
*----------------------------------------------------------------------*
FORM BDC_FIELD USING FNAM FVAL.
*  IF FVAL <> NODATA.
    CLEAR BDCDATA.
    BDCDATA-FNAM = FNAM.
    BDCDATA-FVAL = FVAL.
    APPEND BDCDATA.
*  ENDIF.
ENDFORM.

form BDC_CO11N .

DATA l_qty(10) TYPE c.
loop at it_tab into wa_Tab.
      REFRESH messtab.
    REFRESH bdcdata.


********************************************************************
*  액션 로직.                                                      *
*  1. 엔터를 나중에 쳤다고 해서 순차적으로 저장되는 것은 아니다.   *
*  2. 트랜잭션도 마찬가지다.                                       *
********************************************************************
********************************************************************
*  First Screen.                                                   *
********************************************************************
perform bdc_dynpro      using 'SAPLCORU_S' '0100'.                     " CO11N에 해당하는 프로그램 호출.

  
perform bdc_field       using 'BDC_OKCODE'                             " 엔터를 입력.
                              '/00'.

perform bdc_field       using 'AFRUD-AUFNR'                            " 생산오더 입력 유지
                              WA_tab-AUFNR.                            " 인터널 테이블에 생산오더가 들어가도록 한다.

perform bdc_field       using 'AFRUD-VORNR'                            " 공정번호 입력하는것 유지
                              WA_tab-VORNR.
********************************************************************
*  Second Screen.                                                  *
********************************************************************
perform bdc_dynpro      using 'SAPLCORU_S' '0100'.                     "  ---> 엔터를 치면 프로그램을 다시 호출된다. 스크린이 다시 호출되기 때문에

perform bdc_field       using 'BDC_OKCODE'                             " 저장버튼
                              '=BU'.

WRITE wa_tab-gamng TO l_qty LEFT-JUSTIFIED.
perform bdc_field       using 'AFRUD-LMNGA'                            " Yield 수량  ---> 타입 뻑나서 뺏음.
                              l_qty.


* <=========================시간 관련된 값들=========================>

*perform bdc_field       using 'AFRUD-ISM01'                           " Setup 시간 / 분
*                              record-ISM01_012.
*perform bdc_field       using 'AFRUD-ILE01'
*                              'MIN'.

*perform bdc_field       using 'AFRUD-ISM02'                           " Labor 시간 / 분
*                              record-ISM02_14.
*perform bdc_field       using 'AFRUD-ILE02'
*                              'MIN'.


*    REFRESH MESSTAB.
    CALL TRANSACTION 'CO11N' USING BDCDATA
                     MODE   'N'                                        " 모든 N(BDC를 수행하다가 오류가 나더라도 넘어가라)이나 A(하나하나 다 보여주는 것)냐 E냐
                     UPDATE 'S'                                        " 업데이트 옵션: S(동시에)냐, A(레코딩 끝나고 데이터베이스에 업데이트를 나중에 해라)냐, L이냐
                     MESSAGES INTO MESSTAB.
*perform bdc_transaction using 'CO11N'.
ENDLOOP.
endform.                    " BDC_CO11N


*&---------------------------------------------------------------------*
*&                         ANY WHERE
*&
*&---------------------------------------------------------------------*
 
*...

PERFORM BDC_CO11N.                                                      " BDC 수행(생산오더 공정 처리하는 BDC CO11) 로직

*...