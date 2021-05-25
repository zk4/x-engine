// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.dev";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};


@sync
function log(arg:string) {
}

// test function
function test_同步无返回(){
  let val = xengine.api("com.zkty.jsi.dev", "log","hello,nativelog");
  document.getElementById("debug_text").innerText = val;
}
