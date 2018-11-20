************************************************************************
*                                       TOP                                    *
*----------------------------------------------------------------------*
*       CLASS alv_event_handler DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS alv_event_handler DEFINITION.
  PUBLIC SECTION.
    METHODS: handle_hotspot_click FOR EVENT hotspot_click OF   "---> 핫스팟 이벤트 선언 및 cl_gui_alv 동작 감시 선언.
                            cl_gui_alv_grid
                            IMPORTING e_column_id
                                               es_row_no.

ENDCLASS.                    "lcl_event_receiver DEFINITION

*----------------------------------------------------------------------*
*       CLASS alv_event_handler IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS alv_event_handler IMPLEMENTATION.
  METHOD: handle_hotspot_click.                                           " ---> 클릭시 일정 변수들 반환: 필드명, 로우명, 로우 번호
    PERFORM handle_click USING e_column_id                          "--->e_column_id(필드명) 및 es_row_no(로우 번호) 사용 하여 임의 함수 호출.
                                           es_row_no.
  ENDMETHOD.                    "handle_hotspot_click
ENDCLASS.                    "alv_event_handler IMPLEMENTATION
*&---------------------------------------------------------------------*
*&      Form  handle_click
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_COLUMN   text
*      -->PS_ROW_NO  text
*----------------------------------------------------------------------*
FORM handle_click  USING    p_column
                        ps_row_no TYPE lvc_s_roid.
  READ TABLE it_tab INTO wa_tab INDEX ps_row_no-row_id.           "--->행(행 번호)-열(필드명) 관계의 인덱스로 화면에 있는 값들을 읽어낸다.

  IF p_column = 'MATNR'.                                                       "---> MATNR을 읽었을 경우.
    SET PARAMETER ID 'ZTHMATNR' FIELD wa_tab.                        "---> ZTHMATNR 메모리에 WA_TAB을 넘겨주면서.
    CALL TRANSACTION 'ZSAPMZSF002_08'.                                "---> 트랜잭션을 호출한다.
  ENDIF.

ENDFORM.                    " HANDLE_CLICK

************************************************************************
*                                       F01                                     *
*&---------------------------------------------------------------------*
*&      Module  INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
....
   CREATE OBJECT alv_event_handler.                            " 5. 객체 생성.
    SET HANDLER alv_event_handler->HANDLE_hotspot_click FOR grid.
.....

