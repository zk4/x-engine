package com.zkty.nativ.gmupload;

/**
 * @author : MaJi
 * @time : (8/25/21)
 * dexc :
 */
public interface OnUploadListener {
    /**
     * 下载成功
     */
    void onUploadSuccess(String dataStr);

    /**
     * @param progress
     * 下载进度
     */
    void onUploading(int progress);

    /**
     * 下载失败
     */
    void onUploadFailed();
}
