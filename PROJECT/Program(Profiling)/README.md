# ABAP Profiling Local Program
# ABAP 프로파일링 로컬 프로그램

## Overview / 개요

This local program demonstrates performance profiling techniques in ABAP. It provides various test scenarios to measure and compare the execution time of different coding approaches.

이 로컬 프로그램은 ABAP에서 성능 프로파일링 기법을 보여줍니다. 다양한 테스트 시나리오를 통해 서로 다른 코딩 방식의 실행 시간을 측정하고 비교합니다.

## Program Name / 프로그램 이름

**Z_TH0701_PROFILING**

## Features / 기능

### 1. Loop Performance Comparison / 루프 성능 비교
- Compares DO loop vs WHILE loop performance
- DO 루프와 WHILE 루프의 성능 비교
- Measures execution time for configurable number of iterations
- 설정 가능한 반복 횟수로 실행 시간 측정

### 2. Database Query Performance / 데이터베이스 쿼리 성능
- Compares SELECT INTO TABLE vs SELECT with ENDSELECT
- SELECT INTO TABLE과 SELECT ENDSELECT의 성능 비교
- Shows best practices for database operations
- 데이터베이스 작업의 모범 사례 제시

### 3. Internal Table Operations / 내부 테이블 작업
- Tests different internal table types (Standard, Sorted)
- 다양한 내부 테이블 유형 테스트 (표준, 정렬)
- Compares LOOP and READ TABLE operations
- LOOP과 READ TABLE 작업 비교

### 4. String Operations / 문자열 작업
- Compares CONCATENATE vs String Template performance
- CONCATENATE와 문자열 템플릿 성능 비교
- Demonstrates modern ABAP string handling
- 최신 ABAP 문자열 처리 방식 시연

## How to Use / 사용 방법

1. **Upload the program to SAP**
   - Create a new program in SE38 or SE80
   - Copy the code from `z_th0701_profiling.abap`
   - Activate the program

2. **Configure test parameters**
   - Select which tests to run using checkboxes
   - Set the number of rows for testing (default: 10,000)

3. **Execute the program (F8)**
   - View the results on screen
   - Compare performance metrics

1. **프로그램을 SAP에 업로드**
   - SE38 또는 SE80에서 새 프로그램 생성
   - `z_th0701_profiling.abap`에서 코드 복사
   - 프로그램 활성화

2. **테스트 파라미터 설정**
   - 체크박스를 사용하여 실행할 테스트 선택
   - 테스트용 행 수 설정 (기본값: 10,000)

3. **프로그램 실행 (F8)**
   - 화면에서 결과 확인
   - 성능 지표 비교

## Performance Measurement Technique / 성능 측정 기법

The program uses the `GET RUN TIME FIELD` statement to measure execution time in microseconds.

프로그램은 `GET RUN TIME FIELD` 문을 사용하여 마이크로초 단위로 실행 시간을 측정합니다.

```abap
GET RUN TIME FIELD lv_start_time.
" ... code to measure ...
GET RUN TIME FIELD lv_end_time.
lv_runtime = lv_end_time - lv_start_time.
```

## Key Learning Points / 주요 학습 포인트

1. **Performance Profiling / 성능 프로파일링**
   - Use GET RUN TIME for precise measurements
   - Always test with realistic data volumes
   - 정확한 측정을 위해 GET RUN TIME 사용
   - 항상 실제 데이터 볼륨으로 테스트

2. **Best Practices / 모범 사례**
   - SELECT INTO TABLE is generally faster than SELECT...ENDSELECT
   - Sorted tables provide faster key-based access
   - Use appropriate internal table types for your use case
   - SELECT INTO TABLE이 일반적으로 SELECT...ENDSELECT보다 빠름
   - 정렬 테이블은 키 기반 액세스가 더 빠름
   - 사용 사례에 적합한 내부 테이블 유형 사용

3. **Optimization Tips / 최적화 팁**
   - Minimize database calls
   - Use bulk operations when possible
   - Consider memory vs. performance trade-offs
   - 데이터베이스 호출 최소화
   - 가능한 경우 대량 작업 사용
   - 메모리 대 성능 트레이드오프 고려

## Related T-Codes / 관련 T-Code

- **SAT** (SE30): Runtime Analysis / 런타임 분석
- **ST12**: Single Transaction Analysis / 단일 트랜잭션 분석
- **ST02**: Tune Summary / 메모리 조율 요약
- **ST05**: SQL Trace / SQL 추적

## Author / 작성자

Written By TaeHyeongKim  
Reporting Date: 2025.11.15

## References / 참고 자료

- ABAP Performance Guidelines
- SAP Performance Optimization Guide
- ABAP 성능 가이드라인
- SAP 성능 최적화 가이드
