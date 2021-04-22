// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.localstorage";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};



@sync
@async
function get(arg:string):string {}

@sync
@async
function set(key:string, val:string){}


// test function
//function test_同步无返回(){
  //let val = xengine.api("com.zkty.jsi.localstorage", "simpleMethod");
  //document.getElementById("debug_text").innerText = "无返回,查看原生控制台打印";
//}
//// test function
//function test_同步简单参数(){
  //let val = xengine.api("com.zkty.jsi.localstorage", "simpleArgMethod","hello,from js");
  //document.getElementById("debug_text").innerText =val;
//}

//function test_同步返回命名对象() {
  //let val = xengine.api("com.zkty.jsi.localstorage", "namedObject", {});
  //document.getElementById("debug_text").innerText =typeof val + ":" + val.title + "," + val.titleSize;
//}

//function test_同步返回匿名嵌套对象() {
  //let val = xengine.api("com.zkty.jsi.localstorage", "nestedAnonymousObject", {});
  //document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;

//}

//function test_异步返回命名对象() {
  //xengine.api("com.zkty.jsi.localstorage", "namedObject", {}, (val) => {
    //document.getElementById("debug_text").innerText =
    //typeof val + ":" + val.title + "," + val.titleSize;
  //});
//}
//function test_异步简单参数() {
  //xengine.api("com.zkty.jsi.localstorage", "simpleArgMethod","hello,from js", (val) => {
    //document.getElementById("debug_text").innerText = val
  //});
//}

//function test_异步返回命名对象() {
  //xengine.api("com.zkty.jsi.localstorage", "namedObject", {},
  //(val)=>
  //{
    //document.getElementById("debug_text").innerText =
    //typeof val + ":" + val.title + "," + val.titleSize;
  //}
  //);
//}

//function test_异步返回匿名嵌套对象() {
  //xengine.api("com.zkty.jsi.localstorage", "nestedAnonymousObject", {},
  //(val)=>
  //{
    //document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;
  //}
  //);
//}
  
