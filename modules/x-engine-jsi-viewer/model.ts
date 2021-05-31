// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.viewer";


//打开的回调 扩展使用 
interface StatusDTO {
  //状态信息返回
  resultMsg: string;
}


//打开文件 
function openFileReader(fileDTO: {
  //文件地址
  fileUrl: string;

  //文件类型，指定文件类型打开文件
  fileType: string;

  //title 展示使用
  title: string;
}): StatusDTO {
      xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://www.bitsavers.org/pdf/aeon/Aeon_Systems_Model_7064.pdf","fileType":"pdf","title":"用户协议"}, (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
            console.log(JSON.stringify(val)
    });  
}


function test_openFileReader {
    xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://www.bitsavers.org/pdf/aeon/Aeon_Systems_Model_7064.pdf","fileType":"pdf","title":"用户协议"}, (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
}





  
  
  
  
  
  
  
