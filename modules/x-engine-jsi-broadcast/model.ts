// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.broadcast";

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


// 这个 JSI 只供测试用,不要暴露 broadcast 方法
@sync
function triggerBroadcast(arg: {type: string, payload: string}) {}
//
// @sync
// function triggerNativeBroadcastNull() {}
//
// function test_triggerNativeBroadcastNull() {
//   xengine.api('com.zkty.jsi.broadcast', 'triggerNativeBroadcastNull')
//
// }
// function test_ontriggerNativeBroadcastNull() {
//   xengine.broadcastOn((type, payload) => {
//     if (type === 'native_null') {
//       console.log(type, payload)
//       document.getElementById("debug_text").innerText = type + payload;
//       xengine.assert('test_ontriggerNativeBroadcastNull', payload === null )
//     }
//
//   })
// }

function test_triggerbroadcast() {
  xengine.api('com.zkty.jsi.broadcast', 'triggerBroadcast', {type: 'hello', payload: 'world'})
}

function test_onbroadcast() {
  xengine.broadcastOn((type, payload) => {
    if (type === 'hello') {
      document.getElementById("debug_text").innerText = type + payload;
      xengine.assert('test_onbroadcast', type === 'hello' && payload === 'world')
    }
  })
}

function test_triggerbroadcast_null() {
  xengine.api('com.zkty.jsi.broadcast', 'triggerBroadcast', {type: 'isnull', payload: null})
}

function test_onbroadcast_null() {
  xengine.broadcastOn((type, payload) => {
    if (type === 'isnull') {
      console.log(type, payload)
      document.getElementById("debug_text").innerText = type + payload;
      xengine.assert('test_onbroadcast_null', false )
    }

  })
        xengine.assert('test_onbroadcast_null', true )

}

