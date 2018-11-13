FORM set_grid_fcat_100  CHANGING ct_fcat TYPE lvc_t_fcat.
  DATA: ls_fcat TYPE lvc_s_fcat. "필드 카탈로그 타입.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'OBJID'.     "MATNR 필드만 조회하겠다.
  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = '1'.
  LS_fcat-emphasize = 'C610'.      "칼럼 색상 추가(빨강).

  ls_fcat-scrtext_s = 'OBJID'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'STEXT'.     "STEXT 필드 조회하겠다.
  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = '1'.
  LS_fcat-emphasize = 'C111'.      "칼럼 색상 추가(파랑).
  ls_fcat-scrtext_s = 'STEXT'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'PERNR'.     "PERNR 필드 조회하겠다.
  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = '1'.
    LS_fcat-emphasize = 'C311'.      "칼럼 색상 추가(노랑).
  ls_fcat-scrtext_s = 'PERNR'.
  APPEND ls_fcat TO ct_fcat.
    CLEAR ls_fcat.
  ls_fcat-fieldname = 'ENAME'.     "ENAME 필드 조회하겠다.
  ls_fcat-outputlen = 18.
  ls_fcat-col_pos   = '1'.
      LS_fcat-emphasize = 'C511'.      "칼럼 색상 추가(초록).
  ls_fcat-scrtext_s = 'ENAME'.
  APPEND ls_fcat TO ct_fcat.

ENDFORM.                           "SET_GRID_FCAT_100