package com.zkty.engine.jsi.media2;

import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.anthonynsimon.url.URL;
import com.bumptech.glide.Glide;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.jsi.utils.UrlUtils;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.media2.CameraDTO;
import com.zkty.nativ.media2.CameraRetDTO;
import com.zkty.nativ.media2.Imedia2;
import com.zkty.nativ.media2.Nativemedia2;
import com.zkty.nativ.media2.OpenImageCallBack;
import com.zkty.nativ.media2.PreImageCallBack;
import com.zkty.nativ.media2.SaveCallBack;
import com.zkty.nativ.media2.UpLoadImgCallback;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class MainActivity extends BaseXEngineActivity {
    private TextView tvMsg;
    private Nativemedia2 iMedia;
    private String filePath;
    private ImageView ivImg,ivImg2,ivImg3;
    List<CameraRetDTO> imgData;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        tvMsg = findViewById(R.id.tvMsg);
        ivImg = findViewById(R.id.ivImg);
        ivImg2 = findViewById(R.id.ivImg2);
        ivImg3 = findViewById(R.id.ivImg3);

        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Imedia2.class);
        if (module instanceof Nativemedia2)
            iMedia = (Nativemedia2) module;

    }

    public void media(View view) {
        pushMicroapp("http://10.2.47.9:9111");
    }
    //打开相册
    public void openImg(View view) {
        if(null == iMedia){
            return;
        }

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
            public void success(List<CameraRetDTO> data) {
                imgData = data;
                if(imgData.size() > 0){
                    filePath = imgData.get(0).getId();
                    Glide.with(MainActivity.this).load(new File(filePath)).into(ivImg);
                }
                if(imgData.size() > 1){
                    Glide.with(MainActivity.this).load(new File(imgData.get(1).getId())).into(ivImg2);
                }
                if(imgData.size() > 2){
                    Glide.with(MainActivity.this).load(new File(imgData.get(2).getId())).into(ivImg3);
                }
            }
        });

        ivImg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ArrayList<String> images = new ArrayList<>();
                for (CameraRetDTO datum : imgData) {
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
                for (CameraRetDTO datum : imgData) {
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
                for (CameraRetDTO datum : imgData) {
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

    //预览相册
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

    //上传
    public void upload(View view){
        if(TextUtils.isEmpty(filePath)) return;
        List<String> ids = new ArrayList<>();
        for (int i = 0; i < imgData.size(); i++) {
            ids.add(imgData.get(i).getId());
        }
        Map<String, String> header = new HashMap<>();
        header.put("head1","head1");
        header.put("head2","head2");

        iMedia.upLoadImgList("https://api-uat.lohashow.com/gm-nxcloud-resource/api/nxcloud/res/upload",ids,header, new UpLoadImgCallback() {

            @Override
            public void onUpLoadSucces(int status, String id, String msg, String dataStr, boolean isCommplete) {
                Map<String, String> jsonObject = new LinkedHashMap<>();
                jsonObject.put("status", status + "");
                jsonObject.put("id", id);
                jsonObject.put("result", dataStr);
                jsonObject.put("isCommplete", isCommplete + "");
                Log.d("Nativemediadata", GsonUtil.toJson(jsonObject));
            }

            @Override
            public void onUploadFail() {
                Log.d("Nativemedia","上传失败");
            }
        });
    }
    //保存图片
    public void saveImg(View view){
        iMedia.saveImageUrlToAlbum("https://upload-images.jianshu.io/upload_images/5809200-a99419bb94924e6d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240", new SaveCallBack() {
            @Override
            public void saveCallBack(int status, String msg) {
                ToastUtils.showCenterToast(msg);
            }
        });
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
