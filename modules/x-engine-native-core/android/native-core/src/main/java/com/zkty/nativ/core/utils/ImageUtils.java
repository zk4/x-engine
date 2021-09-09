package com.zkty.nativ.core.utils;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.Base64;
import android.util.Log;
import android.widget.Toast;

import androidx.core.content.FileProvider;


import com.bumptech.glide.Glide;
import com.zkty.nativ.core.XEngineApplication;


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

/**
 * 作者 王磊
 * 日期 2018/3/13
 * 功能 头像获取工具类
 * 备注 复制AvatarHepler
 */
public class ImageUtils {

    public static final int AVATAR_TAKE_PHOTO = 100;
    public static final int AVATAR_CUT_PHOTO = 101;
    public static final int AVATAR_GALLERY = 102;
    public static final int RESULT_CODE_CAMERA = 201;
    public static final int RESULT_CODE_PHOTO = 202;

    public static int REQUEST_OBTAIN_PIC = 301;

    /**
     * 头像拍照
     */
    public static String headPath;
    public static Uri PHOTO_URI;
    public static String PHOTO_PATH;
    //android 10 适配
    private static boolean isAndroidQ = Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q;

    /**
     * 创建图片地址uri,用于保存拍照后的照片 Android 10以后使用这种方法
     */
    private static Uri createImageUri(Context context) {
        String status = Environment.getExternalStorageState();
        // 判断是否有SD卡,优先使用SD卡存储,当没有SD卡时使用手机存储
        if (status.equals(Environment.MEDIA_MOUNTED)) {
            return context.getContentResolver().insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, new ContentValues());
        } else {
            return context.getContentResolver().insert(MediaStore.Images.Media.INTERNAL_CONTENT_URI, new ContentValues());
        }
    }

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
            new File(ImageUtils.headPath).deleteOnExit();
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
        //添加这一句表示对目标应用临时授权该Uri所代表的文件
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        intent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
        if (isAndroidQ) {
            PHOTO_URI = createImageUri(context);
        } else {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {

                // 通过FileProvider创建一个content类型的Uri
                PHOTO_URI = FileProvider.getUriForFile(context, XEngineProvider.getProvider(), temp);
            } else {
                PHOTO_URI = Uri.fromFile(temp);
            }
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
     * 打开相册
     *
     * @param context Activity
     */
    public static void startAlbum2(Activity context) {
//        ImagePicker.getInstance()
//                .setTitle("选择图片")//设置标题
//                .showCamera(false)//设置是否显示拍照按钮
//                .showImage(true)//设置是否展示图片
//                .showVideo(false)//设置是否展示视频
//                .filterGif(true)//设置是否过滤gif图片
//                .setMaxCount(3)//设置最大选择图片数目(默认为1，单选)
//                .setSingleType(true)//设置图片视频不能同时选择
//                .setImageLoader(new GlideLoader())//设置自定义图片加载器
//                .start(context, RESULT_CODE_PHOTO);//REQEST_SELECT_IMAGES_CODE为Intent调用的requestCode
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

    public static Uri getMediaUriFromPath(Context context, String path) {
        Uri mediaUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
        Cursor cursor = context.getContentResolver().query(mediaUri,
                null,
                MediaStore.Images.Media.DISPLAY_NAME + "= ?",
                new String[]{path.substring(path.lastIndexOf("/") + 1)},
                null);

        Uri uri = null;
        if (cursor.moveToFirst()) {
            uri = ContentUris.withAppendedId(mediaUri,
                    cursor.getLong(cursor.getColumnIndex(MediaStore.Images.Media._ID)));
        }
        cursor.close();
        return uri;
    }


    public static boolean savePictureByBase64(Context context, String base64DataStr) {
        // 1.去掉base64中的前缀
        String base64Str = base64DataStr.substring(base64DataStr.indexOf(",") + 1, base64DataStr.length());

        byte[] bytes = Base64.decode(base64Str, Base64.DEFAULT);
        Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
        saveBitmap(context, bitmap, System.currentTimeMillis() + ".jpg");
        return true;
    }

    public static void savePictureByUrl(Context context, String photoUrls) {

        new Thread() {
            @Override
            public void run() {
                try {
                    if (!TextUtils.isEmpty(photoUrls)) {
                        Bitmap bitmap = GetImageInputStream(photoUrls);
                        saveBitmap(context, bitmap, System.currentTimeMillis() + ".jpg");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }


            }
        }.start();
    }

    private static Bitmap GetImageInputStream(String imageurl) {
        URL url;
        HttpURLConnection connection = null;
        Bitmap bitmap = null;
        try {
            url = new URL(imageurl);
            connection = (HttpURLConnection) url.openConnection();
            connection.setConnectTimeout(6000); //超时设置
            connection.setDoInput(true);
            connection.setUseCaches(false); //设置不使用缓存
            InputStream inputStream = connection.getInputStream();
            bitmap = BitmapFactory.decodeStream(inputStream);
            inputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bitmap;
    }


    /*
     * 保存文件，文件名为当前日期
     */
    public static boolean saveBitmap(Context context, Bitmap bitmap, String bitName) {
        String fileName;
        File file;
        String brand = Build.BRAND;

        if (brand.equals("xiaomi")) { // 小米手机brand.equals("xiaomi")
            fileName = Environment.getExternalStorageDirectory().getPath() + "/DCIM/Camera/" + bitName;
        } else if (brand.equalsIgnoreCase("Huawei")) {
            fileName = Environment.getExternalStorageDirectory().getPath() + "/DCIM/Camera/" + bitName;
        } else { // Meizu 、Oppo
            fileName = Environment.getExternalStorageDirectory().getPath() + "/DCIM/" + bitName;
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            saveSignImage(context, bitName, bitmap);
            return true;
        } else {
            Log.d("saveBitmap brand", "" + brand);
            file = new File(fileName);
        }
        if (file.exists()) {
            file.delete();
        }
        FileOutputStream out;
        try {
            out = new FileOutputStream(file);
            // 格式为 JPEG，照相机拍出的图片为JPEG格式的，PNG格式的不能显示在相册中
            if (bitmap.compress(Bitmap.CompressFormat.JPEG, 90, out)) {
                out.flush();
                out.close();
                // 插入图库
                ContentValues values = new ContentValues();
                values.put(MediaStore.Images.Media.DATA, file.getAbsolutePath());
                values.put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg");
                context.getContentResolver().insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);
            }
        } catch (Exception e) {
            e.printStackTrace();
            ToastUtils.showThreadToast("保存失败，请重试");
            return false;
        }
        ToastUtils.showThreadToast("保存成功");
        context.sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.parse("file://" + fileName)));
        return true;
    }


    //将文件保存到公共的媒体文件夹
//这里的filepath不是绝对路径，而是某个媒体文件夹下的子路径，和沙盒子文件夹类似
//这里的filename单纯的指文件名，不包含路径
    public static void saveSignImage(Context context, String fileName, Bitmap bitmap) {
        try {
            //设置保存参数到ContentValues中
            ContentValues contentValues = new ContentValues();
            //设置文件名
            contentValues.put(MediaStore.Images.Media.DISPLAY_NAME, fileName);
            //android Q中不再使用DATA字段，而用RELATIVE_PATH代替
            //RELATIVE_PATH是相对路径不是绝对路径
            //DCIM是系统文件夹，关于系统文件夹可以到系统自带的文件管理器中查看，不可以写没存在的名字
            contentValues.put(MediaStore.Images.Media.RELATIVE_PATH, "DCIM/");
            //contentValues.put(MediaStore.Images.Media.RELATIVE_PATH, "Music/signImage");

            contentValues.put(MediaStore.Images.Media.MIME_TYPE, "image/JPEG");
            //执行insert操作，向系统文件夹中添加文件
            //EXTERNAL_CONTENT_URI代表外部存储器，该值不变
            Uri uri = context.getContentResolver().insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, contentValues);
            if (uri != null) {
                //若生成了uri，则表示该文件添加成功
                //使用流将内容写入该uri中即可
                OutputStream outputStream = context.getContentResolver().openOutputStream(uri);
                if (outputStream != null) {
                    bitmap.compress(Bitmap.CompressFormat.JPEG, 90, outputStream);
                    outputStream.flush();
                    outputStream.close();
                    ToastUtils.showThreadToast("保存成功");

                }
            }
        } catch (Exception e) {
            ToastUtils.showThreadToast("保存失败，请重试");
        }
    }

    static byte[] bytes = null;

    public static byte[] getByteByImageUrl(Context context, String url) {

        if (TextUtils.isEmpty(url)) return null;


        new Thread() {
            @Override
            public void run() {
                Bitmap bitmap = null;
                try {
                    bitmap = Glide.with(context)
                            .asBitmap()
                            .load(url)
                            .into(100, 100).get();
                    if (bitmap != null) {
                        ByteArrayOutputStream stream = new ByteArrayOutputStream();
                        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
                        bytes = stream.toByteArray();
                    }

                } catch (ExecutionException e) {
                    e.printStackTrace();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }.start();
        return bytes;

    }

    public static void getBitmap(String path, int width, int height, BitmapCallback callback) {
        if (TextUtils.isEmpty(path)) callback.onFail();

        if (path.startsWith("http")) {
            new Thread() {
                @Override
                public void run() {
                    Bitmap bitmap = null;
                    try {
                        bitmap = Glide.with(XEngineApplication.getCurrentActivity())
                                .asBitmap()
                                .load(path)
                                .into(width, height).get();
                        if (bitmap != null) {

                            callback.onSuccess(bitmap);
//                            ByteArrayOutputStream stream = new ByteArrayOutputStream();
//                            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
//                            bytes = stream.toByteArray();
                        }

                    } catch (ExecutionException e) {
                        e.printStackTrace();
                        callback.onFail();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                        callback.onFail();
                    }
                }
            }.start();

        } else {
            try {
                byte[] bytes = Base64.decode(path, Base64.DEFAULT);
                callback.onSuccess(BitmapFactory.decodeByteArray(bytes, 0, bytes.length));
            } catch (Exception e) {
                callback.onFail();
            }

        }

    }


    public static void getBitmap(String path, BitmapCallback callback) {

        getBitmap(path, 250, 250, callback);
    }

    public static byte[] bitmapToBytes(Bitmap bitmap) {

        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
        return stream.toByteArray();
    }

    public interface BitmapCallback {
        void onSuccess(Bitmap bitmap);

        void onFail();

    }

}
