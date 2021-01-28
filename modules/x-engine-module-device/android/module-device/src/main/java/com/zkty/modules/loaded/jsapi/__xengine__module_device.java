package com.zkty.modules.loaded.jsapi;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.utils.DensityUtils;
import com.zkty.modules.engine.utils.DeviceUtils;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

public class __xengine__module_device extends xengine__module_device {

    private static int PERMISSION_REQUEST_SMS = 420;

    @Override
    public void _getPhoneType(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = DeviceUtils.getSystemModel();
        handler.complete(moreDTO);

    }

    @Override
    public void _getSystemVersion(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = DeviceUtils.getSystemVersion();
        handler.complete(moreDTO);
    }

    @Override
    public void _getUDID(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {

        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = "android no udid";
        handler.complete(moreDTO);
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    public void _getBatteryLevel(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = String.valueOf(DeviceUtils.getBatteryLevel(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getPreferredLanguage(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = DeviceUtils.getSystemLanguage();
        handler.complete(moreDTO);
    }

    @Override
    public void _getScreenWidth(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getRealWidth(activity));
        handler.complete(moreDTO);

    }

    @Override
    public void _getScreenHeight(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getRealHeight(activity));
        handler.complete(moreDTO);

    }

    @Override
    public void _getSafeAreaTop(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getSafeAreaTop(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getSafeAreaBottom(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getSafeAreaBottom(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getSafeAreaLeft(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getSafeAreaLeft(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getSafeAreaRight(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getSafeAreaRight(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getStatusHeight(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.pixelsToDip(activity, DensityUtils.getStatusBarHeight(activity)));
        handler.complete(moreDTO);
    }

    @Override
    public void _getNavigationHeight(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = "65";
        handler.complete(moreDTO);
    }

    @Override
    public void _getTabBarHeight(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.pixelsToDip(activity, DensityUtils.getNavigationBarHeightIfRoom(activity)));
        handler.complete(moreDTO);
    }

    @Override
    public void _devicePhoneCall(DevicePhoneNumDTO dto, CompletionHandler<Nullable> handler) {
        Intent intent = new Intent(Intent.ACTION_DIAL);
        Uri data = Uri.parse("tel:" + dto.phoneNumber);
        intent.setData(data);
        XEngineWebActivityManager.sharedInstance().getCurrent().startActivity(intent);
        handler.complete();
    }

    @Override
    public void _deviceSendMessage(final DeviceMessageDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Intent intent = new Intent(Intent.ACTION_SENDTO, Uri.parse("smsto:" + dto.phoneNumber));
        intent.putExtra("sms_body", dto.messageContent);
        XEngineWebActivityManager.sharedInstance().getCurrent().startActivity(intent);
        handler.complete();

    }
}
