 # SE16N
 ## [Overview]
- 첫번쨰 이미지 삽입 
SE11에서의 Entry 추가 방식과 동일한 방식이긴 하나, 일부 권한이 허용되지 않는 테이블의 접근과 데이터 입력을 가능하게하는 SE16N기능에 대해 공부하였습니다.
![se11n 0](https://user-images.githubusercontent.com/44318904/50569832-f7403c80-0db3-11e9-9f9d-23f098da0f31.jpg)
****
## Process
1. SE16N 초기화면 및 테이블 선택
![se16n 1 tableselect](https://user-images.githubusercontent.com/44318904/50569818-b8aa8200-0db3-11e9-856a-a91a8f32201e.PNG)

2. SE16N 테이블 선택 후 액티베이트 상태 확인
![se16n 2 activate](https://user-images.githubusercontent.com/44318904/50569826-ceb84280-0db3-11e9-9d0e-4c1621b86246.PNG)

3. 실행 버튼을 클릭하여, 데이터 입력 탭으로 이동.

4. 담겨진 데이터 값들 확인 가능
![se16n 3 dataview](https://user-images.githubusercontent.com/44318904/50569823-ceb84280-0db3-11e9-9043-9fb6c1e5cd11.PNG)

5. Insert Row
![se16n 4 insertrow](https://user-images.githubusercontent.com/44318904/50569825-ceb84280-0db3-11e9-92fe-b43a92937066.PNG)

6. SAVE 버튼을 클릭하여, 데이터 저장.
****
 ### ***TIP*** 
- 테이블 데이터 조작시, 신중을 기해서 실시해야함.
- 실행이 안된다면, &SAP_EDIT명령어를 T-CODE창에서 실시해줌(권한 확장)
- 조작하고자 하는 테이블의 키값들을 고려해서 판단할 필요가 있음.
- Delete row(Multiple select)도 가능하다.
