// 命名空间
const moduleID = "com.zkty.module.bluetooth";

// dto
interface BuletoothEventDTO {
  //返回初始化状态
  __event__: (string)=>void;
}
interface BuletoothContentDTO {
  //各方法返回值
  content: string;
}

interface BuletoothDeviceDTO {
  //蓝牙设备deviceID
  deviceID:string;
  //获取蓝牙设备characteristics特征回调方法
  __event__: (string)=>void;
}

interface BtCharacteristicsDTO{
  //蓝牙设备deviceID
  deviceID:string;
  //蓝牙设备serviceId
  serviceId:string;
  //获取蓝牙设备characteristicId回调方法
  __event__: (string)=>void;
}

interface BtCharacteristicIdDTO{
  //蓝牙设备characteristicId
  characteristicId:string;
  //向对应特征值写入数据回调方法
  __event__: (string)=>void;
}

//初始化蓝牙
function initBluetooth(
  BuletoothEventDTO: BuletoothEventDTO = {
    __event__: (string)=>{},
  }
):BuletoothContentDTO{
  window.initBluetooth = () => {
    bluetooth.initBluetooth({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };
}

//扫描蓝牙设备
function scanBluetoothDevice(
  BuletoothEventDTO: BuletoothEventDTO = {
    __event__: (string)=>{},
  }
):BuletoothContentDTO {
  window.scanBluetoothDevice = () => {
    bluetooth.scanBluetoothDevice({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;

          var content = document.getElementsByClassName('content')[0];
          var arr = new Array();
          var resObj= JSON.parse(res);
          arr.push(resObj['deviceName']);
          if(!content){
            document.body.innerHTML += "<div class='content'></div>";
          }
          for(var i = 0; i < arr.length; i++) {
            var p = document.createElement("p");
            content.appendChild(p);
            p.innerHTML = arr[i];　
          }         
        },
      });
  };
}

//关闭扫描
function closeBluetoothDevice(){
  window.closeBluetoothDevice = () => {
    bluetooth.closeBluetoothDevice();
  };
}

//连接蓝牙设备
function linkBluetoothDevice(
  BuletoothDeviceDTO: BuletoothDeviceDTO = {
    deviceID:"9E7A382F-1BBD-2431-D7B5-6415DDA4BEFB",
    __event__: (string)=>{},
  }
):BuletoothContentDTO{
  window.linkBluetoothDevice = () => {
    bluetooth.linkBluetoothDevice({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };
}

//断开连接蓝牙设备
function cancelLinkBluetoothDevice(
  BuletoothDeviceDTO: BuletoothDeviceDTO = {
    deviceID:"9E7A382F-1BBD-2431-D7B5-6415DDA4BEFB",
    __event__: (string)=>{},
  }
):BuletoothContentDTO{
  window.cancelLinkBluetoothDevice = () => {
    bluetooth.cancelLinkBluetoothDevice({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };
}

//获取蓝牙设备服务
function discoverServices(
  BuletoothDeviceDTO: BuletoothDeviceDTO = {
    deviceID:"9E7A382F-1BBD-2431-D7B5-6415DDA4BEFB",
    __event__: (string)=>{},
  }
):BuletoothContentDTO{
  window.discoverServices = () => {
    bluetooth.discoverServices({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };
}

//获取对应蓝牙设备服务的特征
function discoverCharacteristics(
  BtCharacteristicsDTO: BtCharacteristicsDTO = {
    deviceID:"1A5D368E-68E3-069F-D963-E3781097CCD1",
    serviceId:"FFF0",
    __event__: (string)=>{},
  }
):BuletoothContentDTO{
  window.discoverCharacteristics = () => {
    bluetooth.discoverCharacteristics({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };
}

//向对应特征值写入数据
function writeValueForCharacteristic(
  BtCharacteristicIdDTO: BtCharacteristicIdDTO = {
    characteristicId:'FFF1',
    __event__: (string)=>{},
  }
):BuletoothContentDTO{
  window.writeValueForCharacteristic = () => {
    bluetooth.writeValueForCharacteristic({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };
}

//读取对应特征值
function readCharacteristic(
  BtCharacteristicIdDTO: BtCharacteristicIdDTO = {
    characteristicId:'FFF1',
    __event__: (string)=>{},
  }
):BuletoothContentDTO{
  window.readCharacteristic = () => {
    bluetooth.readCharacteristic({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };
}