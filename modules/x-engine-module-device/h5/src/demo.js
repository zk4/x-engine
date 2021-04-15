
import device from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";

window.getPhoneType = () => {

  window.getPhoneType = () => {
    device
      .getPhoneType({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getPhoneType").click()
    window.getSystemVersion = () => {

  window.getSystemVersion = () => {
    device
      .getSystemVersion({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getSystemVersion").click()
    window.getUDID = () => {

  window.getUDID = () => {
    device
      .getUDID({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getUDID").click()
    window.getBatteryLevel = () => {

  window.getBatteryLevel = () => {
    device
      .getBatteryLevel({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getBatteryLevel").click()
    window.getPreferredLanguage = () => {

  window.getPreferredLanguage = () => {
    device
      .getPreferredLanguage({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getPreferredLanguage").click()
    window.getScreenWidth = () => {

  window.getScreenWidth = () => {
    device
      .getScreenWidth({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getScreenWidth").click()
    window.getScreenHeight = () => {

  window.getScreenHeight = () => {
    device
      .getScreenHeight({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getScreenHeight").click()
    window.getSafeAreaTop = () => {

  window.getSafeAreaTop = () => {
    device
      .getSafeAreaTop({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getSafeAreaTop").click()
    window.getSafeAreaBottom = () => {

  window.getSafeAreaBottom = () => {
    device
      .getSafeAreaBottom({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getSafeAreaBottom").click()
    window.getSafeAreaLeft = () => {

  window.getSafeAreaLeft = () => {
    device
      .getSafeAreaLeft({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getSafeAreaLeft").click()
    window.getSafeAreaRight = () => {

  window.getSafeAreaRight = () => {
    device
      .getSafeAreaRight({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getSafeAreaRight").click()
    window.getStatusHeight = () => {

  window.getStatusHeight = () => {
    device
      .getStatusHeight({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getStatusHeight").click()
    window.getNavigationHeight = () => {

  window.getNavigationHeight = () => {
    device
      .getNavigationHeight({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getNavigationHeight").click()
    window.getTabBarHeight = () => {

  window.getTabBarHeight = () => {
    device
      .getTabBarHeight({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = res;
      });
  };
}
 document.getElementById("getTabBarHeight").click()
    window.devicePhoneCall = () => {

  window.devicePhoneCall = (...args) => {
  device
    .devicePhoneCall({phoneNumber:"10086"})
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
};
}
 document.getElementById("devicePhoneCall").click()
    window.deviceSendMessage = () => {

  window.deviceSendMessage = () => {
    device
      .deviceSendMessage({
        phoneNumber:"10086",
        messageContent:"1111111111",
      });
  };
}
 document.getElementById("deviceSendMessage").click()
    
    