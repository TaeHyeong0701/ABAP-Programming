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
 
   ![s�ڵ� ����](../../image/error_s.png "s�޽���")

2. 'I'

    ![s�ڵ� ����](../../image/error_s.png "i�޽���")
3. 'W'
 ![s�ڵ� ����](../../image/error_s.png "w�޽���")
4. 'E'
 ![s�ڵ� ����](../../image/error_s.png "e�޽���")
5. 'X'
 ![s�ڵ� ����](../../image/error_s.png "x�޽���")

6. 'A'
 ![s�ڵ� ����](../../image/error_s.png "a�޽���")

