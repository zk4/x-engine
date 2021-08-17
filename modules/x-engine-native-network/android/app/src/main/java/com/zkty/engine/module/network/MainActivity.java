package com.zkty.engine.module.network;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.engine.module.network.bean.AdDescInfoBean;
import com.zkty.engine.module.network.bean.IMTokenInfoBean;
import com.zkty.engine.module.network.bean.ImsessiionidBean;
import com.zkty.engine.module.network.net.serve.NetworkServer;
import com.zkty.engine.module.network.net.serve.RequestServer;
import com.zkty.nativ.camera.cameraImpl.GlideLoader;
import com.zkty.nativ.camera.cameraImpl.ImagePicker;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.ImageUtils;
import com.zkty.nativ.network.NetworkMaster;
import com.zkty.nativ.network.bean.BaseResp;
import com.zkty.nativ.network.net.exception.ApiException;
import com.zkty.nativ.network.net.myinterface.OnDownloadListener;
import com.zkty.nativ.network.net.myinterface.OnUploadListener;
import com.zkty.nativ.network.net.myinterface.ServiceCallback;
import com.zkty.nativ.network.utils.GsonUtil;

import org.greenrobot.eventbus.EventBus;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    private TextView tvMsg;
    private Button btnDownLoad,btnUpLoad;

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.btnGet).setOnClickListener(this);
        findViewById(R.id.btnGetQuery).setOnClickListener(this);
        findViewById(R.id.btnPostBody).setOnClickListener(this);
        findViewById(R.id.btnPostQuery).setOnClickListener(this);
        btnDownLoad = findViewById(R.id.btnDownLoad);
        btnUpLoad= findViewById(R.id.btnUpLoad);
        btnDownLoad.setOnClickListener(this);
        btnUpLoad.setOnClickListener(this);
        tvMsg = findViewById(R.id.tvMsg);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.btnGet:
                get();
                break;
            case R.id.btnGetQuery:
                getQuert();
                break;
            case R.id.btnPostBody:
                postBody();
                break;
            case R.id.btnPostQuery:
                postQuery();
                break;
            case R.id.btnDownLoad:
                btnDownLoad.setEnabled(false);
                download();
                break;
            case R.id.btnUpLoad:
                btnUpLoad.setEnabled(false);
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
                break;
        }
    }

    /**
     * get裙拼接参数请求
     */
    private void get(){
        RequestServer.findByPlaceIdAndMallId("1","1", new ServiceCallback<BaseResp<AdDescInfoBean>>() {
            @Override
            public void onSuccess(BaseResp<AdDescInfoBean> dataStr) {
                tvMsg.setText(GsonUtil.toJson(dataStr.getData()));
            }

            @Override
            public void onError(ApiException apiException) {
                tvMsg.setText(GsonUtil.toJson(apiException.errorInfo));
            }

            @Override
            public void onInvalid() {
                tvMsg.setText("请求失败");
            }
        });
    }


    /**
     * getQuery请求
     */

    private void getQuert(){
//        RequestServer.findByPlaceIdAndMallId("1","1", new ServiceCallback<BaseResp<AdDescInfoBean>>() {
//            @Override
//            public void onSuccess(BaseResp<AdDescInfoBean> dataStr) {
//                Log.d("getImToken", GsonUtil.toJson(dataStr));
//            }
//
//            @Override
//            public void onError(ApiException apiException) {
//
//            }
//
//            @Override
//            public void onInvalid() {
//
//            }
//        });
    }


    /**
     * posyBody 请求
     */
    private void postBody(){
        Map<String, Object> map = new HashMap<>();
        map.put("userid", "123123131241241241");
        map.put("entry", "composite");
        map.put("orgi", "666666");
//        map.put("osType", 11);
//        map.put("tokenType","GM-C-User");
//        map.put("userKey", "123131453");
//
        RequestServer.getimsessionid(map, new ServiceCallback<BaseResp<ImsessiionidBean>>() {

            @Override
            public void onSuccess(BaseResp<ImsessiionidBean> dataStr) {
                tvMsg.setText(GsonUtil.toJson(dataStr.getData()));
            }

            @Override
            public void onError(ApiException apiException) {
                tvMsg.setText(GsonUtil.toJson(apiException.errorInfo));
            }

            @Override
            public void onInvalid() {
                tvMsg.setText("请求失败");
            }
        });
//
//        RequestServer.getImToken(map, new ServiceCallback<BaseResp<IMTokenInfoBean>>() {
//            @Override
//            public void onSuccess(BaseResp<IMTokenInfoBean> dataStr) {
//                tvMsg.setText(GsonUtil.toJson(dataStr));
//            }
//
//            @Override
//            public void onError(ApiException apiException) {
//                tvMsg.setText(GsonUtil.toJson(apiException.errorInfo));
//            }
//
//            @Override
//            public void onInvalid() {
//                tvMsg.setText("请求失败");
//            }
//        });
    }


    /**
     * posyQuery 请求
     */
    private void postQuery(){

        Map<String, Object> map = new HashMap<>();
        map.put("phoneNum", "18512344321");
        map.put("smsCode", "1234");
        RequestServer.getLoginApi(map, new ServiceCallback<BaseResp>() {

            @Override
            public void onSuccess(BaseResp dataStr) {
                tvMsg.setText(GsonUtil.toJson(dataStr.getData()));
            }

            @Override
            public void onError(ApiException apiException) {
                tvMsg.setText(GsonUtil.toJson(apiException.errorInfo));
            }

            @Override
            public void onInvalid() {
                tvMsg.setText("请求失败");
            }
        });
    }
    /**
     * download 请求
     */
    private void download(){

        //创建文件夹
        File folder = new File(XEngineApplication.getCurrentActivity().getExternalCacheDir().getAbsoluteFile().getPath() + "/downloads");
        if (!folder.exists()) {
            folder.mkdirs();
        }

        //要保存文件
        File file = new File(folder.getPath() + "/" + "hahaah.pdf");
        //文件路径
        String filePath = file.getPath();

        NetworkServer.getInstance().sendDownload("http://www.bitsavers.org/pdf/aeon/Aeon_Systems_Model_7064.pdf",filePath, new OnDownloadListener() {
            @Override
            public void onDownloadSuccess() {
                btnDownLoad.setEnabled(true);
                tvMsg.setText(filePath + "\n下载完成");
            }

            @Override
            public void onDownloading(int progress) {
                tvMsg.setText(filePath + "\n" +progress + "%");
            }

            @Override
            public void onDownloadFailed() {
                btnDownLoad.setEnabled(false);
                tvMsg.setText(filePath + "\n下载失败");
            }
        });
    }

    /**
     * 上传
     */
    private void upload(String filePath){
        NetworkServer.getInstance().sendUpload("", filePath, new OnUploadListener() {
            @Override
            public void onUploadSuccess() {
                tvMsg.setText(filePath + "\n上传完成");
                btnUpLoad.setEnabled(true);
            }

            @Override
            public void onUploading(int progress) {
                tvMsg.setText(filePath + "\n" +progress + "%");

            }

            @Override
            public void onUploadFailed() {
                tvMsg.setText(filePath + "\n上传失败");
                btnUpLoad.setEnabled(true);
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            switch (requestCode) {
                case ImageUtils.RESULT_CODE_PHOTO:
                    try {
                        ArrayList<String> items = data.getStringArrayListExtra(ImagePicker.EXTRA_SELECT_IMAGES);
                        //发送图片消息
                        upload(items.get(0));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
            }
        }
    }
}
