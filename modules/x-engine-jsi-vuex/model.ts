// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.vuex";

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
  xengine.api("com.zkty.jsi.vuex", "set",{
    key:'abc',
    val:'world'
  });
}

@sync
function set(arg:{key:string, val:string}){
  let val = xengine.api("com.zkty.jsi.vuex", "get",
    'abc',
  );
  console.log(val);
}


function test_set_abc_world(){
  xengine.api("com.zkty.jsi.vuex", "set",{
    key:'abc',
    val:'world'
  });
}

function test_get(){
  let val = xengine.api("com.zkty.jsi.vuex", "get",
    'abc',
  );
  document.getElementById("debug_text").innerText = val;
}