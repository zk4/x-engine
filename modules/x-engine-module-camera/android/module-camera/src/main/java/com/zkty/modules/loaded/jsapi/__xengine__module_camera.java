package com.zkty.modules.loaded.jsapi;

import android.Manifest;
import android.app.Activity;
import android.app.Dialog;
import android.content.ClipData;
import android.content.Context;
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
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.FileProvider;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.dsbridge.OnReturnValue;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.core.IApplicationListener;
import com.zkty.modules.engine.exception.XEngineException;
import com.zkty.modules.engine.imp.ImagePicker;
import com.zkty.modules.engine.provider.XEngineProvider;
import com.zkty.modules.engine.utils.FileUtils;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.loaded.ClientManager;
import com.zkty.modules.loaded.EditArgs;

import com.zkty.modules.loaded.widget.dialog.BottomDialog;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;



public class __xengine__module_camera extends xengine__module_camera implements IApplicationListener {
    private static final String TAG = "XEngine__module_camera";


    private XEngineWebActivity.LifecycleListener lifeCycleListener;
    private int REQUEST_OBTAIN_PIC = 1;

    private CameraDTO cameraDTO;
    private EditArgs editArgs;

    private static int REQUEST_CAMERA = 10;     //启动相机
    private static int REQUEST_ALBUM = 11;      //启动相册
    private static int REQUEST_CROP = 12;       //启动裁剪

    private static int PERMISSION_REQUEST_CAMERA = 20;


    private File out;


    @Override
    public void onAppCreate(Context context) {
        Log.d(TAG, "onAppCreate()");
    }

    @Override
    public void onAppLowMemory() {
        Log.d(TAG, "onAppLowMemory()");
    }

    @Override
    public String moduleId() {
        return "com.zkty.module.camera";
    }

    @Override
    public void onAllModulesInited() {
        super.onAllModulesInited();
    }


