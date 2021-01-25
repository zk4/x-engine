
import wallet from './index.js'

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

    