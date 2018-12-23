******************************************************************************************
*  DATA TYPE                                                                                    *
*  1. smw0에서 템플릿을 받아올 인터널 테이블과 Workarea 설정                  *
******************************************************************************************
DATA : it_wwwdatatab TYPE TABLE OF wwwdatatab,
       wa_wwwdatatab LIKE LINE OF it_wwwdatatab.

*****************************************************************************
*   SMW0상에서 로컬로 데이터를 저장할 수 있도록 하는 함수.       *
*****************************************************************************
FORM get_tmplate USING P_TEMPLATE_NAME.

  SELECT SINGLE *
  INTO CORRESPONDING FIELDS OF wa_wwwdatatab 
  FROM wwwdata                          " 사전에 SAP 상에 저장된 파일들을 불러올 수 있는 테이블 wwwdata
  WHERE 
    objid = 'ZTEST02'                   " objname used when uploading ---> SMW0상에서 저장된 object name을 쓴다.
    .

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'
    EXPORTING
      key         = wa_wwwdatatab.


ENDFORM.                    " GET_TMPL_FROM_SMW0