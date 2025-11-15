*&---------------------------------------------------------------------*
*& Report  Z_TH0701_PROFILING
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeongKim
*& Reporting Date: 2025.11.15
*& Subject: Performance Profiling Local Program
*&          로컬 프로그램 - 성능 프로파일링 및 측정 도구
*&          This program demonstrates various profiling techniques in ABAP
*&---------------------------------------------------------------------*

REPORT Z_TH0701_PROFILING.

**************************************************************************
*   타입 선언
**************************************************************************
TYPES: BEGIN OF ty_result,
         test_name    TYPE string,
         runtime      TYPE i,
         runtime_char TYPE string,
       END OF ty_result.

**************************************************************************
*   데이터 선언
**************************************************************************
DATA: lv_start_time   TYPE i,
      lv_end_time     TYPE i,
      lv_runtime      TYPE i,
      lv_runtime_char TYPE string,
      lt_results      TYPE TABLE OF ty_result,
      ls_result       TYPE ty_result,
      lt_data         TYPE TABLE OF i,
      lv_index        TYPE i,
      lv_sum          TYPE i,
      lv_memory_id    TYPE string.

**************************************************************************
*   선택 화면 정의
**************************************************************************
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_test1 AS CHECKBOX DEFAULT 'X',    " Loop Performance Test
            p_test2 AS CHECKBOX DEFAULT 'X',    " Select Query Performance
            p_test3 AS CHECKBOX DEFAULT 'X',    " Internal Table Operations
            p_test4 AS CHECKBOX DEFAULT 'X'.    " String Operations
PARAMETERS: p_rows TYPE i DEFAULT 10000.         " Number of rows for testing
SELECTION-SCREEN END OF BLOCK b1.

**************************************************************************
*   초기화
**************************************************************************
INITIALIZATION.
  " 초기 설정

**************************************************************************
*   START-OF-SELECTION
**************************************************************************
START-OF-SELECTION.

  WRITE: / '=========================================='.
  WRITE: / 'ABAP Performance Profiling Tool'.
  WRITE: / '성능 프로파일링 도구'.
  WRITE: / '=========================================='.
  SKIP 1.

  " Test 1: Loop Performance Comparison
  IF p_test1 = 'X'.
    PERFORM test_loop_performance.
  ENDIF.

  " Test 2: Database Query Performance
  IF p_test2 = 'X'.
    PERFORM test_query_performance.
  ENDIF.

  " Test 3: Internal Table Operations
  IF p_test3 = 'X'.
    PERFORM test_internal_table_operations.
  ENDIF.

  " Test 4: String Operations
  IF p_test4 = 'X'.
    PERFORM test_string_operations.
  ENDIF.

  " Display Summary
  SKIP 1.
  WRITE: / '=========================================='.
  WRITE: / 'Performance Test Summary'.
  WRITE: / '성능 테스트 요약'.
  WRITE: / '=========================================='.
  SKIP 1.

  LOOP AT lt_results INTO ls_result.
    WRITE: / ls_result-test_name, 30 ls_result-runtime_char.
  ENDLOOP.

**************************************************************************
*   END-OF-SELECTION
**************************************************************************
END-OF-SELECTION.

*&---------------------------------------------------------------------*
*&      Form  test_loop_performance
*&---------------------------------------------------------------------*
*       Loop 성능 비교 테스트
*----------------------------------------------------------------------*
FORM test_loop_performance.
  DATA: lv_counter TYPE i,
        lv_time1   TYPE i,
        lv_time2   TYPE i.

  WRITE: / '=========================================='.
  WRITE: / 'Test 1: Loop Performance Comparison'.
  WRITE: / '루프 성능 비교 테스트'.
  WRITE: / '=========================================='.

  " Test 1a: DO loop
  GET RUN TIME FIELD lv_start_time.
  lv_counter = 0.
  DO p_rows TIMES.
    lv_counter = lv_counter + 1.
  ENDDO.
  GET RUN TIME FIELD lv_end_time.
  lv_time1 = lv_end_time - lv_start_time.

  WRITE: / 'DO Loop (', p_rows, ' iterations):', lv_time1, 'microseconds'.

  " Store result
  CLEAR ls_result.
  ls_result-test_name = 'DO Loop'.
  ls_result-runtime = lv_time1.
  WRITE lv_time1 TO ls_result-runtime_char.
  CONCATENATE ls_result-runtime_char ' μs' INTO ls_result-runtime_char.
  APPEND ls_result TO lt_results.

  " Test 1b: WHILE loop
  GET RUN TIME FIELD lv_start_time.
  lv_counter = 0.
  WHILE lv_counter < p_rows.
    lv_counter = lv_counter + 1.
  ENDWHILE.
  GET RUN TIME FIELD lv_end_time.
  lv_time2 = lv_end_time - lv_start_time.

  WRITE: / 'WHILE Loop (', p_rows, ' iterations):', lv_time2, 'microseconds'.

  " Store result
  CLEAR ls_result.
  ls_result-test_name = 'WHILE Loop'.
  ls_result-runtime = lv_time2.
  WRITE lv_time2 TO ls_result-runtime_char.
  CONCATENATE ls_result-runtime_char ' μs' INTO ls_result-runtime_char.
  APPEND ls_result TO lt_results.

  " Comparison
  IF lv_time1 < lv_time2.
    WRITE: / 'Result: DO loop is faster'.
  ELSEIF lv_time1 > lv_time2.
    WRITE: / 'Result: WHILE loop is faster'.
  ELSE.
    WRITE: / 'Result: Both loops have similar performance'.
  ENDIF.

  SKIP 1.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  test_query_performance
