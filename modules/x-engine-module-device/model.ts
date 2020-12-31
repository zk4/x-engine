// 命名空间
const moduleID = "com.zkty.module.device";

// dto
interface DeviceSheetDTO {
  //回调方法
  __event__: (string)=>void;
}
interface DeviceMoreDTO {
  //返回值
  content: string;
}

interface DevicePhoneNumDTO {
  //手机号
  phoneNumber: string;
}

interface DeviceMessageDTO {
  //手机号
  phoneNumber: string;
  //短信内容
  messageContent:string;
}

//设备类型
function getPhoneType(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO {
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

//系统版本
function getSystemVersion(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//UDID
function getUDID(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//电池电量
function getBatteryLevel(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//当前语言
function getPreferredLanguage(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//屏幕宽度
function getScreenWidth(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//屏幕高度
function getScreenHeight(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//安全区域上边距
function getSafeAreaTop(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//安全区域下边距
function getSafeAreaBottom(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//安全区域左边距
function getSafeAreaLeft(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//安全区域右边距
function getSafeAreaRight(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//状态栏高度
function getStatusHeight(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//导航条高度
function getNavigationHeight(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//tabBar高度
function getTabBarHeight(
  DeviceSheetDTO: DeviceSheetDTO = {
    __event__: (string)=>{},
  }
):DeviceMoreDTO{
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

//打电话
function devicePhoneCall(arg:DevicePhoneNumDTO){
  window.devicePhoneCall = (...args) => {
  device
    .devicePhoneCall({phoneNumber:"10086"})
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
};
}

//发短信
function deviceSendMessage(
  DeviceMessageDTO: DeviceMessageDTO = {
  }
):DeviceMoreDTO{
  window.deviceSendMessage = () => {
    device
      .deviceSendMessage({
        phoneNumber:"10086",
        messageContent:"1111111111",
      });
  };
}
