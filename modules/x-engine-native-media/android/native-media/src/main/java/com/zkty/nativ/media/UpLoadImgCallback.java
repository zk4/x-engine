package com.zkty.nativ.media;

/**
 * @author : MaJi
 * @time : (8/20/21)
 * dexc :
 */
public interface UpLoadImgCallback {
    void onUpLoadSucces(int status,String id,String msg,String dataStr,boolean isCommplete);
    void onUploadFail();
}
