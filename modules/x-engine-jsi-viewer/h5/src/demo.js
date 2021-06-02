
import viewer from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_openPDF = () => {

    xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.pdf","fileType":"pdf","title":"pdf"}, (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
}
window.test_openPPT = () => {

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.ppt","fileType":"ppt","title":"ppt"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
window.test_openWord = () => {

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test1.docx","fileType":"docx","title":"word"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
window.test_openExcel = () => {

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.xlsx","fileType":"xlsx","title":"excel"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}
window.test_openErrorPDF = () => {

  xengine.api("com.zkty.jsi.viewer", "openFileReader", {"fileUrl": "http://127.0.0.1:8000/test.xlsx","fileType":"pdf","title":"excel"}, (val) => {
    document.getElementById("debug_text").innerText = JSON.stringify(val);
  });
}

    