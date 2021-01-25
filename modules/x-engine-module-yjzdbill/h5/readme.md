
`
com.zkty.module.yjzdbill
`



## YJBillPayment

支付

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| businessCstNo | string |  |  | 会员标识 |
| platMerCstNo | string |  |  | 预下单平台商户号 |
| tradeMerCstNo | string |  |  | 预下单交易商户号 |
| billNo | string |  |  | 业务系统订单号 |
| appScheme | string | true | x-engine | 当前app注册的appScheme |
| payType | bool | true |  | 支付业务， 是否是 B端调用，  true为B， false为C |


## YJBillRefund

退款

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| refundOrderNo | string |  |  | 退款订单编号 |


## YJBillList

账单中心

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| businessCstNo | string |  |  | 会员标识 |
| roomNo | string |  |  | 房屋编号 |
| userRoomNo | string |  |  | 人防编号 |
| appScheme | string | true | x-engine | 当前app注册的appScheme appc:x-engine-c appb:x-engine-b |
| payType | bool |  |  | 支付业务， 是否是 B端调用，  true为B， false为C |
| billStatus | string |  | 0 |  账单状态（取值为：0-全部  10-待支付  90-已完成） |
| billType | string |  | 0 | 账单类型取值为：0-全部 1-物业收费账单,2-月保续费账单,3-停车费账单,4-临时收费账单,5-零售,6-预缴费,7-旅游,8-家政,9-拎包，10-押金 |


## callWallet

调用钱包

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| platMerCstNo | string |  |  | 平台商户号 |
| businessCstName | string |  |  | 个人用户姓名 |
| businessCstNo | string |  |  | 个人用户业务系统客户号 |
| businessCstMobileNo | string |  |  | 个人用户手机号 |
| appScheme | string | true | x-engine-c | 当前app注册的appScheme |

    