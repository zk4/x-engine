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
      xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "xxx","fileType":"xxx","title":"xxx"}, (val) => {
        console.log(JSON.stringify(val)
      });  
}


function test_openDOC {
  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.doc","fileType":"doc","title":"doc"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}

function test_openDOCX {
  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.docx","fileType":"docx","title":"docx"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}

function test_openPDF {
    xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.pdf","fileType":"pdf","title":"pdf"}, (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
}

function test_openPPT {
  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.ppt","fileType":"ppt","title":"ppt"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}

function test_openPPTX{
  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.pptx","fileType":"pptx","title":"pptx"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
function test_openXLS {
  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.xls","fileType":"xls","title":"xls"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}

function test_openXLSX {
  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.xlsx","fileType":"xlsx","title":"xlsx"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}

function test_openErrorType {
  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.xlsx","fileType":"pdf","title":"xlsx"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}



  
  
  
  
  
  
  
