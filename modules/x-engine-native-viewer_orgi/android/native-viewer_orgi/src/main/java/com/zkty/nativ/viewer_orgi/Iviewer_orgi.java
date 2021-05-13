package com.zkty.nativ.viewer_orgi;

import java.util.List;

public interface Iviewer_orgi {
    /**
     * 是否是默认
     * @return
     */
    boolean isDefault();


    /**
     * 获取该模块的图片
     * @return
     */
    String getModelPic();

    /**
     * 获取该模块的名称
     * @return
     */
    String getModelName();

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
    void openFileReader(String filePath,String fileType);
}
