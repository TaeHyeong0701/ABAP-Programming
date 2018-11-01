*&---------------------------------------------------------------------*
*& Report  Z_TH0701_INSERTDELETE
*&
*&---------------------------------------------------------------------*
*&
*&
*&-----------------------------------------------------------------------------
*! 알게된 사실 1. INSERT와 DELETE는 INDEX를 활용하여, 삽입 및 삭제가 가능하다.              *
*!          2. INSERT에서 현재 존재하는 인터널테이블의 INDEX + 1 까지만 인덱스 구문 사용 가능. *
*!          3. DELETE에서 현재 존재하는 인터널테이블의 INDEX 까지만 인덱스 구문 사용 가능.     *
*******************************************************************************
REPORT  Z_TH0701_INSERTDELETE.

DATA : it_zthsoccer type TABLE OF zthsoccer,
      wo_Zthsoccer like LINE OF it_zthsoccer.

SELECT *
  FROM zthsoccer
  into table it_Zthsoccer.

write : / '변경전의 값입니다.'.
 LOOP AT it_zthsoccer into wo_Zthsoccer.
   WRITE : / wo_Zthsoccer-name, wo_zthsoccer-nation.
ENDLOOP.

DELETE it_Zthsoccer INDEX 4. "인터널 테이블의 4번째 행을 삭제하라.

wo_Zthsoccer-name = '김태형'.
wo_Zthsoccer-nation = '대한민국'.
INSERT wo_zthsoccer INTO it_zthsoccer index 4. "인터널 테이블의 4번째 행에 새로운 데이터를 삽입하라.

write : /,/ '변경후의 값입니다.'.
 LOOP AT it_zthsoccer into wo_Zthsoccer.
   WRITE : / wo_Zthsoccer-name, wo_zthsoccer-nation.
ENDLOOP.