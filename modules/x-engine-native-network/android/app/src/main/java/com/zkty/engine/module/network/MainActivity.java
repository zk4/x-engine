package com.zkty.engine.module.network;

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
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.network.NetworkMaster;
import com.zkty.nativ.network.bean.BaseResp;
import com.zkty.nativ.network.net.exception.ApiException;
import com.zkty.nativ.network.net.myinterface.OnDownloadListener;
import com.zkty.nativ.network.net.myinterface.ServiceCallback;
import com.zkty.nativ.network.utils.GsonUtil;

import org.greenrobot.eventbus.EventBus;

import java.io.File;
import java.util.HashMap;
import java.util.Map;


public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    private TextView tvMsg;
    private Button btnDownLoad;

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
        btnDownLoad.setOnClickListener(this);
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
        map.put("osType", 11);
        map.put("tokenType","GM-C-User");
        map.put("userKey", "123131453");
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
}
