
import microapp from './index.js'

  import network from '@zk4/network'

  window.install = () => {
    microapp
      .install()
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:" + res;
      });
  };

  window.clearInstallDir = () => {
    microapp
      .clearInstallDir()
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:" + res;
      });
  };


  window.testInstallVersion = () => {

    network.downloadRequest({
      url: 'http://192.168.3.208:8000/com.zkty.microapp.demo.zip',
      method: 'GET',
      isNeedBase64: false,
    }).then((res) => {
      microapp
        .install({ appid: "com.test.model.function", version: "1", filePath: res.filePath })
        .then((res) => {
          document.getElementById("debug_text").innerText = "ret:" + res;
        });
    });
  };

    