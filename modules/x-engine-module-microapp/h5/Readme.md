
version: 0.1.7
``` bash
npm install @zkty-team/x-engine-module-microapp
```



## broadcastOn



**demo**
``` js
{
  window.broadcastOn = (...args) => {
    xengine.broadcastOn(function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
    })
  };
}
``` 

	
**无参数**




## broadcastOff



**demo**
``` js
{
  window.broadcastOff = () => {
    xengine.broadcastOff()
  };
}
``` 

	
**无参数**




## triggerNativeBroadCast



**demo**
``` js
{
  window.triggerNativeBroadCast = () => {
    microapp
      .triggerNativeBroadCast()
  };

}
``` 

	
**无参数**




## repeatReturn__event__



**demo**
``` js
{
  window.repeatReturn__event__ = () => {
    microapp
      .repeatReturn__event__({
          __event__:function(res){
        document.getElementById("debug_text").innerText = "支持多次返回"+ JSON.stringify(res);
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


## repeatReturn__ret__



**demo**
``` js
{
  window.repeatReturn__ret__ = () => {
    microapp
      .repeatReturn__ret__(
        {
          __ret__:function(res){
        document.getElementById("debug_text").innerText = "支持多次返回"+ JSON.stringify("__ret__:"+res);
        return res;
          },
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
    microapp
      .ReturnInPromiseThen()
      .then((res) => {
        document.getElementById("debug_text").innerText ="then 只支持一次性返回"+ JSON.stringify(res);
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
    microapp
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
    microapp
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
    microapp
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
    microapp
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
    microapp
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
    microapp
      .haveArgRetSheetDTO({title:"abc"})
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


## anonymousType



**demo**
``` js
 {
      window.anonymousType = (...args) => {
    microapp
      .anonymousType({
  age: 14,
  
})
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+JSON.stringify(res);
      });
  };

}
``` 

	
**无参数**



    