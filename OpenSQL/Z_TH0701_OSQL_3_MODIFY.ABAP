*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_3_MODIFY
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
************************************************************************
* Senario - 1. 인터널 테이블을 활용하여, ABAP Dictionary에 있는 테이블을 가져온다.  *
*           2. MODIFY 명령문과, APPEND 명령문을 활용하여, 데이터를 삽입한다.       *
*           3. MODIFY와 APPEND의 차이점을 알아보자                           *
***************************************************************************************************************************
*!! 알게된 사실 -1. 인터널 테이블에서는 테이블의 키값의 영향을 받지 않는다.                                                                
*            ---> MODIFY, APPEND시, 키값이 중복되든, 키값을 입력안하든, 테이블의 구조만 따오는 것이어서 상관없음.
*!! 알게된 사실 -2. MODIFY 로 데이터 추가시, INDEX를 설정하지 않는다면 에러가 난다.
*!! 알게된 사실 -3. MODIFY 로  데이터 추가시, 부적절한 인덱스 값(Ex. 기존 테이블은 15개의 인덱스를 갖는데, 17번째에 MODIFY한다.)삽입시 에러가 난다.
*!! 알게된 사실 -4. MODIFY 로 데이터 추가시, 해당 인덱스 값에 있는 값은 지우고 추가한다.
*!! 알게된 사실 -5. TRANSPORTING filed 명령어를 활용하여, 조건에 맞는 특정 필드값만 변경이 가능.
***************************************************************************************************************************
REPORT  Z_TH0701_OSQL_3_MODIFY.
DATA : it_zthsoccer TYPE TABLE OF zthsoccer,
       wo_zthsoccer LIKE LINE OF it_zthsoccer. "테이블 구조 참조할 떄는 LIKE LINE OF 이용해야된다.

SELECT *
  FROM zthsoccer
  INTO TABLE it_zthsoccer.

WRITE : / '변경 전의 테이블 값들입니다.'.
 LOOP AT it_zthsoccer into wo_zthsoccer.
 WRITE : / wo_zthsoccer-soccer_num, wo_Zthsoccer-name, wo_Zthsoccer-height, wo_Zthsoccer-weight, wo_Zthsoccer-soccer_position, wo_Zthsoccer-nation, wo_Zthsoccer-salary.
 ENDLOOP.


wo_zthsoccer-soccer_num = 100.
wo_Zthsoccer-name = '해리케인'.
wo_Zthsoccer-height = 188.
wo_Zthsoccer-weight = 82.
wo_Zthsoccer-soccer_position = 'FW'.
wo_Zthsoccer-nation = '잉글랜드'.
wo_Zthsoccer-salary = 103.
WRITE : / 'APPEND를 활용하여, 헤리케인 선수의 데이터를 삽입하였습니다.'.
APPEND wo_Zthsoccer to it_zthsoccer.
 LOOP AT it_zthsoccer into wo_zthsoccer.
 WRITE : / wo_zthsoccer-soccer_num, wo_Zthsoccer-name, wo_Zthsoccer-height, wo_Zthsoccer-weight, wo_Zthsoccer-soccer_position, wo_Zthsoccer-nation, wo_Zthsoccer-salary.
 ENDLOOP.

WO_ZTHSOCCER-SALARY = '1000'.
MODIFY IT_Zthsoccer from wo_zthsoccer
TRANSPORTING salary WHERE name = '손흥민'.
write: / 'MODIFY를 활용하여, 손흥민 선수의 데이터를 변경하였습니다.'.
 LOOP AT it_zthsoccer into wo_zthsoccer.
 WRITE : / wo_zthsoccer-soccer_num, wo_Zthsoccer-name, wo_Zthsoccer-height, wo_Zthsoccer-weight, wo_Zthsoccer-soccer_position, wo_Zthsoccer-nation, wo_Zthsoccer-salary.
 ENDLOOP.

wo_zthsoccer-soccer_num = 100.
wo_Zthsoccer-name = '이재성'.
wo_Zthsoccer-height = 180.
wo_Zthsoccer-weight = 70.
wo_Zthsoccer-soccer_position = 'MF'.
wo_Zthsoccer-nation = '대한민국'.
wo_Zthsoccer-salary = 23.

MODIFY IT_Zthsoccer from wo_zthsoccer INDEX 16.
write: / 'MODIFY를 활용하여, 이재성 선수의 데이터를 삽입하하였습니다.'.
 LOOP AT it_zthsoccer into wo_zthsoccer.
 WRITE : / wo_zthsoccer-soccer_num, wo_Zthsoccer-name, wo_Zthsoccer-height, wo_Zthsoccer-weight, wo_Zthsoccer-soccer_position, wo_Zthsoccer-nation, wo_Zthsoccer-salary.
 ENDLOOP.