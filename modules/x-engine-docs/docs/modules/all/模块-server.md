


desc of server, 推荐使用  typora  编辑文档, 媒体文件,如图片必须存放在md的相对目录 assets 下 如`[](./a.png)`
 
## namespace
```
com.zkty.module.server
```


# api

```
npm install @zkty/server
```

## api_name_1
desc ....

**示例**	

```javascript
// promise
xengine.server.api_name_1({
  arg_name: "bla bla",
}).then((res) => {
  console.log(res)
}).catch((error) => {
  console.log(error)
})
```

**函数声明**
  
xengine.server.api_name_1(args,[success],[fail])
  

**args 参数说明**

|    参数    |  类型  | 必填 | 默认值  |       说明       |
| :--------: | :----: | :--: | :-----: | :--------------: |
|   arg_name    | type |  是  |   ---   |   desc   |

**success 参数说明**

|    参数    |  类型  |       说明       |
| :--------: | :----: |  :--------------: |
|   res    | type |     desc   |

**fail 参数说明**

|    参数    |  类型  |       说明       |
| :--------: | :----: |  :--------------: |
|   error    | type |     desc   |





# iOS
介绍在引入模块时,iOS 方面要做的事.如工程权限配置等.

```
pod install x-engine-module-server
```


# android
介绍在引入模块时,android 方面要做的事.如工程权限配置等.

gradle
```
implementation x-engine-module-server
```


