*&---------------------------------------------------------------------*
*& Report  Z_TH0701_IN_TABLE_4_CLEAR
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*******************************************************
*!알게된 사실 1. SELECT SINGLE을 사용할 시, ENDSELCT 필수 아님 그러나, 테이블에 단 하나의 조건값이 존재하더라도 일반적인 SELECT 구문은 ENDSELECT 필요. *
*!         2. CLEAR ~ : 헤더라인 삭제.                                                                                          *
*!         3. REFRESH(CLEAR ~[]) : Internal Table Body 삭제.                                                                  *
*!         4. Free : 메모리와 데이터 모두 삭제.                                                                                     *
******************************************************************************************************************************
REPORT  Z_TH0701_IN_TABLE_4_CLEAR.

DATA : it_zthsoccer TYPE TABLE OF zthsoccer WITH HEADER LINE.

*************************************************************************************************************
*scenario 1. 헤더라인에 일부 값을 넣어준다.                                                                         *
*         2. clear [HeaderLine]해준다                                                                                      *
*         3. 출력한다.                                                                                         *
*         결론 : 값이 안나오는 것을 확인하며, clear [header line] 명령문은 header line의 데이터를 삭제하는 명령문임을 확인한다.   *
*************************************************************************************************************
it_zthsoccer-name = '손흥민'.
CLEAR it_zthsoccer. "주석처리하며 확인하자.
write : / it_Zthsoccer-name.




****************************************************************************************************************
*scenario 1. 인터널 테이블에 값을 넣어준다.                                                                            *
*         2. clear [Internal table][] 혹은 Refresh 해준다.                                                                    *
*         3. 출력한다.                                                                                            *
*         결론 : 값이 안나오는 것을 확인하며, clear [internal table][] 명령문의 인터널 테이블의 Body를 삭제하는 명령문임을 확인하다.   *
*****************************************************************************************************************
select *
  FROM zthsoccer
  into table it_zthsoccer.

clear it_Zthsoccer[]. " 주석처리 변환하며 값을 확인하자.
* refresh it_Zthsoccer.

LOOP AT it_Zthsoccer.
WRITE : / it_zthsoccer-soccer_num, it_Zthsoccer-name, it_Zthsoccer-height,
            it_Zthsoccer-weight, it_Zthsoccer-soccer_position, it_Zthsoccer-nation, it_Zthsoccer-salary.
ENDLOOP.