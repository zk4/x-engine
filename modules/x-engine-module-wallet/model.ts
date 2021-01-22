// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.module.wallet";
// JS模块名称
const JSModule = "@zkty-team/x-engine-module-wallet";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};

//调用钱包dto
interface WalletDTO {
  platMerCstNo: string;
  businessCstName: string;
  businessCstNo: string;
  businessCstMobileNo:string;
  //当前app注册的appScheme
  appScheme?:string;
}

//调用钱包
function callWallet(
  args: WalletDTO={
    appScheme:'x-engine-c',
    
  }){
  window.callWallet = () => {
    wallet
      .callWallet({
        platMerCstNo:"000001",
        businessCstName:'001',
        businessCstNo:'001',
        businessCstMobileNo:"00011",
        appScheme:"x-engine-c"
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

