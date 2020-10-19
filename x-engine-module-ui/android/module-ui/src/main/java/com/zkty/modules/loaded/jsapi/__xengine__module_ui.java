package com.zkty.modules.loaded.jsapi;

import android.app.Dialog;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSONObject;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.utils.ActivityUtils;
import com.zkty.modules.loaded.widget.dialog.BottomDialog;
import com.zkty.modules.loaded.widget.dialog.CommonDialog;
import com.zkty.modules.loaded.widget.dialog.DialogHelper;
import com.zkty.modules.loaded.widget.pickerview.PickerView;

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
    public void _showAlertAction(ZKUIAlertDTO dto, CompletionHandler<Nullable> handler) {
        Log.d(TAG, JSONObject.toJSONString(dto));
        try {
            BottomDialog bottomDialog = new BottomDialog(ActivityUtils.getCurrentActivity());

            String title = !TextUtils.isEmpty(dto.title) ? dto.title : null;
            String content = !TextUtils.isEmpty(dto.content) ? dto.content : null;

            String[] item = new String[dto.btnItem.size()];
            for (int i = 0; i < dto.btnItem.size(); i++) {
                if (!TextUtils.isEmpty(dto.btnItem.get(i).title)) {
                    item[i] = dto.btnItem.get(i).title;
                } else {
                    item[i] = "";
                }
            }

            bottomDialog.initDialog(title, content, item, (view, which, l) -> {
                if (which != -2) {
                    JSONObject object = new JSONObject();
                    object.put(TAPINDEX, which);
                    //handler.complete(JSONObject.toJSONString(object));
                    handler.complete();
                }
            });
            bottomDialog.showDialog();

        } catch (Exception e) {
            Log.e(TAG, e.getMessage());
            handler.complete();
        }

    }

    @Override
    public void _showLoading(ZKUIBtnDTO dto, CompletionHandler<Nullable> handler) {
        Log.d(TAG, JSONObject.toJSONString(dto));
        try {
            String title = !TextUtils.isEmpty(dto.title) ? dto.title : "加载中...";
            DialogHelper.showLoadingDialog(ActivityUtils.getCurrentActivity(), title, 0);
        } catch (Exception e) {
            Log.e(TAG, e.getMessage());
            handler.complete();
        }
    }

    @Override
    public void _hideLoading(CompletionHandler<Nullable> handler) {
        DialogHelper.hideDialog();
    }

    @Override
    public void _showModal(ZKUIAlertDTO dto, CompletionHandler<Nullable> handler) {
        Log.d(TAG, JSONObject.toJSONString(dto));
        try {
            String title = !TextUtils.isEmpty(dto.title) ? dto.title : null;
            String content = !TextUtils.isEmpty(dto.content) ? dto.content : null;
            boolean showCancel = dto.showCancel;


            CommonDialog dialog = new CommonDialog(ActivityUtils.getCurrentActivity());
            dialog.setMessageTitle(title);
            dialog.setContentMessage(content);
            dialog.setCancelVisibility(showCancel);
            dialog.setCanceledOnTouchOutside(false);
            dialog.setCommonDialogCallBack(isConfirm -> {
                JSONObject object = new JSONObject();
                object.put(TAPINDEX, isConfirm ? 1 : 0);
                //  handler.complete(JSONObject.toJSONString(object));
                handler.complete();
            });
            dialog.show();
        } catch (Exception e) {
            Log.e(TAG, e.getMessage());
            handler.complete();
        }
    }

    @Override
    public void _showToast(ZKUIToastDTO dto, CompletionHandler<Nullable> handler) {
        Log.d(TAG, JSONObject.toJSONString(dto));
        try {
            String title = !TextUtils.isEmpty(dto.title) ? dto.title : null;
            String icon = !TextUtils.isEmpty(dto.icon) ? dto.icon : "none";
            long duration = !TextUtils.isEmpty(dto.duration) ? Long.parseLong(dto.duration) : 2000;
            switch (icon) {
                case "success":
                    DialogHelper.showSuccessDialog(ActivityUtils.getCurrentActivity(), title, duration);
                    break;
                case "loading":
                    DialogHelper.showLoadingDialog(ActivityUtils.getCurrentActivity(), title, duration);
                    break;
                case "none":
                default:
                    DialogHelper.showNoIconDialog(ActivityUtils.getCurrentActivity(), title, duration);
                    break;
            }

        } catch (Exception e) {
            Log.e(TAG, e.getMessage());
            handler.complete();
        }
    }

    @Override
    public void _hideToast(CompletionHandler<Nullable> handler) {
        DialogHelper.hideDialog();
        handler.complete();
    }

    @Override
    public void _showPickerView(ZKUIPickDTO dto, CompletionHandler<Nullable> handler) {
        Log.d(TAG, JSONObject.toJSONString(dto));
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
                        Log.d(TAG, data.toString());
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
        builder.setPickerHeight((int) dto.pickerHeight);
        builder.setRowHeight((int) dto.rowHeight);
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


        handler.complete();
    }
}
