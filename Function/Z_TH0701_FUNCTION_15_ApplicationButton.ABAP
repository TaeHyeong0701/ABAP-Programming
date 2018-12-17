REPORT   Z_TH0701_ApplicationButton
*...

************************************************************************
*    Declaration: Assign icon.
************************************************************************
TABLES SSCRFIELDS.                                                         
type-pools : icon.

SELECTION-SCREEN FUNCTION KEY 1.                                  "button 생성

************************************************************************
*    INITIALIZATION: Assign icon.
************************************************************************
INITIALIZATION.
MOVE '@J2@' TO SSCRFIELDS-FUNCTXT_01.                           "xls 아이콘 할당.