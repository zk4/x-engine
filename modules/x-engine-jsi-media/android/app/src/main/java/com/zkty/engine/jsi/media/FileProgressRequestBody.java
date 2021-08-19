package com.jianiao.test;

import java.io.File;
import java.io.IOException;

import okhttp3.MediaType;
import okhttp3.RequestBody;
import okio.Buffer;
import okio.BufferedSink;
import okio.ForwardingSink;
import okio.Okio;
import okio.Sink;

/**
 * @author : MaJi
 * @time : (8/19/21)
 * dexc :
 */
public class FileProgressRequestBody extends RequestBody {

    /**
     * @author : MaJi
     * @time : (5/26/21)
     * dexc :
     */
    public interface OnUploadListener {
        /**
         * 下载成功
         */
        void onUploadSuccess();

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
    private RequestBody mRequestBody;
    private OnUploadListener fileUploadObserver;

    public FileProgressRequestBody(File file, OnUploadListener fileUploadObserver) {
        this.mRequestBody = RequestBody.create(MediaType.parse("application/octet-stream"), file);
        this.fileUploadObserver = fileUploadObserver;
    }


    @Override
    public MediaType contentType() {
        return mRequestBody.contentType();
    }

    @Override
    public long contentLength() throws IOException {
        return mRequestBody.contentLength();
    }

    @Override
    public void writeTo(BufferedSink sink) throws IOException {

        CountingSink countingSink = new CountingSink(sink);
        BufferedSink bufferedSink = Okio.buffer(countingSink);
        //写入
        mRequestBody.writeTo(bufferedSink);
        //刷新
        //必须调用flush，否则最后一部分数据可能不会被写入
        bufferedSink.flush();

    }

    protected final class CountingSink extends ForwardingSink {

        private long bytesWritten = 0;

        public CountingSink(Sink delegate) {
            super(delegate);
        }

        @Override
        public void write(Buffer source, long byteCount) throws IOException {
            super.write(source, byteCount);

            bytesWritten += byteCount;
            if (fileUploadObserver != null) {
                if(bytesWritten == contentLength()){
                    fileUploadObserver.onUploadSuccess();
                }else{
                    fileUploadObserver.onUploading((int) (bytesWritten*100 / contentLength()));
                }

            }

        }

    }
}