# Create a SearchHelp
 
 변수 없이도, 조건을 찾아주는 프로그램
    - Search Help    
 
 
## VS SELECT-OPTIONS
| Search Help |SELECT-OPTIONS|
|:---:|:---:|
| 입력변수가 없어도 조건값 조회 가능 |변수 범위를 사전에 정의, 이후 입력변수로 조건값 조회|

## 종류
- Elementary Search help : 단일 Parameter에 대한 Search Help.
- Collective Search help : 여러 Elementary Search Help에 대한 조합(경우의 수) 


## 생성 순서
1. SE11 : Search Help 선택, Create.
2. 종류 선택(Elementary, Collective 중 택 1.)
3. Description 입력
4. Selection Method에서 테이블 혹은 뷰 선택.
5. PARAMETER 입력
   a. Parameter 명 입력
   b.IMP : 값을 입력하면 해당 값에 만족하는 조건들을 가진 필드들만 Search Help에 나타나도록 설정함. 
    Ex1.) 미설정시, 김*(전체조회)

    Ex2.) 설정시, 김*(조건에 따른 조회)
   c.	EXP : 결과로 나타내어지는 필드 
   d.	SPos : Search Help Parameterr에서의 필드 순서.(입력된 값의 오름차순으로 정렬시킴)
   e.	LPos : hit list내에서 보여지는 필드 순서. (입력된 값의 오름차순으로 정렬시킴)
   f.	Modified flag : Search Help에서 테이블을 참조하고 있어도, 테이블의 Element나, Field가 추후 수정되는 것이 가능하고, SearchHelp가 자동으로 적용됨.
6. SAVE AND ACIVATE
 


