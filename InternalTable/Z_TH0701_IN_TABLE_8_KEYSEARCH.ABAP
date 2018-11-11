*&---------------------------------------------------------------------*
*& Report  Z_TH0701_IN_TABLE_8_KEYSEARCH
*&
*&---------------------------------------------------------------------*
*& Scenrio 1. SORTED TABLE과 READ ~ INDEX 값과 ERSDA 필드(제조일)을 이용하여, 가장 최근에 만들어진 5번째 레코드를 조회해보자.
*&         2. STANDRAD TYPE의 MARA 테이블 형태에서 BINARY SEARCH를 이용하여, matnr = '100-300'인 레코드를 빠르게 조회해보자.
*&---------------------------------------------------------------------*
*& 알게된 사실 1. BINARY SEARCH는 GENERAL TABLE에 대해서는 엑세스 할 수 없음 ---> STANDARD TABLE TYPE 사용해야되.
*&          2. BINARY SEARCH는 정렬 이후 2분법 형식으로 조회를 해가기 때문에 통상적으로 대량의 데이터에서 일반적인 READ보다 속도가 개선된다.
REPORT  z_th0701_in_table_8_keysearch.

DATA : it_s_mara TYPE SORTED TABLE OF mara WITH non-UNIQUE KEY ersda,                      " 중복값 허용(기존 테이블에 이미 중복값이 존재하므로), ERSDA 필드 순으로 정렬
      wa_s_mara LIKE LINE OF it_s_mara,
      it_mara TYPE TABLE OF mara,                                                          " Standard type table
      wa_mara LIKE LINE OF it_mara.

SELECT *
  FROM mara INTO TABLE it_s_mara.

SELECT *
  FROM mara INTO TABLE it_mara.

*---------------------------------------------------------------------------------------- INDEX 이용 SEARCH
READ TABLE it_s_mara into wa_s_mara INDEX 5.
WRITE : wa_s_mara-matnr,wa_s_mara-ersda,wa_s_mara-ernam,wa_s_mara-laeda,wa_s_mara-aenam.

*---------------------------------------------------------------------------------------- KEY 이용 BINARY SEARCH
READ TABLE it_mara into wa_mara WITH KEY matnr = '100-300' BINARY SEARCH.
WRITE : wa_mara-matnr,wa_mara-ersda,wa_mara-ernam,wa_mara-laeda,wa_mara-aenam.