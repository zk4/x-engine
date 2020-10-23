

**基座扫描测试**
<div id='modulename' style='display:none'>nav</div>
<img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>

# 原生导航

header 用原生的做,这样, 可以一定程度上提高用户体验, 如果页面无响应, 用户可以返回. 不至于只能杀死进程.

注意: 新的路由地址必须唯一.

changed from git subtree 



![2020-07-13 22.34.15](assets/c7be7afb-5977-4051-a7fb-723bc3c9eb27.gif ':size=20%')

 



href 说明:

``` js
┌─────────────────────────────────────────────────────────────────────────────────────────────┐
│                                            href                                             │
├──────────┬──┬─────────────────────┬─────────────────────┬───────────────────────────┬───────┤
│ protocol │  │        auth         │        host         │           path            │ hash  │
│          │  │                     ├──────────────┬──────┼──────────┬────────────────┤       │
│          │  │                     │   hostname   │ port │ pathname │     search     │       │
│          │  │                     │              │      │          ├─┬──────────────┤       │
│          │  │                     │              │      │          │ │    query     │       │
"  https:   //    user   :   pass   @ sub.host.com : 8080   /p/a/t/h  ?  query=string   #hash "
│          │  │          │          │   hostname   │ port │          │                │       │
│          │  │          │          ├──────────────┴──────┤          │                │       │
│ protocol │  │ username │ password │        host         │          │                │       │
├──────────┴──┼──────────┴──────────┼─────────────────────┤          │                │       │
│   origin    │                     │       origin        │ pathname │     search     │ hash  │
├─────────────┴─────────────────────┴─────────────────────┴──────────┴────────────────┴───────┤
│                                            href                                             │
└─────────────────────────────────────────────────────────────────────────────────────────────┘
```



支持以下路由href:

``` 
file://xxx/../index.html
http://xxx/../index.html
https://xxx/../index.html
ftp://xxx/../index.html
```



# JS


``` bash
npm install @zkty-team/com-zkty-module-nav
```



## setNavTitle

 **demo**
 ``` js
 nav.setNavTitle({ title: "title", titleColor: "#000000", titleSize: 16 }).then((res) => {});
 ```

