
version: 0.1.13
``` bash
npm install @zkty-team/x-engine-module-xxxx
```



## broadcastOn



**demo**
``` js
 {
  window.broadcastOn = (...args) => {
    xengine.broadcastOn(function (res) {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    });
  };
}
``` 

	
**无参数**




参数 object  定义


---------------------
**无返回值**




## broadcastOff



**demo**
``` js
 {
  window.broadcastOff = () => {
    xengine.broadcastOff();
  };
}
``` 

	
**无参数**




参数 object  定义


---------------------
**无返回值**




## triggerNativeBroadCast



**demo**
``` js
 {
  window.triggerNativeBroadCast = () => {
    xxxx.triggerNativeBroadCast();
  };
}
``` 

	
**无参数**




参数 object  定义


---------------------
**无返回值**




## repeatReturn__event__



**demo**
``` js
 {
  window.repeatReturn__event__ = () => {
    xxxx.repeatReturn__event__({
      __event__: function (res) {
        document.getElementById("debug_text").innerText =
          "支持多次返回" + JSON.stringify(res);
        return res;
      },
    });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ | _1_com.zkty.module.xxxx_DTO | optional |  |  |


参数 object  定义
``` js


interface ContinousDTO {

  __event__?: (string) => {

};

}
``` 


---------------------
**无返回值**




## repeatReturn__ret__



**demo**
``` js
 {
  window.repeatReturn__ret__ = () => {
    xxxx.repeatReturn__ret__({
      __ret__: function (res) {
        document.getElementById("debug_text").innerText =
          "支持多次返回" + JSON.stringify("__ret__:" + res);
        return res;
      },
    });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ | _1_com.zkty.module.xxxx_DTO | optional |  |  |


参数 object  定义
``` js


interface ContinousDTO {

  __event__?: (string) => {

};

}
``` 


---------------------
**无返回值**




## ReturnInPromiseThen



**demo**
``` js
 {
  window.ReturnInPromiseThen = () => {
    xxxx.ReturnInPromiseThen().then((res) => {
      document.getElementById("debug_text").innerText =
        "then 只支持一次性返回" + JSON.stringify(res);
    });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ | _1_com.zkty.module.xxxx_DTO | optional |  |  |


参数 object  定义
``` js


interface ContinousDTO {

  __event__?: (string) => {

};

}
``` 


---------------------
**无返回值**




## noArgNoRet

 无参数无返回值

**demo**
``` js
 {
  window.noArgNoRet = (...args) => {
    xxxx.noArgNoRet(...args).then((res) => {
      document.getElementById("debug_text").innerText = "ret:" + res;
    });
  };
}
``` 

	
**无参数**




参数 object  定义


---------------------
**无返回值**




## noArgRetPrimitive

 无参数有 primitive 返回值

**demo**
``` js
 {
  window.noArgRetPrimitive = (...args) => {
    xxxx.noArgRetPrimitive(...args).then((res) => {
      document.getElementById("debug_text").innerText = "ret:" + res;
    });
  };
}
``` 

	
**无参数**




参数 object  定义


---------------------
**无返回值**




## noArgRetSheetDTO

 无参数有返回值

**demo**
``` js
 {
  window.noArgRetSheetDTO = (...args) => {
    xxxx.noArgRetSheetDTO(...args).then((res) => {
      document.getElementById("debug_text").innerText = "title:" + res["title"];
    });
  };
}
``` 

	
**无参数**




参数 object  定义


---------------------
**返回值**
``` js


// dto
interface SheetDTO {

  // 标题
  title: string;
  // 子标题?
  itemList?: Array<string>;
  // 内容
  content?: string;
  // 点击子标题回调函数
  __event__: (index: string) => void;

}
``` 




## haveArgNoRet



**demo**
``` js
 {
  window.haveArgNoRet = (...args) => {
    xxxx.haveArgNoRet(...args).then((res) => {
      document.getElementById("debug_text").innerText = "ret:" + res;
    });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string | 必填 | abc |  标题 |
| itemList | Array\<string\> | optional |  |  子标题? |
| content | string | optional |  |  内容 |
| \_\_event\_\_ | _0_com.zkty.module.xxxx_DTO | 必填 |  |  点击子标题回调函数 |


参数 object  定义
``` js


// dto
interface SheetDTO {

  // 标题
  title: string;
  // 子标题?
  itemList?: Array<string>;
  // 内容
  content?: string;
  // 点击子标题回调函数
  __event__: (index: string) => void;

}
``` 


---------------------
**无返回值**




## haveArgRetPrimitive

 have args ret primitive

**demo**
``` js
 {
  window.haveArgRetPrimitive = (...args) => {
    xxxx.haveArgRetPrimitive(...args).then((res) => {
      document.getElementById("debug_text").innerText = "ret:" + res;
    });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string | 必填 | abc |  标题 |
| itemList | Array\<string\> | optional |  |  子标题? |
| content | string | optional |  |  内容 |
| \_\_event\_\_ | _0_com.zkty.module.xxxx_DTO | 必填 |  |  点击子标题回调函数 |


参数 object  定义
``` js


// dto
interface SheetDTO {

  // 标题
  title: string;
  // 子标题?
  itemList?: Array<string>;
  // 内容
  content?: string;
  // 点击子标题回调函数
  __event__: (index: string) => void;

}
``` 


---------------------
**无返回值**




## haveArgRetSheetDTO

 have args ret Object

**demo**
``` js
 {
  window.haveArgRetSheetDTO = (...args) => {
    xxxx.haveArgRetSheetDTO({ title: "abc" }).then((res) => {
      document.getElementById("debug_text").innerText = "ret:" + res["title"];
    });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string | 必填 | abc |  标题 |
| itemList | Array\<string\> | optional |  |  子标题? |
| content | string | optional |  |  内容 |
| \_\_event\_\_ | _0_com.zkty.module.xxxx_DTO | 必填 |  |  点击子标题回调函数 |


参数 object  定义
``` js


// dto
interface SheetDTO {

  // 标题
  title: string;
  // 子标题?
  itemList?: Array<string>;
  // 内容
  content?: string;
  // 点击子标题回调函数
  __event__: (index: string) => void;

}
``` 


---------------------
**返回值**
``` js


// dto
interface SheetDTO {

  // 标题
  title: string;
  // 子标题?
  itemList?: Array<string>;
  // 内容
  content?: string;
  // 点击子标题回调函数
  __event__: (index: string) => void;

}
``` 




## anonymousType



**demo**
``` js
 {
  window.anonymousType = (...args) => {
    xxxx
      .anonymousType({
        age: 14,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText =
          "ret:" + JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| age | int | optional | 12 |  |
| name | string | optional | zk |  |
| books | Array\<string\> | optional | ["1","2","3"] |  |
| complexArg | _7_com.zkty.module.xxxx_DTO | optional | {"a":1,"name":"zk2"} |  |


参数 object  定义
``` js
 {

    age?: int;
    name?: string;
    books?: Array<string>;
    complexArg?: {
 a: int; name: string 
};
  
}
``` 


---------------------
**返回值**
``` js
 {

  age?: int;
  name?: string;
  books?: Array<string>;
  complexArg?: {
 a: int; name: string 
};

}
``` 



    