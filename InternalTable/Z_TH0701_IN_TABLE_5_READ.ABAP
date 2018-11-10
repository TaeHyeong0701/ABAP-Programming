*&---------------------------------------------------------------------*
*& Report  Z_TH0701_IT_TABLE_5_READ
*&
*&---------------------------------------------------------------------*
*&
*& READ TABLE WITH KEY
*&
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_IT_TABLE_5_READ

DATA : it_sflight TYPE TABLE OF sflight,
      wa_sflight LIKE LINE OF it_sflight,
      wo_sflight LIKE LINE OF it_sflight,
      it_s_sflight TYPE SORTED TABLE OF sflight WITH non-UNIQUE KEY planetype,     
* 키값으로 Planetype으로 지정함.(Planetype순으로 정렬함) // non-unique하기 떄문에 중복값 존재.
      wa_s_sflight LIKE LINE OF it_s_sflight.
SELECT *
  FROM sflight INTO TABLE it_sflight.
  SELECT *                  
  FROM sflight INTO TABLE it_s_sflight.                                             
READ TABLE it_sflight INTO wa_sflight WITH KEY carrid = 'AA'.                       " 일반 필드 값을 기준으로 조회함. SELECT절의 WHERE절과 유사
READ TABLE it_s_sflight INTO wa_S_sflight WITH TABLE KEY planetype = '747-400'.     " TABLE KEY값을 기준으로 조회함.
* select * FROM it_Sflight into wo_S_Sflight where carrid = 'AA'.                   " SELECT TABLE은 인터널 테이블을 대상으로 할 수 없음. ---> READ TABLE을 써야하는 이유

WRITE : / wa_sflight-carrid, wa_sflight-connid, wa_sflight-price.
WRITE : / wa_s_sflight-carrid, wa_s_sflight-connid, wa_s_sflight-price.