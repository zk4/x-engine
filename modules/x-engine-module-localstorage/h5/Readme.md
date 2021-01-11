
version: 0.1.8
``` bash
npm install @zkty-team/x-engine-module-localstorage
```



## set



**demo**
``` js
 {
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
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string | 必填 |  | 存储设置key值 |
| value | string | 必填 |  | 存储设置value值 |
| isPublic | bool | 必填 |  | 是否数据共享 |


参数 object  定义
``` js


// dto set
interface StorageSetDTO {

  //存储设置key值
  key: string;
  //存储设置value值
  value: string;
  //是否数据共享
  isPublic: boolean;

}
``` 


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
 {
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
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string | 必填 |  | 要获取的存储值的key值 |
| isPublic | bool | 必填 |  | 要获取的存储值是否是共享数据 |


参数 object  定义
``` js


// dto get
interface StorageGetDTO {

  //要获取的存储值的key值
  key: string;
  //要获取的存储值是否是共享数据
  isPublic: boolean;

}
``` 


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
 {
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
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string | 必填 |  | 要删除的存储值的key值 |
| isPublic | bool | 必填 |  | 要删除的存储值是否是共享数据 |


参数 object  定义
``` js


// dto remove
interface StorageRemoveDTO {

  //要删除的存储值的key值
  key: string;
  //要删除的存储值是否是共享数据
  isPublic: boolean;

}
``` 


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
 {
  window.removeAll = () => {
    localstorage
      .removeAll({
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| isPublic | bool | 必填 |  |  |


参数 object  定义
``` js


interface StorageRemoveAllDTO {

  isPublic: boolean;

}
``` 


---------------------
**返回值**
``` js


interface StorageStatusDTO {

  //存储状态返回值
  result: string;

}
``` 



    