**demo**
``` js
 {
  window.setNavTitle = () => {
    nav.setNavTitle().then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | title | 导航条的文字 |
| titleColor | string |  | #000000 | 16进制的颜色色值 |
| titleSize | int |  | 16 | 字体大小 |


## setNavLeftBtn



**demo**
``` js
 {
  window.setNavLeftBtn = () => {
    nav.setNavLeftBtn().then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | menu | 导航条右边按钮的文字 |
| titleColor | string |  | #000000 | 16进制的颜色色值 |
| titleSize | int |  | 16 | 导航条文字的大小 |
| icon | string | true |  | 见下方说明 |
| iconSize | Array\<double\> |  | ["20","20"] | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | true | [{"icon":"","iconSize":"20","title":"1"},{"icon":"","iconSize":"20","title":"2"},{"icon":"","iconSize":"20","title":"3"}] |  |
| showMenuImg | string | true | false | 见下方说明 |
| popWidth | string | true | 200 | menu的宽 |
| \_\_event\_\_ | string | true |  |  |


## setNavRightBtn



**demo**
``` js
 {
  window.setNavRightBtn = () => {
    nav
      .setNavRightBtn({
        title: "right",
        titleColor: "#000000",
        titleSize: 16,
        icon: "",
        iconSize: ["20", "20"],
        __event__: () => {
          document.getElementById("debug_text").innerText = "ret: click right";
        },
      })
      .then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | menu | 导航条右边按钮的文字 |
| titleColor | string |  | #000000 | 16进制的颜色色值 |
| titleSize | int |  | 16 | 导航条文字的大小 |
| icon | string | true |  | 见下方说明 |
| iconSize | Array\<double\> |  | ["20","20"] | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | true | [{"icon":"","iconSize":"20","title":"1"},{"icon":"","iconSize":"20","title":"2"},{"icon":"","iconSize":"20","title":"3"}] |  |
| showMenuImg | string | true | false | 见下方说明 |
| popWidth | string | true | 200 | menu的宽 |
| \_\_event\_\_ | string | true |  |  |


## setNavRightMenuBtn



**demo**
``` js
 {
  window.setNavRightMenuBtn = () => {
    nav
      .setNavRightMenuBtn({
        title: "menu",
        titleColor: "#000000",
        titleSize: 16,
        icon: "",
        iconSize: ["20", "20"],
        popWidth: "200",
        showMenuImg: "false",
        popList: [
          { icon: "", iconSize: "20", title: "1" },
          { icon: "", iconSize: "20", title: "2" },
          { icon: "", iconSize: "20", title: "3" },
        ],
        __event__: (r) => {
          document.getElementById("debug_text").innerText =
            "ret: click setNavRightMenuBtn: " + r;
        },
      })
      .then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | menu | 导航条右边按钮的文字 |
| titleColor | string |  | #000000 | 16进制的颜色色值 |
| titleSize | int |  | 16 | 导航条文字的大小 |
| icon | string | true |  | 见下方说明 |
| iconSize | Array\<double\> |  | ["20","20"] | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | true | [{"icon":"","iconSize":"20","title":"1"},{"icon":"","iconSize":"20","title":"2"},{"icon":"","iconSize":"20","title":"3"}] |  |
| showMenuImg | string | true | false | 见下方说明 |
| popWidth | string | true | 200 | menu的宽 |
| \_\_event\_\_ | string | true |  |  |


## setNavRightMoreBtn



**demo**
``` js
 {
  window.setNavRightMoreBtn = () => {
    nav.setNavRightMoreBtn().then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| btns | Array\<NavBtnDTO\> |  | [{"title":"right1","titleColor":"#000000","titleSize":16,"iconSize":["20","20"]},{"title":"","icon":"/assets/search.png","titleColor":"#000000","titleSize":16,"iconSize":["20","20"]}] |  |


## navigatorPush

跳转页面.

**demo**
``` js
 {
  window.navigatorPush = () => {
    nav.navigatorPush().then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | true |  | 跳转地址 |
| params | string | true |  | 其余参数 |


## navigatorBack

返回层级. 如果url为空则返回上一级, 堆栈中有对应地址, 则返回该界面

**demo**
``` js
 {
  window.navigatorBack = () => {
    nav.navigatorBack().then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | true |  | 跳转地址 |
| params | string | true |  | 其余参数 |


## navigatorRouter

跳转页面.

**demo**
``` js
 {
  window.navigatorRouter = () => {
    nav.navigatorRouter().then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string |  |  | 跳转类型 |
| uri | string |  |  | 跳转目标 |
| path | string |  |  | 跳转参数 |


## setNavSearchBar

** demo **
``` js
nav
  .setNavSearchBar({
    cornerRadius: 5,
    backgroundColor: "#FF0000",
    iconSearch: "",
    iconSearchSize: [20, 20],
    iconClear: "",
    iconClearSize: [20, 20],
    textColor: "#000000",
    fontSize: 16,
    placeHolder: "默认文字",
    placeHolderFontSize: 16,
    isInput: true,
    becomeFirstResponder: false,
    __event__: () => {
      document.getElementById("debug_text").innerText =
        "ret: click searchBar";
    },
  })
  .then((res) => {});

```

**demo**
``` js
 {
  window.setNavSearchBar = () => {
    nav
      .setNavSearchBar({
        cornerRadius: 5,
        backgroundColor: "#FF0000",
        iconSearch: "",
        iconSearchSize: [20, 20],
        iconClear: "",
        iconClearSize: [20, 20],
        textColor: "#000000",
        fontSize: 16,
        placeHolder: "默认文字",
        placeHolderFontSize: 16,
        isInput: true,
        becomeFirstResponder: false,
        __event__: () => {
          document.getElementById("debug_text").innerText =
            "ret: click searchBar";
        },
      })
      .then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| cornerRadius | int |  | 5 | 搜索框圆角大小 |
| backgroundColor | string |  | #FF0000 | 搜索框背景颜色 |
| iconSearch | string |  |  | 搜索框里搜索图片 |
| iconSearchSize | Array\<double\> |  | [20,20] | 搜索框里搜索图片大小 |
| iconClear | string |  |  | 搜索框里清空图片 |
| iconClearSize | Array\<double\> |  | [20,20] | 搜索框里清空图片大小 |
| textColor | string |  | #000000 | 搜索框文本颜色 |
| fontSize | int |  | 16 | 搜索框文本字体大小 |
| placeHolder | string |  | 默认文字 | 搜索框占位符 |
| placeHolderFontSize | int |  | 16 | 搜索框占位符大小 |
| isInput | bool |  | true | 搜索框是否添加点击事件 |
| becomeFirstResponder | bool |  |  | 搜索框是否获取焦点 |
| \_\_event\_\_ | string | true |  |  |

    

# iOS


# android


