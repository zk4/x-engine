// 命名空间
const moduleID = "com.zkty.module.scan";

interface ScanOpenDto {

    //扫码结果 xx(result)
    __event__:(result)=>{};
}

function openScanView(arg:ScanOpenDto = {
    __event__:(result)=>{},
}){
    window.openScanView = () => {
        scan
          .openScanView()
          .then((res) => {});
      };
}
