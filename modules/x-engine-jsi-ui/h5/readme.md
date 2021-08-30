

JSI Id: com.zkty.jsi.ui

version: 2.8.1



## setNavTitle
[`async`](/docs/modules/模块-规范?id=jsi-调用)

**demo**
``` js

  xengine.api("com.zkty.jsi.ui", "setNavTitle", {
    title: "title",
    titleColor: "#000000"
  });

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string | 必填 |  | 导航条的文字 |
| titleColor | string | 必填 |  | 16进制的颜色色值 |
| titleSize | int | 必填 | 16 | 字体大小 |
**无返回值**



## setNavBarHidden
[`async`](/docs/modules/模块-规范?id=jsi-调用)
> 使用push,或 nav 里 hideNavbar 参数控制状态的显示
**demo**
``` js

  xengine.api("com.zkty.jsi.ui", "setNavBarHidden", {
    //是否隐藏navBar
    isHidden: true,
    //是否使用动画效果
    isAnimation: true,
  });

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| isHidden | bool | 必填 |  | 是否隐藏navBar |
| isAnimation | bool | 必填 |  | 是否使用动画效果 |
**无返回值**


    