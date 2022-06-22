// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.browser";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};

//使用系统浏览器打开url
function open(urlDTO: {
  //链接地址
  url: string; 
}): {
  // 状态码
  // code = 0  成功
  // code = -1 失败
  code: int;
  // 函数状态描述（比如找不到系统浏览器，链接解析失败等）
  msg: string;
} {
  xengine.api("com.zkty.jsi.browser", "open",{
        "url":"",
 
    } ,(val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
}

 //测试弹窗广告
function test_open() {
  xengine.api("com.zkty.jsi.browser", "open",{
        "url":"https://wwww.baidu.com"        
    } ,(val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
}


