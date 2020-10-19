package com.zkty.modules.loaded.imp.utils;

import com.zkty.modules.loaded.imp.data.MediaFile;

import java.util.ArrayList;
import java.util.List;

public class DataUtil {

    private static volatile DataUtil mDataUtilInstance;
    private List<MediaFile> mData = new ArrayList<>();

    private DataUtil() {
    }

    public static DataUtil getInstance() {
        if (mDataUtilInstance == null) {
            synchronized (DataUtil.class) {
                if (mDataUtilInstance == null) {
                    mDataUtilInstance = new DataUtil();
                }
            }
        }
        return mDataUtilInstance;
    }

    public List<MediaFile> getMediaData() {
        return mData;
    }

    public void setMediaData(List<MediaFile> data) {
        this.mData = data;
    }


}
