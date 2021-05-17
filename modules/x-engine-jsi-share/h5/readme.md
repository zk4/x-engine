

JSI Id: com.zkty.jsi.share

version: 0.1.13



## simpleMethod
`async` `sync`


**demo**
``` js

  //demo code

``` 

**无参数**

**无返回值**



## simpleArgMethod
`async` `sync`



**无参数**

**返回值**
``` js
string
``` 



## nestedAnonymousObject
`async` `sync`



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
`sync` `async`



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
`sync` `async`



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
`sync` `async`



**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| name | string | 必填 |  |  |
| age | int | 必填 |  |  |
**返回值**
``` js
 {
goodname:string,
price:int
}
``` 


    