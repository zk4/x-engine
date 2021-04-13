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

// method defined
@sync
function syncMethod(arg: NamedDTO = { titleSize: 16 }): string {}

@sync
function syncStringMethod(arg: string): string {}

@sync
function syncMethod1() {}

@async
function asyncMethod(
  arg: /*匿名参数*/ { name: string } = { name: "default value" } /*默认参数*/
): string {}

// test function
function test_syncStringMethod() {
  let val = xengine.api("com.zkty.jsi.xxxx", "syncStringMethod", "1111111");
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}
function test_syncMethod() {
  let val = xengine.api("com.zkty.jsi.xxxx", "syncMethod", {
    title: "title",
    titleSize: 12,
  });
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}
// test function
function test_syncMethod1() {
  let val = xengine.api("com.zkty.jsi.xxxx", "syncMethod1");
}

function test_asyncMethod() {
  xengine.api("com.zkty.jsi.xxxx", "asyncMethod", {}, (val) => {
    document.getElementById("debug_text").innerText = typeof val + ":" + val;
  });
}

