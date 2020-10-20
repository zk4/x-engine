
import device from './index.js'

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

    