 # Message Category
 
 �ý��� ���� �߻���, ����ڿ��� �˷��ִ� �޽��� Ÿ�Կ� ���� �����Ͽ����ϴ�.
 
 
## Message Category

 
| �ؽ�Ʈ |�ǹ�|�����ܰ�|

|:---:|:---:|:---:|

| S  |�����ߴ�.|Success|

|I|�˾�â���� �˷��ش�|Success|

|W|Status�ٿ� �������ǥ�� ������ �޽��� ���|Success|

|E|Status�ٿ� ��������ǥ�� ������ �޽���|Fail|

|X|Dump error + ��������|Fail|

|A|�˾�â + ��������|Fail|

|BC410 ��Ű��|���� �޽��� ���� ��Ű��(Predefined)|-|



## �����ڵ�

```

IF sysubrc <> 0.
MESSAGE 'Fail' TYPE '<text>'.
ENDIF.


```



## ���ȭ��

1. 'S'
 
   [!s�ڵ� ����](https://github.com/TaeHyeong0701/ABAP-Programming/tree/master/image/error_S.png)

2. 'I'

   [!I�ڵ� ����](https://github.com/TaeHyeong0701/ABAP-Programming/tree/master/image/error_I.png)
3. 'W'
[!W�ڵ� ����](https://github.com/TaeHyeong0701/ABAP-Programming/tree/master/image/error_W.png)
4. 'E'
[!E�ڵ� ����](https://github.com/TaeHyeong0701/ABAP-Programming/tree/master/image/error_E.png)

5. 'X'
[!X�ڵ� ����](https://github.com/TaeHyeong0701/ABAP-Programming/tree/master/image/error_X.png)

6. 'A'
[!A�ڵ� ����](https://github.com/TaeHyeong0701/ABAP-Programming/tree/master/image/error_A.png)