*&---------------------------------------------------------------------*
*       데이터베이스 쿼리 성능 테스트
*----------------------------------------------------------------------*
FORM test_query_performance.
  DATA: lt_t000   TYPE TABLE OF t000,
        ls_t000   TYPE t000,
        lv_count  TYPE i,
        lv_time1  TYPE i,
        lv_time2  TYPE i.

  WRITE: / '=========================================='.
  WRITE: / 'Test 2: Database Query Performance'.
  WRITE: / '데이터베이스 쿼리 성능 테스트'.
  WRITE: / '=========================================='.

  " Test 2a: SELECT with INTO TABLE
  GET RUN TIME FIELD lv_start_time.
  SELECT * FROM t000 INTO TABLE lt_t000 UP TO 100 ROWS.
  GET RUN TIME FIELD lv_end_time.
  lv_time1 = lv_end_time - lv_start_time.

  DESCRIBE TABLE lt_t000 LINES lv_count.
  WRITE: / 'SELECT INTO TABLE (100 rows):', lv_time1, 'microseconds'.
  WRITE: / 'Records fetched:', lv_count.

  " Store result
  CLEAR ls_result.
  ls_result-test_name = 'SELECT INTO TABLE'.
  ls_result-runtime = lv_time1.
  WRITE lv_time1 TO ls_result-runtime_char.
  CONCATENATE ls_result-runtime_char ' μs' INTO ls_result-runtime_char.
  APPEND ls_result TO lt_results.

  " Test 2b: SELECT with loop
  REFRESH lt_t000.
  GET RUN TIME FIELD lv_start_time.
  SELECT * FROM t000 INTO ls_t000 UP TO 100 ROWS.
    APPEND ls_t000 TO lt_t000.
  ENDSELECT.
  GET RUN TIME FIELD lv_end_time.
  lv_time2 = lv_end_time - lv_start_time.

  DESCRIBE TABLE lt_t000 LINES lv_count.
  WRITE: / 'SELECT with ENDSELECT loop (100 rows):', lv_time2, 'microseconds'.
  WRITE: / 'Records fetched:', lv_count.

  " Store result
  CLEAR ls_result.
  ls_result-test_name = 'SELECT with ENDSELECT'.
  ls_result-runtime = lv_time2.
  WRITE lv_time2 TO ls_result-runtime_char.
  CONCATENATE ls_result-runtime_char ' μs' INTO ls_result-runtime_char.
  APPEND ls_result TO lt_results.

  " Comparison
  IF lv_time1 < lv_time2.
    WRITE: / 'Result: SELECT INTO TABLE is faster (recommended)'.
  ELSEIF lv_time1 > lv_time2.
    WRITE: / 'Result: SELECT with loop is faster'.
  ELSE.
    WRITE: / 'Result: Both methods have similar performance'.
  ENDIF.

  SKIP 1.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  test_internal_table_operations
