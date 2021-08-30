// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.scan";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};

@async // 打开扫码页面
function openScanView(): string {
  xengine.api("com.zkty.jsi.scan", "openScanView", {}, (val) => {
    console.log(JSON.stringify(val))
  });
}

function test_openScanView() {
  xengine.api("com.zkty.jsi.scan", "openScanView", {}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
