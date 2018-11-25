*&---------------------------------------------------------------------*
*&  Include           MZ_TH_MINI_PROJECT1_1O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module STATUS_0100 output.
  SET PF-STATUS 'TH_1_BUTTON'.
  SET TITLEBAR 'TH'.

endmodule.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module STATUS_0200 output.
 SET PF-STATUS 'TH_2_BUTTON'.
*  SET TITLEBAR 'xxx'.

endmodule.                 " STATUS_0200  OUTPUT
MODULE modify_0200 OUTPUT.
*  PERFORM fetch_data.
*GET PARAMETER ID 'MAT' FIELD ZSFT00108-MATNR.
  GET PARAMETER ID 'ZTHMATNR' FIELD wa_tab.
  IF wa_tab IS NOT INITIAL.                                "메모리 이용한 값이 있을 경우.
    MOVE-CORRESPONDING wa_tab TO zsft00108.
    MOVE-CORRESPONDING wa_tab TO t134t.
    LOOP AT SCREEN.
      IF screen-name = 'CHANGE'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-MATNR'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-ERSDA'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-ERNAM'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-LAEDA'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-AENAM'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-MAKTX'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-MATKL'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-MEINS'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-MTART'.
        screen-input = 0.
      ELSEIF screen-name = 'T134T-MTBEZ'.
        screen-input = 0.
        ENDIF.
      MODIFY SCREEN.
    ENDLOOP.

  ELSE.                               "메모리 이용한 값이 없을 경우.
    IF result_tab IS INITIAL.                 "개인테이블에도 값이 없을 경우.
      LOOP AT SCREEN.
        IF screen-name = 'CHANGE'.
          screen-input = 1.
        ELSEIF screen-name = 'ZSFT00108-MATNR'.
          screen-input = 1.
          zsft00108-matnr = th_matnr.
        ELSEIF screen-name = 'ZSFT00108-ERSDA'.
          screen-input = 1.
        ELSEIF screen-name = 'ZSFT00108-ERNAM'.
          screen-input = 1.
        ELSEIF screen-name = 'ZSFT00108-LAEDA'.
          screen-input = 1.
        ELSEIF screen-name = 'ZSFT00108-AENAM'.
          screen-input = 1.
        ENDIF.

        MODIFY SCREEN.
      ENDLOOP.

    ELSE.
      MOVE-CORRESPONDING result_tab TO zsft00108.
      MOVE-CORRESPONDING result_tab TO t134t.
* MOVE result_tab-mtbez to THmtbez.
      LOOP AT SCREEN.
      IF screen-name = 'CHANGE'.
        screen-input = 1.
      ELSEIF screen-name = 'ZSFT00108-MATNR'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-ERSDA'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-ERNAM'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-LAEDA'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-AENAM'.
        screen-input = 0.
      ELSEIF screen-name = 'ZSFT00108-MAKTX'.
        screen-input = 1.
      ELSEIF screen-name = 'ZSFT00108-MATKL'.
        screen-input = 1.
      ELSEIF screen-name = 'ZSFT00108-MEINS'.
        screen-input = 1.
      ELSEIF screen-name = 'ZSFT00108-MTART'.
        screen-input = 1.
      ELSEIF screen-name = 'T134T-MTBEZ'.
        screen-input = 0.
        ENDIF.
        MODIFY SCREEN.
      ENDLOOP.
    ENDIF.
  ENDIF.
  SET PARAMETER ID 'ZTHMATNR' FIELD space.
ENDMODULE.                 " MODIFY_0200  OUTPUT