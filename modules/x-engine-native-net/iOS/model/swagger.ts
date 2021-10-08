
          const apiName = "charge_feeList";
          const apiBaseUrl = ""
          const apiPath = "/charge/feeList"
          const apiMethod ="GET"
        interface netdto_charge_feeListReq  {
// 收费项目
feeName? : string;
// 页码
pageNum : int;
// 查询条数
pageSize : int;
// 门店名称
storeName? : string;
}
interface netdto_charge_feeListRes 
{
current? : int;
message? : string;
records? : Array<{
// 是否需要附件：0不需要，1需要
attachmentsRequired? : int;
// 费项收费周期
billCycle? : string;
// 计收主体Id
companyId? : string;
// 计收主体名
companyName? : string;
// 创建人
createPerson? : string;
// 创建时间
createTime? : string;
// 备注
description? : string;
// 数据有效性标识
endTime? : string;
// 费项编码
feeCode? : string;
// 费项名称
feeName? : string;
// 费项关联的费标数量
feeScaleCount? : int;
// 费项关联的费标列表
feeScaleList? : Array<{
// 费标关联的账单数
billCount? : int;
// 账单周期
billCycle? : string;
// 费标计费周期
chargeCycle? : string;
// 计费周期方式
chargeCycleType? : string;
// 计费开始月份
chargeStartMonth? : int;
// 计费方式
chargeType? : string;
// 费标计费单位
chargeUnit? : string;
// 费标计费单价
chargeUnitPrice? : number;
// 费标计费比例
chargeUnitProportion? : number;
// 费标收费周期
chargingCycle? : string;
// 创建人
createPerson? : string;
// 创建时间
createTime? : string;
// 小数处理方式
decimalMode? : string;
// 保留小数点位数
decimalPlace? : int;
// 备注
description? : string;
// 数据有效性标识
endTime? : string;
// 费项编码
feeCode? : string;
// 关联费项id
feeId? : string;
// 费项名称
feeName? : string;
// 主键
id? : string;
// 删除状态
ifDelete? : int;
// 费项标准Id
scaleId? : string;
// 费项标准名称
scaleName? : string;
// 分摊方式
shareType? : string;
// 店铺引用费标数
shopUsedCount? : int;
// 费项来源
sourceApp? : string;
// 门店ID
storeId? : string;
// 门店名字
storeName? : string;
// 单价方式
unitPriceType? : string;
// 修改人
updatePerson? : string;
// 修改时间
updateTime? : string;
// 用户Id
userId? : string;
}>;
// 是否需要设置费标
feeScaleNecessary? : string;
// 是否生成账单
generateBill? : string;
// 主键
id? : string;
// 费项删除状态
ifDelete? : int;
// 是否需要开票
invoiceNecessary? : string;
// 费项被费标引用数
scaleUsedCount? : int;
// 门店id
storeId? : string;
// 门店名称
storeName? : string;
// 税率编码
taxCode? : string;
// 税率
taxRate? : string;
// 修改人
updatePerson? : string;
// 修改时间
updateTime? : string;
// 用户Id
userId? : string;
}>;
status? : string;
success? : boolean;
total? : int;
}
