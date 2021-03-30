

JSI Id: com.zkty.jsi.ui

version: 0.1.13
``` bash
npm install @zkty-team/x-engine-jsi-ui
```



## setNavTitle



**demo**
``` js

    engine.api('com.zkty.jsi.ui','setNavTitle',{
      title: 'title'
    })

``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string | 必填 |  | 导航条的文字 |
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




## setNavBarHidden

使用push,或 nav 里 hideNavbar 参数控制状态的显示

**demo**
``` js
  
    engine.api('com.zkty.jsi.ui','setNavBarHidden',{
      //是否隐藏navBar
      isHidden: boolean,
      //是否使用动画效果
      isAnimation: boolean
}

    })
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



    