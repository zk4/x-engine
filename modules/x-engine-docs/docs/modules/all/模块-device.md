

**基座扫描测试**
<div id='modulename' style='display:none'>device</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>



# JS


version: 0.1.5
``` bash
npm install @zkty-team/x-engine-module-device
```



## getPhoneType

设备类型

**demo**
``` js
 {
  window.getPhoneType = () => {
    device
      .getPhoneType({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getSystemVersion

系统版本

**demo**
``` js
{
  window.getSystemVersion = () => {
    device
      .getSystemVersion({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getUDID

UDID

**demo**
``` js
{
  window.getUDID = () => {
    device
      .getUDID({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getBatteryLevel

电池电量

**demo**
``` js
{
  window.getBatteryLevel = () => {
    device
      .getBatteryLevel({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getPreferredLanguage

当前语言

**demo**
``` js
{
  window.getPreferredLanguage = () => {
    device
      .getPreferredLanguage({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getScreenWidth

屏幕宽度

**demo**
``` js
{
  window.getScreenWidth = () => {
    device
      .getScreenWidth({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getScreenHeight

屏幕高度

**demo**
``` js
{
  window.getScreenHeight = () => {
    device
      .getScreenHeight({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getSafeAreaTop

安全区域上边距

**demo**
``` js
{
  window.getSafeAreaTop = () => {
    device
      .getSafeAreaTop({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getSafeAreaBottom

安全区域下边距

**demo**
``` js
{
  window.getSafeAreaBottom = () => {
    device
      .getSafeAreaBottom({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getSafeAreaLeft

安全区域左边距

**demo**
``` js
{
  window.getSafeAreaLeft = () => {
    device
      .getSafeAreaLeft({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getSafeAreaRight

安全区域右边距

**demo**
``` js
{
  window.getSafeAreaRight = () => {
    device
      .getSafeAreaRight({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getStatusHeight

状态栏高度

**demo**
``` js
{
  window.getStatusHeight = () => {
    device
      .getStatusHeight({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getNavigationHeight

导航条高度

**demo**
``` js
{
  window.getNavigationHeight = () => {
    device
      .getNavigationHeight({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## getTabBarHeight

tabBar高度

**demo**
``` js
{
  window.getTabBarHeight = () => {
    device
      .getTabBarHeight({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 回调方法 |


## devicePhoneCall

打电话

**demo**
``` js
{
  window.devicePhoneCall = (...args) => {
  device
    .devicePhoneCall(...args)
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
};
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| phoneNumber | string |  | 10086 | 手机号 |

    

# iOS


# android


