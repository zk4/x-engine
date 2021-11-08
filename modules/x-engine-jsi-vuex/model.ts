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

function test_get_abc(){
  xengine.api("com.zkty.jsi.vuex", "set",{
    key:'abc',
    val:'world'
  });
  let val = xengine.api("com.zkty.jsi.vuex", "get",
    'abc',
  );
    xengine.assert('test_get_abc', val==='world')
  document.getElementById("debug_text").innerText = val;
}

function test_get_empty_str(){
  xengine.api("com.zkty.jsi.vuex", "set",{
    key:'empty_str',
    val:''
  });
  let val = xengine.api("com.zkty.jsi.vuex", "get",
    'empty_str',
  );
    xengine.assert('test_get_empty_str', val==='')
  document.getElementById("debug_text").innerText = val;
}
function test_get_non_exist(){
  let val = xengine.api("com.zkty.jsi.vuex", "get",
    'abcafsdfdf',
  );
    xengine.assert('test_get_non_exist', val===null)
  document.getElementById("debug_text").innerText = val;
}
function test_set_null(){
  xengine.api("com.zkty.jsi.vuex", "set",{
    key:'isnull',
    val:null
  });
  let val = xengine.api("com.zkty.jsi.vuex", "get",
    'isnull',
  );
    xengine.assert('test_set_null', val===null)
  document.getElementById("debug_text").innerText = val;
}

