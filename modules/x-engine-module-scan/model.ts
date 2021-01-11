// 命名空间
const moduleID = "com.zkty.module.scan";

interface ScanOpenDto {
  //扫码结果 xx(result)
  __event__: (index: string) => void;
}

function openScanView(
  arg: ScanOpenDto = {
    __event__: (result) => {},
  }
) {
  window.openScanView = (...args) => {
    scan
      .openScanView({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {

        document.getElementById("debug_text").innerText = typeof(res)+":"+JSON.stringify(res);
      });
  };
}
