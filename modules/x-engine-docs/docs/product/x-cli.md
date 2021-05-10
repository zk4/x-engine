## 安装 

 ```
npm install @zkty-team/x-cli -g 
 ```



## 主要命令

```
x-cli model --help

// 根据 model.ts 生成三端接口
// iOS 与 android 将生成 JSI 待实现的文件
x-cli model model.ts -t 2 -n
```




### model

根据 [model.ts](#model.ts语法)  定义， 生成 oc， java， js 三端统一接口与 readme.md。 

h5:

```
./src/mock.js     h5 mock 用，不存在时会生成一次，所以可修改。
./src/index.html  每次覆盖
./src/index.js    每次覆盖
./src/demo.js     每次覆盖
```



java:

````
// 接口文件， dto 规范。每次覆盖
gen/xengine_jsi_xxxx.java
````



oc:

```
// 接口文件， dto 规范。每次覆盖
gen/xengine_jsi_secrect.h
gen/xengine_jsi_secrect.m
```



#### model.ts语法

model.ts 脚本的语法与 typescript 几乎一样。

>  注意： 不要使用 typescript 的关键字做为参数名, 比如 delete new 等等

#### 类型



##### 类型对应关系

| ts                          | oc                | java      |
| --------------------------- | ----------------- | --------- |
| boolean                     | BOOL              | Boolean   |
| int （x-cli 扩展，非 ts 类型） | NSInteger         | Integer   |
| double （慎用，会丢失精度） | double            | Double    |
| string                      | NSString          | String    |
| Array<?>                    | NSArray<?>        | List<?>   |
| Map<?,?\>                   | NSDitionary<?,?\> | Map<?,?\>      |
| Set<?>                      | NSSet<?,?\>       | Set<?,?\>     |



##### 具名类型

比如：

``` ts
interface SheetDTO {
    title: string;
    itemList?: Array<Map<string,string>>;
    content?: string;
}
```

##### 匿名类型

**推荐**

匿名类型则不需要你再定义具名类型.因为只有 js bridge 会用到. 你可以不用关心

```
function hello(arg:{name:string,age:int}){}
```



#### 参数

接口参数只支持一个参数或不传。

多个参数怎么办? 用对象包住即可.

如 {name:string,age:int}

也可以传原始类型,如 string, int。

|                 | 有返回值（primitive） | 有返回值（对象） | 无返回值 |
| --------------- | --------------------- | ---------------- | -------- |
| 有参(primitive) | 支持                  | 支持             | 支持     |
| 有参(对象)      | 支持                  | 支持             | 支持     |
| 无参            | 支持                  | 支持             | 支持     |



##### 支持嵌套

```
Map<string,Map<string,Map<string,Map<string,string>>>>;
```



##### 支持可选参数

```
title?:string
```

可选参数会在类型转换时做自动校验. 如果是必传参数, 则会直接报错.方便 debug



##### 特殊参数

带`__xxxx__` 前后双下划线的都为 x-cli 保留参数.

\_\_event\_\_ 通常用在二级回调。 可按如下方式申明。

```
__event__:(a:string,b:Array<string>) =>void
```

 oc/java 主动调用 js 的桥梁 



#### 函数

可以指定默认参数.返回值. 将生成 native 对应类型与接口.

``` typescript
function showActionSheet(sheetDTO:SheetDTO={title:"title",itemList:["a","b","c"],content:"content"}):string {}
```

> 无返回值不需要写

#### demo 方法

直接写在函数声明的函数体内即可.

#### 测试方法

以 test 开头,会生成 h5 测试界面.

``` typescript
	
function test_showActionSheet(sheetDTO:SheetDTO={title:"title",itemList:["a","b","c"],content:"content"}){
    window.showActionSheet=()=>{
      xxxx.showActionSheet(
      )
      .then(res=>{
        document.getElementById("debug_text").innerText= res;
      })
    }
}
```

#### 注释

注释只会生成 readme.md，一定要写在函数定义的上面。

支持 /* */

支持 // 

支持注释内部 markdown 语法。 

``` typescript
// 这里是注释开始
// ``` js
// console.log("hello, this is js block")
// ```
// **高亮**
// [google 链接](https://www.google.com)
// 这里是注释结束
function funcname(arg:SheetDTO={arg:"abc"}):string {
    window.haveArgRetPrimitive = () => {
    xxxx
      .haveArgRetPrimitive()
      .then((res) => {
        document.getElementById("debug_text").innerText = "primitive args:"+res;
      });
  };
}

```

将生成

![image-20200915113639133](assets/image-20200915113639133.png)



#### 异步与同步

默认生成异步方法

如果只加了@sync, 只会生成同步方法

如果只加了@async, 只会生成异步方法



####  model.ts demo

``` typescript
// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.xxxx";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};

interface NamedDTO {
  //文字
  title: string;
  //大小
  titleSize: int;
}

// ------------------------ js api 声明-----------------
@sync
@async
function simpleMethod() {
  //demo code
}

@sync
@async
function simpleArgMethod(arg:string):string {}

@sync
@async
function nestedAnonymousObject(): { a: string; i: { n1: string } } {}

@async
@sync
function namedObject(): NamedDTO {}


// ------------------------ 测试方法 -----------------

function test_同步无返回(){
  let val = xengine.api("com.zkty.jsi.xxxx", "simpleMethod");
  document.getElementById("debug_text").innerText = "无返回,查看原生控制台打印";
 
}
// test function
function test_同步简单参数(){
  let val = xengine.api("com.zkty.jsi.xxxx", "simpleArgMethod","hello,from js");
  document.getElementById("debug_text").innerText =val;
   xengine.assert('test_同步无返回',val==='native return');
}

function test_同步返回命名对象() {
  let val = xengine.api("com.zkty.jsi.xxxx", "namedObject", {});
  document.getElementById("debug_text").innerText =typeof val + ":" + val.title + "," + val.titleSize;
}

function test_同步返回匿名嵌套对象() {
  let val = xengine.api("com.zkty.jsi.xxxx", "nestedAnonymousObject", {});
  document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;

}

function test_异步返回命名对象() {
  xengine.api("com.zkty.jsi.xxxx", "namedObject", {}, (val) => {
    document.getElementById("debug_text").innerText =
    typeof val + ":" + val.title + "," + val.titleSize;
  });
}
function test_异步简单参数() {
  xengine.api("com.zkty.jsi.xxxx", "simpleArgMethod","hello,from js", (val) => {
    document.getElementById("debug_text").innerText = val
  });
}

function test_异步返回命名对象() {
  xengine.api("com.zkty.jsi.xxxx", "namedObject", {},
  (val)=>
  {
    document.getElementById("debug_text").innerText =
    typeof val + ":" + val.title + "," + val.titleSize;
  }
  );
}

function test_异步返回匿名嵌套对象() {
  xengine.api("com.zkty.jsi.xxxx", "nestedAnonymousObject", {},
  (val)=>
  {
    document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;
  }
  );
}
```

 
