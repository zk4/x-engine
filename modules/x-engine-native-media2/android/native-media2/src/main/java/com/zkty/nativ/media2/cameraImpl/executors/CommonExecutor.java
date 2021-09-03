package com.zkty.nativ.media2.cameraImpl.executors;


import androidx.annotation.NonNull;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;

public class CommonExecutor {

    private static volatile CommonExecutor mCommonExecutor;
    private ExecutorService mExecutorService;

    private CommonExecutor() {
        mExecutorService = Executors.newCachedThreadPool(new ThreadFactory() {
            @Override
            public Thread newThread(@NonNull Runnable runnable) {
                Thread thread = new Thread(runnable);
                thread.setName("CommonExecutor");
                return thread;
            }
        });
    }

    public static CommonExecutor getInstance() {
        if (mCommonExecutor == null) {
            synchronized (CommonExecutor.class) {
                if (mCommonExecutor == null) {
                    mCommonExecutor = new CommonExecutor();
                }
            }
        }
        return mCommonExecutor;
    }


    public void execute(Runnable runnable) {
        mExecutorService.execute(runnable);
    }

}
