// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.secrect";

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

function test_get(){
  let val = xengine.api("com.zkty.jsi.secrect", "get",
    'TOKEN',
  );

  document.getElementById("debug_text").innerText = val;
  xengine.assert('test_get',val ==='I am token');
}

//function test_同步返回命名对象() {
  //let val = xengine.api("com.zkty.jsi.secrect", "namedObject", {});
  //document.getElementById("debug_text").innerText =typeof val + ":" + val.title + "," + val.titleSize;
//}

//function test_同步返回匿名嵌套对象() {
  //let val = xengine.api("com.zkty.jsi.secrect", "nestedAnonymousObject", {});
  //document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;

//}

//function test_异步返回命名对象() {
  //xengine.api("com.zkty.jsi.secrect", "namedObject", {}, (val) => {
    //document.getElementById("debug_text").innerText =
    //typeof val + ":" + val.title + "," + val.titleSize;
  //});
//}
//function test_异步简单参数() {
  //xengine.api("com.zkty.jsi.secrect", "simpleArgMethod","hello,from js", (val) => {
    //document.getElementById("debug_text").innerText = val
  //});
//}

//function test_异步返回命名对象() {
  //xengine.api("com.zkty.jsi.secrect", "namedObject", {},
  //(val)=>
  //{
    //document.getElementById("debug_text").innerText =
    //typeof val + ":" + val.title + "," + val.titleSize;
  //}
  //);
//}

//function test_异步返回匿名嵌套对象() {
  //xengine.api("com.zkty.jsi.secrect", "nestedAnonymousObject", {},
  //(val)=>
  //{
    //document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;
  //}
  //);
//}
  
