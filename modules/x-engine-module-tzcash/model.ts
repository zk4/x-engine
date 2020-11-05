// 命名空间
const moduleID = "com.zkty.module.tzcash";

// dto
interface TZCashDTO {
  //预下单返回的订单流水号
  orderNoList: string;
  //预下单的业务平台客户号
  businessCstNo: string;
  //预下单的平台商户号
  platMerCstNo: string;
  //前端回调地址(安卓使用，iOS随便传)
  frontBackUrl:string,
  // 当前订单状态回调函数
  __event__: (string)=>void,
}

//支付状态
interface TZCashRetDTO {
  //支付状态
  orderStatus: string;
}

function callPaymentSDK(
  TZCashDTO: TZCashDTO = {
    orderNoList: "8448617924972777512",
    businessCstNo: "15374649080",
    platMerCstNo:'8377631273379692750',
    frontBackUrl:'123',
    __event__:(string)=>{}
  }
):TZCashRetDTO {
  window.callPaymentSDK = () => {
    tzcash
      .callPaymentSDK({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = JSON.stringify(res);
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}


