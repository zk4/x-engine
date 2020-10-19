package com.zkty.engine.module.network.net;

import android.os.Build;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class NetManager {
    private static final int CONNECTTIMEOUT = 30000;
    private static final int READTIMEOUT = 30000;


    public static Response httpGet(String url) {

        Response response = null;

        HttpURLConnection httpURLConnection = null;
        try {
            URL urlObj = new URL(url);

            httpURLConnection = (HttpURLConnection) urlObj.openConnection();

            httpURLConnection.setConnectTimeout(CONNECTTIMEOUT);
            httpURLConnection.setReadTimeout(READTIMEOUT);

            httpURLConnection.setDoInput(true);

            // 4.0 ~ 4.3 存在EOFException
            if (Build.VERSION.SDK_INT > 13 && Build.VERSION.SDK_INT < 19) {
                httpURLConnection.setRequestProperty("Connection", "close");
            }

            response = readStream(httpURLConnection);

        } catch (MalformedURLException e) {
            e.printStackTrace();

            response = new Response();
            response.content = e.getMessage();
            response.code = -1;
        } catch (IOException e) {
            e.printStackTrace();

            response = new Response();
            response.content = e.getMessage();
            response.code = -1;
        } catch (Exception ex) {
            ex.printStackTrace();
            response = new Response();
            response.content = ex.getMessage();
            response.code = -1;
        } finally {
            if (httpURLConnection != null)
                httpURLConnection.disconnect();
        }

        return response;
    }

    static Response readStream(HttpURLConnection connection) {
        Response response = new Response();

        StringBuilder stringBuilder = new StringBuilder();

        BufferedReader reader = null;
        try {

            reader = new BufferedReader(new InputStreamReader(
                    connection.getInputStream(), "UTF-8"));

            int tmp;
            while ((tmp = reader.read()) != -1) {
                stringBuilder.append((char) tmp);
            }

            response.code = connection.getResponseCode();
            response.content = stringBuilder.toString();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            response.code = -1;
            response.content = e.getMessage();
        } catch (IOException e) {
            e.printStackTrace();

            try {
                //it could be caused by 400 and so on

                reader = new BufferedReader(new InputStreamReader(
                        connection.getErrorStream(), "UTF-8"));

                //clear
                stringBuilder.setLength(0);

                int tmp;
                while ((tmp = reader.read()) != -1) {
                    stringBuilder.append((char) tmp);
                }

                response.code = connection.getResponseCode();
                response.content = stringBuilder.toString();

            } catch (IOException e1) {
                response.content = e1.getMessage();
                response.code = -1;
                e1.printStackTrace();
            } catch (Exception ex) {
                //if user directly shuts down network when trying to write to server
                //there could be NullPointerException or SSLException
                response.content = ex.getMessage();
                response.code = -1;
                ex.printStackTrace();
            }
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return response;
    }

    //return null means successfully write to server
    static Response writeStream(HttpURLConnection connection, String content) {
        BufferedOutputStream out = null;
        Response response = null;
        try {
            out = new BufferedOutputStream(connection.getOutputStream());
            out.write(content.getBytes("UTF-8"));
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();

            try {
                //it could be caused by 400 and so on
                response = new Response();

                BufferedReader reader = new BufferedReader(new InputStreamReader(
                        connection.getErrorStream(), "UTF-8"));

                StringBuilder stringBuilder = new StringBuilder();

                int tmp;
                while ((tmp = reader.read()) != -1) {
                    stringBuilder.append((char) tmp);
                }

                response.code = connection.getResponseCode();
                response.content = stringBuilder.toString();

            } catch (IOException e1) {
                response = new Response();
                response.content = e1.getMessage();
                response.code = -1;
                e1.printStackTrace();
            } catch (Exception ex) {
                //if user directly shutdowns network when trying to write to server
                //there could be NullPointerException or SSLException
                response = new Response();
                response.content = ex.getMessage();
                response.code = -1;
                ex.printStackTrace();
            }
        } finally {
            try {
                if (out != null)
                    out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return response;
    }

    /**
     * http post 请求
     *
     * @param url     请求url
     * @param jsonStr post参数
     * @return HttpResponse请求结果实例
     */
    public static Response httpPost(String url, String jsonStr) {
        Response response = null;

        HttpURLConnection httpURLConnection = null;
        try {
            URL urlObj = new URL(url);

            httpURLConnection = (HttpURLConnection) urlObj.openConnection();

            httpURLConnection.setRequestMethod("POST");
            httpURLConnection.setConnectTimeout(CONNECTTIMEOUT);
            httpURLConnection.setReadTimeout(READTIMEOUT);
            httpURLConnection.setRequestProperty("Content-Type", "application/json;charset=utf-8");
            httpURLConnection.setDoOutput(true);
            httpURLConnection.setChunkedStreamingMode(0);

            // 4.0 ~ 4.3 存在EOFException
            if (Build.VERSION.SDK_INT > 13 && Build.VERSION.SDK_INT < 19) {
                httpURLConnection.setRequestProperty("Connection", "close");
            }

            //start to post
            response = writeStream(httpURLConnection, jsonStr);

            if (response == null) { //if post successfully

                response = readStream(httpURLConnection);

            }
        } catch (MalformedURLException e) {
            e.printStackTrace();

            response = new Response();
            response.content = e.getMessage();
            response.code = -1;
        } catch (IOException e) {
            e.printStackTrace();

            response = new Response();
            response.content = e.getMessage();
            response.code = -1;
        } catch (Exception ex) {
            ex.printStackTrace();
            response = new Response();
            response.content = ex.getMessage();
            response.code = -1;
        } finally {
            if (httpURLConnection != null)
                httpURLConnection.disconnect();
        }

        return response;
    }

    public static class Response {
        public Integer code;
        public String content;


    }
}