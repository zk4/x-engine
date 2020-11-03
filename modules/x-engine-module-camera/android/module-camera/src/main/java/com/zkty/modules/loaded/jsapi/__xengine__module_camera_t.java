package com.zkty.modules.loaded.jsapi;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.util.Base64;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSONObject;
import com.yalantis.ucrop.UCrop;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.dsbridge.OnReturnValue;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.core.IApplicationListener;
import com.zkty.modules.engine.exception.XEngineException;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.loaded.imp.GlideLoader;
import com.zkty.modules.loaded.imp.ImagePicker;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class __xengine__module_camera_t extends xengine__module_camera implements IApplicationListener {
    private static final String TAG = "XEngine__module_camera";


    private XEngineWebActivity.LifecycleListener lifeCycleListener;
    private int REQUEST_OBTAIN_PIC = 1;

    private CameraDTO cameraDTO;

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


    @Override
    public void _openImagePicker(final CameraDTO dto, final CompletionHandler<CameraRetDTO> handler) {
        Log.d(TAG, "receive object:" + JSONObject.toJSONString(dto));
        cameraDTO = dto;
//        //test
//        cameraDTO.allowsEditing = false;
//        cameraDTO.savePhotosAlbum = false;
//        cameraDTO.cameraDevice = "front";

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


                            if (dto.allowsEditing) {          //需要裁剪
                                if (mXEngineWebView != null && items != null && !items.isEmpty()) {
                                    long timestamp = System.currentTimeMillis();
                                    out = new File(act.getCacheDir(), "temp_" + timestamp + ".jpg");
                                    UCrop.of(Uri.fromFile(new File(items.get(0))), Uri.fromFile(out))
                                            .withAspectRatio(1, 1)
                                            .withMaxResultSize(720, 720)
                                            .start(act);
                                }
                            } else {     //不需要裁剪
                                if (mXEngineWebView != null && items != null && !items.isEmpty()) {
                                    String path = items.get(0);
                                    Bitmap bitmap = BitmapFactory.decodeFile(path);

                                    CameraRetDTO ret = new CameraRetDTO();
                                    ret.retImage = bmpToBase64(bitmap);
                                    handler.complete(ret);
                                }
                            }

//                            if (mXEngineWebView != null && items != null) {
//                                String path = items.get(0);                 //原始文件位置
//                                File file = new File(path);
//                                Log.d(TAG, file.getParent() + "---" + file.getName());
//
//                                mXEngineWebView.callHandler(dto.__event__, new Object[]{path}, new OnReturnValue<Object>() {
//                                    @Override
//                                    public void onValue(Object retValue) {
//
//                                    }
//                                });
//                            } else {
//                                throw new XEngineException("XEngineWebView is null!");
//                            }
                        } else if (requestCode == UCrop.REQUEST_CROP) {
                            final Uri resultUri = UCrop.getOutput(data);
                            if (mXEngineWebView != null && resultUri != null) {
                                Log.d(TAG, "result:" + resultUri.getPath());
                            }
                        }
                    }
                }

                @Override
                public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {

                }
            };
        }
        act.addLifeCycleListener(lifeCycleListener);

        ImagePicker.getInstance()
                .setTitle("选择图片")//设置标题
                .showCamera(true)//设置是否显示拍照按钮
                .showImage(true)//设置是否展示图片
                .showVideo(false)//设置是否展示视频
                .filterGif(true)//设置是否过滤gif图片
                .setMaxCount(1)//设置最大选择图片数目(默认为1，单选)
                .setSingleType(true)//设置图片视频不能同时选择
                .setImageLoader(new GlideLoader())//设置自定义图片加载器
                .start(act, REQUEST_OBTAIN_PIC);//REQEST_SELECT_IMAGES_CODE为Intent调用的requestCode
    }


    /**
     * bitmap转Base64
     *
     * @param bitmap
     * @return
     */
    public static String bmpToBase64(Bitmap bitmap) {
        String result = null;
        ByteArrayOutputStream baos = null;
        try {
            if (bitmap != null) {
                baos = new ByteArrayOutputStream();
                bitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos);
                baos.flush();
                baos.close();
                byte[] bitmapBytes = baos.toByteArray();
                result = Base64.encodeToString(bitmapBytes, Base64.DEFAULT);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (baos != null) {
                    baos.flush();
                    baos.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

}
