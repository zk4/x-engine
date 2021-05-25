package com.zkty.nativ.network.net;




import com.zkty.nativ.network.NetworkMaster;

import java.io.File;

import okhttp3.Cache;

public class HttpCache {

    private static final int HTTP_RESPONSE_DISK_CACHE_MAX_SIZE = 50 * 1024 * 1024;

    public static Cache getCache() {
        return new Cache(new File(NetworkMaster.getContext().getCacheDir().getAbsolutePath() + File.separator + "data/NetCache"),
                HTTP_RESPONSE_DISK_CACHE_MAX_SIZE);
    }
}
