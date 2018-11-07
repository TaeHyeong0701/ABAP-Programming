*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_2_GROUPBY
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
* 20090709에 비행한 승무원중 스튜어디스의 인원수를 구하라!

REPORT  Z_TH0701_OSQL_2_GROUPBY.
DATA : result type i.
DATA : it_sflcrew LIKE TABLE OF sflcrew,   "LIKE TABLE OF 구문을 이용하여, ABAP Dictionary 테이블 참조.
      wo_sflcrew LIKE LINE OF it_sflcrew.  "헤더라인이 없을 경우 LIKE를 사용하여, WorkArea를 선언할 수 도 있다.  LIKE LINE OF로 지정할 경우 인터널 테이블을 참조할 수 없다.

SELECT COUNT(*) AS pilotcount
  FROM sflcrew
  INTO result "Result 변수에 저장하라.
  WHERE FLDATE = '20090709' "FLDATE가 20090709인 것을
   GROUP BY ROLE "ROLE로 그룹화 하여,
  HAVING ROLE = 'STEWARD'. "ROLE이 STEWARD인 것을 출력한다.
  ENDSELECT.
WRITE : '2009년 7월 9일에 비행을 나간 스튜어디스는',result,'명입니다'.
* Group By 함수를 사용함으로서, 집계함수를 이용가능하다.
* 집계함수 1. COUNT : 로우 갯수.
* 집계함수 2. AVG
* 집계함수 3. MAX
* 집계함수 4. MIN
* 집계함수 5. STDDEV : 편차
* 집계함수 6. SUM

* HAVING 절과 WHERE절에 유의하자.
* ---> WHERE절은 FROM절로 부터 받은 테이블에 대해 조건을 거는 것(먼저)
* ---> HAVING절은 GROUPBY절에 대해 조건을 거는것 (나중에, 집계함수도 조건으로 사용가능)