package com.zkty.modules.engine.utils;

import android.app.ActivityManager;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.media.ExifInterface;
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Utils {
    private static final String TAG = Utils.class.getSimpleName();

    /**
     * 获取本地图片的旋转信息
     *
     * @param localPath
     * @return
     */
    public static int getImageOrientation(String localPath) {
        Log.d("ExifInterface", "start:" + System.currentTimeMillis());
        int degree = -1;
        try {
            ExifInterface exifInterface = new ExifInterface(localPath);
            int orientation = exifInterface.getAttributeInt(ExifInterface.TAG_ORIENTATION, -1);
            switch (orientation) {
                case ExifInterface.ORIENTATION_ROTATE_90:
                    degree = 90;
                    break;
                case ExifInterface.ORIENTATION_ROTATE_180:
                    degree = 180;
                    break;
                case ExifInterface.ORIENTATION_ROTATE_270:
                    degree = 270;
                    break;
                default:
                    degree = 0;
                    break;
            }
        } catch (IOException e) {

        }
        Log.d("ExifInterface", "end:" + System.currentTimeMillis());
        return degree;
    }

    public static InputStream getLocalImage(String url) {
        InputStream inputStream = null;
        Uri uri = Uri.parse(url);
        Log.d(TAG, "url:" + uri.toString() + "---host:" + uri.getHost() + "---path:" + uri.getPath() + "--query:" + uri.getQuery());
        String path = uri.getPath();
        if (path != null && ((path.endsWith(".jpg") || path.endsWith(".png") || path.endsWith(".webp")))) {
            File image = new File(path);
            if (image.exists()) {           //存在本地图片
                int degree = 0;
                Bitmap bitmap = null;
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                Set<String> query = uri.getQueryParameterNames();
                if (query != null && !query.isEmpty()) {                     //解析参数并读取图片
                    BitmapFactory.Options options = new BitmapFactory.Options();
                    options.inJustDecodeBounds = true;
                    bitmap = BitmapFactory.decodeFile(path, options);

                    Log.d(TAG, "options:" + options.outWidth + "---" + options.outHeight);

                    int w = 0, h = 0, bytes = 0;
                    float q = 1.0f;

                    if (!TextUtils.isEmpty(uri.getQueryParameter("w"))) {
                        w = Integer.parseInt(uri.getQueryParameter("w"));
                    }
                    if (!TextUtils.isEmpty(uri.getQueryParameter("h"))) {
                        h = Integer.parseInt(uri.getQueryParameter("h"));
                    }
                    if (!TextUtils.isEmpty(uri.getQueryParameter("bytes"))) {
                        bytes = Integer.parseInt(uri.getQueryParameter("bytes"));
                    }
                    if (!TextUtils.isEmpty(uri.getQueryParameter("q"))) {
                        q = Float.parseFloat(uri.getQueryParameter("q"));
                    }
                    if (w == 0 && h == 0) {
                        w = options.outWidth;
                        h = options.outHeight;
                    } else {
                        w = Math.min(w, options.outWidth);
                        h = Math.min(h, options.outHeight);
                        if (w == 0) {                   //未指定w
                            w = (options.outWidth * h) / options.outHeight;
                        } else if (h == 0) {            //未指定h
                            h = (options.outHeight * w) / options.outWidth;
                        } else {                        //指定w和h

                        }
                    }

                    options.inJustDecodeBounds = false;
                    bitmap = BitmapFactory.decodeFile(path, options);

                    degree = getImageOrientation(path);
                    Log.d(TAG, "before:w" + options.outWidth + "--h:" + options.outHeight);
                    Log.d(TAG, "after:w" + w + "--h:" + h);

                    bitmap = Bitmap.createScaledBitmap(bitmap, w, h, false);

                    if (degree > 0) {
                        Matrix matrix = new Matrix();
                        matrix.postRotate(degree);
                        bitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight(), matrix, false);
                    }

                    bitmap.compress(Bitmap.CompressFormat.JPEG, (int) (q * 100), baos);

                    Log.d(TAG, "scaled:" + bitmap.getWidth() + "---" + bitmap.getHeight());

                    //                                int degree = Utils.getImageOrientation(path);
//                                int outSample = 1;
//                                Bitmap sampleBmp = null;
//                                while (true) {
//                                    BitmapFactory.Options options = new BitmapFactory.Options();
//                                    options.inSampleSize = outSample;
//                                    sampleBmp = BitmapFactory.decodeFile(path, options);
//                                    if (sampleBmp.getAllocationByteCount() <= 1024 * 1024 * 4) {            //压缩到4M以内
//                                        break;
//                                    } else {
//                                        outSample = 2 * outSample;
//                                    }
//                                }
//
//                                File temp = new File(ResourceManager.getCacheDir(), file.getName());
//                                if (temp.exists()) {            //已经存在
//                                    Log.d(TAG, "cache exit!");
//                                    path = temp.getPath();
//                                } else {            //不存在
//                                    Log.d(TAG, "cache not exit!");
//
//                                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
//
//                                    if (degree > 0) {
//                                        Matrix matrix = new Matrix();
//                                        matrix.postRotate(degree);
//                                        sampleBmp = Bitmap.createBitmap(sampleBmp, 0, 0, sampleBmp.getWidth(), sampleBmp.getHeight(), matrix, false);
//                                    }
//
//                                    sampleBmp.compress(Bitmap.CompressFormat.JPEG, 100, baos);
//                                    InputStream inputStream = new ByteArrayInputStream(baos.toByteArray());
//
//                                    String cache = FileUtils.saveFile(inputStream, ResourceManager.getCacheDir(), file.getName());              //保存压缩后的图片
//
//                                    if (!TextUtils.isEmpty(cache)) {        //保存成功|使用压缩后的图片路径
//                                        Log.d(TAG, "save success!----" + cache);
//                                        path = cache;
//                                    } else {                                //保存失败|使用原始图片路径
//                                        Log.d(TAG, "save failed!");
//                                    }
//                                }
//
//                                Log.d(TAG, "path-1:" + path);

                    inputStream = new ByteArrayInputStream(baos.toByteArray());
                } else {                                //直接读取图片
                    bitmap = BitmapFactory.decodeFile(path);
                    degree = getImageOrientation(path);
                    if (degree > 0) {                       //需要旋转图片
                        Matrix matrix = new Matrix();
                        matrix.postRotate(degree);
                        bitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight(), matrix, false);
                    }
                    bitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos);
                    inputStream = new ByteArrayInputStream(baos.toByteArray());
                }

                if (bitmap != null) {
                    bitmap.recycle();
                }
            }
        }
        return inputStream;
    }


    /**
     * 判断一个字符是否是数字
     *
     * @param str
     * @return
     */
    public static boolean isNumeric(String str) {
        if (!TextUtils.isEmpty(str)) {
            Pattern pattern = Pattern.compile("[0-9]*");
            Matcher isNum = pattern.matcher(str);
            if (!isNum.matches()) {
                return false;
            }
            return true;
        }
        return false;
    }


    public static String getCurProcessName(Context context) {
        int pid = android.os.Process.myPid();
        ActivityManager mActivityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        for (ActivityManager.RunningAppProcessInfo appProcess : mActivityManager.getRunningAppProcesses()) {
            if (appProcess.pid == pid) {
                return appProcess.processName;
            }
        }
        return null;
    }


    public static String getPhoneNumberFormString(String str) {

        if (TextUtils.isEmpty(str)) return null;
        String expression = "400-\\d{3}-\\d{4}";

        Pattern pattern = Pattern.compile(expression);
        Matcher matcher = pattern.matcher(str);
        if (matcher.find()) {
            return matcher.group();
        }


        return null;

    }

    // 两次点击间隔不能少于1000ms
    private static final int FAST_CLICK_DELAY_TIME = 1000;
    private static long lastClickTime;

    public static boolean isFastClick() {
        boolean flag = true;
        long currentClickTime = System.currentTimeMillis();
        if ((currentClickTime - lastClickTime) >= FAST_CLICK_DELAY_TIME) {
            flag = false;
        }
        lastClickTime = currentClickTime;
        return flag;
    }
}
