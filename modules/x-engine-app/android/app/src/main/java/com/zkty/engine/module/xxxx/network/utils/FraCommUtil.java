package com.zkty.engine.module.xxxx.network.utils;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Activity;
import android.app.ActivityManager;
import android.app.AlertDialog;
import android.bluetooth.BluetoothAdapter;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.Resources;
import android.database.Cursor;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Environment;
import android.provider.MediaStore;
import android.provider.Settings;
import android.util.DisplayMetrics;
import android.view.Display;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;


import com.zkty.engine.module.xxxx.network.NetworkMaster;

import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Locale;


public class FraCommUtil {

    /**
     * 获取应用的上下文对象，可以直接强转为application
     *
     * @return FraApplication.getInstance();
     */
    public static Context getContext() {
        return NetworkMaster.getContext();
    }

    /**
     * 获取资源Resources对象
     *
     * @return
     */
    public static Resources getResource() {
        return getContext().getResources();
    }

    /**
     * 只是去拨号界面，但是并不拨打电话
     *
     * @param ctx
     * @param phoneUrl 电话号码
     */
    public static void callPhone(Context ctx, String phoneUrl) {
        try {
            //进入拨号界面
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + phoneUrl));
//          Intent intent = new Intent(Intent.ACTION_CALL);//直接拨打电话
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            ctx.startActivity(intent);
        } catch (Exception e) {

        }

    }

    /**
     * 查询当前设备是否显示了虚拟按键
     * <p/>
     * api17及以上才会调用，17一下return false
     *
     * @param windowManager
     * @return
     */
    @TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
    public static boolean hasSoftKeys(WindowManager windowManager) {

        if (Build.VERSION.SDK_INT < 17) {
            return false;
        }
        //API 17之后使用，获取的像素宽高包含虚拟键所占空间，在API 17之前通过反射获取
        Display d = windowManager.getDefaultDisplay();

        DisplayMetrics realDisplayMetrics = new DisplayMetrics();
        d.getRealMetrics(realDisplayMetrics);
        int realHeight = realDisplayMetrics.heightPixels;
        int realWidth = realDisplayMetrics.widthPixels;
        //获取的像素宽高不包含虚拟键所占空间
        DisplayMetrics displayMetrics = new DisplayMetrics();
        d.getMetrics(displayMetrics);
        int displayHeight = displayMetrics.heightPixels;
        int displayWidth = displayMetrics.widthPixels;

        return (realWidth - displayWidth) > 0
                || (realHeight - displayHeight) > 0;
    }

    /**
     * 取消显示软件盘
     *
     * @param act
     */
    public static void dismissInput(Activity act) {

        InputMethodManager systemService = (InputMethodManager) act.getSystemService(Context.INPUT_METHOD_SERVICE);
        //获取当前获得焦点的view
        View currentFocus = act.getCurrentFocus();
        System.out.println("============进去=========1");
        if (currentFocus != null) {
            System.out.println("============进去=========");
            assert systemService != null;
            systemService.hideSoftInputFromWindow(currentFocus.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
        }
    }

    /**
     * 显示软件盘
     *
     * @param act
     */
    public static void showInput(Activity act) {

        InputMethodManager systemService = (InputMethodManager) act.getSystemService(Context.INPUT_METHOD_SERVICE);
        //获取当前获得焦点的view
        View currentFocus = act.getCurrentFocus();

        if (currentFocus != null) {
            assert systemService != null;
            systemService.showSoftInput(currentFocus, 0);
        }
    }

    /**
     * 判断wifi网络是否可用
     *
     * @param context
     * @return
     */
    public static boolean isWifiDataEnable(Context context) {
        try {
            ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
            boolean isWifiDataEnable = false;
            assert connectivityManager != null;
            isWifiDataEnable = connectivityManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI).isConnectedOrConnecting();
            return isWifiDataEnable;

        } catch (Exception e) {
            return false;
        }
    }


    /**
     * 获取包名
     *
     * @param act
     * @return
     */
    public static String getPackageName(Context act) {
        PackageManager pm = act.getPackageManager();
        try {
            PackageInfo packInfo = pm.getPackageInfo(act.getPackageName(), 0);
            return packInfo.packageName;
        } catch (NameNotFoundException e) {
            e.printStackTrace();
            return "";
        }
    }

    /**
     * 获取版本名称
     *
     * @param act
     * @return
     */
    public static String getVersionName(Context act) {
        PackageManager pm = act.getPackageManager();
        try {
            PackageInfo packInfo = pm.getPackageInfo(act.getPackageName(), 0);
            return packInfo.versionName;
        } catch (NameNotFoundException e) {
            e.printStackTrace();
            return "";
        }
    }

    /**
     * 获取版本号
     *
     * @param act
     * @return
     */
    public static int getVersionCode(Context act) {
        PackageManager pm = act.getPackageManager();
        try {
            PackageInfo packInfo = pm.getPackageInfo(act.getPackageName(), 0);
            return packInfo.versionCode;
        } catch (NameNotFoundException e) {
            e.printStackTrace();
            return 1;
        }
    }

    @SuppressWarnings("deprecation")
    public static File getUriToFile(Activity ctx, Uri uri) {
        File file = null;
        try {
            String[] proj = {MediaStore.Images.Media.DATA};

            Cursor actualimagecursor = ctx.managedQuery(uri, proj, null, null, null);

            int actual_image_column_index = actualimagecursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);

            actualimagecursor.moveToFirst();

            String img_path = actualimagecursor.getString(actual_image_column_index);

            file = new File(img_path);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return file;
    }

    public static int dip2px(Context context, float dipValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dipValue * scale + 0.5f);
    }

    /**
     * 获取屏幕的Metrics,可以通过Metrics获取屏幕的宽高
     *
     * @return
     */
    public static DisplayMetrics getScreenMetrics(Activity context) {
        DisplayMetrics dm = new DisplayMetrics();
        context.getWindowManager().getDefaultDisplay().getMetrics(dm);
        return dm;
    }

    /**
     * 判断SDCard是否存在
     *
     * @return
     */
    public static boolean isSDcardExist() {
        return Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED);
    }

    /**
     * 获取SDCard的File:   Environment.getExternalStorageDirectory()
     *
     * @return
     */
    public static File getSDCard() {
        return Environment.getExternalStorageDirectory();

    }

    /**
     * 获得当前进程的名字
     *
     * @param context
     * @return 进程号
     */
    public static String getCurProcessName(Context context) {

        int pid = android.os.Process.myPid();

        ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);

        for (ActivityManager.RunningAppProcessInfo appProcess : activityManager.getRunningAppProcesses()) {

            if (appProcess.pid == pid) {
                return appProcess.processName;
            }
        }
        return null;
    }

    /**
     * 判断当前的网络状态
     *
     * @param context
     * @return
     */
    public static boolean isNetworkConnected(Context context) {
        if (context != null) {
            ConnectivityManager mConnectivityManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
            assert mConnectivityManager != null;
            NetworkInfo mNetworkInfo = mConnectivityManager.getActiveNetworkInfo();
            if (mNetworkInfo != null) {
                return mNetworkInfo.isAvailable();
            }
        }
        return false;
    }

    /**
     * 打开设置网络界面
     */
    public static void setNetworkMethod(final Context context) {
        //提示对话框
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setTitle("网络设置提示").setMessage("网络连接不可用,是否进行设置?").setPositiveButton("设置", new DialogInterface.OnClickListener() {

            @Override
            public void onClick(DialogInterface dialog, int which) {

                Intent intent = null;
                //判断手机系统的版本  即API大于10 就是3.0或以上版本
                if (Build.VERSION.SDK_INT > 10) {
                    intent = new Intent(Settings.ACTION_WIRELESS_SETTINGS);
                } else {
                    intent = new Intent();
                    ComponentName component = new ComponentName("com.android.settings", "com.android.settings.WirelessSettings");
                    intent.setComponent(component);
                    intent.setAction("android.intent.action.VIEW");
                }
                context.startActivity(intent);
            }
        }).setNegativeButton("取消", new DialogInterface.OnClickListener() {

            @Override
            public void onClick(DialogInterface dialog, int which) {

                dialog.dismiss();
            }
        }).show();
    }


    /**
     * 获取当前手机系统语言。
     *
     * @return 返回当前系统语言。例如：当前设置的是“中文-中国”，则返回“zh-CN”
     */
    public static String getSystemLanguage() {
        return Locale.getDefault().getLanguage();
    }

    /**
     * 获取当前系统上的语言列表(Locale列表)
     *
     * @return 语言列表
     */
    public static Locale[] getSystemLanguageList() {
        return Locale.getAvailableLocales();
    }

    /**
     * 获取当前手机系统版本号
     *
     * @return 系统版本号
     */
    public static String getSystemVersion() {
        return Build.VERSION.RELEASE;
    }

    /**
     * 获取手机型号
     *
     * @return 手机型号
     */
    public static String getSystemModel() {
        return Build.MODEL;
    }

    /**
     * 获取手机厂商
     *
     * @return 手机厂商
     */
    public static String getDeviceBrand() {
        return Build.BRAND;
    }


    /**
     * Pseudo-Unique ID, 这个在任何Android手机中都有效
     * 有一些特殊的情况，一些如平板电脑的设置没有通话功能，或者你不愿加入READ_PHONE_STATE许可。而你仍然想获得唯
     * 一序列号之类的东西。这时你可以通过取出ROM版本、制造商、CPU型号、以及其他硬件信息来实现这一点。这样计算出
     * 来的ID不是唯一的（因为如果两个手机应用了同样的硬件以及Rom 镜像）。但应当明白的是，出现类似情况的可能性基
     * 本可以忽略。大多数的Build成员都是字符串形式的，我们只取他们的长度信息。我们取到13个数字，并在前面加上“35
     * ”。这样这个ID看起来就和15位IMEI一样了。
     *
     * @return PesudoUniqueID
     */
    private static String getPesudoUniqueID() {
        return "35" + //we make this look like a valid IMEI
                Build.BOARD.length() % 10 +
                Build.BRAND.length() % 10 +
                Build.CPU_ABI.length() % 10 +
                Build.DEVICE.length() % 10 +
                Build.DISPLAY.length() % 10 +
                Build.HOST.length() % 10 +
                Build.ID.length() % 10 +
                Build.MANUFACTURER.length() % 10 +
                Build.MODEL.length() % 10 +
                Build.PRODUCT.length() % 10 +
                Build.TAGS.length() % 10 +
                Build.TYPE.length() % 10 +
                Build.USER.length() % 10;
    }

    /**
     * The WLAN MAC Address string
     * 是另一个唯一ID。但是你需要为你的工程加入android.permission.ACCESS_WIFI_STATE 权限，否则这个地址会为
     * null。Returns: 00:11:22:33:44:55 (这不是一个真实的地址。而且这个地址能轻易地被伪造。).WLan不必打开，
     * 就可读取些值。
     *
     * @return m_szWLANMAC
     */
    private static String getWLANMACAddress() {
        WifiManager wm = (WifiManager) NetworkMaster.getContext().getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        assert wm != null;
        @SuppressLint("HardwareIds") String m_szWLANMAC = wm.getConnectionInfo().getMacAddress();
        return m_szWLANMAC;
    }

    /**
     * 只在有蓝牙的设备上运行。并且要加入android.permission.BLUETOOTH 权限.Returns: 43:25:78:50:93:38 .
     * 蓝牙没有必要打开，也能读取。
     *
     * @return m_szBTMAC
     */
    private static String getBTMACAddress() {
        BluetoothAdapter m_BluetoothAdapter = null; // Local Bluetooth adapter
        m_BluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        @SuppressLint("HardwareIds") String m_szBTMAC = m_BluetoothAdapter.getAddress();

        return m_szBTMAC;
    }

    /**
     * Combined Device ID
     * 综上所述，我们一共有五种方式取得设备的唯一标识。它们中的一些可能会返回null，或者由于硬件缺失、权限问题等
     * 获取失败。但你总能获得至少一个能用。所以，最好的方法就是通过拼接，或者拼接后的计算出的MD5值来产生一个结果。
     * 通过算法，可产生32位的16进制数据:9DDDF85AFF0A87974CE4541BD94D5F55
     *
     * @return
     */
    public static String getUniqueID() {
        //  String m_szLongID = getPesudoUniqueID() + getWLANMACAddress() + getBTMACAddress();
        String m_szLongID = getPesudoUniqueID() + getWLANMACAddress();
        // compute md5
        MessageDigest m = null;
        try {
            m = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        assert m != null;
        m.update(m_szLongID.getBytes(), 0, m_szLongID.length());
        // get md5 bytes
        byte p_md5Data[] = m.digest();
        // create a hex string
        StringBuilder m_szUniqueID = new StringBuilder();
        for (byte aP_md5Data : p_md5Data) {
            int b = (0xFF & aP_md5Data);
            // if it is a single digit, make sure it have 0 in front (proper padding)
            if (b <= 0xF)
                m_szUniqueID.append("0");
            // add number to string
            m_szUniqueID.append(Integer.toHexString(b));
        }   // hex string to uppercase
        m_szUniqueID = new StringBuilder(m_szUniqueID.toString().toUpperCase());
        return m_szUniqueID.toString();
    }

    /**
     * 作者：沈钦伟
     * 功能:防止按钮点击过快
     */
    // 两次点击按钮之间的点击间隔不能少于1000毫秒
    private static final int MIN_CLICK_DELAY_TIME = 1000;
    private static long lastClickTime;

    public static boolean isFastClick() {
        boolean flag = false;
        long curClickTime = System.currentTimeMillis();
        if ((curClickTime - lastClickTime) >= MIN_CLICK_DELAY_TIME) {
            flag = true;
        }
        lastClickTime = curClickTime;
        return flag;
    }



}
