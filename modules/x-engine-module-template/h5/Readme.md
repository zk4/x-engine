
version: 0.0.58
``` bash
npm install @zkty-team/x-engine-module-xxxx
```



## registerEvent



**demo**
``` js
{
  window.registerEvent = (...args) => {
    xengine.register(function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
    })
  };

}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| eventName | string |  | this_is_customEvent |  |


## unregisterEvent



**demo**
``` js
{
    xengine.unregister()
}
``` 

	
**无参数**




## triggerNativeBroadCast



**demo**
``` js
{
  window.triggerNativeBroadCast = () => {
    xxxx
      .triggerNativeBroadCast()
  };

}
``` 

	
**无参数**




## xengine_on_message



**demo**
``` js
{
  window.xengine_on_message = () => {
    xxxx
      .xengine_on_message({
          __ret__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify("__ret__:"+res);
          },
          __event__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
          }
        }
      )
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string |  |  |  |
| args | Map\<string,string\> | true |  |  |
| sender | string | true |  |  |
| receiver | Array\<string\> | true |  |  |
| \_\_event\_\_ |  |  |  |  |
| \_\_ret\_\_ |  |  |  |  |


## repeatReturn__ret__



**demo**
``` js
{
  window.repeatReturn__ret__ = () => {
    xxxx
      .repeatReturn__ret__({
          __ret__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify("__ret__:"+res);
        return res;
          },
          __event__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
        return res;
          }
        }
      )
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  | true |  |  |


## ReturnInPromiseThen



**demo**
``` js
{
  window.ReturnInPromiseThen = () => {
    xxxx
      .ReturnInPromiseThen({
          __event__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
          }
        }
      )
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  | true |  |  |


## noArgNoRet

 无参数无返回值

**demo**
``` js
{
    window.noArgNoRet = (...args) => {
    xxxx
      .noArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

}
``` 

	
**无参数**




## noArgRetPrimitive

 无参数有 primitive 返回值

**demo**
``` js
 {
    window.noArgRetPrimitive = (...args) => {
    xxxx
      .noArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}
``` 

	
**无参数**




## noArgRetSheetDTO

 无参数有返回值

**demo**
``` js
 {
    window.noArgRetSheetDTO = (...args) => {
    xxxx
      .noArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "title:"+res["title"];
      });
  };
}
``` 

	
**无参数**




## haveArgNoRet



**demo**
``` js
{
    window.haveArgNoRet = (...args) => {
    xxxx
      .haveArgNoRet(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | abc |  标题 |
| itemList | Array\<string\> | true |  |  子标题? |
| content | string | true |  |  内容 |
| \_\_event\_\_ |  |  |  |  点击子标题回调函数 |


## haveArgRetPrimitive

 have args ret primitive

**demo**
``` js
 {
    window.haveArgRetPrimitive = (...args) => {
    xxxx
      .haveArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | abc |  标题 |
| itemList | Array\<string\> | true |  |  子标题? |
| content | string | true |  |  内容 |
| \_\_event\_\_ |  |  |  |  点击子标题回调函数 |


## haveArgRetSheetDTO

 have args ret Object

**demo**
``` js
 {
    window.haveArgRetSheetDTO = (...args) => {
    xxxx
      .haveArgRetSheetDTO(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | abc |  标题 |
| itemList | Array\<string\> | true |  |  子标题? |
| content | string | true |  |  内容 |
| \_\_event\_\_ |  |  |  |  点击子标题回调函数 |

    