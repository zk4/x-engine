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
function get(arg:string):string {}

@sync
function set(arg:{key:string, val:string}){}


function test_set_abc_world(){
  let val = xengine.api("com.zkty.jsi.localstorage", "set",{
    key:'abc',
    val:'world'
  });
}

function test_get(){
  let val = xengine.api("com.zkty.jsi.localstorage", "get",
    'abc',
  );
  document.getElementById("debug_text").innerText = val;
}

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
  
