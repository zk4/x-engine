
`
com.zkty.module.nav
`



## setNavTitle

 **demo**
 ``` js
 nav.setNavTitle({ title: "title", titleColor: "#000000", titleSize: 16 }).then((res) => {});
 ```

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | title | 导航条的文字 |
| titleColor | string |  | #000000 | 16进制的颜色色值 |
| titleSize | int |  | 16 | 字体大小 |


## setNavLeftBtn



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  |  | 导航条右边按钮的文字 |
| titleColor | string |  |  | 16进制的颜色色值 |
| titleSize | int |  |  | 导航条文字的大小 |
| titleBig | string | true |  | 按钮文字粗细  |
| titleFontName | string | true |  | 设置字体, android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium |
| isBoldFont | bool | true |  | 在不设置 titleFontName 时, 是否使用系统粗体. |
| icon | string | true |  | 见下方说明 |
| iconSize | Array\<double\> |  |  | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | true |  |  |
| showMenuImg | string | true |  | 见下方说明 |
| popWidth | string | true |  | menu的宽 |
| \_\_event\_\_ | string | true |  |  |


## setNavRightBtn



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  |  | 导航条右边按钮的文字 |
| titleColor | string |  |  | 16进制的颜色色值 |
| titleSize | int |  |  | 导航条文字的大小 |
| titleBig | string | true |  | 按钮文字粗细  |
| titleFontName | string | true |  | 设置字体, android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium |
| isBoldFont | bool | true |  | 在不设置 titleFontName 时, 是否使用系统粗体. |
| icon | string | true |  | 见下方说明 |
| iconSize | Array\<double\> |  |  | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | true |  |  |
| showMenuImg | string | true |  | 见下方说明 |
| popWidth | string | true |  | menu的宽 |
| \_\_event\_\_ | string | true |  |  |


## setNavRightMenuBtn



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  |  | 导航条右边按钮的文字 |
| titleColor | string |  |  | 16进制的颜色色值 |
| titleSize | int |  |  | 导航条文字的大小 |
| titleBig | string | true |  | 按钮文字粗细  |
| titleFontName | string | true |  | 设置字体, android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium |
| isBoldFont | bool | true |  | 在不设置 titleFontName 时, 是否使用系统粗体. |
| icon | string | true |  | 见下方说明 |
| iconSize | Array\<double\> |  |  | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | true |  |  |
| showMenuImg | string | true |  | 见下方说明 |
| popWidth | string | true |  | menu的宽 |
| \_\_event\_\_ | string | true |  |  |


## setNavRightMoreBtn



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| btns | Array\<NavBtnDTO\> |  |  |  |


## navigatorPush

跳转页面.

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | true |  | 跳转地址 |
| params | string | true |  | 其余参数 |
| hideNavbar | bool | true |  |  是否隐藏navbar, 默认 false |


## navigatorBack

返回层级. 如果url为空则返回上一级, 堆栈中有对应地址, 则返回该界面

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | true |  | 跳转地址 |
| hideNavbar | bool | true |  |  是否隐藏navbar, 默认 false |


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

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| cornerRadius | int |  |  | 搜索框圆角大小 |
| backgroundColor | string |  |  | 搜索框背景颜色 |
| iconSearch | string |  |  | 搜索框里搜索图片 |
| iconSearchSize | Array\<double\> |  |  | 搜索框里搜索图片大小 |
| iconClear | string |  |  | 搜索框里清空图片 |
| iconClearSize | Array\<double\> |  |  | 搜索框里清空图片大小 |
| textColor | string |  |  | 搜索框文本颜色 |
| fontSize | int |  |  | 搜索框文本字体大小 |
| placeHolder | string |  |  | 搜索框占位符 |
| placeHolderFontSize | int |  |  | 搜索框占位符大小 |
| isInput | bool |  |  | 搜索框是否添加点击事件 |
| becomeFirstResponder | bool |  |  | 搜索框是否获取焦点 |
| \_\_event\_\_ | string | true |  |  |


## setSearchBarHidden



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| isHidden | bool |  |  | 是否隐藏navBar |
| isAnimation | bool |  |  | 是否使用动画效果 |


## setNavBarHidden

*
Deprecated
使用push,或 nav 里 hideNavbar 参数控制状态的显示
*

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| isHidden | bool |  |  | 是否隐藏navBar |
| isAnimation | bool |  |  | 是否使用动画效果 |


## removeHistoryPage



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| history | Array\<string\> |  |  |  |

    