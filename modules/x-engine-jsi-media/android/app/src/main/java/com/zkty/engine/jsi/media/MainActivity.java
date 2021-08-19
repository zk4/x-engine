package com.zkty.engine.jsi.media;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.TextView;


import androidx.appcompat.app.AppCompatActivity;

import com.anthonynsimon.url.URL;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.utils.ImageUtils;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.jsi.utils.UrlUtils;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.media.Imedia;
import com.zkty.nativ.media.Nativemedia;
import com.zkty.nativ.media.PreImageCallBack;
import com.zkty.nativ.media.cameraImpl.GlideLoader;
import com.zkty.nativ.media.cameraImpl.ImagePicker;
import com.zkty.nativ.media.cameraImpl.data.MediaFile;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import okhttp3.Callback;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;

public class MainActivity extends AppCompatActivity {

    private TextView tvMsg;
    private Nativemedia iMedia;
    private String filePath;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tvMsg = findViewById(R.id.tvMsg);
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Imedia.class);
        if (module instanceof Nativemedia)
            iMedia = (Nativemedia) module;
    }

    public void media(View view) {
        pushMicroapp("http://10.2.47.9:9111");
    }

    public void openImg(View view) {
        ImagePicker.getInstance()
                .setTitle("选择图片")//设置标题
                .showCamera(true)//设置是否显示拍照按钮
                .showImage(true)//设置是否展示图片
                .showVideo(false)//设置是否展示视频
                .filterGif(true)//设置是否过滤gif图片
                .setMaxCount(1)//设置最大选择图片数目(默认为1，单选)
                .setSingleType(true)//设置图片视频不能同时选择
                .setImageLoader(new GlideLoader())//设置自定义图片加载器
                .start(MainActivity.this, ImageUtils.RESULT_CODE_PHOTO);//REQEST_SELECT_IMAGES_CODE为Intent调用的requestCode
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
        doUpload("https://api-uat.lohashow.com/gm-nxcloud-resource/api/nxcloud/res/upload",new FileProgressRequestBody.OnUploadListener() {
            @Override
            public void onUploadSuccess() {
                Log.d("MainActivity","上传成功" );
            }

            @Override
            public void onUploading(int progress) {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        tvMsg.setText(progress + "%");
                    }
                });
                Log.d("MainActivity",progress + "%" );
            }

            @Override
            public void onUploadFailed() {
                Log.d("MainActivity","上传失败" );
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
