FUNCTION ZBC400_GIT_CORRESPONDINGFILEDSOF.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  BC400_S_CONNECTION-CARRID
*"     REFERENCE(IV_CONNID) TYPE  BC400_S_CONNECTION-CONNID
*"  EXPORTING
*"     REFERENCE(ES_CONNECTION) TYPE  BC400_S_CONNECTION
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------
  SELECT SINGLE fltime carrid connid cityfrom airpfrom
    cityto airpto deptime arrtime
*    9개의 필드 값을 조회하겠다.
*    [옵션]* : 모든 필드를 가져오겠다.
*              INTO 대상 테이블과 순서가 맞지 않으면 오류가 난다. --> corresponding field of 로 해결한다.
    FROM spfli
*    어디서 가져올거냐? --> 테이블명 입력 // SPFLI 테이블에서 가져오겠다.
    INTO CORRESPONDING FIELDS OF es_connection
*    es_connection에 넣겠다.
    WHERE carrid = iv_carrid
    AND connid = iv_connid.
*    조건에 맞는 테이블을 가져오겠다.
*   carrid(SPFLI테이블 중)필드값 = iv_carrid(Import 파라미터값.)
*   connid(SPFLI 테이블 중) 필드값 = iv_connid(Import 파라미터값.)
*   SELECT 문장이 끝날때 "."을 찍어준다.
   IF sy-subrc <> 0. " SY-SUBRIC 이 0이 아니면, 즉, 정상적으로 실행이 안되면,
     RAISE no_data. " RAISE를 이용해서 EXCEPTION호출한다.
     ENDIF.
     ENDFUNCTION.