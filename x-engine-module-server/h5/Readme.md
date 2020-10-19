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



