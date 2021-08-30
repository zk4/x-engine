

JSI Id: com.zkty.jsi.legacy

version: 0.1.13



## broadcastOn
`sync`,`async`

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
**无返回值**



## broadcastOff
`sync`,`async`

**demo**
``` js
 {
  window.broadcastOff = () => {
    xengine.broadcastOff();
  };
}
``` 

**无参数**
**无返回值**



## triggerNativeBroadCast
`sync`,`async`

**demo**
``` js
 {
  window.triggerNativeBroadCast = () => {
    legacy.triggerNativeBroadCast();
  };
}
``` 

**无参数**
**无返回值**



## repeatReturn__event__
`sync`,`async`

**demo**
``` js
 {
  window.repeatReturn__event__ = () => {
    legacy.repeatReturn__event__({
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
| \_\_event\_\_ | _1_com.zkty.jsi.legacy_DTO | optional |  |  |
**返回值**
``` js
string
``` 



## repeatReturn__ret__
`sync`,`async`

**demo**
``` js
 {
  window.repeatReturn__ret__ = () => {
    legacy.repeatReturn__ret__({
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
| \_\_event\_\_ | _1_com.zkty.jsi.legacy_DTO | optional |  |  |
**返回值**
``` js
string
``` 



## ReturnInPromiseThen
`sync`,`async`

**demo**
``` js
 {
  window.ReturnInPromiseThen = () => {
    legacy.ReturnInPromiseThen().then((res) => {
      document.getElementById("debug_text").innerText =
        "then 只支持一次性返回" + JSON.stringify(res);
    });
  };
}
``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ | _1_com.zkty.jsi.legacy_DTO | optional |  |  |
**返回值**
``` js
string
``` 


    