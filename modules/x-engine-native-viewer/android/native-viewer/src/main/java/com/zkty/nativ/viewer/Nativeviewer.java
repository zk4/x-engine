package com.zkty.nativ.viewer;

import android.text.TextUtils;
import android.util.Log;
import android.view.View;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.jsi.utils.FileUtils;
import com.zkty.nativ.ui.view.dialog.DialogHelper;
import com.zkty.nativ.viewer.dialog.SelectOpenTypeDialog;
import com.zkty.nativ.viewer.utils.DownloadUtil;

import java.io.File;
import java.util.List;

public class Nativeviewer extends NativeModule implements Iviewer {

    private List<NativeModule> modules;
    //文件类型
    private String fileType;
    //文件名称
    private String fileName;

    //文件路径
    private String filePath;

    @Override
    public String moduleId() {
        return "com.zkty.native.viewer";
    }

    @Override
    public void afterAllNativeModuleInited() {
        modules = NativeContext.sharedInstance().getModulesByProtocol(IviewerStatus.class);

    }

    @Override
    public void openFileReader(String fileUrl, String fileName,CallBack callBack) {
        this.fileType = DownloadUtil.getFileType(fileUrl);
        this.fileName = fileName;
        this.filePath = fileUrl;

        modules = NativeContext.sharedInstance().getModulesByProtocol(IviewerStatus.class);
        for (NativeModule module : modules) {
            if (module instanceof IviewerStatus) {
                IviewerStatus iViewer = (IviewerStatus) module;
                if (!iViewer.typeList().contains(fileType)) {
                    modules.remove(iViewer);
                }
                iViewer.setDefault(false);
            }
        }
        NativeModule nativeModule = modules.get(0);
        modules.add(nativeModule);
        checkModel();
    }

    /**
     * 检查文件类型
     *
     */
    //支持的类型
    public void checkModel() {
        if (TextUtils.isEmpty(filePath)) {
            ToastUtils.showCenterToast("文件路径为空");
            return;
        }
        //没有符合的组件
        if (modules.size() == 0) {
            return;
        }
        //只有一个组件
        if (modules.size() == 1) {
            IviewerStatus iviewerStatus = (IviewerStatus) modules.get(0);
            openFile(iviewerStatus, iviewerStatus.isDefault());
            return;
        }

        //有组件设置默认属性
        boolean isOpen = false;
        for (int i = 0; i < modules.size(); i++) {
            IviewerStatus iviewerStatus = (IviewerStatus) modules.get(i);
            if (iviewerStatus.isDefault()) {
                isOpen = true;
                openFile(iviewerStatus, iviewerStatus.isDefault());
                break;
            }
        }
        if (!isOpen) {
            //弹窗让用户选择
            new SelectOpenTypeDialog.Builder(XEngineApplication.getCurrentActivity(), modules)
                    .setOpenClickListener(new SelectOpenTypeDialog.Builder.OnClickListener() {
                        @Override
                        public void onItemClick(View view, IviewerStatus iviewerStatus, boolean isDefault) {
                            openFile(iviewerStatus, isDefault);
                        }
                    })
                    .show();
        }
    }


    /**
     * 打开文件
     *
     * @param iviewerStatus 模块
     * @param isDefault 是否设置默认
     */
    public void openFile(IviewerStatus iviewerStatus, boolean isDefault) {
        iviewerStatus.openFileReader(filePath, fileName, fileType);
        iviewerStatus.setDefault(isDefault);
    }



//    /**
//     * 下载文件
//     *
//     */
//    public void downloadFile() {
//        //创建文件夹
//        File folder = new File(XEngineApplication.getCurrentActivity().getExternalCacheDir().getAbsoluteFile().getPath() + "/downloads");
//        if (!folder.exists()) {
//            folder.mkdirs();
//        }
//        if(TextUtils.isEmpty(fileName)){
//            //获取文件名称
//            String realUrl = filePath.substring(0, filePath.indexOf("?"));
//            this.fileName = getFileName(realUrl);
//        }
//
//
//        //要保存文件
//        File file = new File(folder.getPath() + "/" + fileName);
//        //文件路径
//        this.filePath = file.getPath();
//        //文件存 直接打开 不下载
//        if (file.exists()) {
//            checkFile();
//            return;
//        }
//        //开始下载'
//        XEngineApplication.getCurrentActivity().runOnUiThread(new Runnable() {
//            @Override
//            public void run() {
//                DialogHelper.showLoadingDialog(XEngineApplication.getCurrentActivity(), "下载中...", 0);
//            }
//        });
//        DownloadUtil.get().download(filePath, filePath, new DownloadUtil.OnDownloadListener() {
//            @Override
//            public void onDownloadSuccess() {
//                XEngineApplication.getCurrentActivity().runOnUiThread(new Runnable() {
//                    @Override
//                    public void run() {
//                        DialogHelper.showSuccessDialog(XEngineApplication.getCurrentActivity(), "下载成功", 1);
//                        checkFile();
//                    }
//                });
//            }
//
//            @Override
//            public void onDownloading(int progress) {
//                //进度
//                Log.i("注意", progress + "%");
//            }
//
//            @Override
//            public void onDownloadFailed() {
//                //失败
//                DialogHelper.showSuccessDialog(XEngineApplication.getCurrentActivity(), "下载失败", 1);
//            }
//        });
//    }


}
