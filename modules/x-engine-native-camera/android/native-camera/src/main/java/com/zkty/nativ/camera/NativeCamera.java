package com.zkty.nativ.camera;

import android.Manifest;
import android.app.Activity;
import android.content.ClipData;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.hardware.Camera;
import android.media.MediaScannerConnection;
import android.net.Uri;
import android.os.Build;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.FileProvider;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.zkty.nativ.camera.cameraImpl.GlideLoader;
import com.zkty.nativ.camera.cameraImpl.ImagePicker;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.ImageUtils;
import com.zkty.nativ.core.utils.XEngineProvider;
import com.zkty.nativ.jsi.exception.XEngineException;
import com.zkty.nativ.jsi.utils.FileUtils;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.LifecycleListener;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.ui.view.dialog.BottomDialog;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class NativeCamera extends NativeModule implements ICamera {
    private static final String TAG = "NativeCamera";


    private LifecycleListener lifeCycleListener;
    private int REQUEST_OBTAIN_PIC = 1;

    private CameraDTO cameraDTO;
    private EditArgs editArgs;

    private static int REQUEST_CAMERA = 0x510;     //启动相机
    private static int REQUEST_ALBUM = 0x511;      //启动相册
    private static int REQUEST_ALBUM_MUILTE = 0x513;      //启动相册选取多张
    private static int REQUEST_CROP = 0x512;       //启动裁剪

    private static int PERMISSION_REQUEST_CAMERA = 20;

    OpenImageCallBack callBack;

    private File out;
    private File outCrop;

    @Override
    public String moduleId() {
        return "com.zkty.native.camera";
    }

    @Override
    public void openImagePicker(CameraDTO dto, OpenImageCallBack callBack) {
        this.callBack = callBack;
        Log.d(TAG, "receive object:" + JSONObject.toJSONString(dto));
        cameraDTO = dto;
        editArgs = new EditArgs();
        if (cameraDTO.getArgs() != null) {
            if (cameraDTO.getArgs().containsKey("width")) {
                editArgs.setWidth(cameraDTO.getArgs().get("width"));
            }
            if (cameraDTO.getArgs().containsKey("height")) {
                editArgs.setHeight(cameraDTO.getArgs().get("height"));
            }
            if (cameraDTO.getArgs().containsKey("quality")) {
                editArgs.setQuality(cameraDTO.getArgs().get("quality"));
            }
            if (cameraDTO.getArgs().containsKey("bytes")) {
                editArgs.setBytes(cameraDTO.getArgs().get("bytes"));
            }
            if (cameraDTO.getPhotoCount() > 0) {
                editArgs.setPhotoCount(cameraDTO.getPhotoCount());
            }
        }

        out = null;
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
                act.removeLifeCycleListener(lifeCycleListener);
                lifeCycleListener = null;
            }

            @Override
            public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
                Log.d(TAG, "onActivityResult---" + "requestCode:" + requestCode + "---resultCode:" + resultCode);

                if (resultCode == Activity.RESULT_OK) {
                    if (requestCode == REQUEST_OBTAIN_PIC) {
                        ArrayList<String> items = data.getStringArrayListExtra(ImagePicker.EXTRA_SELECT_IMAGES);
                        StringBuffer stringBuffer = new StringBuffer();
                        stringBuffer.append("当前选中图片路径：\n");
                        for (int i = 0; i < items.size(); i++) {
                            stringBuffer.append(items.get(i) + "\n");
                        }
                        Log.d(TAG, "selected:" + stringBuffer.toString());

                        if (items != null) {
                            String path = items.get(0);                 //原始文件位置

                            ArrayList<String> paths = new ArrayList<>();
                            items.add(path);
                            setResult(paths);
                        } else {
                            throw new XEngineException("XEngineWebView is null!");
                        }
                    } else if (requestCode == REQUEST_CAMERA) {                 //相机返回
                        Log.d(TAG, "camera:---path:" + out.getPath());

                        if (cameraDTO.isAllowsEditing()) {                //保存到相册功能需要适配
                            // 其次把文件插入到系统图库
                            try {
                                MediaStore.Images.Media.insertImage(act.getContentResolver(), out.getAbsolutePath(), out.getName(), null);
                            } catch (FileNotFoundException e) {
                                e.printStackTrace();
                            }

                            // 最后通知图库更新
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) { // 判断SDK版本是不是4.4或者高于4.4
                                String[] paths = new String[]{out.getPath()};
                                MediaScannerConnection.scanFile(act, paths, null, null);
                            } else {
                                Intent intent = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
                                intent.setData(Uri.fromFile(out));
                                act.sendBroadcast(intent);
                            }
                        }

                        if (out.exists()) {
                            if (cameraDTO.isAllowsEditing()) {
                                crop(act, FileProvider.getUriForFile(act, XEngineProvider.getProvider(), out), out.getParentFile(), out.getName(), editArgs);
                            } else {
                                ArrayList<String> items = new ArrayList<>();
                                items.add(out.getPath());
                                setResult(items);

                            }
                        }
                    } else if (requestCode == REQUEST_ALBUM) {                  //相册返回
                        Uri uri = data.getData();
                        Log.d(TAG, "album:" + uri.toString());
                        try {
                            long timestamp = System.currentTimeMillis();
//                                out = new File(act.getCacheDir(), "temp_" + timestamp + ".jpg");
//
//                                String file1 = FileUtils.saveFile(act.getContentResolver().openInputStream(uri), out.getParentFile(), out.getName());          //读取相册原始文件并保存到缓存目录
                            out = FileUtils.uri2File(uri);
                            if (out.exists()) {
                                Log.d(TAG, "out:" + out.getPath());

                                if (cameraDTO.isAllowsEditing()) {              //编辑
                                    crop(act, uri, out.getParentFile(), out.getName(), editArgs);
                                } else {                                    //直接返回
                                    ArrayList<String> items = new ArrayList<>();
                                    items.add(out.getPath());
                                    setResult(items);

                                }
                            }
                        } catch (Exception e) {

                        }
                    } else if (requestCode == REQUEST_CROP) {                   //裁剪返回
                        Log.d(TAG, "crop:");

                        if (outCrop.exists()) {
                            String path = outCrop.getPath();
                            Log.d(TAG, "outCrop:" + path);

                            ArrayList<String> items = new ArrayList<>();
                            items.add(path);
                            setResult(items);           //设置数据返回
                        } else {
                            throw new XEngineException("XEngineWebView is null!");
                        }
                    } else if (requestCode == REQUEST_ALBUM_MUILTE) {
                        ArrayList<String> items = data.getStringArrayListExtra(ImagePicker.EXTRA_SELECT_IMAGES);
                        if (items != null && items.size() > 0) {
                            setResult(items);
                        }

                    }
                }
            }

            @Override
            public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
                Log.d(TAG, "onRequestPermissionsResult" + requestCode);
                if (requestCode == PERMISSION_REQUEST_CAMERA) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        if (act.checkSelfPermission(Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED) {
                            showDialog(act);
                        }
                    }
                }
            }
        };
        act.addLifeCycleListener(lifeCycleListener);
