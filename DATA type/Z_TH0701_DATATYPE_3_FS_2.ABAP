*&---------------------------------------------------------------------*
*& Report  Z_TH0701_DATATYPE_3_FS_2
*&
*&---------------------------------------------------------------------*
*& Written by TaeHyeong
*& Reporting data: `18.11.13
*&---------------------------------------------------------------------*
* Scenario 1. GLT1테이블에서 TSL1 ~ TSL16 까지의 1~20ROW까지, 출력하라.
*          2. 각 행의 소계를 구하라.
*          3. 최종 합계에는 SUM값들의 합을 구하라
***********************************************************************
REPORT  z_th0701_datatype_3_fs_2.

DATA : it_tab TYPE TABLE OF glt1,
      wa_tab LIKE LINE OF it_tab.
DATA : target(12) TYPE C.               "WA-TAB-TSL00 ---> 12자리.
DATA : num(2) TYPE N.                   "참고. Numeric2 타입으로 선언하면 추후 인터널테이블 루프문에서 알아서 변환됨. ex) 8 ---> 08
DATA : result TYPE WERTV8.              "TSL 타입.
DATA : GROUP_RESULT TYPE WERTV8.        "TSL 타입.
FIELD-SYMBOLS <fs>.                     "필드값에 대한 필드심볼(포인터)를 지정하겠다.

START-OF-SELECTION.
  SELECT *
    FROM glt1 INTO CORRESPONDING FIELDS OF TABLE it_tab
    UP TO 20 ROWS.                        " 1~20row 까지 값을 받아옴.

END-OF-SELECTION.

  LOOP AT it_tab INTO wa_tab.
    ULINE.
    WRITE :  sy-tabix, '행입니다.'.
    IF sy-subrc <> 0.
      EXIT.
    ELSE.
      CLEAR RESULT.                      "클리어하여, 각 행을 구분해준다.
      DO 16 TIMES.
       num = sy-index.
       CONCATENATE 'WA_TAB-TSL' num INTO target.
       ASSIGN (target) to <fs>.
       WRITE : <fs>.
       result = result + <fs>.
      ENDDO.
      ULINE.
      WRITE : / '이번행의 소계:', RESULT.
      GROUP_RESULT = GROUP_RESULT + RESULT.
    ENDIF.

  ENDLOOP.
      WRITE : / '1~20레코드 까지 TSL00들의 총계:', GROUP_RESULT.