*&---------------------------------------------------------------------*
*& Report  Z_TH0701_DYNAMIC
*&
*&---------------------------------------------------------------------*
*& Subject: Dynamic Table AND PARAMETERS.
*& Written By: TaeHyeong Kim
*& Reporting Data : `18.11.17.
*&---------------------------------------------------------------------*

REPORT  z_th0701_dynamic.
*--------------------------------------------------------" 1. 데이터 레퍼런스 및 파라미터 값 선언.
DATA: dref TYPE REF TO data.
PARAMETERS : tabname TYPE string.
*--------------------------------------------------------" 2. 값을 받아올 필드심볼 선언. (ROW: 행의 구조체 타입, component: 행에 있는 각 필드값.)
FIELD-SYMBOLS: <row>       TYPE ANY,
               <field>.
*--------------------------------------------------------" 3. 데이터 레퍼런스가 테이블 구조를 참조하여, 타입이 지정됨.
CREATE DATA dref TYPE (tabname).
*--------------------------------------------------------" 4. 테이블 구조를 역참조받아 <row> 필드심볼에 할당한다.
                                                                 "!! 바로 값을 받아올 수 없기 떄문에 역참조와 필드심볼을 활용해야된다.
ASSIGN dref->* TO <row>.

*--------------------------------------------------------" 5. 테이블 추출.
                                                                 "!! 동적명을 사용하니, 테이블명은 ( )를 붙여주고, <row>필드심볼에 값을 넣어준다.
SELECT *
FROM (tabname)
INTO <row>.
  NEW-LINE.
  DO.                                                      " 5-1. <row>의 구조체에서 sy-index(한칼럼 한칼럼씩)를 활용하여, field 추출.
    ASSIGN COMPONENT sy-index OF STRUCTURE <row> TO <field>.
    if sy-subrc <> 0.                                    " 7. 탈출구문 필히 작성: 안하면 계속 루핑된다.
      exit.
      ENDIF.
    WRITE: <field>.                                      " 6. <filed> 추출하여 결과화면 출력.
  ENDDO.
ENDSELECT.