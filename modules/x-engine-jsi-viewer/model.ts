// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.viewer";

//返回参数
interface OpenFiileDTO {
  //文件地址
  filePath: string;
  //文件名称
  fileName: string;
}

//返回参数
interface StatusDTO {
  //状态信息返回
  result: string;
}


//打开文件 
function openFileReader(fileDTO: OpenFiileDTO): StatusDTO {
  xengine.api("com.zkty.jsi.viewer", "openFileReader", {
    filePath: "xxx",
    fileName: "协议.pdf"}, (val) => {
      console.log(JSON.stringify(val)
    )}
  );    
}


function test_openFileReader {
    xengine.api("com.zkty.jsi.viewer", "openFileReader", {filePath: "http://www.bitsavers.org/pdf/aeon/Aeon_Systems_Model_7064.pdf",fileName: "协议.pdf"}, (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
}





  
  
  
  
  
  
  
