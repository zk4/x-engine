// 命名空间
const moduleID = "com.zkty.module.microapp";

interface XEMicroAppInsertDTO {

  appid: string;
  version: string;
  filePath: string;
}

function xxxx() {
  import network from '@zk4/network'
}

function install(args: XEMicroAppInsertDTO = { appid: "", version: "", filePath: "" }) {
  window.install = () => {
    microapp
      .install()
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:" + res;
      });
  };
}

function clearInstallDir(args: XEMicroAppInsertDTO = { appid: "", version: "", filePath: "" }) {
  window.clearInstallDir = () => {
    microapp
      .clearInstallDir()
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:" + res;
      });
  };
}
function testInstallVersion(args: XEMicroAppInsertDTO = { appid: "", version: "", filePath: "" }) {

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
}