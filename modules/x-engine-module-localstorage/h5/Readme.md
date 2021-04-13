

JSI Id: com.zkty.module.localstorage

version: 0.1.13



## set



**demo**
``` js

  window.set = () => {
    localstorage
      .set({
        key: "key",
        value: "value",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string | 必填 |  | 存储设置key值 |
| value | string | 必填 |  | 存储设置value值 |
| isPublic | bool | 必填 |  | 是否数据共享 |


---------------------
**返回值**
``` js


interface StorageStatusDTO {

  //存储状态返回值
  result: string;

}
``` 




## get



**demo**
``` js

  window.get = () => {
    localstorage
      .get({
        key: "key",
        isPublic: false,
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
| isPublic | bool | 必填 |  | 要获取的存储值是否是共享数据 |


---------------------
**返回值**
``` js


interface StorageStatusDTO {

  //存储状态返回值
  result: string;

}
``` 




## remove



**demo**
``` js

  window.remove = () => {
    localstorage
      .remove({
        key: "key",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string | 必填 |  | 要删除的存储值的key值 |
| isPublic | bool | 必填 |  | 要删除的存储值是否是共享数据 |


---------------------
**返回值**
``` js


interface StorageStatusDTO {

  //存储状态返回值
  result: string;

}
``` 




## removeAll



**demo**
``` js

  window.removeAll = () => {
    localstorage
      .removeAll({
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| isPublic | bool | 必填 |  |  |


---------------------
**返回值**
``` js


interface StorageStatusDTO {

  //存储状态返回值
  result: string;

}
``` 



    