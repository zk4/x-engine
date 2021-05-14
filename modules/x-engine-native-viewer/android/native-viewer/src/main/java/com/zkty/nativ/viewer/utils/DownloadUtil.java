package com.zkty.nativ.viewer.utils;

import android.os.Environment;

import androidx.annotation.NonNull;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * @author : MaJi
 * @time : (5/13/21)
 * dexc :下载管理类
 */
public class DownloadUtil {
    private static DownloadUtil downloadUtil;
    private final OkHttpClient okHttpClient;

    public static DownloadUtil get() {
        if (downloadUtil == null) {
            downloadUtil = new DownloadUtil();
        }
        return downloadUtil;
    }



    private DownloadUtil() {
        okHttpClient = new OkHttpClient();
    }

    /**
     * @param url 下载连接
     * @param savePath 储存下载文件的SDCard目录
     * @param listener 下载监听
     */
    public void download(final String url, final String savePath, final OnDownloadListener listener) {
        Request request = new Request.Builder().url(url).build();
        okHttpClient.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(okhttp3.Call call, IOException e) {
                // 下载失败
                listener.onDownloadFailed();
            }
            @Override
            public void onResponse(okhttp3.Call call, Response response) throws IOException {
                InputStream is = null;
                byte[] buf = new byte[2048];
                int len = 0;
                FileOutputStream fos = null;
                // 储存下载文件的目录
                try {
                    is = response.body().byteStream();
                    long total = response.body().contentLength();
                    File file = new File(savePath);
                    fos = new FileOutputStream(file);
                    long sum = 0;
                    while ((len = is.read(buf)) != -1) {
                        fos.write(buf, 0, len);
                        sum += len;
                        int progress = (int) (sum * 1.0f / total * 100);
                        // 下载中
                        listener.onDownloading(progress);
                    }
                    fos.flush();
                    // 下载完成
                    listener.onDownloadSuccess();
                } catch (Exception e) {
                    listener.onDownloadFailed();
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
        });
    }

    /**
     * @param saveDir
     * @return
     * @throws IOException
     * 判断下载目录是否存在
     */
    private String isExistDir(String saveDir) throws IOException {
        // 下载位置
        File downloadFile = new File(Environment.getExternalStorageDirectory(), saveDir);
        if (!downloadFile.mkdirs()) {
            downloadFile.createNewFile();
        }
        String savePath = downloadFile.getAbsolutePath();
        return savePath;
    }

    /**
     * @param url
     * @return
     * 从下载连接中解析出文件名
     */
    @NonNull
    public static String getNameFromUrl(String url) {
        return url.substring(url.lastIndexOf("/") + 1);
    }

    public interface OnDownloadListener {
        /**
         * 下载成功
         */
        void onDownloadSuccess();

        /**
         * @param progress
         * 下载进度
         */
        void onDownloading(int progress);

        /**
         * 下载失败
         */
        void onDownloadFailed();
    }


    /**
     * 获取文件类型
     *
     * @param path
     * @return
     */
    public static String getFileType(String path) {
        //获取文件名称
        if(path.startsWith("http") && path.contains("?")){
            path = path.substring(0, path.indexOf("?"));
        }
        String type = "";
        if (path.endsWith(".pdf")) {
            type = "pdf";
        } else if (path.endsWith(".ppt")) {
            type = "ppt";
        } else if (path.endsWith(".pptx")) {
            type = "pptx";
        } else if (path.endsWith(".doc")) {
            type = "doc";
        } else if (path.endsWith(".docx")) {
            type = "docx";
        } else if (path.endsWith(".xls")) {
            type = "xls";
        } else if (path.endsWith(".xlsx")) {
            type = "xlsx";
        } else if (path.endsWith(".txt")) {
            type = "txt";
        } else if (path.endsWith(".epub")) {
            type = "epub";
        }
        return type;
    }

    /**
     * 获取文件名吃
     * @param urlname
     * @return
     */
    public static String getFileName(String urlname) {
        if(urlname.startsWith("http")){
            //获取文件名称
            urlname = urlname.substring(0, urlname.indexOf("?"));
            int start = urlname.lastIndexOf("/");
            int end = urlname.length();
            if (start != -1 && end != -1) {
                return urlname.substring(start + 1, end);
            } else {
                return null;
            }
        }else{
            File file = new File(urlname);
            String fileName = file.getName();
            return fileName;
        }
    }
}

