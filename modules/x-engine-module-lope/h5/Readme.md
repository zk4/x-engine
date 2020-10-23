
``` bash
npm install @zkty-team/com-zkty-module-lope
```



## initSdkAndConfigure

初始化蓝牙Sdk

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| pid | string |  | 03jfuto709chalfwo84nf921qujt5p |  pid |
| \_\_event\_\_ |  |  | (string)=>{} |  初始化结果回调函数 |


## scanDevice

初始化蓝牙Sdk

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| interval | int |  | 1 |  扫描周期，推荐0.15，即150毫秒 |
| serviceUUIDs | Array\<string\> |  | ["2560","FEE7"] | 扫描的uuid范围 |
| immediately | bool |  |  | 是否扫到第一个设备后立即停止扫描并回调 |
| \_\_event\_\_ |  |  | (string)=>{} |  扫描结果回调函数 |


## openDoor



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| locks | Array\<Map\<string,string\>\> |  | [{"mac":"00:18:E4:0C:73:89","key":"12345678"},{"mac":"00:18:E4:0C:6C:21","key":"12345678"}] |  门禁设备信息将导出给接入方, 包括MAC，秘钥等基本信息 |
| \_\_event\_\_ |  |  | (string)=>{} |  开门结果回调函数 |


## lightLift



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| mac | string |  | B0:7E:11:F4:D9:94 | 梯控设备mac |
| ioIndex | int |  | 4 | 梯控设备输出口编号 |
| \_\_event\_\_ |  |  | (string)=>{} |  开门结果回调函数 |

    