    /**
     * dto.args:{width:"", height:"", quality:"", bytes:""} //
     *
     * @param dto
     * @param handler
     */
    @Override
    public void _openImagePicker(final CameraDTO dto, final CompletionHandler<CameraRetDTO> handler) {
        Log.d(TAG, "receive object:" + JSONObject.toJSONString(dto));
        cameraDTO = dto;
//        //test
//        cameraDTO.allowsEditing = false;
//        cameraDTO.savePhotosAlbum = false;
//        cameraDTO.cameraDevice = "front";

        editArgs = new EditArgs();
        if (cameraDTO.args != null) {
            if (cameraDTO.args.containsKey("width")) {
                editArgs.setWidth(cameraDTO.args.get("width"));
            }
            if (cameraDTO.args.containsKey("height")) {
                editArgs.setHeight(cameraDTO.args.get("height"));
            }
            if (cameraDTO.args.containsKey("quality")) {
                editArgs.setQuality(cameraDTO.args.get("quality"));
            }
            if (cameraDTO.args.containsKey("bytes")) {
                editArgs.setBytes(cameraDTO.args.get("bytes"));
            }
        }

        out = null;
        final XEngineWebActivity act = (XEngineWebActivity) XEngineWebActivityManager.sharedInstance().getCurrent();
        if (lifeCycleListener == null) {
            lifeCycleListener = new XEngineWebActivity.LifecycleListener() {
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

                            if (mXEngineWebView != null && items != null) {
                                String path = items.get(0);                 //原始文件位置
                                File file = new File(path);
                                Log.d(TAG, file.getParent() + "---" + file.getName());

//                                mXEngineWebView.callHandler(dto.__event__, new Object[]{path}, new OnReturnValue<Object>() {
//                                    @Override
//                                    public void onValue(Object retValue) {
//
//                                    }
//                                });

                                setResult(act, path, editArgs, handler);           //设置数据返回
                            } else {
                                throw new XEngineException("XEngineWebView is null!");
                            }
                        } else if (requestCode == REQUEST_CAMERA) {                 //相机返回
                            Log.d(TAG, "camera:---path:" + out.getPath());

                            if (cameraDTO.savePhotosAlbum) {                //保存到相册功能需要适配
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
                                if (cameraDTO.allowsEditing) {
                                    crop(act, FileProvider.getUriForFile(act, XEngineProvider.getProvider(), out), out.getParentFile(), out.getName(), editArgs);
                                } else {
                                    if (mXEngineWebView != null) {
//                                        mXEngineWebView.callHandler(dto.__event__, new Object[]{out.getPath()}, new OnReturnValue<Object>() {
//                                            @Override
//                                            public void onValue(Object retValue) {
//
//                                            }
//                                        });

                                        setResult(act, out.getPath(), editArgs, handler);           //设置数据返回
                                    } else {
                                        throw new XEngineException("XEngineWebView is null!");
                                    }
                                }
                            }
                        } else if (requestCode == REQUEST_ALBUM) {                  //相册返回
                            Uri uri = data.getData();
                            Log.d(TAG, "album:" + uri.toString());
                            try {
                                long timestamp = System.currentTimeMillis();
                                out = new File(act.getCacheDir(), "temp_" + timestamp + ".jpg");

                                String file = FileUtils.saveFile(act.getContentResolver().openInputStream(uri), out.getParentFile(), out.getName());          //读取相册原始文件并保存到缓存目录

                                if (!TextUtils.isEmpty(file)) {
                                    Log.d(TAG, "out:" + out.getPath());

                                    if (cameraDTO.allowsEditing) {              //编辑
                                        crop(act, uri, out.getParentFile(), out.getName(), editArgs);
                                    } else {                                    //直接返回
                                        if (mXEngineWebView != null && out.exists()) {
//                                            mXEngineWebView.callHandler(dto.__event__, new Object[]{out.getPath()}, new OnReturnValue<Object>() {
//                                                @Override
//                                                public void onValue(Object retValue) {
//
//                                                }
//                                            });
                                            setResult(act, out.getPath(), editArgs, handler);           //设置数据返回
                                        } else {
                                            throw new XEngineException("XEngineWebView is null!");
                                        }
                                    }
                                }
                            } catch (Exception e) {

                            }
                        } else if (requestCode == REQUEST_CROP) {                   //裁剪返回
                            Log.d(TAG, "crop:");

                            if (mXEngineWebView != null && out.exists()) {
                                String path = out.getPath();
                                Log.d(TAG, "crop:" + path);
//
//                                mXEngineWebView.callHandler(dto.__event__, new Object[]{base64}, new OnReturnValue<Object>() {
//                                    @Override
//                                    public void onValue(Object retValue) {
//                                        Log.d(TAG, "result:" + System.currentTimeMillis());
//                                    }
//                                });
                                setResult(act, path, editArgs, handler);           //设置数据返回
                            } else {
                                throw new XEngineException("XEngineWebView is null!");
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
        }
        act.addLifeCycleListener(lifeCycleListener);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && act.checkSelfPermission(Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
            act.requestPermissions(new String[]{Manifest.permission.CAMERA}, PERMISSION_REQUEST_CAMERA);
        } else {
            showDialog(act);
        }

//        ImagePicker.getInstance()
//                .setTitle("选择图片")//设置标题
//                .showCamera(true)//设置是否显示拍照按钮
//                .showImage(true)//设置是否展示图片
//                .showVideo(false)//设置是否展示视频
//                .filterGif(true)//设置是否过滤gif图片
//                .setMaxCount(1)//设置最大选择图片数目(默认为1，单选)
//                .setSingleType(true)//设置图片视频不能同时选择
//                .setImageLoader(new GlideLoader())//设置自定义图片加载器
//                .start(act, REQUEST_OBTAIN_PIC);//REQEST_SELECT_IMAGES_CODE为Intent调用的requestCode
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
        if (!TextUtils.isEmpty(cameraDTO.cameraDevice) && cameraDTO.cameraDevice.equals("front")) {
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
        Intent intent = new Intent(Intent.ACTION_PICK);
        intent.setType("image/*");
        activity.startActivityForResult(intent, REQUEST_ALBUM);
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
        Intent intent = new Intent("com.android.camera.action.CROP");
        intent.setDataAndType(uri, "image/*");
        intent.putExtra("crop", "true");

        Uri photoUri;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
            photoUri = FileProvider.getUriForFile(activity, XEngineProvider.getProvider(), new File(dir, fileName));
            intent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION | Intent.FLAG_GRANT_READ_URI_PERMISSION);
            intent.setClipData(ClipData.newRawUri(MediaStore.EXTRA_OUTPUT, photoUri));
        } else {
            photoUri = Uri.fromFile(new File(dir, fileName));
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
        intent.putExtra("return-data", true);
        activity.startActivityForResult(intent, REQUEST_CROP);
    }


    /**
     * @param activity
     * @param path
     */
    private void setResult(Activity activity, String path, EditArgs editArgs, final CompletionHandler<CameraRetDTO> handler) {
        if (mXEngineWebView != null) {
            CameraRetDTO cameraRetDTO = new CameraRetDTO();
            if (cameraDTO.isbase64) {
                cameraRetDTO.retImage = ClientManager.imageToBase64(path);
//                cameraRetDTO.retImage = "data:image/jpeg;base64," + ClientManager.imageToBase64(path);
            } else {
                cameraRetDTO.retImage = path;
            }
            cameraRetDTO.contentType = "image/jpeg";
            File temp = new File(path);
            if (temp.exists())
                cameraRetDTO.fileName = temp.getName();

            mXEngineWebView.callHandler(cameraDTO.__event__, new Object[]{new String[]{JSON.toJSONString(cameraRetDTO)}}, new OnReturnValue<CameraRetDTO>() {
                @Override
                public void onValue(CameraRetDTO retValue) {
                    Log.d(TAG, "result:" + System.currentTimeMillis());
                }
            });
        }
    }
}
