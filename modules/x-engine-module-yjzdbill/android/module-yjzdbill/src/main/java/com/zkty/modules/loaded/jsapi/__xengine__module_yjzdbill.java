package com.zkty.modules.loaded.jsapi;


import androidx.annotation.Nullable;


import com.kapp.sdllpay.PaymentCallback;
import com.yjlc.module.BillManager;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.XEngineApplication;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.loaded.util.SharePreferenceUtils;

import org.json.JSONException;
import org.json.JSONObject;


public class __xengine__module_yjzdbill extends xengine__module_yjzdbill {


    @Override
    public void _YJBillPayment(YJBillDTO dto, CompletionHandler<YJBillRetDTO> handler) {
//
//        dto.platMerCstNo = "1249741882914750465";
//
//        dto.billNo = "06202012141619003321701693321701";
//
//        dto.businessCstNo = "13660078710";
//
//        dto.tradeMerCstNo = "1249745434852704256";
//
//        dto.payType = false;

        String baseUrl = (String) SharePreferenceUtils.get(XEngineWebActivityManager.sharedInstance().getCurrent(), true, "bill_base_url", null);
        BillManager billManager = BillManager.getInstance();
        billManager.init(XEngineWebActivityManager.sharedInstance().getCurrent(), baseUrl);
        billManager.payBills(null, dto.billNo, dto.businessCstNo, dto.platMerCstNo, dto.tradeMerCstNo, dto.payType ? com.yjlc.module.constant.AppConstant.payType_2b : com.yjlc.module.constant.AppConstant.payType_2c, new BillManager.BillPaymentCallBack() {
            @Override
            public void payRsult(JSONObject jsonObject) {

                if (jsonObject.has("status")) {
                    YJBillRetDTO yjBillRetDTO = new YJBillRetDTO();
                    try {
                        yjBillRetDTO.billRetStatus = jsonObject.getString("status");
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                    handler.complete(yjBillRetDTO);

                }

            }
        });


    }

    @Override
    public void _YJBillRefund(YJBillRefundDTO dto, CompletionHandler<YJBillRetDTO> handler) {

        String baseUrl = (String) SharePreferenceUtils.get(XEngineWebActivityManager.sharedInstance().getCurrent(), true, "bill_base_url", null);
        BillManager billManager = BillManager.getInstance();
        billManager.init(XEngineWebActivityManager.sharedInstance().getCurrent(), baseUrl);
        billManager.refundBills(dto.refundOrderNo, new PaymentCallback() {
            @Override
            public void paymentResult(JSONObject jsonObject) {
                if (jsonObject.has("status")) {
                    YJBillRetDTO yjBillRetDTO = new YJBillRetDTO();
                    try {
                        yjBillRetDTO.billRetStatus = jsonObject.getString("status");
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                    handler.complete(yjBillRetDTO);

                }
            }
        });


    }

    @Override
    public void _YJBillList(YJBillListDTO dto, CompletionHandler<Nullable> handler) {

        String baseUrl = (String) SharePreferenceUtils.get(XEngineWebActivityManager.sharedInstance().getCurrent(), true, "bill_base_url", null);

        BillManager billManager = BillManager.getInstance();
        billManager.init(XEngineWebActivityManager.sharedInstance().getCurrent(), baseUrl);
        billManager.queryBills("", "", dto.businessCstNo, dto.payType ? com.yjlc.module.constant.AppConstant.payType_2b : com.yjlc.module.constant.AppConstant.payType_2c);
        handler.complete();
    }
}
