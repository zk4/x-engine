

JSI Id: com.zkty.jsi.xxxx

version: 2.8.1



## simpleMethod
[`async`](/docs/modules/模块-规范?id=jsi-调用) [`sync`](/docs/modules/模块-规范?id=jsi-调用)


**demo**
``` js

  //demo code

``` 

**无参数**

**无返回值**



## simpleArgMethod
[`async`](/docs/modules/模块-规范?id=jsi-调用) [`sync`](/docs/modules/模块-规范?id=jsi-调用)



**无参数**

**返回值**
``` js
string
``` 



## nestedAnonymousObject
[`async`](/docs/modules/模块-规范?id=jsi-调用) [`sync`](/docs/modules/模块-规范?id=jsi-调用)



**无参数**

**返回值**
``` js
 {
 a: string; i: {
 n1: string 
} 
}
``` 



## namedObject
[`sync`](/docs/modules/模块-规范?id=jsi-调用) [`async`](/docs/modules/模块-规范?id=jsi-调用)



**无参数**

**返回值**
``` js


interface NamedDTO {

  //文字
  title: string;
  //大小
  titleSize: int;

}
``` 



## namedObjectWithNamedArgs
[`sync`](/docs/modules/模块-规范?id=jsi-调用) [`async`](/docs/modules/模块-规范?id=jsi-调用)



**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string | 必填 |  | 文字 |
| titleSize | int | 必填 |  | 大小 |
**返回值**
``` js


interface NamedDTO {

  //文字
  title: string;
  //大小
  titleSize: int;

}
``` 



## namedObjectWithArgs
[`sync`](/docs/modules/模块-规范?id=jsi-调用) [`async`](/docs/modules/模块-规范?id=jsi-调用)



**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| name | string | 必填 |  |  |
| age | int | 必填 |  |  |
**返回值**
``` js
 {
 goodname: string; price: int 
}
``` 



## complexAnoymousRetWithAnoymousArgs
[`sync`](/docs/modules/模块-规范?id=jsi-调用) [`async`](/docs/modules/模块-规范?id=jsi-调用)



**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| name | string | 必填 |  |  |
| age | int | 必填 |  |  |
| houses | Array\<_11_com.zkty.jsi.xxxx_DTO\> | 必填 |  |  |
**返回值**
``` js
 {

  name: string;
  age: int;
  houses: Array<{

    address: string;
    longtitude: string;
    latitude: string;
    dealer: {

      name: string;
      age: int;
    
};
  
}>;

}
``` 


    