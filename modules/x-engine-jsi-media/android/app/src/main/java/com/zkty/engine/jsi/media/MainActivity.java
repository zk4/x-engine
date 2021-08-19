package com.zkty.engine.jsi.media;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.anthonynsimon.url.URL;
import com.anthonynsimon.url.exceptions.MalformedURLException;
import com.zkty.nativ.core.utils.ImageUtils;
import com.zkty.nativ.jsi.utils.UrlUtils;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.media.cameraImpl.GlideLoader;
import com.zkty.nativ.media.cameraImpl.ImagePicker;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    private TextView tvMsg;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tvMsg = findViewById(R.id.tvMsg);

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

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            switch (requestCode) {
                case ImageUtils.RESULT_CODE_PHOTO:
                    try {
                        ArrayList<String> items = data.getStringArrayListExtra(ImagePicker.EXTRA_SELECT_IMAGES);
                        tvMsg.setText(items.get(0));
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
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
    }
}