*&---------------------------------------------------------------------*
*       내부 테이블 작업 성능 테스트
*----------------------------------------------------------------------*
FORM test_internal_table_operations.
  DATA: lt_data1   TYPE TABLE OF i,
        lt_data2   TYPE STANDARD TABLE OF i,
        lt_data3   TYPE SORTED TABLE OF i WITH UNIQUE KEY table_line,
        lv_value   TYPE i,
        lv_time1   TYPE i,
        lv_time2   TYPE i,
        lv_time3   TYPE i,
        lv_loop    TYPE i.

  WRITE: / '=========================================='.
  WRITE: / 'Test 3: Internal Table Operations'.
  WRITE: / '내부 테이블 작업 성능 테스트'.
  WRITE: / '=========================================='.

  " Prepare test data
  DO 1000 TIMES.
    lv_value = sy-index.
    APPEND lv_value TO lt_data1.
    APPEND lv_value TO lt_data2.
    INSERT lv_value INTO TABLE lt_data3.
  ENDDO.

  " Test 3a: LOOP and READ TABLE on standard table
  GET RUN TIME FIELD lv_start_time.
  LOOP AT lt_data1 INTO lv_value.
    lv_loop = lv_value * 2.
  ENDLOOP.
  GET RUN TIME FIELD lv_end_time.
  lv_time1 = lv_end_time - lv_start_time.

  WRITE: / 'LOOP on Standard Table (1000 entries):', lv_time1, 'microseconds'.

  " Store result
  CLEAR ls_result.
  ls_result-test_name = 'LOOP Standard Table'.
  ls_result-runtime = lv_time1.
  WRITE lv_time1 TO ls_result-runtime_char.
  CONCATENATE ls_result-runtime_char ' μs' INTO ls_result-runtime_char.
  APPEND ls_result TO lt_results.

  " Test 3b: READ TABLE with binary search
  GET RUN TIME FIELD lv_start_time.
  DO 100 TIMES.
    READ TABLE lt_data2 INTO lv_value INDEX sy-index.
  ENDDO.
  GET RUN TIME FIELD lv_end_time.
  lv_time2 = lv_end_time - lv_start_time.

  WRITE: / 'READ TABLE (100 reads):', lv_time2, 'microseconds'.

  " Store result
  CLEAR ls_result.
  ls_result-test_name = 'READ TABLE'.
  ls_result-runtime = lv_time2.
  WRITE lv_time2 TO ls_result-runtime_char.
  CONCATENATE ls_result-runtime_char ' μs' INTO ls_result-runtime_char.
  APPEND ls_result TO lt_results.

  " Test 3c: READ TABLE on sorted table
  GET RUN TIME FIELD lv_start_time.
  DO 100 TIMES.
    READ TABLE lt_data3 INTO lv_value WITH KEY table_line = sy-index.
  ENDDO.
  GET RUN TIME FIELD lv_end_time.
  lv_time3 = lv_end_time - lv_start_time.

  WRITE: / 'READ TABLE on Sorted Table (100 reads):', lv_time3, 'microseconds'.

  " Store result
  CLEAR ls_result.
  ls_result-test_name = 'READ Sorted Table'.
  ls_result-runtime = lv_time3.
  WRITE lv_time3 TO ls_result-runtime_char.
  CONCATENATE ls_result-runtime_char ' μs' INTO ls_result-runtime_char.
  APPEND ls_result TO lt_results.

  WRITE: / 'Note: Sorted tables provide faster key-based access'.

  SKIP 1.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  test_string_operations
*&---------------------------------------------------------------------*
*       문자열 작업 성능 테스트
*----------------------------------------------------------------------*
FORM test_string_operations.
  DATA: lv_string1  TYPE string,
        lv_string2  TYPE string,
        lv_char100  TYPE c LENGTH 100,
        lv_time1    TYPE i,
        lv_time2    TYPE i,
        lv_counter  TYPE i.

  WRITE: / '=========================================='.
  WRITE: / 'Test 4: String Operations Performance'.
  WRITE: / '문자열 작업 성능 테스트'.
  WRITE: / '=========================================='.

  " Test 4a: String concatenation
  GET RUN TIME FIELD lv_start_time.
  CLEAR lv_string1.
  DO 1000 TIMES.
    CONCATENATE lv_string1 'A' INTO lv_string1.
  ENDDO.
  GET RUN TIME FIELD lv_end_time.
  lv_time1 = lv_end_time - lv_start_time.

  WRITE: / 'String CONCATENATE (1000 times):', lv_time1, 'microseconds'.

  " Store result
  CLEAR ls_result.
  ls_result-test_name = 'String CONCATENATE'.
  ls_result-runtime = lv_time1.
  WRITE lv_time1 TO ls_result-runtime_char.
  CONCATENATE ls_result-runtime_char ' μs' INTO ls_result-runtime_char.
  APPEND ls_result TO lt_results.

  " Test 4b: String template
  GET RUN TIME FIELD lv_start_time.
  CLEAR lv_string2.
  DO 1000 TIMES.
    lv_string2 = |{ lv_string2 }A|.
  ENDDO.
  GET RUN TIME FIELD lv_end_time.
  lv_time2 = lv_end_time - lv_start_time.

  WRITE: / 'String Template (1000 times):', lv_time2, 'microseconds'.

  " Store result
  CLEAR ls_result.
  ls_result-test_name = 'String Template'.
  ls_result-runtime = lv_time2.
  WRITE lv_time2 TO ls_result-runtime_char.
  CONCATENATE ls_result-runtime_char ' μs' INTO ls_result-runtime_char.
  APPEND ls_result TO lt_results.

  " Comparison
  IF lv_time1 < lv_time2.
    WRITE: / 'Result: CONCATENATE is faster for this test'.
  ELSEIF lv_time1 > lv_time2.
    WRITE: / 'Result: String template is faster for this test'.
  ELSE.
    WRITE: / 'Result: Both methods have similar performance'.
  ENDIF.

  SKIP 1.
ENDFORM.

*Text elements
*----------------------------------------------------------
* 001 Select Performance Tests to Run
