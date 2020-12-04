
import YJZDBill from './index.js'

  window.YJBillPayment = () => {
    YJZDBill
      .YJBillPayment({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = JSON.stringify(res);
        },
      })
      .then((res) => {
        console.log(JSON.stringify(res));
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

  window.YJBillRefund = () => {
    YJZDBill
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
    YJZDBill
      .YJBillList()
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

    