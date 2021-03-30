// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.jsi";
// JS模块名称
const JSModule = "@zkty-team/x-engine-jsi-jsi";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};

// dto
interface SheetDTO {
  // 标题
  title: string;
  // 子标题?
  itemList?: Array<string>;
  // 内容
  content?: string;
  // 点击子标题回调函数
  __event__: (index: string) => void;
}

interface ContinousDTO {
  __event__?: (string) => {};
}

interface MsgPayloadDTO {
  type: string;
  args?: Map<string, string>;
  sender?: string;
  receiver?: Array<string>;
  __event__: (string) => void;
  __ret__: (string) => void;
}
function broadcastOn() {
  window.broadcastOn = (...args) => {
    xengine.broadcastOn(function (res) {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    });
  };
}
function broadcastOff() {
  window.broadcastOff = () => {
    xengine.broadcastOff();
  };
}
function triggerNativeBroadCast() {
  window.triggerNativeBroadCast = () => {
    jsi.triggerNativeBroadCast();
  };
}
function repeatReturn__event__(args: ContinousDTO): string {
  window.repeatReturn__event__ = () => {
    jsi.repeatReturn__event__({
      __event__: function (res) {
        document.getElementById("debug_text").innerText =
          "支持多次返回" + JSON.stringify(res);
        return res;
      },
    });
  };
}
function repeatReturn__ret__(args: ContinousDTO): string {
  window.repeatReturn__ret__ = () => {
    jsi.repeatReturn__ret__({
      __ret__: function (res) {
        document.getElementById("debug_text").innerText =
          "支持多次返回" + JSON.stringify("__ret__:" + res);
        return res;
      },
    });
  };
}

function ReturnInPromiseThen(args: ContinousDTO): string {
  window.ReturnInPromiseThen = () => {
    jsi.ReturnInPromiseThen().then((res) => {
      document.getElementById("debug_text").innerText =
        "then 只支持一次性返回" + JSON.stringify(res);
    });
  };
}

