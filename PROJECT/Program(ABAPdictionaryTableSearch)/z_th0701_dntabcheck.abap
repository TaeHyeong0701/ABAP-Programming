*&---------------------------------------------------------------------*
*& Report  Z_TH0701_DNTABCHECK
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_DNTABCHECK.

PARAMETERS result TYPE string.

 DATA : tdd02l LIKE dd02l.                         " SAP TABLE 구조를 참조.

  SELECT * FROM  dd02l                             " SAP TABLE에서 조회.
         INTO tdd02l
         WHERE  tabname  = result                  " 조회한 결과.
             AND    as4local = 'A'                 " 로컬에 액티브되었는가? A :
         AND   ( tabclass      <> 'INTTAB'         " 테이블 타입. (INTTAB : 구조체, 클러스터 테이블)
                 AND tabname   <> 'APPEND'         "
                 AND tabclass  <> 'VIEW' ).        "
  ENDSELECT.
    if sy-subrc = 0.
      WRITE : / 'ABAP Dictionary에 테이블이 있습니다.'.
    ELSE.
      WRITE : / 'ABAP Dictionary에 테이블이 없습니다.'.
      ENDIF.

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
