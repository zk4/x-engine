package com.zkty.nativ.viewer_original.activity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;


import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.XEngineNavBar;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import module.viewer_original.R;


/**
 * @author : MaJi
 * @time : (5/13/21)
 * dexc :
 */
public class PreViewActivity extends BaseXEngineActivity {

    public static final String FILE_PATH = "filePath";
    public static final String FILE_NAME = "fileName";
    public static final String FILE_TYPE = "fileType";
    public static final String TITLE = "title";
    private LinearLayout llContent;
    private XEngineNavBar mXEngineNavBar;

    private RelativeLayout relLoadX5;
    private TextView tvProgress;
    private String filePath,downLoadUrl;
    private String fileType;
    private String title;

    private int maxProgress = 100;
    private int cunProgress = 0;
    private boolean isFirst = true;

    public static void startAty(String filePath, String title, String fileType) {
        Intent intent = new Intent(XEngineApplication.getCurrentActivity(), PreViewActivity.class);
        intent.putExtra(PreViewActivity.FILE_PATH,filePath);
        intent.putExtra(PreViewActivity.FILE_TYPE,fileType);
        intent.putExtra(PreViewActivity.TITLE,title);
        XEngineApplication.getCurrentActivity().startActivity(intent);
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_preview_file);

        filePath = getIntent().getStringExtra(FILE_PATH);
        fileType = getIntent().getStringExtra(FILE_TYPE);
        title= getIntent().getStringExtra(TITLE);



        llContent = findViewById(R.id.llContent);
        mXEngineNavBar = findViewById(R.id.mXEngineNavBar);

        relLoadX5 = findViewById(R.id.relLoadX5);
        tvProgress = findViewById(R.id.tvProgress);

        List<Double> iconSize = new ArrayList<>();
        iconSize.add(20.0);
        iconSize.add(20.0);
        Map<String,String> map = new HashMap<>();
        map.put("title","分享");
        Map<String,String> map1 = new HashMap<>();
        map1.put("title","更多");
        List<Map<String,String> > itemlist = new ArrayList<>();
        itemlist.add(map);
        itemlist.add(map1);

//        mXEngineNavBar.setNavRightMenuBtn("更多", "#121212", null, null, iconSize, itemlist, false, "100", (parent, view, position, id) -> ToastUtils.showCenterToast(itemlist.get(position).get("title")));
        mXEngineNavBar.setLeftListener(v -> finish());

        //设置标题
        mXEngineNavBar.setTitle(title,null,null);

        //打开文件
//        if(QbSdk.canLoadX5(XEngineApplication.getApplication())){//是否支持 x5 浏览
//            openFile(filePath, fileType);
//        }else{
//            if(fileType.contains("pdf")){
//                PrePdfViewActivity.startAty(filePath,title,fileType);
//                finish();
//            }
//            relLoadX5.setVisibility(View.VISIBLE);
//            //x5下载监听
//            QbSdk.setTbsListener(new TbsListener() {
//                @Override
//                public void onDownloadFinish(int i) {
//                    Log.d("initX5 prew", "onDownloadFinish -->下载X5内核完成：" + i);
//                    if(i != 100 && !TbsDownloader.isDownloading() && !QbSdk.canLoadX5(getApplicationContext())){
//                        new Handler().postDelayed(new Runnable() {
//                            @Override
//                            public void run() {
//                                TbsDownloader.startDownload(getApplicationContext());
//                            }
//                        },10000);
//
//                    }else{
//                        runOnUiThread(new Runnable() {
//                            @Override
//                            public void run() {
//                                tvProgress.setText("浏览器安装中");
//                            }
//                        });
//                    }
//
//
//                }
//                @Override
//                public void onInstallFinish(int i) {
//                    //安装完成
//                    if(QbSdk.canLoadX5(getApplicationContext())){
//                        runOnUiThread(new Runnable() {
//                            @Override
//                            public void run() {
//                                openFile(filePath, fileType);
//                            }
//                        });
//                    }
//
//                }
//                @Override
//                public void onDownloadProgress(int progress) {
//                    if(isFirst && progress > 20){
//                        maxProgress = 100 - progress;
//                        cunProgress = progress;
//                    }
//                    isFirst = false;
//                    float ratio = ((progress - cunProgress) / maxProgress);
//                    int pro = (int) (100 * ratio);
//                    runOnUiThread(new Runnable() {
//                        @Override
//                        public void run() {
//                            tvProgress.setText("浏览器加载中：" + pro + "%");
//                        }
//                    });
//                    Log.d("initX5  prew", "onDownloadProgress -->下载X5内核进度：" + progress);
//                }
//            });
//            //判断是否在下载中
//            Log.d("initX5 prew",  "是否正在下载X5内核 -->" +TbsDownloader.isDownloading() + "");
//            if(!TbsDownloader.isDownloading()){
//                Log.d("initX5 prew",  "下载X5内核 -->");
//                TbsDownloader.startDownload(getApplicationContext());
//            }
        }

//    }


    /**
     * 打开文件
     * @param path
     */
    private void openFile(String path,String fileType) {
//        relLoadX5.setVisibility(View.GONE);
//        tbsReaderView = new TbsReaderView(this, readerCallback);
//        llContent.addView(tbsReaderView,new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
//        Bundle bundle = new Bundle();
//        //文件路径
//        bundle.putString("filePath", path);
//        //临时文件的路径，必须设置，否则会报错
//        bundle.putString("tempPath", Environment.getExternalStorageDirectory().getAbsolutePath()+"腾讯文件TBS");
//        //准备
//        boolean result = tbsReaderView.preOpen(fileType, false);
//        if (result) {
//            //预览文件
//            tbsReaderView.openFile(bundle);
//        }
    }


    /**
     * 下面的回调必须要实现，暂时没找到此回调的用处
//     */
//    TbsReaderView.ReaderCallback readerCallback = new TbsReaderView.ReaderCallback() {
//        @Override
//        public void onCallBackAction(Integer integer, Object o, Object o1) {
//
//        }
//    };

//    @Override
//    protected void onDestroy() {
//        super.onDestroy();
//        //需要将预览服务停止，一定不要忘了
//        if(tbsReaderView != null){
//            tbsReaderView.onStop();
//        }
//    }

}
