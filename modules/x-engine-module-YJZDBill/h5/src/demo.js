
import yjzdbill from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


  window.YJBillPayment = () => {
    yjzdbill
      .YJBillPayment({
    businessCstNo:"000001",
    platMerCstNo: "8377631273379692750",
    tradeMerCstNo: "8377707718294634760",
    billNo:'01202012081346103822413721356429',
    appScheme:'x-engine',
    payType:false,
        __ret__:(res)=>{
                  console.log(JSON.stringify(res));
        document.getElementById("debug_text").innerText = JSON.stringify(res);
        }
      })
  };

  window.YJBillRefund = () => {
    yjzdbill
      .YJBillRefund({
        refundOrderNo:'RFO1607064781790',
        __event__: (res) => {
          document.getElementById("debug_text").innerText = JSON.stringify(res);
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

  window.YJBillList = () => {
    yjzdbill
      .YJBillList({
    businessCstNo:"000001",
    appScheme:'x-engine',
    payType:false

      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

    