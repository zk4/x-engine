
import viewer from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_openFileReader = () => {

    xengine.api("com.zkty.jsi.viewer", "openFileReader", {fileUrl: "http://www.bitsavers.org/pdf/aeon/Aeon_Systems_Model_7064.pdf",fileType: "pdf",title : "用户协议"}, (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
}
 document.getElementById("test_openFileReader").click()
      
    