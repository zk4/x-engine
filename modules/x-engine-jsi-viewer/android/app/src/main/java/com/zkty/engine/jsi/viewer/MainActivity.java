package com.zkty.engine.jsi.viewer;

import android.os.Bundle;
import android.os.Environment;
import android.text.TextUtils;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;

import com.anthonynsimon.url.URL;
import com.anthonynsimon.url.exceptions.MalformedURLException;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.viewer.CallBack;
import com.zkty.nativ.viewer.Nativeviewer;
import com.zkty.nativ.viewer_orgi.Nativeviewer_orgi;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        findViewById(R.id.tv_pdf).setOnClickListener(this);
        findViewById(R.id.tv_ppt).setOnClickListener(this);
        findViewById(R.id.tv_pptx).setOnClickListener(this);
        findViewById(R.id.tv_doc).setOnClickListener(this);
        findViewById(R.id.tv_docx).setOnClickListener(this);
        findViewById(R.id.tv_xls).setOnClickListener(this);
        findViewById(R.id.tv_xlsx).setOnClickListener(this);
        findViewById(R.id.tv_txt).setOnClickListener(this);
        findViewById(R.id.tv_epub).setOnClickListener(this);

    }

    public void viewer(View view) {
        push("http://10.2.129.142:9111");
    }

    public static void push(String url) {
        try {
            URL url1 = URL.parse(url);
            String scheme = url1.getScheme();
            //URL解析的 fragment 包含query，eg：/mall2/orderlist?selectedIndex=0，故query传null
            push(scheme, url1.getHost(), url1.getPath(), url1.getFragment(), null, null);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }


    }

    public static void push(String scheme, String host, String pathname, String fragment, Map<String, String> query, Map<String, String> params) {
        String protocol = "https:";
        if ("omp".equals(scheme)) protocol = "http:";
        if ("http".equals(scheme)) protocol = "http:";
        if ("https".equals(scheme)) protocol = "https:";
        if ("microapp".equals(scheme)) protocol = "file:";

        boolean hideNavbar = params != null && params.containsKey("hideNavbar") && Boolean.parseBoolean(String.valueOf(params.get("hideNavbar")));
        XEngineWebActivityManager.sharedInstance().startXEngineActivity(XEngineApplication.getCurrentActivity(), protocol, host, pathname, fragment, query, hideNavbar);

    }

    @Override
    public void onClick(View v) {
        String filePath = "";
        switch (v.getId()){
            case R.id.tv_pdf:
//                filePath = Environment.getExternalStorageDirectory()+"/9b82cdfe4167b7da07fb395ce3963f4cw004.pdf";
                filePath = "http://gfsei.atguat.net.cn/9b82cdfe4167b7da07fb395ce3963f4cw004.pdf?Expires=2563098084&AccessKey=40de0c1abb5e4506bccc56d4aee3d945&Signature=1083d55756878793fe68cf43fd599d95";
                break;
            case R.id.tv_ppt:
                filePath = Environment.getExternalStorageDirectory()+"/git控制版本.ppt";
                break;
            case R.id.tv_pptx:
                filePath = Environment.getExternalStorageDirectory()+"/ppt-2.pptx";
                break;
            case R.id.tv_doc:
            case R.id.tv_docx:
                filePath = Environment.getExternalStorageDirectory()+"/testdocx.docx";
                break;
            case R.id.tv_xls:
            case R.id.tv_xlsx:
                filePath = Environment.getExternalStorageDirectory()+"/埋点.xlsx";
                break;
            case R.id.tv_txt:
                filePath = Environment.getExternalStorageDirectory()+"/商品卡.txt";
                break;
            case R.id.tv_epub:
                filePath = Environment.getExternalStorageDirectory()+"/testepub.epub";
                break;
        }

        Nativeviewer nativeviewer = new Nativeviewer();
        nativeviewer.openFileReader(filePath,"pdf","用户协议", new CallBack() {
            @Override
            public void success(String dto) {
                ToastUtils.showCenterToast(dto);
            }
        });
    }


}
