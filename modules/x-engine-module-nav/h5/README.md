
version: 0.1.8
``` bash
npm install @zkty-team/x-engine-module-nav
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
| title | string | 必填 | title | 导航条的文字 |
| titleColor | string | 必填 | #000000 | 16进制的颜色色值 |
| titleSize | int | 必填 | 16 | 字体大小 |


参数 object  定义
``` js


interface NavTitleDTO {

  //导航条的文字
  title: string;
  //16进制的颜色色值
  titleColor: string;
  //字体大小
  titleSize: int;

}
``` 


---------------------
**无返回值**




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
| title | string | 必填 | menu | 导航条右边按钮的文字 |
| titleColor | string | 必填 | #000000 | 16进制的颜色色值 |
| titleSize | int | 必填 | 16 | 导航条文字的大小 |
| titleBig | string | optional |  | 按钮文字粗细  |
| titleFontName | string | optional |  | 设置字体, android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium |
| isBoldFont | bool | optional |  | 在不设置 titleFontName 时, 是否使用系统粗体. |
| icon | string | optional |  | 见下方说明 |
| iconSize | Array\<double\> | 必填 | ["20","20"] | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | optional | [{"icon":"","iconSize":"20","title":"1"},{"icon":"","iconSize":"20","title":"2"},{"icon":"","iconSize":"20","title":"3"}] |  |
| showMenuImg | string | optional | false | 见下方说明 |
| popWidth | string | optional | 200 | menu的宽 |
| \_\_event\_\_ | string | optional |  |  |


参数 object  定义
``` js


interface NavBtnDTO {

  //导航条右边按钮的文字
  title: string;
  //16进制的颜色色值
  titleColor: string;
  //导航条文字的大小
  titleSize: int;

  //按钮文字粗细 
  titleBig?: string;
  
  //设置字体,
 android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium
  titleFontName?: string;
  //在不设置 titleFontName 时,
 是否使用系统粗体.
  isBoldFont?: boolean;

  //见下方说明
  icon?: string;
  //图片的宽高
  iconSize: Array<double>;

  popList?: Array<Map<string,
 string>>;
  //见下方说明
  showMenuImg?: string;
  //menu的宽
  popWidth?: string;

  __event__?: string;

}
``` 


---------------------
**无返回值**




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
| title | string | 必填 | menu | 导航条右边按钮的文字 |
| titleColor | string | 必填 | #000000 | 16进制的颜色色值 |
| titleSize | int | 必填 | 16 | 导航条文字的大小 |
| titleBig | string | optional |  | 按钮文字粗细  |
| titleFontName | string | optional |  | 设置字体, android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium |
| isBoldFont | bool | optional |  | 在不设置 titleFontName 时, 是否使用系统粗体. |
| icon | string | optional |  | 见下方说明 |
| iconSize | Array\<double\> | 必填 | ["20","20"] | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | optional | [{"icon":"","iconSize":"20","title":"1"},{"icon":"","iconSize":"20","title":"2"},{"icon":"","iconSize":"20","title":"3"}] |  |
| showMenuImg | string | optional | false | 见下方说明 |
| popWidth | string | optional | 200 | menu的宽 |
| \_\_event\_\_ | string | optional |  |  |


参数 object  定义
``` js


interface NavBtnDTO {

  //导航条右边按钮的文字
  title: string;
  //16进制的颜色色值
  titleColor: string;
  //导航条文字的大小
  titleSize: int;

  //按钮文字粗细 
  titleBig?: string;
  
  //设置字体,
 android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium
  titleFontName?: string;
  //在不设置 titleFontName 时,
 是否使用系统粗体.
  isBoldFont?: boolean;

  //见下方说明
  icon?: string;
  //图片的宽高
  iconSize: Array<double>;

  popList?: Array<Map<string,
 string>>;
  //见下方说明
  showMenuImg?: string;
  //menu的宽
  popWidth?: string;

  __event__?: string;

}
``` 


---------------------
**无返回值**




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
| title | string | 必填 | menu | 导航条右边按钮的文字 |
| titleColor | string | 必填 | #000000 | 16进制的颜色色值 |
| titleSize | int | 必填 | 16 | 导航条文字的大小 |
| titleBig | string | optional |  | 按钮文字粗细  |
| titleFontName | string | optional |  | 设置字体, android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium |
| isBoldFont | bool | optional |  | 在不设置 titleFontName 时, 是否使用系统粗体. |
| icon | string | optional |  | 见下方说明 |
| iconSize | Array\<double\> | 必填 | ["20","20"] | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | optional | [{"icon":"","iconSize":"20","title":"1"},{"icon":"","iconSize":"20","title":"2"},{"icon":"","iconSize":"20","title":"3"}] |  |
| showMenuImg | string | optional | false | 见下方说明 |
| popWidth | string | optional | 200 | menu的宽 |
| \_\_event\_\_ | string | optional |  |  |


参数 object  定义
``` js


interface NavBtnDTO {

  //导航条右边按钮的文字
  title: string;
  //16进制的颜色色值
  titleColor: string;
  //导航条文字的大小
  titleSize: int;

  //按钮文字粗细 
  titleBig?: string;
  
