*&---------------------------------------------------------------------*
*& Report  Z_TH0701_DNTABLE
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong Kim
*& Reporting Date: `18.11.27
*& Subject: Dynamic Table Function
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_DNTABLE.
*---------------------------------------< ALV출력 값들.
DATA : OK_CODE TYPE SY-UCOMM,
      container TYPE REF TO cl_gui_custom_container,
      grid TYPE REF TO cl_gui_alv_grid.

*---------------------------------------< Data Declaration 1: 인터널 테이블을 조작하기 위한 값들.
DATA : d_wa_tab TYPE REF TO data,
      d_it_tab TYPE REF TO data,

*----------------------------------------< Data Declaration 2: Nametab internal table, workarea ---> nametab의 값들을 받아주기 위한 internaltable과 workarea
      it_nametab LIKE TABLE OF dntab,
      wa_nametab LIKE LINE OF it_nametab,

*----------------------------------------< Data Declaration 3: 필드카탈로그 ---> 동적테이블의 형태(필드명, 참조 필드명, nametab 결과 테이블)
      lt_fcat TYPE TABLE OF lvc_s_fcat,
      ls_fcat LIKE LINE  OF lt_fcat.
*----------------------------------------< Data Declaration 4: 동적테이블 필드심볼 internaltable ---> 동적테이블의 값들을 할당하기 위한  internaltable과 workare의 필드심볼
FIELD-SYMBOLS: <d_it_tab> TYPE table,
               <d_wa_tab> TYPE ANY.
*----------------------------------------< 1. 파라미터 입력 장소
PARAMETERS tbname TYPE CHAR30.             

*----------------------------------------< 2. 참조테이블의 명칭과 필드들을  알아내겠다!
 CALL FUNCTION 'NAMETAB_GET'
    EXPORTING
      langu          = sy-langu                 " 현재 사용자의 언어로 설정한다.
      tabname        = tbname                   " 입력한 파라미터값으로 테이블명을 주겠다.
    TABLES
      nametab        = it_nametab               " 원하는 테이블을 반환한다.
    EXCEPTIONS
      no_texts_found = 1.
SORT it_nametab BY position.
*----------------------------------------< 3. NAMETAB의 결과로 생성된 필드명, 참조 필드명, 참조 테이블 값들을 필드카탈로그에 넘겨준다.
 LOOP AT it_nametab into wa_nametab.
       IF sy-subrc = 0.
   ls_fcat-fieldname =  wa_nametab-fieldname.       " 필드명들을 넘겨준다.
 	 ls_fcat-ref_table =  tbname.                     " 참조 테이블값을 넘겨준다.
 	 ls_fcat-ref_field =  wa_nametab-fieldname.       " 참조 필드들을 할당한다.
 	 APPEND  ls_fcat  TO lt_fcat.
   ENDIF.
 ENDLOOP.
*----------------------------------------< 4. 다이나믹 테이블을 만들어 낸다.
CALL METHOD cl_alv_table_create=>create_dynamic_table
  EXPORTING
    it_fieldcatalog = lt_fcat
  IMPORTING
    ep_table        = d_it_tab.

ASSIGN d_it_tab->* to <d_it_tab>.

*CREATE DATA d_wa_tab LIKE LINE OF <d_it_tab>.
*ASSIGN d_wa_tab->* TO <d_wa_tab>.
*----------------------------------------< 5. 다이나믹 테이블에 값을 할당시켜준다.
select * from (tbname) into CORRESPONDING FIELDS OF TABLE <d_it_tab> UP TO 50 ROWS.

*----------------------------------------< 6. 스크린을 부른 다음 ALV를 호출한다.
CALL SCREEN 100.

*...
*&---------------------------------------------------------------------*
*&      Module  INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

*----------------------------------------< 7. 동적 테이블과 동적테이블의 필드카탈로그를 참조한다.
  CALL METHOD grid->set_table_for_first_display
  CHANGING
    it_outtab = <d_it_tab>                                             
    it_fieldcatalog = lt_fcat.