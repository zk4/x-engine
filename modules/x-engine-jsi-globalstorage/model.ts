// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.globalstorage";

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
  let val = xengine.api("com.zkty.jsi.globalstorage", "get",
    'abc',
  );
  console.log(val);
}

@sync
function set(arg:{key:string, val:string}){
  xengine.api("com.zkty.jsi.globalstorage", "set",{
    key:'abc',
    val:'world'
  });
}

@sync
function del(arg:string) {
 xengine.api("com.zkty.jsi.globalstorage", "del",
    'abc',
  );
}


function test_set_haha(){
  xengine.api("com.zkty.jsi.globalstorage", "set",{
    key:'abc',
    val:'world'
  });
}
function test_set(){
  xengine.api("com.zkty.jsi.globalstorage", "set",{
    key:'abc',
    val:'world'
  });
}

function test_get(){
  let val = xengine.api("com.zkty.jsi.globalstorage", "get",
    'abc',
  );
  document.getElementById("debug_text").innerText = val;
}

function test_del(){
  xengine.api("com.zkty.jsi.globalstorage", "del",
    'abc',
  );
 
}

  
  
  
  
  
  
  
  
