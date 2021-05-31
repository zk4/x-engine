package com.zkty.nativ.viewer;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.annotation.Nullable;

import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.XEngineNavBar;
import com.zkty.nativ.viewer.utils.DownloadUtil;
import com.zkty.nativ.viewer.widget.CircularProgressBar;

import java.io.File;

import module.viewer.R;

/**
 * @author : MaJi
 * @time : (5/27/21)
 * dexc :
 */
public class DownLoadFileActivity extends BaseXEngineActivity implements View.OnClickListener {

    public static final String FILE_URL = "fileUrl";
    public static final String FILE_NAME = "fileName";
    public static final String FILE_TYPE = "fileType";
    public static final String TITLE = "title";
    public static final String IS_DEFAULT = "isDefault";


    public static void startAty(String fileUrl, String fileName, String fileType, String title, boolean isDefault) {
        Intent intent = new Intent(XEngineApplication.getCurrentActivity(), DownLoadFileActivity.class);
        intent.putExtra(DownLoadFileActivity.FILE_URL,fileUrl);
        intent.putExtra(DownLoadFileActivity.FILE_NAME,fileName);
        intent.putExtra(DownLoadFileActivity.FILE_TYPE,fileType);
        intent.putExtra(DownLoadFileActivity.TITLE,title);
        intent.putExtra(DownLoadFileActivity.IS_DEFAULT,isDefault);
        XEngineApplication.getCurrentActivity().startActivity(intent);
    }
    private XEngineNavBar mXEngineNavBar;
    private TextView tvFileName;
    private CircularProgressBar lockQuantityCircularProgressBar;
    private TextView tvProgress;
    private TextView tvDownLoadStatus;
    private Button tvDownLoad;
    //文件的信息
    private String fileUrl,filePath,fileName,fileType,title;
    //是否设置默认
    private boolean isDefault;
    //是否下载完成
    private boolean isDownLoadFinish = false;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_download_file);
        //接收参数
        fileUrl = getIntent().getStringExtra(FILE_URL);
        fileName = getIntent().getStringExtra(FILE_NAME) ;
        fileType = getIntent().getStringExtra(FILE_TYPE);
        title = getIntent().getStringExtra(TITLE);
        isDefault = getIntent().getBooleanExtra(IS_DEFAULT,false);

        //初始化UI
        mXEngineNavBar = findViewById(R.id.mXEngineNavBar);
        tvFileName = findViewById(R.id.tvFileName);
        lockQuantityCircularProgressBar = findViewById(R.id.lockQuantityCircularProgressBar);
        tvProgress = findViewById(R.id.tvProgress);
        tvDownLoadStatus = findViewById(R.id.tvDownLoadStatus);
        tvDownLoad = findViewById(R.id.tvDownLoad);

        //设置标题
        mXEngineNavBar.setTitle(title,null,null);
        tvFileName.setText(title);
        //返回监听
        mXEngineNavBar.setLeftListener(v -> finish());
        tvDownLoad.setOnClickListener(this);
        //下载文件
        downLoadFile();
    }

    /**
     * 下载文件
     */
    private void downLoadFile() {
        //创建文件夹
        File folder = new File(XEngineApplication.getCurrentActivity().getExternalCacheDir().getAbsoluteFile().getPath() + "/downloads");
        if (!folder.exists()) {
            folder.mkdirs();
        }

        //要保存文件
        File file = new File(folder.getPath() + "/" + fileName + "." + fileType);
        //文件路径
        filePath = file.getPath();
        //文件存 直接打开 不下载
        if (file.exists()) {
            //文件存在 下载完成
            isDownLoadFinish = true;
            openFile(filePath, fileType);
            return;
        }
        DownloadUtil.get().download(fileUrl, filePath,fileType, new DownloadUtil.OnDownloadListener() {
            @Override
            public void onDownloadSuccess() {
                //下载完成
                isDownLoadFinish = true;
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
                        float circlerogress = (float) (progress / 100.00);
                        lockQuantityCircularProgressBar.setProgress(circlerogress);
                    }
                });
            }

            @Override
            public void onDownloadFailed(String msg) {
                XEngineApplication.getCurrentActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        tvDownLoadStatus.setVisibility(View.VISIBLE);
                        tvDownLoad.setVisibility(View.VISIBLE);
                        tvDownLoadStatus.setText(msg);
                        tvDownLoad.setText("重新下载");
                        Nativeviewer.getCallback().success(msg);
                    }
                });

            }
        });
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

    /**
     * 打开文件
     * @param filePath
     * @param fileType
     */
    private void openFile(String filePath, String fileType) {
        Nativeviewer.getIviewerStatus().openFileReader(filePath, title, fileType);
        Nativeviewer.getIviewerStatus().setDefault(isDefault);
        finish();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        try {
            //没有下载完成 则删除文件
            if(!isDownLoadFinish){
                File file = new File(filePath);
                if(file.exists()){
                    file.delete();
                }
            }
        }catch (Exception e){

        }
    }
}