  //设置字体,
 android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium
  titleFontName?: string;
  //在不设置 titleFontName 时,
 是否使用系统粗体.
  isBoldFont?: boolean;

  //见下方说明
  icon?: string;
  //图片的宽高
  iconSize: Array<double>;

  popList?: Array<Map<string,
 string>>;
  //见下方说明
  showMenuImg?: string;
  //menu的宽
  popWidth?: string;

  __event__?: string;

}
``` 


---------------------
**无返回值**




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
| btns | Array\<NavBtnDTO\> | 必填 | [{"title":"right1","titleColor":"#000000","titleSize":16,"iconSize":["20","20"]},{"title":"","icon":"/assets/search.png","titleColor":"#000000","titleSize":16,"iconSize":["20","20"]}] |  |


参数 object  定义
``` js


interface NavMoreBtnDTO {

  btns: Array<NavBtnDTO>;

}
``` 


---------------------
**无返回值**




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
| url | string | optional |  | 跳转地址 |
| params | string | optional |  | 其余参数 |
| hideNavbar | bool | optional |  |  是否隐藏navbar, 默认 false |


参数 object  定义
``` js


interface NavNavigatorDTO {

  //跳转地址
  url?: string;
  //其余参数
  params?: string;
  // 是否隐藏navbar,
 默认 false
  hideNavbar?: boolean;

}
``` 


---------------------
**无返回值**




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
| url | string | optional |  | 跳转地址 |
| hideNavbar | bool | optional |  |  是否隐藏navbar, 默认 false |


参数 object  定义
``` js


interface NavNavigatorBackDTO{

  //跳转地址
  url?: string;
  // 是否隐藏navbar,
 默认 false
  hideNavbar?: boolean;

}
``` 


---------------------
**无返回值**




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
| cornerRadius | int | 必填 | 5 | 搜索框圆角大小 |
| backgroundColor | string | 必填 | #FF0000 | 搜索框背景颜色 |
| iconSearch | string | 必填 |  | 搜索框里搜索图片 |
| iconSearchSize | Array\<double\> | 必填 | [20,20] | 搜索框里搜索图片大小 |
| iconClear | string | 必填 |  | 搜索框里清空图片 |
| iconClearSize | Array\<double\> | 必填 | [20,20] | 搜索框里清空图片大小 |
| textColor | string | 必填 | #000000 | 搜索框文本颜色 |
| fontSize | int | 必填 | 16 | 搜索框文本字体大小 |
| placeHolder | string | 必填 | 默认文字 | 搜索框占位符 |
| placeHolderFontSize | int | 必填 | 16 | 搜索框占位符大小 |
| isInput | bool | 必填 | true | 搜索框是否添加点击事件 |
| becomeFirstResponder | bool | 必填 |  | 搜索框是否获取焦点 |
| \_\_event\_\_ | string | optional |  |  |


参数 object  定义
``` js


interface NavSearchBarDTO {

  //搜索框圆角大小
  cornerRadius: int;
  //搜索框背景颜色
  backgroundColor: string;
  //搜索框里搜索图片
  iconSearch: string;
  //搜索框里搜索图片大小
  iconSearchSize: Array<double>;
  //搜索框里清空图片
  iconClear: string;
  //搜索框里清空图片大小
  iconClearSize: Array<double>;
  //搜索框文本颜色
  textColor: string;
  //搜索框文本字体大小
  fontSize: int;
  //搜索框占位符
  placeHolder: string;
  //搜索框占位符大小
  placeHolderFontSize: int;
  //搜索框是否添加点击事件
  isInput: boolean;
  //搜索框是否获取焦点
  becomeFirstResponder: boolean;

  __event__?: string;

}
``` 


---------------------
**无返回值**




## setSearchBarHidden



**demo**
``` js
{
  window.setSearchBarHidden = () => {
    nav
      .setSearchBarHidden({
        isHidden: true,
        isAnimation: true,
      })
      .then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| isHidden | bool | 必填 |  | 是否隐藏navBar |
| isAnimation | bool | 必填 |  | 是否使用动画效果 |


参数 object  定义
``` js


interface NavHiddenBarDTO {


  //是否隐藏navBar
  isHidden: boolean;
  //是否使用动画效果
  isAnimation: boolean;

}
``` 


---------------------
**无返回值**




## setNavBarHidden

*
Deprecated
使用push,或 nav 里 hideNavbar 参数控制状态的显示
*

**demo**
``` js
{
  window.setNavBarHidden = () => {
    nav
      .setNavBarHidden({
        isHidden: true,
        isAnimation: true,
      })
      .then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| isHidden | bool | 必填 |  | 是否隐藏navBar |
| isAnimation | bool | 必填 |  | 是否使用动画效果 |


参数 object  定义
``` js


interface NavHiddenBarDTO {


  //是否隐藏navBar
  isHidden: boolean;
  //是否使用动画效果
  isAnimation: boolean;

}
``` 


---------------------
**无返回值**




## removeHistoryPage



**demo**
``` js
{
  window.removeHistoryPage = () => {
    nav
      .removeHistoryPage({
        history:[
        ],
      })
      .then((res) => {});
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| history | Array\<string\> | 必填 |  |  |


参数 object  定义
``` js


interface NavHistoryDTO {

  history: Array<string>;

}
``` 


---------------------
**无返回值**



    