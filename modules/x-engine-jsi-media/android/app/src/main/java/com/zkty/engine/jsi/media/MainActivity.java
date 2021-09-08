package com.zkty.engine.jsi.media;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.anthonynsimon.url.URL;
import com.bumptech.glide.Glide;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.utils.ImageUtils;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.jsi.utils.UrlUtils;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.media.CameraDTO;
import com.zkty.nativ.media.CameraRetDTO;
import com.zkty.nativ.media.Imedia;
import com.zkty.nativ.media.Nativemedia;
import com.zkty.nativ.media.OpenImageCallBack;
import com.zkty.nativ.media.PreImageCallBack;
import com.zkty.nativ.media.UpLoadImgCallback;
import com.zkty.nativ.media.cameraImpl.ImageCacheManager;
import com.zkty.nativ.media.cameraImpl.ImagePicker;
import com.zkty.nativ.media.cameraImpl.UploadUtils;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import okhttp3.Callback;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;

public class MainActivity extends BaseXEngineActivity {

    private TextView tvMsg;
    private Nativemedia iMedia;
    private String filePath;
    private ImageView ivImg,ivImg2,ivImg3;
    private ImageDataBean imageDataBean;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tvMsg = findViewById(R.id.tvMsg);
        ivImg = findViewById(R.id.ivImg);
        ivImg2 = findViewById(R.id.ivImg2);
        ivImg3 = findViewById(R.id.ivImg3);
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Imedia.class);
        if (module instanceof Nativemedia)
            iMedia = (Nativemedia) module;
    }

    public void media(View view) {
        pushMicroapp("http://10.2.47.9:9111");
    }

    public void openImg(View view) {

        CameraDTO cameraDTO = new CameraDTO();
        cameraDTO.setAllowsEditing(false);
        cameraDTO.setCameraDevice("back");
        cameraDTO.setCameraFlashMode(-1);
        cameraDTO.setIsbase64(false);
        cameraDTO.setPhotoCount(3);
        cameraDTO.setSavePhotosAlbum(false);

        HashMap<String, String> map = new HashMap<>();
        map.put("bytes","100");
        cameraDTO.setArgs(map);

        iMedia.openImagePicker(cameraDTO, new OpenImageCallBack() {

            @Override
            public void success(String data) {
                imageDataBean = GsonUtil.fromJson(data, ImageDataBean.class);

                if(imageDataBean.getData().size() > 0){

                    String base64DataStr = imageDataBean.getData().get(0).getThumbnail();
                    ivImg.setImageBitmap(getBitmap(base64DataStr));
                    filePath = ImageCacheManager.get(imageDataBean.getData().get(0).getId());
//                    filePath = imageDataBean.getData().get(0).getId();
//                    Glide.with(MainActivity.this).load(new File(filePath)).into(ivImg);
                }
                if(imageDataBean.getData().size() > 1){
                    String base64DataStr = imageDataBean.getData().get(1).getThumbnail();
                    ivImg2.setImageBitmap(getBitmap(base64DataStr));
                }
                if(imageDataBean.getData().size() > 2){
                    String base64DataStr = imageDataBean.getData().get(2).getThumbnail();
                    ivImg3.setImageBitmap(getBitmap(base64DataStr));
                }
            }
        });

        ivImg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ArrayList<String> images = new ArrayList<>();
                for (CameraRetDTO datum : imageDataBean.getData()) {
                    images.add(datum.getId());
                }
                iMedia.preImage(images, 0, new PreImageCallBack() {
                    @Override
                    public void closeCallBack() {
                        ToastUtils.showCenterToast("关闭");
                    }
                });
            }
        });


        ivImg2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ArrayList<String> images = new ArrayList<>();
                for (CameraRetDTO datum : imageDataBean.getData()) {
                    images.add(datum.getId());
                }
                iMedia.preImage(images, 1, new PreImageCallBack() {
                    @Override
                    public void closeCallBack() {
                        ToastUtils.showCenterToast("关闭");
                    }
                });
            }
        });

        ivImg3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ArrayList<String> images = new ArrayList<>();
                for (CameraRetDTO datum : imageDataBean.getData()) {
                    images.add(datum.getId());
                }
                iMedia.preImage(images, 2, new PreImageCallBack() {
                    @Override
                    public void closeCallBack() {
                        ToastUtils.showCenterToast("关闭");
                    }
                });
            }
        });




    }

    public Bitmap getBitmap(String base64DataStr){
        String base64Str = base64DataStr.substring(base64DataStr.indexOf(",") + 1, base64DataStr.length());
        byte[] bytes = Base64.decode(base64Str, Base64.DEFAULT);
        Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
        return bitmap;
    }

    public void preImg(View view) {

        ArrayList<String> images = new ArrayList<>();
        images.add("https://upload-images.jianshu.io/upload_images/5809200-a99419bb94924e6d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240");
        images.add("https://upload-images.jianshu.io/upload_images/5809200-736bc3917fe92142.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240");
        images.add("https://upload-images.jianshu.io/upload_images/5809200-7fe8c323e533f656.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240");

        iMedia.preImage(images, 1, new PreImageCallBack() {
            @Override
            public void closeCallBack() {
                ToastUtils.showCenterToast("关闭");
            }
        });


    }
    public void upload(View view){
        if(TextUtils.isEmpty(filePath)) return;
        List<String> ids = new ArrayList<>();
        for (int i = 0; i < imageDataBean.getData().size(); i++) {
            ids.add(imageDataBean.getData().get(i).getId());
        }
        iMedia.upLoadImgList(UploadUtils.upLoadUrl,ids, new UpLoadImgCallback() {

            @Override
            public void onUpLoadSucces(String status, String id, String dataStr) {
                Map<String, String> jsonObject = new LinkedHashMap<>();
                jsonObject.put("status", status);
                jsonObject.put("id", id);
                jsonObject.put("result", dataStr);
                Log.d("Nativemediadata", GsonUtil.toJson(jsonObject));
            }

            @Override
            public void onUploadFail() {
                Log.d("Nativemedia","上传失败");
            }
        });
    }


    private void doUpload(String url, FileProgressRequestBody.OnUploadListener fileUploadObserver) {
        try {
            // 构造上传请求，模拟表单提交文件
            File file = new File(filePath);
            FileProgressRequestBody filePart = new FileProgressRequestBody(file,fileUploadObserver);


            MultipartBody requestBody = new MultipartBody.Builder()
                    .setType(MultipartBody.FORM)
                    .addFormDataPart("file",file.getName(),filePart)
                    .build();

            // 创建Request对象
            Request request = new Request.Builder()
                    .url(url)
                    .post(requestBody)
                    .build();

            OkHttpClient httpClient = new OkHttpClient.Builder()
                    //time out
                    .connectTimeout(100, TimeUnit.SECONDS)
                    .readTimeout(100, TimeUnit.SECONDS)
                    .writeTimeout(100, TimeUnit.SECONDS)
                    //失败重连
                    .retryOnConnectionFailure(true)
                    .build();
            httpClient.newCall(request).enqueue(new Callback() {
                @Override
                public void onFailure(okhttp3.Call call, IOException e) {
                    // 下载失败
                    Log.d("MainActivity","上传失败" + e.getMessage());
                }

                @Override
                public void onResponse(okhttp3.Call call, Response response) throws IOException {

                    ResponseBody body = response.body();
                    byte[] bytes = body.bytes();
                    //解密字符串
                    String dataStr = new String(bytes, "UTF-8");

                    Log.d("MainActivity","上传成功" + dataStr);
                }
            });
        } catch (Exception ioe) {
        }
    }



    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            switch (requestCode) {
                case ImageUtils.RESULT_CODE_PHOTO:
                    try {
                        ArrayList<String> items = data.getStringArrayListExtra(ImagePicker.EXTRA_SELECT_IMAGES);
                        tvMsg.setText(items.get(0));
                        filePath = items.get(0);
                        //发送图片消息
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
            }
        }
    }

    public void pushMicroapp(String url) {
        try {
            Map<String, String> params = new HashMap<>();
            params.put("hideNavbar", "true");
            URL url1 = URL.parse(url);
            String scheme = url1.getScheme();

            XEngineWebActivityManager.sharedInstance().startXEngineActivity(MainActivity.this,scheme+  ":", url1.getHost(), url1.getPath(), url1.getFragment(), UrlUtils.getQueryMapFormString(url1.getQuery()), true);

            //URL解析的 fragment 包含query，eg：/mall2/orderlist?selectedIndex=0，故query传null
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
