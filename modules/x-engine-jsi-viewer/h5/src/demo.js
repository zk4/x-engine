
import viewer from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_openFileReader = () => {

    xengine.api("com.zkty.jsi.viewer", "openFileReader", {"http://gfsei.atguat.net.cn/9b82cdfe4167b7da07fb395ce3963f4cw004.pdf?Expires=2563098084&AccessKey=40de0c1abb5e4506bccc56d4aee3d945&Signature=1083d55756878793fe68cf43fd599d95"}, (val) => {
    document.getElementById("debug_text").innerText =
    typeof val + ":" + val.title + "," + val.titleSize;
  });
}
 document.getElementById("test_openFileReader").click()
      
    