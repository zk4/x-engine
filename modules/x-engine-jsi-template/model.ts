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


@sync
@async
function simpleMethod() {}

@sync
@async
function nestedObject(): { a: string; i: { n1: string } } {}

@async
@sync
function nestedNamedObject(): NamedDTO {}


// test function
function test_同步无返回(){
  let val = xengine.api("com.zkty.jsi.xxxx", "simpleMethod");
  document.getElementById("debug_text").innerText = "无返回,查看原生控制台打印";
}

function test_同步返回命名对象() {
  let val = xengine.api("com.zkty.jsi.xxxx", "nestedNamedObject", {});
  document.getElementById("debug_text").innerText =typeof val + ":" + val.title + "," + val.titleSize;
}

function test_同步返回匿名嵌套对象() {
  let val = xengine.api("com.zkty.jsi.xxxx", "nestedObject", {});
  document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;

}

function test_异步返回命名对象() {
  xengine.api("com.zkty.jsi.xxxx", "nestedNamedObject", {}, (val) => {
    document.getElementById("debug_text").innerText =
    typeof val + ":" + val.title + "," + val.titleSize;
  });
}

function test_异步返回命名对象() {
  xengine.api("com.zkty.jsi.xxxx", "nestedNamedObject", {},
  (val)=>
  {
    document.getElementById("debug_text").innerText =
    typeof val + ":" + val.title + "," + val.titleSize;
  }
  );
}

function test_异步返回匿名嵌套对象() {
  xengine.api("com.zkty.jsi.xxxx", "nestedObject", {},
  (val)=>
  {
    document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;
  }
  );
}
  
  
  
  
  
  
  
  