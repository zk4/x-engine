package com.zkty.nativ.viewer;

import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.ui.view.dialog.DialogHelper;
import com.zkty.nativ.viewer.bean.ModelInfoBean;
import com.zkty.nativ.viewer.dialog.SelectOpenTypeDialog;
import com.zkty.nativ.viewer.utils.DownloadUtil;
import com.zkty.nativ.viewer_orgi.Nativeviewer_orgi;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import module.viewer.R;

public class Nativeviewer extends NativeModule implements Iviewer {

    @Override
    public String moduleId() {
        return "com.zkty.native.viewer";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public void openFileReader(String fileUrl, CallBack callBack) {
        if(fileUrl.startsWith("http")){
            //下载文件
            downloadFile(fileUrl);
        }else{
            checkFile(fileUrl);
        }
    }
    /**
     * 下载文件
     * @param downloadUrl
     */
    public void downloadFile(String downloadUrl){
        //创建文件夹
        File folder = new File(XEngineApplication.getCurrentActivity().getExternalCacheDir().getAbsoluteFile().getPath() + "downloads");
        if (!folder.exists()) {
            folder.mkdirs();
        }
        //获取文件名称
        String realUrl = downloadUrl.substring(0,downloadUrl.indexOf("?"));
        String filename = getFileName(realUrl);

        //要保存文件
        File file = new File(folder.getPath() + "/" +filename);
        //文件路径
        String filePath = file.getPath();
        //文件存 直接打开 不下载
        if(file.exists()){
            checkFile(filePath);
            return;
        }
        //开始下载'
        XEngineApplication.getCurrentActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
             DialogHelper.showLoadingDialog(XEngineApplication.getCurrentActivity(), "下载中...", 0);
            }
        });
        DownloadUtil.get().download(downloadUrl, filePath, new DownloadUtil.OnDownloadListener() {
            @Override
            public void onDownloadSuccess() {
                XEngineApplication.getCurrentActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        DialogHelper.showSuccessDialog(XEngineApplication.getCurrentActivity(), "下载成功", 1);
                        checkFile(filePath);
                    }
                });
            }

            @Override
            public void onDownloading(int progress) {
                //进度
                Log.i("注意",progress+"%");
            }

            @Override
            public void onDownloadFailed() {
                //失败
                DialogHelper.showSuccessDialog(XEngineApplication.getCurrentActivity(), "下载失败", 1);
            }
        });
    }



    /**
     * 检查文件类型
     * @param filePath
     */
    //支持的类型
    List<ModelInfoBean> modelList = new ArrayList();
    Nativeviewer_orgi nativeviewer;
    public void checkFile(String filePath){
        if(TextUtils.isEmpty(filePath)){
            ToastUtils.showCenterToast("文件路径为空");
            return;
        }
        String fileType = getFileType(filePath);
        modelList.clear();
        //Nativeviewer model支持
        nativeviewer = new Nativeviewer_orgi();
        //是否支持此类型
        if(nativeviewer.typeList().contains(fileType)){
            ModelInfoBean bean = new ModelInfoBean(nativeviewer.isDefault(),nativeviewer.moduleId(),nativeviewer.getModelName(),nativeviewer.getModelPic());
            modelList.add(bean);
        }
        //是否支持此类型
        if(nativeviewer.typeList().contains(fileType)){
            ModelInfoBean bean = new ModelInfoBean(nativeviewer.isDefault(),nativeviewer.moduleId(),nativeviewer.getModelName(),nativeviewer.getModelPic());
            modelList.add(bean);
        }
        //没有符合的组件
        if(modelList.size() < 0 ){
            return;
        }
        //只有一个组件
        if(modelList.size() == 1 ){
            ModelInfoBean bean = modelList.get(0);
            openFile(filePath,fileType,bean.getModelId());
        }
        //有组件设置默认属性
        for (int i = 0; i < modelList.size(); i++) {
            ModelInfoBean bean = modelList.get(i);
            if(bean.isDefault()){
                openFile(filePath,fileType,bean.getModelId());
                break;
            }
        }
        //弹窗让用户选择

        new SelectOpenTypeDialog.Builder(XEngineApplication.getCurrentActivity(),modelList)
                .setOpenClickListener(new SelectOpenTypeDialog.Builder.OnClickListener() {
                    @Override
                    public void onItemClick(View view, ModelInfoBean bean) {
                        openFile(filePath,fileType,bean.getModelId());
                    }
                })
                .show();


    }


    /**
     * 打开文件
     * @param filePath
     * @param fileType
     * @param modelType
     */
    public void openFile(String filePath,String fileType,String modelType){
        switch (modelType){
            //TBS
            case "com.zkty.native.viewer_orgi":
                nativeviewer.openFileReader(filePath, fileType);
                break;
            default:
                break;
        }
    }


    /**
     * 获取文件类型
     * @param path
     * @return
     */
    private String getFileType(String path) {
        String type = "";
        if(path.endsWith(".pdf")){
            type = "pdf";
        }else if(path.endsWith(".ppt")){
            type = "ppt";
        }else if(path.endsWith(".pptx")){
            type = "pptx";
        }else if(path.endsWith(".doc")){
            type = "doc";
        }else if(path.endsWith(".docx")){
            type = "docx";
        }else if(path.endsWith(".xls")){
            type = "xls";
        }else if(path.endsWith(".xlsx")){
            type = "xlsx";
        }else if(path.endsWith(".txt")){
            type = "txt";
        }else if(path.endsWith(".epub")){
            type = "epub";
        }
        return type;
    }



    public String getFileName(String urlname) {
        int start = urlname.lastIndexOf("/");
        int end = urlname.length();
        if (start != -1 && end != -1) {
            return urlname.substring(start+1,end);
        } else {
            return null;
        }
    }




}
