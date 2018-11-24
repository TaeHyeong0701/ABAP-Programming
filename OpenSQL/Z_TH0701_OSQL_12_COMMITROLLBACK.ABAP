*&---------------------------------------------------------------------*
*& Report  Z_TH0701_COMMITROLLBACK
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong
*& Reporting Date: `18.11.24.
*& Subject: Commitwork and Rollbackwork Study Add.
*&---------------------------------------------------------------------*
* Scenario 1. Add '살라' soccer player Data
*          2. Rollbackwork.
*          3. print where name = '살라'
*          4. Add '황의조' soccer player Data
*          5. Commitwork.
*          6. print where name = '황의조'
************************************************************************

REPORT  Z_TH0701_COMMITROLLBACK.


DATA : it_tab TYPE TABLE OF zthsoccer,
      wa_tab like LINE OF it_tab.

SELECT MAX( soccer_num )                                                 "---> soccer_num을 추출해내고, 다음 번호에 값을 입력하기 위한 로직.
  FROM ZTHSOCCER INTO wa_tab-soccer_num.

wa_tab-soccer_num = wa_tab-soccer_num + 1.                               "---> 모하메드 살라 선수 입력 값들.
wa_tab-team = '리버풀'.
wa_tab-name = '모하메드 살라'.
wa_tab-height = 175.
wa_tab-weight = 71.
wa_tab-soccer_position = 'FW'.
wa_tab-nation = '이집트'.
wa_tab-salary = 174.

MODIFY zthsoccer FROM wa_tab.                                            "---> DB테이블 변경
ROLLBACK WORK.                                                           "---> ROLLBACK 구문으로 트랜잭션을 되돌린다.

CLEAR wa_tab.                                                            "---> Garbage 처리.
SELECT name                                                              "---> 모하메드 살라 선수 추출.
  FROM zthsoccer into CORRESPONDING FIELDS OF wa_tab
  where name = '모하메드 살라'.
  ENDSELECT.                                                             
  IF SY-SUBRC = 0.                                                       "---> 결과확인 : 확인결과 '살라' 선수의 데이터는 "롤백"으로 인해 저장되지 않았다.
WRITE : / 'Commit 결과:',wa_tab-name.
  ELSE .
  WRITE: / 'Rollback 결과: 원하는 값이 없다.'.         
  ENDIF.

CLEAR wa_tab.

SELECT MAX( soccer_num )                                                 "---> soccer_num을 추출해내고, 다음 번호에 값을 입력하기 위한 로직.
  FROM ZTHSOCCER INTO wa_tab-soccer_num.                                 

wa_tab-soccer_num = wa_tab-soccer_num + 1.                               "---> 황의조  선수 입력 값들.
wa_tab-team = '감바 오사카'.
wa_tab-name = '황의조'.
wa_tab-height = 184.
wa_tab-weight = 73.
wa_tab-soccer_position = 'FW'.
wa_tab-nation = '대한민국'.
wa_tab-salary = 7.
MODIFY zthsoccer FROM wa_tab.                                              "---> DB테이블 변경
COMMIT WORK.                                                               "---> COMMIT 구문으로 트랜잭션을 커밋한다.
CLEAR wa_tab.                                                              "---> Garbage 처리.
SELECT name                                                                "---> 황의조  선수 추출.
  FROM zthsoccer into CORRESPONDING FIELDS OF wa_tab
  where name = '황의조'.
  ENDSELECT.
    IF SY-SUBRC = 0.                                                       "---> 결과확인 : 확인결과 '황의조' 선수의 데이터는 "커밋"으로 인해 저장완료되었다.
WRITE : / 'Commit 결과:',wa_tab-name.
  ELSE .
  WRITE: / 'Commit 결과: 원하는 값이 없다.'.
  ENDIF.