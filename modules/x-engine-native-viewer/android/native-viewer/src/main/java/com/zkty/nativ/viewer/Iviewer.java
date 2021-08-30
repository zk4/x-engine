package com.zkty.nativ.viewer;

public interface Iviewer {


    /**
     * 打开文件预览
     * @param fileUrl
     * @param fileType
     * @param title
     * @param callBack
     */
    void openFileReader(String fileUrl,String fileType,String title,CallBack callBack);




}
