*&---------------------------------------------------------------------*
*&  Include           MZ_TH_MINI_PROJECT1_1F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  FETCH_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fetch_data .


*  SELECT a~matnr a~seqnr a~mtart a~matkl a~meins a~ersda a~ernam a~laeda a~aenam b~wgbez INTO CORRESPONDING FIELDS OF TABLE it_tab
  SELECT * INTO CORRESPONDING FIELDS OF TABLE it_tab
    FROM zsft00108 AS a INNER JOIN t023t AS b
    ON a~matkl = b~matkl
    WHERE a~matnr = th_matnr
    AND b~spras = sy-langu.
  IF sy-subrc = 0.
    SELECT *
      FROM t134t INTO CORRESPONDING FIELDS OF TABLE it_t134t_tab
      FOR ALL ENTRIES IN it_tab
      WHERE mtart = it_tab-mtart
          AND spras = sy-langu.

    LOOP AT it_tab INTO wa_tab.
      READ TABLE it_t134t_tab INTO wa_t134t_tab WITH KEY mtart = wa_tab-mtart.
      IF sy-subrc = 0.
        wa_tab-mtbez = wa_t134t_tab-mtbez.
      ENDIF.
      MODIFY it_tab FROM wa_tab.
    ENDLOOP.
          MOVE-CORRESPONDING wa_tab TO result_tab.



 ELSE .
    SELECT a~mandt a~matnr a~mtart a~matkl a~meins a~ersda a~ernam a~laeda a~aenam b~maktx INTO CORRESPONDING FIELDS OF TABLE it_tab
       FROM mara AS a INNER JOIN makt AS b
       ON a~matnr = b~matnr
       WHERE a~matnr = th_matnr
       and b~spras = sy-langu.
*    ENDSELECT.
    IF sy-subrc = 0.
*      isinitial = 0.
      SELECT *
      FROM t134t INTO CORRESPONDING FIELDS OF TABLE it_t134t_tab
      FOR ALL ENTRIES IN it_tab
      WHERE mtart = it_tab-mtart
       AND SPRAS = SY-LANGU.

      LOOP AT it_tab INTO wa_tab.
        READ TABLE it_t134t_tab INTO wa_t134t_tab WITH KEY mtart = wa_tab-mtart.
        IF sy-subrc = 0.
          wa_tab-mtbez = wa_t134t_tab-mtbez.
        ENDIF.
        MODIFY it_tab FROM wa_tab.
      ENDLOOP.
      MOVE-CORRESPONDING wa_tab TO result_tab.
*       MOVE wa_tab-mtbez to thmtbez.      "
*      isinitial = 1.
    ENDIF.
  ENDIF.
    SORT it_tab BY seqnr DESCENDING.

*    isinitial = 1.
    LOOP AT it_tab INTO wa_tab. "READTABLE
      IF sy-tabix = 1.
        MOVE-CORRESPONDING wa_tab TO result_tab.
      ENDIF.
    ENDLOOP.

    clear wa_tab.


ENDFORM.                    " FETCHs_DATA