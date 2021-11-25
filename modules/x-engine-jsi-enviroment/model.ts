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


// 这个方法其实只为了确定 jsi 能通。永远会返回 {code:0，msg:''}。
@sync
function isHybird(): {
  // 如果没问题，code 为 0
  // 有问题 code -1
  code: int,
  // 问题描述
  msg:string
} {}

// test function
function test_isHybrid() {
  let val = xengine.api("com.zkty.jsi.enviroment", "isHybird");
  console.log(val)
  // document.getElementById("debug_text").innerText = JSON.stringify(val);
  // xengine.assert('test_isHybrid', val.code ===0 && val.msg==="" )
}
