

JSI Id: com.zkty.module.secrect

version: 0.1.12



## get



**demo**
``` js

  window.get = () => {
    secrect
      .get({
        key: "key"
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string | 必填 |  | 要获取的存储值的key值 |


---------------------
**返回值**
``` js


interface SecretDTO {

  //返回值
  result: string;

}
``` 



    