package com.zkty.engine.module.network;

import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.engine.module.network.bean.AdDescInfoBean;
import com.zkty.engine.module.network.bean.IMTokenInfoBean;
import com.zkty.engine.module.network.bean.ImsessiionidBean;
import com.zkty.engine.module.network.net.serve.RequestServer;
import com.zkty.nativ.network.bean.BaseResp;
import com.zkty.nativ.network.net.exception.ApiException;
import com.zkty.nativ.network.net.myinterface.ServiceCallback;
import com.zkty.nativ.network.utils.GsonUtil;

import java.util.HashMap;
import java.util.Map;


public class MainActivity extends AppCompatActivity {

    private TextView viewById;

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        viewById = findViewById(R.id.tv_version);
    }

    public void network(View view) {
        //http://larkapi.gomeuat.com.cn/open/getimsessionid
        //http://larkapi.gomeuat.com.cn/open/getimsessionid
        Map<String, Object> map = new HashMap<>();
        map.put("userid", "123123131241241241");
        map.put("entry", "composite");
        map.put("orgi", "666666");

        RequestServer.getimsessionid(map, new ServiceCallback<BaseResp<ImsessiionidBean>>() {

            @Override
            public void onSuccess(BaseResp<ImsessiionidBean> dataStr) {
                Log.d("getImToken", GsonUtil.toJson(dataStr));
            }

            @Override
            public void onError(ApiException apiException) {

            }

            @Override
            public void onInvalid() {

            }
        });

        RequestServer.getImToken(map, new ServiceCallback<BaseResp<IMTokenInfoBean>>() {
            @Override
            public void onSuccess(BaseResp<IMTokenInfoBean> dataStr) {
                Log.d("getImToken", GsonUtil.toJson(dataStr));
            }

            @Override
            public void onError(ApiException apiException) {

            }

            @Override
            public void onInvalid() {

            }
        });

        RequestServer.findByPlaceIdAndMallId(map, new ServiceCallback<BaseResp<AdDescInfoBean>>() {
            @Override
            public void onSuccess(BaseResp<AdDescInfoBean> dataStr) {
                Log.d("getImToken", GsonUtil.toJson(dataStr));
            }

            @Override
            public void onError(ApiException apiException) {

            }

            @Override
            public void onInvalid() {

            }
        });


        //创建文件夹
//        File folder = new File(XEngineApplication.getCurrentActivity().getExternalCacheDir().getAbsoluteFile().getPath() + "/downloads");
//        if (!folder.exists()) {
//            folder.mkdirs();
//        }
//
//        //要保存文件
//        File file = new File(folder.getPath() + "/" + "hahaah.pdf");
//        //文件路径
//        String filePath = file.getPath();
//
//        NetworkServer.getInstance().sendDownload("http://www.bitsavers.org/pdf/aeon/Aeon_Systems_Model_7064.pdf",filePath, new OnDownloadListener() {
//            @Override
//            public void onDownloadSuccess() {
//                viewById.setText("下载完成");
//            }
//
//            @Override
//            public void onDownloading(int progress) {
//                viewById.setText(progress + "%");
//                LogUtils.d(progress + "%");
//            }
//
//            @Override
//            public void onDownloadFailed() {
//                viewById.setText("下载失败");
//            }
//        });


//
//        RxService.upLoadFile("", filePath, new OnUploadListener() {
//            @Override
//            public void onUploadSuccess() {
//
//            }
//
//            @Override
//            public void onUploading(int progress) {
//
//            }
//
//            @Override
//            public void onUploadFailed() {
//
//            }
//        });
    }
}
