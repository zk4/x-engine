
import bluetooth from './index.js'

  window.initBluetooth = () => {
    bluetooth.initBluetooth({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };

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

  window.closeBluetoothDevice = () => {
    bluetooth.closeBluetoothDevice();
  };

  window.linkBluetoothDevice = () => {
    bluetooth.linkBluetoothDevice({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };

  window.cancelLinkBluetoothDevice = () => {
    bluetooth.cancelLinkBluetoothDevice({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };

  window.discoverServices = () => {
    bluetooth.discoverServices({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };

  window.discoverCharacteristics = () => {
    bluetooth.discoverCharacteristics({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };

  window.writeValueForCharacteristic = () => {
    bluetooth.writeValueForCharacteristic({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };

  window.readCharacteristic = () => {
    bluetooth.readCharacteristic({
      __event__: (res) => {
        document.getElementById("debug_text").innerText = res;
      }
    });
  };

    