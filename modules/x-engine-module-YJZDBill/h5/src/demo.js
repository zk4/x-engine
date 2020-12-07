
import yjzdbill from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


  window.echo = () => {
    yjzdbill
      .echo({
          //__ret__:function(res){
        //document.getElementById("debug_text").innerText = JSON.stringify("__ret__"+res);
          //},
          __event__:function(res){
        document.getElementById("debug_text").innerText = JSON.stringify(res);
          }
        }
      )
      //.then((res) => {
        //document.getElementById("debug_text").innerText = JSON.stringify(res);
      //});
  };

  window.YJBillPayment = () => {
    yjzdbill
      .YJBillPayment({
        __ret__:(res)=>{
                  console.log(JSON.stringify(res));
        document.getElementById("debug_text").innerText = JSON.stringify(res);
        }
      })
  };

  window.YJBillRefund = () => {
    yjzdbill
      .YJBillRefund({
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
      .YJBillList()
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

    