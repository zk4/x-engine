
import lope from './index.js'

  window.initSdkAndConfigure = () => {
    lope
      .initSdkAndConfigure({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };

  window.scanDevice = () => {
    lope
      .scanDevice({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };

  window.openDoor = () => {
  lope
    .openDoor({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      },
    })
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };


  window.lightLift = (...args) => {
  lope
    .lightLift({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      },
    })
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };


    