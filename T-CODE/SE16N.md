 # SE16N
 ## [Overview]
- 첫번쨰 이미지 삽입 
SE11에서의 Entry 추가 방식과 동일한 방식이긴 하나, 일부 권한이 허용되지 않는 테이블의 접근과 데이터 입력을 가능하게하는 SE16N기능에 대해 공부하였습니다.
![se11n 0](https://user-images.githubusercontent.com/44318904/50569832-f7403c80-0db3-11e9-9f9d-23f098da0f31.jpg)
****
## Process
1. SE16N 초기화면 및 테이블 선택
![se16n 1](https://user-images.githubusercontent.com/44318904/50569861-fc51bb80-0db4-11e9-91ee-673889a4cddb.PNG)

2. SE16N 테이블 선택 후 액티베이트 상태 확인
![se16n 2](https://user-images.githubusercontent.com/44318904/50569862-fcea5200-0db4-11e9-8e55-7df9026836a2.PNG)

3. 실행 버튼을 클릭하여, 데이터 입력 탭으로 이동.

4. 담겨진 데이터 값들 확인 가능
![se16n 3](https://user-images.githubusercontent.com/44318904/50569859-fc51bb80-0db4-11e9-8716-d6ae23885143.PNG)

5. Insert Row
![se16n 4](https://user-images.githubusercontent.com/44318904/50569860-fc51bb80-0db4-11e9-8f34-e508a3981fc2.PNG)

6. SAVE 버튼을 클릭하여, 데이터 저장.
****
 ### ***TIP*** 
- 테이블 데이터 조작시, 신중을 기해서 실시해야함.
- 실행이 안된다면, &SAP_EDIT명령어를 T-CODE창에서 실시해줌(권한 확장)
- 조작하고자 하는 테이블의 키값들을 고려해서 판단할 필요가 있음.
- Delete row(Multiple select)도 가능하다.
