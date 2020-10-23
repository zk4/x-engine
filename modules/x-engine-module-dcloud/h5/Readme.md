
``` bash
npm install @zkty-team/com-zkty-module-dcloud
```



## openUniMP

 启动小程序

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| appId | string |  | __UNI__11E9B73 |  |


## preloadUniMP

 预加载后打开小程序

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| appId | string |  | __UNI__11E9B73 |  |


## openUniMPWithArg



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| appId | string |  | __UNI__11E9B73 |  |
| arguments | Map\<string,string\> |  | {"arguments":"Hello uni microprogram"} | 配置启动小程序时传递的参数 |
| redirectPath | string |  | pages/component/view/view |  路径 |
| enableBackground | bool |  |  |  开启后台运行 |
| showAnimated | bool | true |  | 是否开启 show 小程序时的动画效果 默认：true |
| hideAnimated | bool | true |  | 是否开启 hide 时的动画效果 默认：true |

    