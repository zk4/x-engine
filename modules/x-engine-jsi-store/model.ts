// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.store";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};

interface ZKStoreEntryDTO {
  key: string;
  // 不可为空
  val: string;
}
@async
@sync
function get(arg: string): string {}

@sync
@async
function set(arg: ZKStoreEntryDTO) {}

//////////////////////////////////////////////
//test
function test_setObject(arg: ZKStoreEntryDTO) {
  xengine.api(
    "com.zkty.jsi.store",
    "set",
    {
      key: "obj",
      val: JSON.stringify({ key: { a: "a", b: [1, 2, 3], c: { d: "d" } } }),
    },
    (res) => {
      console.log(res);
    }
  );
}
function test_getObject(arg: string ): string {
  xengine.api("com.zkty.jsi.store", "get", "obj" , (val) => {
    document.getElementById("debug_text").innerText = typeof val + ":" + val;
  });
}

function test_setObject_sync(arg: ZKStoreEntryDTO) {
  xengine.api("com.zkty.jsi.store", "set", {
    key: "obj",
    val: JSON.stringify({ key: { a: "a", b: [1, 2, 3], c: { d: "d" } } }),
  });
}
function test_getObject_sync(arg: { key: string }): string {
  let val = xengine.api("com.zkty.jsi.store", "get", { key: "obj" });
  document.getElementById("debug_text").innerText = typeof val + ":" + val;
}

//test

function test_setNil(arg: ZKStoreEntryDTO) {
  xengine.api(
    "com.zkty.jsi.store",
    "set",
    {
      key: "nil",
      val: null,
    },
    (res) => {}
  );
}

function test_getNil(arg: { key: string }): string {
  xengine.api("com.zkty.jsi.store", "get", { key: "nil" }, (val) => {
    if (!res) {
      document.getElementById("debug_text").innerText = "为 nil";
    }
  });
}

//test

function test_setAssertChangeColor(arg: ZKStoreEntryDTO) {
  xengine.api(
    "com.zkty.jsi.store",
    "set",
    {
      key: "str",
      val: "hello",
    },
    (res) => {}
  );
}

function test_getAssertTrue(arg: { key: string }): string {
  xengine.api("com.zkty.jsi.store", "get", { key: "str" }, (val) => {
    xengine.assert('test_getAssertTrue',val === 'hello')
    document.getElementById("debug_text").innerText = "为 nil";
  });
}


