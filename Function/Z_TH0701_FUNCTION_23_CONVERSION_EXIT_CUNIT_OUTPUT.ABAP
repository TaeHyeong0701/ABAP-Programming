***********************************************************************
* meins의 언어 문제를 해결. 예. PC ---> ST(X) // PC ---> ST(O)
***********************************************************************
CALL FUNCTION 'CONVERSION_EXIT_CUNIT_OUTPUT'
         EXPORTING
           input    = wa_ref-meins
           language = sy-langu
          IMPORTING
            output   = wa_ref-meins.
 APPEND wa_ref TO it_ref.