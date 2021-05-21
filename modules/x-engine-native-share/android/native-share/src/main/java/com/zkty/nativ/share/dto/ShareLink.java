package com.zkty.nativ.share.dto;

import com.zkty.nativ.core.annotation.Optional;

import java.io.Serializable;

public class ShareLink implements Serializable {
    public String title;

    public String desc;

    @Optional
    public String imgUrl;

    public String url;
}
