*&---------------------------------------------------------------------*
*&  Include           MZ_TH_MINI_PROJECT1_1O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'TH_1_BUTTON'.
  SET TITLEBAR 'TH'.

ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS 'TH_2_BUTTON'.
*  SET TITLEBAR 'xxx'.

ENDMODULE.                 " STATUS_0200  OUTPUT
*----------------------------------------------------------------------*
*  MODULE modify_0200 OUTPUT
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
MODULE modify_0200 OUTPUT.
************************************************************************
*   2번 프로젝트와 연동하여, SAP 메모리를 활용하여 데이터를 받는다.
************************************************************************
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

  ELSE.
************************************************************************
*   2번 프로젝트와 연동하였지만, 받아온 값이 없을경우 프로그램내에서 변경/조회한다.
************************************************************************
    IF result_tab IS INITIAL.
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

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701
