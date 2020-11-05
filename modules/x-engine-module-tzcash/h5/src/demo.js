
import tzcash from './index.js'

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

    