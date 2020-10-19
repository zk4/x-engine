package com.zkty.modules.loaded.imp;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.io.IOException;

import okhttp3.MediaType;
import okhttp3.RequestBody;
import okio.Buffer;
import okio.BufferedSink;
import okio.ForwardingSink;
import okio.Okio;
import okio.Sink;

public class ProgressRequestBody extends RequestBody {
    private static final String TAG = ProgressRequestBody.class.getSimpleName();


    private RequestBody requestBody;
    private ProgressRequestListener listener;
    protected CountingSink countingSink;


    public ProgressRequestBody(RequestBody requestBody, ProgressRequestListener listener) {
        this.requestBody = requestBody;
        this.listener = listener;
    }

    @Nullable
    @Override
    public MediaType contentType() {
        return requestBody.contentType();
    }

    @Override
    public long contentLength() throws IOException {
        return requestBody.contentLength();
    }

    @Override
    public void writeTo(@NotNull BufferedSink sink) throws IOException {
        countingSink = new CountingSink(sink);

        BufferedSink bufferedSink = Okio.buffer(countingSink);
        requestBody.writeTo(bufferedSink);

        bufferedSink.flush();//必须调用flush，否则最后一部分数据可能不会被写入
    }

    protected final class CountingSink extends ForwardingSink {
        long bytesWritten = 0L;
        long contentLength = 0L;

        public CountingSink(Sink delegate) {
            super(delegate);
        }

        @Override
        public void write(Buffer source, long byteCount) throws IOException {
            super.write(source, byteCount);
            if (contentLength == 0) {
                contentLength = contentLength();
            }
            bytesWritten += byteCount;

            if (listener != null) {
                listener.onRequestProgress(bytesWritten, contentLength, bytesWritten == contentLength);
            }
        }
    }
}
