package com.zkty.nativ.device;

import android.Manifest;
import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.provider.ContactsContract;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSON;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.DensityUtils;
import com.zkty.nativ.core.utils.DeviceUtils;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.LifecycleListener;

import java.util.HashMap;
import java.util.Map;

import module.device.R;

public class NativeDevice extends NativeModule implements IDevice {

    private LifecycleListener lifeCycleListener;
    private int CODE_PERMISSION_CONTACTS = 1;
    private static final int REQUEST_CODE_DEFINE = 0X0115;
    private String[] permissions = {Manifest.permission.READ_CONTACTS};


    @Override
    public String moduleId() {
        return "com.zkty.native.device";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public String getStatusBarHeight() {
        return String.valueOf((int) DensityUtils.pixelsToDip(XEngineApplication.getApplication(), DensityUtils.getStatusBarHeight(XEngineApplication.getApplication())));
    }

    @Override
    public String getNavigationHeight() {
        return String.valueOf((int) DensityUtils.pixelsToDip(XEngineApplication.getApplication(), XEngineApplication.getApplication().getResources().getDimension(R.dimen.dp_65)));
    }

    @Override
    public String getScreenHeight() {
        return String.valueOf((int) DensityUtils.pixelsToDip(XEngineApplication.getApplication(), DensityUtils.getScreenHeight(XEngineApplication.getApplication())));
    }

    @Override
    public String getTabbarHeight() {
        return String.valueOf((int) DensityUtils.pixelsToDip(XEngineApplication.getApplication(), XEngineApplication.getApplication().getResources().getDimension(R.dimen.dp_70)));
    }

    @Override
    public String getSystemVersion() {
        return DeviceUtils.getSystemVersion();
    }

    @Override
    public String getUDID() {
        return null;
    }

    @Override
    public String callPhone(String phone) {
        Intent intent = new Intent(Intent.ACTION_DIAL);
        Uri data = Uri.parse("tel:" + phone);
        intent.setData(data);
        XEngineApplication.getCurrentActivity().startActivity(intent);
        return null;
    }

    @Override
    public String sendMessage(String phone, String msg) {
        Intent intent = new Intent(Intent.ACTION_SENDTO, Uri.parse("smsto:" + phone));
        intent.putExtra("sms_body", msg);
        XEngineApplication.getCurrentActivity().startActivity(intent);
        return null;
    }

    @Override
    public String getDeviceInfo() {
        Map<String, String> map = new HashMap<>();
        map.put("type", "android");
        map.put("systemVersion", DeviceUtils.getSystemVersion());
        map.put("language", DeviceUtils.getSystemLanguage());

        return JSON.toJSONString(map);
    }

    @Override
    public void pickContact(ContactCallBack callBack) {


        Activity activity = XEngineApplication.getCurrentActivity();
        if (activity == null || !(activity instanceof BaseXEngineActivity)) return;
        final BaseXEngineActivity act = (BaseXEngineActivity) activity;

        if (lifeCycleListener != null) {
            act.removeLifeCycleListener(lifeCycleListener);
            lifeCycleListener = null;
        }
        lifeCycleListener = new LifecycleListener() {
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

                if (requestCode == REQUEST_CODE_DEFINE) {
                    if (resultCode == Activity.RESULT_OK) {
                        if (data != null) {
                            Uri uri = data.getData();
                            String phoneNum = null;
                            String contactName = null;
                            // 创建内容解析者
                            ContentResolver contentResolver = activity.getContentResolver();
                            Cursor cursor = null;
                            if (uri != null) {
                                cursor = contentResolver.query(uri,
                                        new String[]{"display_name", "data1"}, null, null, null);
                            }
                            while (cursor.moveToNext()) {
                                contactName = cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME));
                                phoneNum = cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));
                            }
                            cursor.close();
                            //  把电话号码中的  -  符号 替换成空格
                            if (phoneNum != null) {
                                phoneNum = phoneNum.replaceAll("-", " ");
                                // 空格去掉  为什么不直接-替换成"" 因为测试的时候发现还是会有空格 只能这么处理
                                phoneNum = phoneNum.replaceAll(" ", "");
                            }
                            callBack.onResult(contactName, phoneNum);
                        }
                    } else {
                        callBack.onResult(null, null);
                    }
                }
            }

            @Override
            public void onRequestPermissionsResult(int requestCode, @NonNull String[] strings, @NonNull int[] ints) {
                if (requestCode == CODE_PERMISSION_CONTACTS) {
                    if (activity.checkCallingOrSelfPermission(permissions[0]) == PackageManager.PERMISSION_GRANTED) {
                        pick(activity);
                    } else {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                            activity.requestPermissions(permissions, CODE_PERMISSION_CONTACTS);
                        }
                    }
                }
            }
        };
//        }

        act.addLifeCycleListener(lifeCycleListener);


        if (activity.checkCallingOrSelfPermission(permissions[0]) == PackageManager.PERMISSION_GRANTED) {
            pick(activity);
        } else {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                activity.requestPermissions(permissions, CODE_PERMISSION_CONTACTS);
            }
        }


    }

    private void pick(Activity activity) {
        Intent intent = new Intent();
        intent.setAction("android.intent.action.PICK");
        intent.addCategory("android.intent.category.DEFAULT");
        intent.setType("vnd.android.cursor.dir/phone_v2");
        activity.startActivityForResult(intent, REQUEST_CODE_DEFINE);
    }


}
