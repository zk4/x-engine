package com.zkty.nativ.viewer;

import android.text.TextUtils;
import android.view.View;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.utils.FileUtils;
import com.zkty.nativ.viewer.dialog.SelectOpenTypeDialog;
import com.zkty.nativ.viewer.utils.DownloadUtil;

import java.util.List;

public class Nativeviewer extends NativeModule implements Iviewer {

    private List<NativeModule> modules;
    //文件类型
    private String fileType;
    //文件名称
    private String fileName;

    //文件路径
    private String filePath;
    //h5 回调
    private CallBack callBack;

    @Override
    public String moduleId() {
        return "com.zkty.native.viewer";
    }

    @Override
    public void afterAllNativeModuleInited() {
        modules = NativeContext.sharedInstance().getModulesByProtocol(IviewerStatus.class);

    }

    @Override
    public void openFileReader(String fileUrl, String fileType,CallBack callBack) {
        this.callBack = callBack;
        this.fileType = fileType;
        this.fileName = "fileName";
        this.filePath = fileUrl;

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
        if (TextUtils.isEmpty(filePath)) {
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
     *
     * @param iviewerStatus 模块
     * @param isDefault 是否设置默认
     */
    public void openFile(IviewerStatus iviewerStatus, boolean isDefault) {
        iviewerStatus.openFileReader(filePath, fileName, fileType);
        iviewerStatus.setDefault(isDefault);
    }


}
