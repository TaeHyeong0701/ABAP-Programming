    CALL TRANSACTION 'MF50' USING bdcdata
                     MODE   p_mode                                        " 모든 N(BDC를 수행하다가 오류가 나더라도 넘어가라)이나 A(하나하나 다 보여주는 것)냐 E냐
                     UPDATE 'S'                                        " 업데이트 옵션: S(동시에)냐, A(레코딩 끝나고 데이터베이스에 업데이트를 나중에 해라)냐, L이냐
                     MESSAGES INTO messtab.

***********************************************************************
* 데이터가 담긴 인터널 테이블 ---> 결과 ALV에 뿌려줄 인터널테이블 데이터 이동.
***********************************************************************
  MOVE-CORRESPONDING wa_tab TO re_wa_tab.

    re_wa_tab-light = c_green.
    LOOP AT messtab[] INTO messtab.
***********************************************************************
* messtab의 타입이 E라면.
***********************************************************************
      IF messtab-msgtyp = 'E'.
        re_wa_tab-light = c_red.
***********************************************************************
* MESSAGE_TEXT_BUILD 함수를 통해서, 에러 메시지를 받는다.
***********************************************************************
        CALL FUNCTION 'MESSAGE_TEXT_BUILD'
          EXPORTING
            msgid               = messtab-msgid
            msgnr               = messtab-msgnr
          IMPORTING
            message_text_output = re_wa_tab-text.
        EXIT.
      ENDIF.
    ENDLOOP.