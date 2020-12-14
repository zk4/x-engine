
import yjzdbill from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


  window.YJBillPayment = () => {
    yjzdbill
      .YJBillPayment({
    businessCstNo:"13631095145",
    platMerCstNo: "1249741882914750465",
    tradeMerCstNo: "1249745434852704256",
    billNo:"022020121223334419935012819688",
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

    
