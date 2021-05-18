package com.zkty.nativ.share;

public interface IShareManager {

    void share(String channel, String type, String text, String title, String desc, String imgUrl, String imgData, String url
            , String userName, String path, String link, int miniProgramType);

}
