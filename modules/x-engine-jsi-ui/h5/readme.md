

#### JSI Id: com.zkty.jsi.ui

- 安装方式

``` bash
npm install @zkty-team/x-engine-jsi-ui
```


---


## setNavTitle

设置原生导航条文字

**demo**

``` javascript
XEngine.bridge.call("com.zkty.jsi.ui.setNavTitle",{
	title: "title",
	titleColor: "#000000",
	titleSize: 16,
}
```

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string | 必填 |  | 导航条的文字 |
| titleColor | string | 必填 | "#000" | 16进制的颜色色值 |
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




## setNavBarHidden

设置原生导航条的显示和隐藏

**demo**
``` js
XEngine.bridge.call("com.zkty.jsi.ui.setNavBarHidden", {
	isHidden: true,
	isAnimation: true
}
```

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| isHidden | bool | 必填 | true | 是否隐藏原生导航条 |
| isAnimation | bool | 必填 | true | 是否使用动画效果 |


参数 object  定义
``` javascript
interface NavHiddenBarDTO {
  //是否隐藏navBar
  isHidden: boolean;
  //是否使用动画效果
  isAnimation: boolean;
}		
```


---------------------
**无返回值**



​    