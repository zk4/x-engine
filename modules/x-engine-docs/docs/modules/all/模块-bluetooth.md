

**基座扫描测试**
<div id='modulename' style='display:none'>bluetooth</div>
<img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>




# JS


``` bash
npm install @zkty-team/com-zkty-module-bluetooth
```



## initBluetooth

初始化蓝牙

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ | string |  |  |  |


## scanBluetoothDevice

扫描蓝牙设备

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ | string |  |  |  |


## closeBluetoothDevice

关闭扫描

	
**无参数**




## linkBluetoothDevice

连接蓝牙设备

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| deviceID | string |  | 9E7A382F-1BBD-2431-D7B5-6415DDA4BEFB |  |
| \_\_event\_\_ | string |  |  |  |


## cancelLinkBluetoothDevice

断开连接蓝牙设备

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| deviceID | string |  | 9E7A382F-1BBD-2431-D7B5-6415DDA4BEFB |  |
| \_\_event\_\_ | string |  |  |  |


## discoverServices

获取蓝牙设备服务

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| deviceID | string |  | 9E7A382F-1BBD-2431-D7B5-6415DDA4BEFB |  |
| \_\_event\_\_ | string |  |  |  |


## discoverCharacteristics

获取对应蓝牙设备服务的特征

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| deviceID | string |  | 1A5D368E-68E3-069F-D963-E3781097CCD1 |  |
| serviceId | string |  | FFF0 |  |
| \_\_event\_\_ | string |  |  |  |


## writeValueForCharacteristic

向对应特征值写入数据

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| characteristicId | string |  | FFF1 |  |
| \_\_event\_\_ | string |  |  |  |


## readCharacteristic

读取对应特征值

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| characteristicId | string |  | FFF1 |  |
| \_\_event\_\_ | string |  |  |  |

    

# iOS


# android


