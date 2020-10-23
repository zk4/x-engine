package com.zkty.modules.loaded.jsapi;

import android.app.Dialog;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSONObject;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.dsbridge.OnReturnValue;
import com.zkty.modules.engine.utils.ActivityUtils;
import com.zkty.modules.loaded.widget.dialog.BottomDialog;
import com.zkty.modules.loaded.widget.dialog.CommonDialog;
import com.zkty.modules.loaded.widget.dialog.DialogHelper;
import com.zkty.modules.loaded.widget.pickerview.PickerView;

import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;
import java.util.List;


public class __xengine__module_ui extends xengine__module_ui {
    private static final String TAG = __xengine__module_ui.class.getSimpleName();


    private static final String TITLE = "title";
    private static final String CONTENT = "content";
    private static final String ITEMLIST = "itemList";
    private static final String TAPINDEX = "tapIndex";
    private static final String SHOWCANCEL = "showCancel";
    private static final String ICON = "icon";
    private static final String DURATION = "duration";


    @Override
    public void _showToast(XEToastDTO dto, CompletionHandler<Nullable> handler) {


        String title = !TextUtils.isEmpty(dto.tipContent) ? dto.tipContent : null;
        String icon = !TextUtils.isEmpty(dto.icon) ? dto.icon : "none";
        switch (icon) {
            case "success":
                DialogHelper.showSuccessDialog(ActivityUtils.getCurrentActivity(), title, dto.duration);
                break;
            case "loading":
                DialogHelper.showLoadingDialog(ActivityUtils.getCurrentActivity(), title, dto.duration);
                break;
            case "none":
            default:
                DialogHelper.showNoIconDialog(ActivityUtils.getCurrentActivity(), title, dto.duration);
                break;
        }

        handler.complete();

    }

    @Override
    public void _hiddenHudToast(CompletionHandler<Nullable> handler) {
        DialogHelper.hideDialog();
        handler.complete();
    }

    @Override
    public void _showLoading(XETipDTO dto, CompletionHandler<Nullable> handler) {
        Log.d(TAG, JSONObject.toJSONString(dto));
        try {
            String title = !TextUtils.isEmpty(dto.tipContent) ? dto.tipContent : "加载中...";
            DialogHelper.showLoadingDialog(ActivityUtils.getCurrentActivity(), title, 0);
        } catch (Exception e) {
            Log.e(TAG, e.getMessage());
            handler.complete();
        }
    }

    @Override
    public void _showModal(XEModalDTO dto, CompletionHandler<XEAlertResultDTO> handler) {

        String title = !TextUtils.isEmpty(dto.tipTitle) ? dto.tipTitle : null;
        String content = !TextUtils.isEmpty(dto.tipContent) ? dto.tipContent : null;

        CommonDialog dialog = new CommonDialog(ActivityUtils.getCurrentActivity());
        dialog.setTitle(title);
        dialog.setContent(content);
        if (!dto.showCancel)
            dialog.setSingleMode();
        dialog.setCanceledOnTouchOutside(false);

        dialog.setClickCallback(new CommonDialog.ClickCallback() {
            @Override
            public void onCancel() {
                XEAlertResultDTO resultDTO = new XEAlertResultDTO();
                resultDTO.tapIndex = "0";
                handler.complete(resultDTO);
            }

            @Override
            public void onConfirm() {
                XEAlertResultDTO resultDTO = new XEAlertResultDTO();
                resultDTO.tapIndex = "1";
                handler.complete(resultDTO);
            }
        });

        dialog.show();

    }


    @Override
    public void _hideLoading(CompletionHandler<Nullable> handler) {
        DialogHelper.hideDialog();
        handler.complete();
    }


    @Override
    public void _hideToast(CompletionHandler<Nullable> handler) {
        DialogHelper.hideDialog();
        handler.complete();
    }


    @Override
    public void _showSuccessToast(XEToastDTO dto, CompletionHandler<Nullable> handler) {
        DialogHelper.showSuccessDialog(ActivityUtils.getCurrentActivity(), dto.tipContent, dto.duration);
        handler.complete();
    }

    @Override
    public void _showFailToast(XEToastDTO dto, CompletionHandler<Nullable> handler) {
        DialogHelper.showFailDialog(ActivityUtils.getCurrentActivity(), dto.tipContent, dto.duration);
        handler.complete();
    }

    @Override
    public void _showActionSheet(XESheetDTO dto, CompletionHandler<XERetDTO> handler) {

        BottomDialog bottomDialog = new BottomDialog(ActivityUtils.getCurrentActivity());

        String[] item = new String[dto.itemList.size()];
        for (int i = 0; i < dto.itemList.size(); i++) {
            item[i] = dto.itemList.get(i);
        }
        bottomDialog.initDialog(dto.title, dto.content, item, (view, which, l) -> {
            mXEngineWebView.callHandler(dto.__event__, new Object[]{which}, new OnReturnValue<Object>() {
                @Override
                public void onValue(Object retValue) {

                }
            });


        });
        bottomDialog.showDialog();

    }

    @Override
    public void _showPickerView(XEPickerDTO dto, CompletionHandler<XERetDTO> handler) {

        List<List<String>> data = new ArrayList<>();
        if (dto.data != null) {
            data = dto.data;
        }
        Dialog dateDialog = null;
        PickerView.Builder
                builder = new PickerView.Builder(ActivityUtils.getCurrentActivity())
                .setData(data).setOnDateSelectedListener(new PickerView.OnDataSelectedListener() {
                    @Override
                    public void onDataSelected(List<String> data) {

                        mXEngineWebView.callHandler(dto.__event__, new Object[]{data}, new OnReturnValue<Object>() {
                            @Override
                            public void onValue(Object retValue) {

                            }
                        });

                    }

                    @Override
                    public void onCancel() {

                    }
                });
        if (!TextUtils.isEmpty(dto.toolBarBackgroundColor)) {
            builder.setToolBarColor(dto.toolBarBackgroundColor);
        }
        if (!TextUtils.isEmpty(dto.pickerBackgroundColor)) {
            builder.setPickerBackgroundColor(dto.pickerBackgroundColor);
        }
        if (!TextUtils.isEmpty(dto.backgroundColor)) {
            builder.setBackgroundColor(dto.backgroundColor);
        }
        if (!TextUtils.isEmpty(dto.backgroundColorAlpha)) {
            builder.setBackgroundColorAlpha(dto.backgroundColorAlpha);
        }
        builder.setPickerHeight(Integer.parseInt(dto.pickerHeight));
        builder.setRowHeight(Integer.parseInt(dto.rowHeight));
        if (!TextUtils.isEmpty(dto.leftText)) {
            builder.setLeftText(dto.leftText);
        }
        if (!TextUtils.isEmpty(dto.leftTextColor)) {
            builder.setLeftTextColor(dto.leftTextColor);
        }
        builder.setLeftTextSize((int) dto.leftTextSize);
        if (!TextUtils.isEmpty(dto.rightText)) {
            builder.setRightText(dto.rightText);
        }
        if (!TextUtils.isEmpty(dto.rightTextColor)) {
            builder.setRightTextColor(dto.rightTextColor);
        }
        builder.setRightTextSize((int) dto.rightTextSize);

        dateDialog = builder.create();
        dateDialog.show();

    }
}
