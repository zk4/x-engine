
## js_api_name

**函数描述**

.....

**函数声明**
xengine.module.js_api_name(Object)
  

**Object参数说明**	

|    参数    |  类型  | 必填 | 默认值  |       说明       |
| :--------: | :----: | :--: | :-----: | :--------------: |
|   title    | String |  是  |   ---   |   导航条的文字   |
| titleColor | String |  否  | #000000 | 16进制的颜色色值 |
| titleSize  | Number |  否  |   16    | 导航条文字的大小 |

**示例**	

```javascript
xengine.nav.setNavTitle({
  title:'导航条',
  titleColor : "#000000",
  titleSize  : 16
});
```


