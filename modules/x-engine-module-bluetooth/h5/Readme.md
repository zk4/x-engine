
`
com.zkty.module.bluetooth
`



## initBluetooth

初始化蓝牙

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 返回初始化状态 |


## scanBluetoothDevice

扫描蓝牙设备

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| \_\_event\_\_ |  |  | (string)=>{} | 返回初始化状态 |


## closeBluetoothDevice

关闭扫描

	
**无参数**




## linkBluetoothDevice

连接蓝牙设备

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| deviceID | string |  | 9E7A382F-1BBD-2431-D7B5-6415DDA4BEFB | 蓝牙设备deviceID |
| \_\_event\_\_ |  |  | (string)=>{} | 获取蓝牙设备characteristics特征回调方法 |


## cancelLinkBluetoothDevice

断开连接蓝牙设备

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| deviceID | string |  | 9E7A382F-1BBD-2431-D7B5-6415DDA4BEFB | 蓝牙设备deviceID |
| \_\_event\_\_ |  |  | (string)=>{} | 获取蓝牙设备characteristics特征回调方法 |


## discoverServices

获取蓝牙设备服务

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| deviceID | string |  | 9E7A382F-1BBD-2431-D7B5-6415DDA4BEFB | 蓝牙设备deviceID |
| \_\_event\_\_ |  |  | (string)=>{} | 获取蓝牙设备characteristics特征回调方法 |


## discoverCharacteristics

获取对应蓝牙设备服务的特征

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| deviceID | string |  | 1A5D368E-68E3-069F-D963-E3781097CCD1 | 蓝牙设备deviceID |
| serviceId | string |  | FFF0 | 蓝牙设备serviceId |
| \_\_event\_\_ |  |  | (string)=>{} | 获取蓝牙设备characteristicId回调方法 |


## writeValueForCharacteristic

向对应特征值写入数据

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| characteristicId | string |  | FFF1 | 蓝牙设备characteristicId |
| \_\_event\_\_ |  |  | (string)=>{} | 向对应特征值写入数据回调方法 |


## readCharacteristic

读取对应特征值

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| characteristicId | string |  | FFF1 | 蓝牙设备characteristicId |
| \_\_event\_\_ |  |  | (string)=>{} | 向对应特征值写入数据回调方法 |

    