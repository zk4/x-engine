// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.viewer";


//返回参数
interface StatusDTO {
  //状态信息返回
  result: string;
}


//打开文件 
function openFileReader(filePath: string): StatusDTO {
  xengine.api("com.zkty.jsi.viewer", "openFileReader", 'http://gfsei.atguat.net.cn/9b82cdfe4167b7da07fb395ce3963f4cw004.pdf?Expires=2563098084&AccessKey=40de0c1abb5e4506bccc56d4aee3d945&Signature=1083d55756878793fe68cf43fd599d95', (val) => {
     document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}


// test function
function test_openFileReader(){
    xengine.api("com.zkty.jsi.viewer", "openFileReader", 'http://gfsei.atguat.net.cn/9b82cdfe4167b7da07fb395ce3963f4cw004.pdf?Expires=2563098084&AccessKey=40de0c1abb5e4506bccc56d4aee3d945&Signature=1083d55756878793fe68cf43fd599d95', (val) => {
     document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}




  
  
  
  
  
  
  
