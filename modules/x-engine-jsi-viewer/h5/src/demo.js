
import viewer from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_openDOC = () => {

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.doc","fileType":"doc","title":"doc"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
 document.getElementById("test_openDOC").click()
        window.test_openDOCX = () => {

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.docx","fileType":"docx","title":"docx"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
 document.getElementById("test_openDOCX").click()
        window.test_openPDF = () => {

    xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.pdf","fileType":"pdf","title":"pdf"}, (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
}
 document.getElementById("test_openPDF").click()
        window.test_openPPT = () => {

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.ppt","fileType":"ppt","title":"ppt"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
 document.getElementById("test_openPPT").click()
        window.test_openPPTX = () => {

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.pptx","fileType":"pptx","title":"pptx"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
 document.getElementById("test_openPPTX").click()
        window.test_openXLS = () => {

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.xls","fileType":"xls","title":"xls"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
 document.getElementById("test_openXLS").click()
        window.test_openXLSX = () => {

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.xlsx","fileType":"xlsx","title":"xlsx"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
 document.getElementById("test_openXLSX").click()
        window.test_openErrorType = () => {

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.xlsx","fileType":"pdf","title":"xlsx"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
 document.getElementById("test_openErrorType").click()
        
    