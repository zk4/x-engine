package com.zkty.modules.loaded.jsapi;

import com.alibaba.fastjson.JSONObject;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.utils.FileUtils;
import com.zkty.modules.engine.utils.ResourceManager;
import com.zkty.modules.loaded.callback.IXEngineNetProtocol;
import com.zkty.modules.loaded.callback.IXEngineNetProtocolCallback;
import com.zkty.modules.loaded.callback.XEngineNetRequest;
import com.zkty.modules.loaded.callback.XEngineNetResponse;
import com.zkty.modules.loaded.imp.DebugUtils;
import com.zkty.modules.loaded.imp.XEngineNetImpl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

public class __xengine__module_network extends xengine__module_network {
    private static final String TAG = "XEngine__module_network";

    @Override
    public void _getRequest(final RequestDTO dto, final CompletionHandler<ReponseDTO> handler) {
        DebugUtils.debug(TAG, "request_GET:" + JSONObject.toJSONString(dto));
        XEngineNetImpl.getInstance().doRequest(IXEngineNetProtocol.Method.GET, dto.url, dto.headers, dto.params, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                ReponseDTO responseDto = new ReponseDTO();

                responseDto.request = dto;
                responseDto.status = response.getCode();
                responseDto.headers = response.getHeader();
                String json = FileUtils.readInputSteam(response.getBody());
                responseDto.data = json;
                DebugUtils.debug(TAG, "json:" + JSONObject.toJSONString(responseDto));

                handler.complete(responseDto);
            }

            @Override
            public void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done) {

            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done) {

            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                DebugUtils.debug(TAG, "error:" + error);
            }
        });
    }

    @Override
    public void _postRequest(final RequestDTO dto, final CompletionHandler<ReponseDTO> handler) {
        DebugUtils.debug(TAG, "request_POST:" + JSONObject.toJSONString(dto));

        XEngineNetImpl.getInstance().doRequest(IXEngineNetProtocol.Method.POST, dto.url, dto.headers, dto.params, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                ReponseDTO responseDto = new ReponseDTO();

                responseDto.request = dto;
                responseDto.status = response.getCode();
                responseDto.headers = response.getHeader();
                String json = FileUtils.readInputSteam(response.getBody());
                responseDto.data = json;
                DebugUtils.debug(TAG, "json:" + JSONObject.toJSONString(responseDto));

                handler.complete(responseDto);
            }

            @Override
            public void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done) {

            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done) {

            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                DebugUtils.debug(TAG, "error:" + error);
            }
        });
    }

    @Override
    public void _deleteRequest(final RequestDTO dto, final CompletionHandler<ReponseDTO> handler) {
        DebugUtils.debug(TAG, "request_DELETE:" + JSONObject.toJSONString(dto));
        XEngineNetImpl.getInstance().doRequest(IXEngineNetProtocol.Method.DELETE, dto.url, dto.headers, dto.params, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                ReponseDTO responseDto = new ReponseDTO();

                responseDto.request = dto;
                responseDto.status = response.getCode();
                responseDto.headers = response.getHeader();
                String json = FileUtils.readInputSteam(response.getBody());
                responseDto.data = json;
                DebugUtils.debug(TAG, "json:" + JSONObject.toJSONString(responseDto));

                handler.complete(responseDto);
            }

            @Override
            public void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done) {

            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done) {

            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                DebugUtils.debug(TAG, "error:" + error);
            }
        });
    }

    @Override
    public void _headRequest(final RequestDTO dto, final CompletionHandler<ReponseDTO> handler) {
        DebugUtils.debug(TAG, "request_HEAD:" + JSONObject.toJSONString(dto));
        XEngineNetImpl.getInstance().doRequest(IXEngineNetProtocol.Method.HEADER, dto.url, dto.headers, dto.params, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                ReponseDTO responseDto = new ReponseDTO();

                responseDto.request = dto;
                responseDto.status = response.getCode();
                responseDto.headers = response.getHeader();
                String json = FileUtils.readInputSteam(response.getBody());
                responseDto.data = json;
                DebugUtils.debug(TAG, "json:" + JSONObject.toJSONString(responseDto));

                handler.complete(responseDto);
            }

            @Override
            public void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done) {

            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done) {

            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                DebugUtils.debug(TAG, "error:" + error);
            }
        });
    }

    @Override
    public void _putRequest(final RequestDTO dto, final CompletionHandler<ReponseDTO> handler) {
        DebugUtils.debug(TAG, "request_PUT:" + JSONObject.toJSONString(dto));

        XEngineNetImpl.getInstance().doRequest(IXEngineNetProtocol.Method.PUT, dto.url, dto.headers, dto.params, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                ReponseDTO responseDto = new ReponseDTO();

                responseDto.request = dto;
                responseDto.status = response.getCode();
                responseDto.headers = response.getHeader();
                String json = FileUtils.readInputSteam(response.getBody());
                responseDto.data = json;
                DebugUtils.debug(TAG, "json:" + JSONObject.toJSONString(responseDto));

                handler.complete(responseDto);
            }

            @Override
            public void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done) {

            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done) {

            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                DebugUtils.debug(TAG, "error:" + error);
            }
        });
    }

    @Override
    public void _patchRequest(final RequestDTO dto, final CompletionHandler<ReponseDTO> handler) {
        DebugUtils.debug(TAG, "request_PATCH:" + JSONObject.toJSONString(dto));
        XEngineNetImpl.getInstance().doRequest(IXEngineNetProtocol.Method.PATCH, dto.url, dto.headers, dto.params, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                ReponseDTO responseDto = new ReponseDTO();

                responseDto.request = dto;
                responseDto.status = response.getCode();
                responseDto.headers = response.getHeader();
                String json = FileUtils.readInputSteam(response.getBody());
                responseDto.data = json;
                DebugUtils.debug(TAG, "json:" + JSONObject.toJSONString(responseDto));

                handler.complete(responseDto);
            }

            @Override
            public void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done) {

            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done) {

            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                DebugUtils.debug(TAG, "error:" + error);
            }
        });
    }

    @Override
    public void _downloadRequest(final DownloadRequestDTO dto, final CompletionHandler<DownloadReponseDTO> handler) {
        DebugUtils.debug(TAG, "request_DOWNLOAD:" + JSONObject.toJSONString(dto));

        XEngineNetImpl.getInstance().doRequest(IXEngineNetProtocol.Method.GET, dto.url, dto.headers, dto.params, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                DownloadReponseDTO downloadReponseDTO = new DownloadReponseDTO();

                downloadReponseDTO.request = dto;

                downloadReponseDTO.status = response.getCode();
                downloadReponseDTO.headers = response.getHeader();

                String temp = dto.url.substring(dto.url.lastIndexOf("/") + 1, dto.url.length());
                if (temp.contains("?")) {
                    temp = temp.substring(0, temp.lastIndexOf("?"));
                }
                DebugUtils.debug(TAG, "file name:" + temp);

                boolean over = false;

                File out = new File(ResourceManager.getCacheDir(), temp);
                InputStream inputStream = null;
                FileOutputStream outputStream = null;
                try {
                    if (!out.exists()) {
                        out.createNewFile();
                    }
                    inputStream = response.getBody();
                    outputStream = new FileOutputStream(out);
                    int readCount = 0;
                    long total = 0;
                    long contentLength = response.getContentLength();
                    byte[] b = new byte[1024];

                    while (true) {
                        readCount = inputStream.read(b);
                        total = total + readCount;
                        if (readCount == -1) {
                            over = true;
                            break;
                        }
                        outputStream.write(b, 0, readCount);

                        onDownLoadProgress(request, response, total, contentLength, total == contentLength);
                    }
                } catch (IOException e) {

                } finally {
                    try {
                        if (inputStream != null) {
                            inputStream.close();
                        }
                        if (outputStream != null) {
                            outputStream.close();
                        }
                    } catch (IOException e) {

                    }
                }

                if (over) {             //保存成功
                    downloadReponseDTO.filePath = out.getPath();
                    DebugUtils.debug(TAG, "json:" + JSONObject.toJSONString(downloadReponseDTO));

                    handler.complete(downloadReponseDTO);
                } else {                //保存失败
                    downloadReponseDTO.filePath = "";
                    DebugUtils.debug(TAG, "json:" + JSONObject.toJSONString(downloadReponseDTO));

                    handler.complete(downloadReponseDTO);
                }
            }

            @Override
            public void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done) {

            }

            private int last = 0;

            @Override
            public void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done) {
                int progress = (int) ((bytesReaded * 100) / contentLength);
                if (last != progress) {
                    DebugUtils.debug(TAG, "---readed:" + bytesReaded + "---contentLength:" + contentLength);
                    mXEngineWebView.callHandler(dto.__event__, new Integer[]{progress});
                }
                last = progress;
            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                DebugUtils.debug(TAG, "error:" + error);
            }
        });

    }

    @Override
    public void _uploadRequest(final UploadRequestDTO dto, final CompletionHandler<UploadReponseDTO> handler) {
        DebugUtils.debug(TAG, "request_UPLOAD:" + JSONObject.toJSONString(dto));

        Map<String, String> file = new HashMap<>();
        file.put(dto.filename, dto.filepath);
        XEngineNetImpl.getInstance().doRequest(IXEngineNetProtocol.Method.POST, dto.url, dto.headers, dto.params, file, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                UploadReponseDTO uploadReponseDTO = new UploadReponseDTO();
                uploadReponseDTO.request = dto;
                uploadReponseDTO.status = response.getCode();
                uploadReponseDTO.headers = response.getHeader();

                String string = FileUtils.readInputSteam(response.getBody());
                uploadReponseDTO.data = string;
                DebugUtils.debug(TAG, "json:" + JSONObject.toJSONString(uploadReponseDTO));

                handler.complete(uploadReponseDTO);
            }


            private int last = 0;

            @Override
            public void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done) {
                DebugUtils.debug(TAG, "upload----written:" + bytesWritten + "---contentLength:" + contentLength + "---done:" + done);
                int progress = (int) ((bytesWritten * 100) / contentLength);
                if (last != progress) {
                    mXEngineWebView.callHandler(dto.__event__, new Integer[]{progress});
                }
                last = progress;
            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done) {

            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                DebugUtils.debug(TAG, "error:" + error);
            }
        });
    }
}
