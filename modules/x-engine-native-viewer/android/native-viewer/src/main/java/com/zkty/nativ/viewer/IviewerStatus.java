package com.zkty.nativ.viewer;

import java.util.List;

public interface IviewerStatus {

    /**
     * 模块ID
     * @return
     */
    String moduleId();
    /**
     * 获取该模块的图片
     * @return
     */
    String getModelPicUrl();

    /**
     * 获取该模块的图片
     * @return
     */
    int getModelPicRes();

    /**
     * 获取该模块的名称
     * @return
     */
    String getModelName();
    /**
     * 是否是默认
     * @return
     */
    boolean isDefault();

    /**
     * 是否支持在线打开
     * @return
     */
    boolean isOnlineOpen();

    /**
     * 设置默认 状态
     * @return
     */
    void setDefault(Boolean isDefault);
    /**
     * 支持的类型
     * @return
     */
    List<String> typeList();

    /**
     * 打开文件预览
     * @param filePath
     * @param fileType
     */
    void openFileReader(String filePath,String fileName,String fileType);
}
