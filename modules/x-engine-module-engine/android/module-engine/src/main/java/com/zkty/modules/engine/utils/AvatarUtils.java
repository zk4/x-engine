package com.zkty.modules.engine.utils;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.provider.MediaStore;

import android.text.TextUtils;
import android.widget.Toast;

import androidx.core.content.FileProvider;


import java.io.File;
import java.util.UUID;

/**
 * 作者 王磊
 * 日期 2018/3/13
 * 功能 头像获取工具类
 * 备注 复制AvatarHepler
 */
public class AvatarUtils {

    public static final int AVATAR_TAKE_PHOTO = 100;
    public static final int AVATAR_CUT_PHOTO = 101;
    public static final int AVATAR_GALLERY = 102;
    public static final int RESULT_CODE_CAMERA = 201;
    public static final int RESULT_CODE_PHOTO = 202;

    /**
     * 头像拍照
     */
    public static String headPath;
    public static Uri PHOTO_URI;
    public static String PHOTO_PATH;

    public static void startCameraPicCut(Activity act) {

        String state = Environment.getExternalStorageState();
        if (state.equals(Environment.MEDIA_MOUNTED)) {
            // 调用系统的拍照功能
            Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
            intent.putExtra("camerasensortype", 2); // 调用前置摄像头
            intent.putExtra("autofocus", true); // 自动对焦
            intent.putExtra("fullScreen", false); // 全屏
            intent.putExtra("showActionIcons", false);
            // 指定调用相机拍照后照片的储存路径

            headPath = getImagesFilePath(act) + UUID.randomUUID().toString() + "_original_image.png";
            new File(AvatarUtils.headPath).deleteOnExit();
            intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(new File(headPath)));
            act.startActivityForResult(intent, AVATAR_TAKE_PHOTO);
        } else {
            Toast.makeText(act, "请确认已经插入SD卡", Toast.LENGTH_SHORT).show();
            return;
        }
    }

    /**
     * 图片裁剪
     *
     * @param uri
     * @param size
     */
    public static void startPhotoZoom(Uri mUriSave, Uri uri, int size, Activity act) {
        try {
            Intent intent = new Intent("com.android.camera.action.CROP");
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION); //添加这一句表示对目标应用临时授权该Uri所代表的文件
            }
            intent.setDataAndType(uri, "image/*");
            // crop为true是设置在开启的intent中设置显示的view可以剪裁
            intent.putExtra("crop", "true");
            // aspectX aspectY 是宽高的比例
            intent.putExtra("aspectX", 1);
            intent.putExtra("aspectY", 1);
            //指定剪切后的图片存储路径
            //   intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(new File(desImagePath)));
            intent.putExtra(MediaStore.EXTRA_OUTPUT, mUriSave);
            // outputX,outputY 是剪裁图片的宽高
            intent.putExtra("outputX", size);
            intent.putExtra("outputY", size);
            intent.putExtra("return-data", false);
            intent.putExtra("noFaceDetection", true);
            intent.putExtra("outputFormat", Bitmap.CompressFormat.PNG.toString());
            intent.putExtra("scale", true);
            act.startActivityForResult(intent, AVATAR_CUT_PHOTO);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //相册选择更换图片
    public static void startImageCapture(Activity atc) {
        Intent intent = new Intent(Intent.ACTION_PICK, null);
        intent.setDataAndType(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, "image/*");
        atc.startActivityForResult(intent, AVATAR_GALLERY);
    }

    public static String SDPATH = null;//图片目录

    /**
     * 获得图片文件夹
     */
    public static String getImagesFilePath(Context context) {
        SDPATH = getSavePath(context, "images");
        return SDPATH;
    }

    /**
     * 获得文件存储的绝对路径
     *
     * @param context
     * @param dirName 可传 image,voice,errorLog
     * @return
     */
    private static String getSavePath(Context context, String dirName) {
        String path;
        if (Environment.MEDIA_MOUNTED.equals(Environment.getExternalStorageState())) {
            //有SD卡
            path = Environment.getExternalStorageDirectory()
                    + File.separator
                    + "Android"
                    + File.separator
                    + "Data"
                    + File.separator
                    + context.getPackageName()
                    + File.separator
                    + dirName
                    + File.separator;
        } else {
            //无SD卡
            path = context.getFilesDir().getAbsolutePath() + File.separator + dirName + File.separator;
        }
        File file = new File(path);
        if (!file.exists()) {
            file.mkdirs();
        }
        return path;
    }

    /**
     * 拍照
     *
     * @param context Activity
     */
    public static void startCamera(Activity context) {
        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        PHOTO_PATH = Environment.getExternalStorageDirectory().getPath() + "/MyApp/temp/IMG_" + (System.currentTimeMillis() + ".jpg");
        File temp = new File(PHOTO_PATH);
//        File imageStorageDir = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES), "MyApp");
//        File temp = new File(imageStorageDir + File.separator + "IMG_" + String.valueOf(System.currentTimeMillis()) + ".jpg");
        if (!temp.getParentFile().exists()) {
            temp.getParentFile().mkdirs();
        }
        if (temp.exists()) {
            temp.delete();
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            //添加这一句表示对目标应用临时授权该Uri所代表的文件
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            intent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
            // 通过FileProvider创建一个content类型的Uri
            PHOTO_URI = FileProvider.getUriForFile(context, "xengine.provider", temp);
        } else {
            PHOTO_URI = Uri.fromFile(temp);
        }
        intent.putExtra(MediaStore.EXTRA_OUTPUT, PHOTO_URI);
        context.startActivityForResult(intent, RESULT_CODE_CAMERA);
    }

    /**
     * 打开相册
     *
     * @param context Activity
     */
    public static void startAlbum(Activity context) {
        Intent albumIntent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
        albumIntent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
        albumIntent.setDataAndType(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, "image/*");
        context.startActivityForResult(albumIntent, RESULT_CODE_PHOTO);
    }

    /**
     * 拍照结束后
     */
    public static void afterOpenCamera(String imagePaths, Context context) {
        File f = new File(imagePaths);
        addImageGallery(f, context);
    }

    /**
     * 解决拍照后在相册中找不到的问题
     */
    public static void addImageGallery(File file, Context context) {
        ContentValues values = new ContentValues();
        values.put(MediaStore.Images.Media.DATA, file.getAbsolutePath());
        values.put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg");
        context.getContentResolver().insert(
                MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);
    }

    /**
     * 解决小米手机上获取图片路径为null的情况
     *
     * @param intent
     * @return
     */
    public static Uri geturi(Intent intent, Context context) {
        Uri uri = intent.getData();
        String type = intent.getType();
        if (null != uri && null != type) {
            if (uri.getScheme().equals("file") && (type.contains("image/"))) {
                String path = uri.getEncodedPath();
                if (path != null) {
                    path = Uri.decode(path);
                    ContentResolver cr = context.getContentResolver();
                    StringBuilder buff = new StringBuilder();
                    buff.append("(").append(MediaStore.Images.ImageColumns.DATA).append("=")
                            .append("'" + path + "'").append(")");
                    Cursor cur = cr.query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                            new String[]{MediaStore.Images.ImageColumns._ID},
                            buff.toString(), null, null);
                    int index = 0;
                    for (cur.moveToFirst(); !cur.isAfterLast(); cur.moveToNext()) {
                        index = cur.getColumnIndex(MediaStore.Images.ImageColumns._ID);
                        index = cur.getInt(index);
                    }
                    if (index == 0) {
                        // do nothing
                    } else {
                        Uri uri_temp = Uri.parse("content://media/external/images/media/" + index);
                        if (uri_temp != null) {
                            uri = uri_temp;
                        }
                    }
                }
            }
        }
        return uri;
    }

    public static boolean isImage(String path) {
        if (TextUtils.isEmpty(path)) {
            return false;
        }

        String pathlower = path.toLowerCase();

        if (pathlower.endsWith(".jpg") ||
                pathlower.endsWith(".png") ||
                pathlower.endsWith(".gif") ||
                pathlower.endsWith(".jpeg") ||
                pathlower.endsWith(".bpm")) {
            return true;
        }
        return false;
    }


}