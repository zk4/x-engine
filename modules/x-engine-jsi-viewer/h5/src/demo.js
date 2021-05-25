
import viewer from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_openFileReader = () => {

    xengine.api("com.zkty.jsi.viewer", "openFileReader", {filePath: "http://www.bitsavers.org/pdf/aeon/Aeon_Systems_Model_7064.pdf",fileName: "协议.pdf"}, (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    });
}
 document.getElementById("test_openFileReader").click()
      
    