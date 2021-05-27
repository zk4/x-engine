package com.zkty.nativ.viewer;

import android.text.TextUtils;
import android.view.View;

import com.tencent.smtt.utils.Md5Utils;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.utils.FileUtils;
import com.zkty.nativ.viewer.dialog.SelectOpenTypeDialog;
import com.zkty.nativ.viewer.utils.DownloadUtil;

import java.util.List;

public class Nativeviewer extends NativeModule implements Iviewer {

    private List<NativeModule> modules;
    //文件下载地址
    private String fileUrl;
    //文件类型
    private String fileType;
    //文件名称
    private String fileName;
    //预览时的标题
    private String title;
    //h5 回调
    private static CallBack callBack;

    @Override
    public String moduleId() {
        return "com.zkty.native.viewer";
    }

    @Override
    public void afterAllNativeModuleInited() {
        modules = NativeContext.sharedInstance().getModulesByProtocol(IviewerStatus.class);

    }

    @Override
    public void openFileReader(String fileUrl, String fileType,String title,CallBack callBack) {
        this.callBack = callBack;
        this.fileType = fileType;
        this.fileName = Md5Utils.getMD5(fileUrl);
        this.fileUrl = fileUrl;
        this.title = title;

        modules = NativeContext.sharedInstance().getModulesByProtocol(IviewerStatus.class);
        for (NativeModule module : modules) {
            if (module instanceof IviewerStatus) {
                IviewerStatus iViewer = (IviewerStatus) module;
                if (!iViewer.typeList().contains(fileType)) {
                    modules.remove(iViewer);
                }
            }
        }
        checkModel();
    }

    /**
     * 检查文件类型
     *
     */
    //支持的类型
    public void checkModel() {
        if (TextUtils.isEmpty(fileUrl)) {
            callBack.success("文件地址");
            return;
        }
        //没有符合的组件
        if (modules.size() == 0) {
            callBack.success("不支持该文件类型");
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
     * @param iviewerStatus 模块
     * @param isDefault 是否设置默认
     */
    public void openFile(IviewerStatus iviewerStatus, boolean isDefault) {
        if(iviewerStatus.isOnlineOpen()){
            iviewerStatus.openFileReader(fileUrl, title, fileType);
            iviewerStatus.setDefault(isDefault);
        }else{
            this.iviewerStatus = iviewerStatus;
            DownLoadFileActivity.startAty(fileUrl,fileName,fileType,title,isDefault);
        }
    }


    /**
     * 获取回调
     */
    public static CallBack getCallback(){
        return callBack;
    }

    /**
     * 获取回调
     */
    private static IviewerStatus iviewerStatus;
    public static IviewerStatus getIviewerStatus(){
        return iviewerStatus;
    }

}
