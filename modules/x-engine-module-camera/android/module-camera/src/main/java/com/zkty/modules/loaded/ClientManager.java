package com.zkty.modules.loaded;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.text.TextUtils;
import android.util.Base64;
import android.util.Log;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;

public class ClientManager {
    private static final String TAG = ClientManager.class.getSimpleName();

    private static Context mContext;
    private static String filePath;
    private static EditArgs editArgs;


    private static Map<String, Socket> clientList = new HashMap<>();
    private static ServerThread serverThread = null;
    private static PrintStream writer;

    private static class ServerThread implements Runnable {

        private int port = 18129;
        private boolean isExit = false;
        private ServerSocket server;

        public ServerThread() {
            try {
                server = new ServerSocket(port);
                Log.d(TAG, "启动服务成功" + "port:" + port);
            } catch (IOException e) {
                Log.d(TAG, "启动server失败，错误原因：" + e.getMessage());
            }
        }

        @Override
        public void run() {
            try {
                while (!isExit) {           // 进入等待环节
                    Log.d(TAG, "等待设备的连接... ... ");
                    final Socket socket = server.accept();
                    // 获取手机连接的地址及端口号
                    final String address = socket.getRemoteSocketAddress().toString();
                    Log.d(TAG, "连接成功，连接的设备为：" + address);
                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            try {// 单线程索锁
                                synchronized (this) {// 放进到Map中保存
                                    clientList.put(address, socket);
                                }
                                // 定义输入流
                                InputStream inputStream = socket.getInputStream();

                                InputStreamReader isr = new InputStreamReader(socket.getInputStream(), "UTF-8");

                                byte[] buffer = new byte[1024];
                                int len;
                                while ((len = inputStream.read(buffer)) != -1) {
                                    String text = new String(buffer, 0, len);
                                    Log.d(TAG, "收到的数据为：\n" + text);
                                    // 必须先关闭输入流才能获取下面的输出流
                                    socket.shutdownInput();
                                    // 在这里群发消息
                                    sendMsgAll();
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                Log.d(TAG, "错误信息为：" + e.getMessage());
                            } finally {
                                synchronized (this) {
                                    Log.d(TAG, "关闭链接：" + address);
                                    clientList.remove(address);
                                }
                            }
                        }
                    }).start();

                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        public void Stop() {
            isExit = true;
            if (server != null) {
                try {
                    server.close();
                    Log.d(TAG, "已关闭server");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static ServerThread startServer(Context context, String filepath, EditArgs args) {
        mContext = context;
        filePath = filepath;
        editArgs = args;

        Log.d(TAG, "开启服务");
        if (serverThread != null) {
            showDown();
        }
        serverThread = new ServerThread();
        new Thread(serverThread).start();
        Log.d(TAG, "开启服务成功");
        return serverThread;
    }

    // 关闭所有server socket 和 清空Map
    public static void showDown() {
        if (serverThread != null && clientList != null) {
            for (Socket socket : clientList.values()) {
                try {
                    socket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (writer != null) {
                writer.close();
            }
            serverThread.Stop();
            clientList.clear();

        }

    }

    // 群发的方法
    public static boolean sendMsgAll() {
        try {
            for (Socket socket : clientList.values()) {
                if (writer != null) {
                    writer.close();
                }
                writer = new PrintStream(socket.getOutputStream());//告诉客户端连接成功 并传状态过去
//                writer.println("HTTP/1.1 200 OK");// 返回应答消息,并结束应答
//                writer.println("Content-Length: " + returnServer.getBytes().length);// 返回内容字节数
//                writer.println("Content-Type: text/plain;charset=utf-8");
//                writer.println();// 根据 HTTP 协议, 空行将结束头信息
//                writer.write(returnServer.getBytes());

                if (!TextUtils.isEmpty(filePath)) {
                    BitmapFactory.Options options = new BitmapFactory.Options();
                    options.inPreferredConfig = Bitmap.Config.RGB_565;
                    Log.d(TAG, "path:" + filePath);
                    Log.d(TAG, "start:" + System.currentTimeMillis());
                    Bitmap bitmap = BitmapFactory.decodeFile(filePath, options);

                    if (editArgs != null && !TextUtils.isEmpty(editArgs.getQuality())) {                //质量压缩
                        bitmap = compressBitmap(bitmap, (int) (Float.parseFloat(editArgs.getQuality()) * 100));
                    }

                    String base64 = bmpToBase64(bitmap);
                    writer.println(base64);
                } else {
                    writer.println("");
                }

                writer.flush();
                // 关闭输出流
                socket.shutdownOutput();
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    private static Bitmap compressBitmap(Bitmap bitmap, int quality) {
        System.out.println("bitmap==" + bitmap.getByteCount());
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        //通过这里改变压缩类型，其有不同的结果
        bitmap.compress(Bitmap.CompressFormat.JPEG, quality, bos);
        System.out.println("bos=====" + bos.size());
        ByteArrayInputStream bis = new ByteArrayInputStream(bos.toByteArray());
        System.out.println("bis=====" + bis.available());
        return BitmapFactory.decodeStream(bis);
    }

    /**
     * bitmap转Base64
     *
     * @param bitmap
     * @return
     */
    public static String bmpToBase64(Bitmap bitmap) {
        String result = null;
        ByteArrayOutputStream baos = null;
        try {
            if (bitmap != null) {
                baos = new ByteArrayOutputStream();
                bitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos);
                baos.flush();
                baos.close();
                byte[] bitmapBytes = baos.toByteArray();
                result = Base64.encodeToString(bitmapBytes, Base64.DEFAULT);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (baos != null) {
                    baos.flush();
                    baos.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

}
