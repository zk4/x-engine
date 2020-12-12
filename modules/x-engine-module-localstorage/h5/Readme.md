
version: 0.0.60
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
| key | string |  | key | 存储设置key值 |
| value | string |  | value | 存储设置value值 |
| isPublic | bool |  |  | 是否数据共享 |


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
| key | string |  | key | 要获取的存储值的key值 |
| isPublic | bool |  |  | 要获取的存储值是否是共享数据 |


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
| key | string |  | key | 要删除的存储值的key值 |
| isPublic | bool |  |  | 要删除的存储值是否是共享数据 |


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
| isPublic | bool |  |  |  |

    