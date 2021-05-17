


secret 模块,是用来让 jsi 获取全局信息, 如 token. 用户名,手机号.
需要在 microapp.json 里提前定义以获取相应权限. 
由客户端约定具体的 key 字段.




JSI Id: com.zkty.jsi.secrect

version: 0.1.13



## get
`sync`

**demo**
``` js

  let val = xengine.api("com.zkty.jsi.secrect", "get",
    'TOKEN',
  );
  console.log(val);

``` 

**无参数**
**返回值**
``` js
string
``` 


    

