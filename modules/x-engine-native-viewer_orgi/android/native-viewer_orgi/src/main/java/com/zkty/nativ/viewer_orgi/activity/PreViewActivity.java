package com.zkty.nativ.viewer_orgi.activity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;

import com.tencent.smtt.sdk.TbsReaderView;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.XEngineNavBar;
import com.zkty.nativ.ui.view.dialog.DialogHelper;
import com.zkty.nativ.viewer.utils.DownloadUtil;
import com.zkty.nativ.viewer_orgi.widget.CircularProgressBar;

import java.io.File;

import module.viewer_orgi.R;


/**
 * @author : MaJi
 * @time : (5/13/21)
 * dexc :
 */
public class PreViewActivity extends BaseXEngineActivity implements View.OnClickListener {

    public static final String FILE_PATH = "filePath";
    public static final String FILE_NAME = "fileName";
    public static final String FILE_TYPE = "fileType";

    private LinearLayout llContent;
    private XEngineNavBar mXEngineNavBar;
    private TbsReaderView tbsReaderView;
    private String filePath,downLoadUrl;
    private String fileName;
    private String fileType;
    private LinearLayout llLoadLayout;
    private TextView tvFileName;
    private CircularProgressBar lockQuantityCircularProgressBar;
    private TextView tvProgress;
    private TextView tvDownLoadStatus;
    private Button tvDownLoad;

    public static void startAty(String filePath, String fileName, String fileType) {

        Intent intent = new Intent(XEngineApplication.getCurrentActivity(), PreViewActivity.class);
        intent.putExtra(PreViewActivity.FILE_PATH,filePath);
        intent.putExtra(PreViewActivity.FILE_NAME,fileName);
        intent.putExtra(PreViewActivity.FILE_TYPE,fileType);
        XEngineApplication.getCurrentActivity().startActivity(intent);
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_preview_file);
        llContent = findViewById(R.id.llContent);
        llLoadLayout = findViewById(R.id.llLoadLayout);
        tvFileName = findViewById(R.id.tvFileName);
        lockQuantityCircularProgressBar = findViewById(R.id.lockQuantityCircularProgressBar);
        tvProgress = findViewById(R.id.tvProgress);
        tvDownLoadStatus = findViewById(R.id.tvDownLoadStatus);
        tvDownLoad = findViewById(R.id.tvDownLoad);

        mXEngineNavBar = findViewById(R.id.mXEngineNavBar);
        mXEngineNavBar.setLeftListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        tvDownLoad.setOnClickListener(this);

        filePath = getIntent().getStringExtra(FILE_PATH);
        downLoadUrl = filePath;
        fileName = getIntent().getStringExtra(FILE_NAME) ;
        fileType = getIntent().getStringExtra(FILE_TYPE);
        if(TextUtils.isEmpty(getIntent().getStringExtra(FILE_NAME))){
            this.fileName = DownloadUtil.getFileName(filePath);
        }
        mXEngineNavBar.setTitle(fileName,null,null);
        tvFileName.setText(fileName);
        //是否是在线地址
        if(filePath.startsWith("http")){
            downLoadFile();
        }else{
            //打开文件
            openFile(filePath, fileType);
        }
    }

    /**
     * 下载文件
     */
    private void downLoadFile() {
        llLoadLayout.setVisibility(View.VISIBLE);
        //创建文件夹
        File folder = new File(XEngineApplication.getCurrentActivity().getExternalCacheDir().getAbsoluteFile().getPath() + "/downloads");
        if (!folder.exists()) {
            folder.mkdirs();
        }

        //要保存文件
        File file = new File(folder.getPath() + "/" + fileName);
        //文件路径
        this.filePath = file.getPath();
        //文件存 直接打开 不下载
        if (file.exists()) {
            openFile(filePath, fileType);
            return;
        }
        DownloadUtil.get().download(downLoadUrl, filePath, new DownloadUtil.OnDownloadListener() {
            @Override
            public void onDownloadSuccess() {
                XEngineApplication.getCurrentActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        tvProgress.setText("100%");
                        lockQuantityCircularProgressBar.setProgress(1);
                        tvDownLoadStatus.setText("下载成功");
                        tvDownLoad.setText("打开");
                        tvDownLoadStatus.setVisibility(View.VISIBLE);
                        tvDownLoad.setVisibility(View.VISIBLE);
//                        openFile(filePath, fileType);
                    }
                });
            }

            @Override
            public void onDownloading(int progress) {
                XEngineApplication.getCurrentActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        tvProgress.setText(progress + "%");
                        tvDownLoadStatus.setVisibility(View.GONE);
                        tvDownLoad.setVisibility(View.GONE);
                        float circlerogress = progress /100;
                        lockQuantityCircularProgressBar.setProgress(circlerogress);
                    }
                });
                //进度
//                Log.i("注意", progress + "%");
            }

            @Override
            public void onDownloadFailed() {
                XEngineApplication.getCurrentActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        tvDownLoadStatus.setVisibility(View.VISIBLE);
                        tvDownLoad.setVisibility(View.VISIBLE);
                        tvDownLoadStatus.setText("下载失败");
                        tvDownLoadStatus.setText("重新下载");
                    }
                });

            }
        });
    }

    /**
     * 打开文件
     * @param path
     */
    private void openFile(String path,String fileType) {
        llLoadLayout.setVisibility(View.GONE);
        tbsReaderView = new TbsReaderView(this, readerCallback);
        llContent.addView(tbsReaderView,new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        Bundle bundle = new Bundle();
        //文件路径
        bundle.putString("filePath", path);
        //临时文件的路径，必须设置，否则会报错
        bundle.putString("tempPath", Environment.getExternalStorageDirectory().getAbsolutePath()+"腾讯文件TBS");
        //准备
        boolean result = tbsReaderView.preOpen(fileType, false);
        if (result) {
            //预览文件
            tbsReaderView.openFile(bundle);
        }
    }



    /**
     * 下面的回调必须要实现，暂时没找到此回调的用处
     */
    TbsReaderView.ReaderCallback readerCallback = new TbsReaderView.ReaderCallback() {
        @Override
        public void onCallBackAction(Integer integer, Object o, Object o1) {

        }
    };

    @Override
    protected void onDestroy() {
        super.onDestroy();
        //需要将预览服务停止，一定不要忘了
        if(tbsReaderView != null){
            tbsReaderView.onStop();
        }
    }

    @Override
    public void onClick(View v) {
        if (v.getId() == R.id.tvDownLoad) {
            if(tvDownLoad.getText().equals("重新下载")){
                downLoadFile();
            }else if(tvDownLoad.getText().equals("打开")){
                //打开文件
                openFile(filePath, fileType);
            }

        }
    }
}
