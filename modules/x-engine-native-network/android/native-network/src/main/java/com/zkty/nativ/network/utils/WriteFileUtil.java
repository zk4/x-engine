package com.zkty.nativ.network.utils;

import android.os.Handler;
import android.os.Looper;

import com.zkty.nativ.network.net.myinterface.OnDownloadListener;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import okhttp3.ResponseBody;

/**
 * @author : MaJi
 * @time : (5/26/21)
 * dexc :
 */
public class WriteFileUtil {
    public static Handler mHandler = new Handler(Looper.getMainLooper());
    public static void writeFile(ResponseBody body, String filePath, OnDownloadListener onDownloadListener) {
        InputStream is = null;
        byte[] buf = new byte[2048];
        int len = 0;
        FileOutputStream fos = null;
        // 储存下载文件的目录
        try {
            is = body.byteStream();
            long total = body.contentLength();
            File file = new File(filePath);
            fos = new FileOutputStream(file);
            long sum = 0;
            while ((len = is.read(buf)) != -1) {
                fos.write(buf, 0, len);
                sum += len;
                int progress = (int) (sum * 1.0f / total * 100);
                // 下载中
                mHandler.post(() -> onDownloadListener.onDownloading(progress));
            }
            fos.flush();
            // 下载完成
            mHandler.post(() -> onDownloadListener.onDownloadSuccess());

        } catch (Exception e) {
            mHandler.post(() -> onDownloadListener.onDownloadFailed());
        } finally {
            try {
                if (is != null)
                    is.close();
            } catch (IOException e) {
            }
            try {
                if (fos != null)
                    fos.close();
            } catch (IOException e) {
            }
        }
    }
}
