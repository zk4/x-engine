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
function get(arg:string):string {
  let val = xengine.api("com.zkty.jsi.secrect", "get",
    'TOKEN',
  );
  console.log(val);
}

function test_get(){
  let val = xengine.api("com.zkty.jsi.secrect", "get",
    'TOKEN',
  );

  document.getElementById("debug_text").innerText = val;
  xengine.assert('test_get',val ==='I am token');
}
