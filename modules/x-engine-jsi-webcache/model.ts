// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.webcache";

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
function simpleMethod() {
  //demo code
}
// test function
function test_同步无返回(){
  let val = xengine.api("com.zkty.jsi.webcache", "simpleMethod");
  document.getElementById("debug_text").innerText = "无返回,查看原生控制台打印";
}
