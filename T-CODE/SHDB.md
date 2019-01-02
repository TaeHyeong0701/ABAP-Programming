# SHDB : BDC 레코딩 트랜잭션
####
### OVERVIEW

SHDB는 BDC프로그램의 모태가 되는 레코딩을 만드는 트랜잭션이며, 완성된 BDC프로그램은 **배치프로그램**과 유사하게 반복 작업의 효율성을 높여주는 역할을 하게 된다.
<행동 복사기>
![cop](https://user-images.githubusercontent.com/44318904/50592059-d6700800-0ed5-11e9-9393-9bca9f2d219a.jpg)

#
### SHDB 프로세스
1. SHDB 실행 화면 및 New Recording 실행
- Recording 명칭 및 참조하여 실행할 T-CODE 등을 입력해준다.(여기서는 CS01 BOM생성 과 관련된 T-CODE를 참조하였다.)
![shdb_1](https://user-images.githubusercontent.com/44318904/50592061-d7089e80-0ed5-11e9-85b9-01351d9accfd.PNG)


2. 순차적으로 참조하는 트랜잭션 코드를 실행하여준다. 여기서는 레코딩 개념으로 사용자가 입력하는 값들에 의해 불필요한 레코딩들이 발생되지 않도록 해당 프로세스의 정확한 이해 및 섬세한 작업을 적극 권고되어짐.(CS01을 실행하여, 레코딩을 따냈다.)
![shdb_2](https://user-images.githubusercontent.com/44318904/50592062-d7089e80-0ed5-11e9-9ac5-c84feb91299c.PNG)


3.  Save 버튼 클릭
4.  결과 레코딩화면을  Program -> 원하는 패키지에 저장후 확인하면 완료된다.
![shdb_3](https://user-images.githubusercontent.com/44318904/50592058-d6700800-0ed5-11e9-8af5-02f6d1f6567d.PNG)


5. 이후 부터는 해당 레코딩의 BDC 로직을 이용해서 개발에 사용하면 된다.


