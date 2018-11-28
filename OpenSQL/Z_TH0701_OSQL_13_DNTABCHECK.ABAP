*&---------------------------------------------------------------------*
*& Report  Z_TH0701_DNTABCHECK
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeongKim
*& Reporting Date: '18.11.28 
*& Subject: Table exist check.
*&---------------------------------------------------------------------*

REPORT  z_th0701_dntabcheck.

WRITE : 2(6)'테이블'.
SELECT-OPTIONS: result FOR string .

DATA : tdd02l LIKE dd02l.                            " SAP TABLE 구조를 참조.

SELECT * FROM  dd02l                                " SAP TABLE에서 조회.
       INTO tdd02l
       WHERE  tabname  = result.                    " 조회한 결과.
*             AND    as4local = 'A'                     " 로컬에 액티브되었는가? (A : Active, L: Locking. 등)
*         AND   ( tabclass      <> 'INTTAB'         " 테이블 타입. (INTTAB : 구조체, CLUSTER: 클러스터 테이블 등)
ENDSELECT.
IF sy-subrc = 0.
  WRITE : / 'ABAP Dictionary에 테이블이 있습니다.'.
ELSE.
  WRITE : / 'ABAP Dictionary에 테이블이 없습니다.'.
ENDIF.