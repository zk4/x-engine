package com.zkty.modules.loaded.jsapi;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

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
        moreDTO.content = String.valueOf(DensityUtils.getStatusBarHeight(activity));
        handler.complete(moreDTO);
    }

    @Override
    public void _getNavigationHeight(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.dipToPixels(activity, 45));
        handler.complete(moreDTO);
    }

    @Override
    public void _getTabBarHeight(DeviceSheetDTO dto, CompletionHandler<DeviceMoreDTO> handler) {
        Activity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        DeviceMoreDTO moreDTO = new DeviceMoreDTO();
        moreDTO.content = String.valueOf(DensityUtils.getNavigationBarHeightIfRoom(activity));
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

        final XEngineWebActivity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        XEngineWebActivity.LifecycleListener lifeCycleListener = new XEngineWebActivity.LifecycleListener() {
            @Override
            public void onCreate() {

            }

            @Override
            public void onStart() {

            }

            @Override
            public void onRestart() {

            }

            @Override
            public void onResume() {

            }

            @Override
            public void onPause() {

            }

            @Override
            public void onStop() {

            }

            @Override
            public void onDestroy() {

            }

            @Override
            public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {

            }

            @Override
            public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {

                if (requestCode == PERMISSION_REQUEST_SMS) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        if (activity.checkSelfPermission(Manifest.permission.SEND_SMS) == PackageManager.PERMISSION_GRANTED) {
                            Intent intent = new Intent(Intent.ACTION_SENDTO, Uri.parse("smsto:" + dto.phoneNumber));
                            intent.putExtra("sms_body", dto.messageContent);
                            XEngineWebActivityManager.sharedInstance().getCurrent().startActivity(intent);
                        }
                    }
                }

            }
        };


        if (activity != null) {
            activity.removeLifeCycleListener(lifeCycleListener);

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && activity.checkSelfPermission(Manifest.permission.SEND_SMS) != PackageManager.PERMISSION_GRANTED) {
                activity.requestPermissions(new String[]{Manifest.permission.SEND_SMS}, PERMISSION_REQUEST_SMS);
            } else {
                Intent intent = new Intent(Intent.ACTION_SENDTO, Uri.parse("smsto:" + dto.phoneNumber));
                intent.putExtra("sms_body", dto.messageContent);
                XEngineWebActivityManager.sharedInstance().getCurrent().startActivity(intent);
            }
        }
        handler.complete();

    }
}
