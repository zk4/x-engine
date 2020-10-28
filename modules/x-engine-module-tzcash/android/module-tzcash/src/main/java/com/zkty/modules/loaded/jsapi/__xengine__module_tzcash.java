package com.zkty.modules.loaded.jsapi;


import android.text.TextUtils;

import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

import pay.PayUtils;


public class __xengine__module_tzcash extends xengine__module_tzcash {

    @Override
    public void _callPaymentSDK(TZCashDTO dto, final CompletionHandler<TZCashRetDTO> handler) {
        if (!TextUtils.isEmpty(dto.businessCstNo) && !TextUtils.isEmpty(dto.orderNoList) &&
                !TextUtils.isEmpty(dto.platMerCstNo) && !TextUtils.isEmpty(dto.frontBackUrl)) {
            PayUtils.Pay(XEngineWebActivityManager.sharedInstance().getCurrent(), dto.orderNoList, dto.businessCstNo, dto.platMerCstNo, dto.frontBackUrl, new PayUtils.PayResultListener() {
                @Override
                public void onPayResultListener(String result) {
                    TZCashRetDTO tzCashRetDTO = new TZCashRetDTO();
                    tzCashRetDTO.orderStatus = result;
                    handler.complete(tzCashRetDTO);
                }
            });
        }
    }
}
