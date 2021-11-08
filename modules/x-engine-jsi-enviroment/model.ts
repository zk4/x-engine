// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.enviroment";

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
function isHybird(): {
  code: int,
  msg:string
} {}

// test function
function test_isHybrid() {
  let val = xengine.api("com.zkty.jsi.enviroment", "isHybird");
  document.getElementById("debug_text").innerText = JSON.stringify(val);
  xengine.assert('test_isHybrid', val.code ===0 && val.msg==="" )
}