//        }


        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && act.checkSelfPermission(Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
            act.requestPermissions(new String[]{Manifest.permission.CAMERA}, PERMISSION_REQUEST_CAMERA);
        } else {
            showDialog(act);
        }
    }

    /**
     * @param act
     */
    private void showDialog(final Activity act) {
        String[] sexItem = new String[]{"拍照", "从相册选择"};
        BottomDialog bottomDialog = new BottomDialog(act);
        bottomDialog.initDialog(null, null, sexItem, (view, which, l) -> {
            if (which == 0) {
                startCamera(act);
                bottomDialog.dismissDialog();
            } else if (which == 1) {
                startAlbum(act);
                bottomDialog.dismissDialog();
            } else {
                bottomDialog.dismissDialog();
            }
        });

        bottomDialog.showDialog();
    }

    /**
     * 启动相机
     *
     * @param activity
     */
    private void startCamera(Activity activity) {
        if (Camera.getNumberOfCameras() <= 0) {
            return;
        }
        out = new File(activity.getCacheDir(), "temp_" + System.currentTimeMillis() + ".jpg");

        Uri uri;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            uri = FileProvider.getUriForFile(activity, XEngineProvider.getProvider(), out);
        } else {
            uri = Uri.fromFile(out);
        }

        boolean hasFront = false, hasBack = false;
        Camera.CameraInfo cameraInfo = new Camera.CameraInfo();
        for (int i = 0; i < Camera.getNumberOfCameras(); i++) {
            Camera.getCameraInfo(i, cameraInfo);
            if (cameraInfo.facing == Camera.CameraInfo.CAMERA_FACING_FRONT) {
                hasFront = true;
            } else if (cameraInfo.facing == Camera.CameraInfo.CAMERA_FACING_BACK) {
                hasBack = true;
            }
        }

        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);// 启动系统相机
        if (!TextUtils.isEmpty(cameraDTO.getCameraDevice()) && cameraDTO.getCameraDevice().equals("front")) {
            if (hasFront) {
                intent.putExtra("android.intent.extras.CAMERA_FACING", Camera.CameraInfo.CAMERA_FACING_FRONT); // 调用前置摄像头
            } else {
                intent.putExtra("android.intent.extras.CAMERA_FACING", Camera.CameraInfo.CAMERA_FACING_BACK); // 调用后置摄像头
            }
        } else {
            if (hasBack) {
                intent.putExtra("android.intent.extras.CAMERA_FACING", Camera.CameraInfo.CAMERA_FACING_BACK); // 调用后置摄像头
            } else {
                intent.putExtra("android.intent.extras.CAMERA_FACING", Camera.CameraInfo.CAMERA_FACING_FRONT); // 调用前置摄像头
            }
        }
        intent.putExtra(MediaStore.EXTRA_OUTPUT, uri);
        activity.startActivityForResult(intent, REQUEST_CAMERA);
    }


    /**
     * 启动相册
     *
     * @param activity
     */
    private void startAlbum(Activity activity) {

        if (editArgs != null && editArgs.getPhotoCount() > 1) {

            ImagePicker.getInstance()
                    .setTitle("选择图片")//设置标题
                    .showCamera(false)//设置是否显示拍照按钮
                    .showImage(true)//设置是否展示图片
                    .showVideo(false)//设置是否展示视频
                    .filterGif(true)//设置是否过滤gif图片
                    .setMaxCount(editArgs.getPhotoCount())//设置最大选择图片数目(默认为1，单选)
                    .setSingleType(true)//设置图片视频不能同时选择
                    .setImageLoader(new GlideLoader())//设置自定义图片加载器
                    .start(activity, REQUEST_ALBUM_MUILTE);//REQEST_SELECT_IMAGES_CODE为Intent调用的requestCode


        } else {
            Intent intent = new Intent(Intent.ACTION_PICK);
            intent.setType("image/*");
            activity.startActivityForResult(intent, REQUEST_ALBUM);
        }
    }


    /**
     * 打开系统图片剪切
     *
     * @param activity
     * @param uri      需要裁剪的图片地址
     * @param dir      裁剪后输出的目录
     * @param fileName 裁剪后输出的文件名
     */
    private void crop(Activity activity, Uri uri, File dir, String fileName, EditArgs edit) {

        Log.d(TAG, "uri=" + uri.getPath());
        Intent intent = new Intent("com.android.camera.action.CROP");
        intent.setDataAndType(uri, "image/*");
        intent.putExtra("crop", "true");

        outCrop = new File(dir, System.currentTimeMillis() + ".jpg");
        try {
            if (outCrop.exists()) {
                outCrop.delete();
            }
            outCrop.createNewFile();
        } catch (IOException e) {
            e.printStackTrace();
        }

        Uri photoUri;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            photoUri = FileProvider.getUriForFile(activity, XEngineProvider.getProvider(), outCrop);
            intent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION | Intent.FLAG_GRANT_READ_URI_PERMISSION);
            intent.setClipData(ClipData.newRawUri(MediaStore.EXTRA_OUTPUT, photoUri));
        } else {
            photoUri = Uri.fromFile(outCrop);
        }

        intent.putExtra(MediaStore.EXTRA_OUTPUT, photoUri); //指定输出的文件路径及文件名
        intent.putExtra("outputFormat", Bitmap.CompressFormat.JPEG);

        if (edit != null) {
            Log.d(TAG, "args:" + edit.toString());
        } else {
            Log.d(TAG, "args: null");
        }
        if (edit != null && !TextUtils.isEmpty(edit.getWidth()) && Integer.parseInt(edit.getWidth()) > 0) {
            intent.putExtra("outputX", Integer.parseInt(edit.getWidth()));
            intent.putExtra("aspectX", Integer.parseInt(edit.getWidth()));
        } else {
            intent.putExtra("outputX", 720);
            intent.putExtra("aspectX", 1);
        }
        if (edit != null && !TextUtils.isEmpty(edit.getHeight()) && Integer.parseInt(editArgs.getHeight()) > 0) {
            intent.putExtra("outputY", Integer.parseInt(edit.getHeight()));
            intent.putExtra("aspectY", Integer.parseInt(edit.getHeight()));
        } else {
            intent.putExtra("outputY", 720);
            intent.putExtra("aspectY", 1);
        }

        intent.putExtra("scale", true);
        intent.putExtra("scaleUpIfNeeded", true);
        intent.putExtra("return-data", false);
        activity.startActivityForResult(intent, REQUEST_CROP);
    }


    private void setResult(List<String> paths) {


        List<CameraRetDTO> results = new ArrayList<>();
        for (int j = 0; j < paths.size(); j++) {
            BitmapFactory.Options options = new BitmapFactory.Options();
            options.inPreferredConfig = Bitmap.Config.ARGB_8888;
//                options.inJustDecodeBounds = true;

            CameraRetDTO cameraRetDTO = new CameraRetDTO();
            cameraRetDTO.setWidth(String.valueOf(options.outWidth));
            cameraRetDTO.setHeight(String.valueOf(options.outHeight));

            if (cameraDTO.isIsbase64()) {
                String ret = ClientManager.imageToBase64(paths.get(j));
                if (ret != null) {
                    cameraRetDTO.setRetImage(ret);
                } else {
                    cameraRetDTO.setRetImage(ClientManager.imageToBase64(XEngineWebActivityManager.sharedInstance().getCurrent(), paths.get(j)));
                }
            } else {
                cameraRetDTO.setRetImage(paths.get(j));
            }
            cameraRetDTO.setContentType("image/jpeg");
            File temp = new File(paths.get(j));
            if (temp.exists())
                cameraRetDTO.setFileName(temp.getName());

            results.add(cameraRetDTO);
        }
        HashMap<String, List<CameraRetDTO>> map = new HashMap<>();
        map.put("data", results);
        callBack.success(JSON.toJSONString(map));

    }


    @Override
    public void saveImageToAlbum(String imageData, String type, SaveCallBack callBack) {
        Activity activity = XEngineApplication.getCurrentActivity();
        if ("url".equals(type)) {
            ImageUtils.savePictureByUrl(activity, imageData);
        } else {
            ImageUtils.savePictureByBase64(activity, imageData);
        }
        callBack.saveCallBack();
    }
}
