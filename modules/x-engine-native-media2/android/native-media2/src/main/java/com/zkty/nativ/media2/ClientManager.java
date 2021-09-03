package com.zkty.nativ.media2;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.media.ExifInterface;
import android.net.Uri;
import android.os.ParcelFileDescriptor;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.Base64;
import android.util.Log;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
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

                byte[] bitmapBytes = baos.toByteArray();
                result = Base64.encodeToString(bitmapBytes, Base64.NO_WRAP);
                baos.flush();
                baos.close();
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

    /**
     * 将图片转换成Base64编码的字符串
     */
    public static String imageToBase64(String path) {
        if (TextUtils.isEmpty(path)) {
            return null;
        }
        InputStream is = null;
        byte[] data = null;
        String result = null;
        try {
            is = new FileInputStream(path);
            //创建一个字符流大小的数组。
            data = new byte[is.available()];
            //写入数组
            is.read(data);
            //用默认的编码格式进行编码
            result = Base64.encodeToString(data, Base64.NO_WRAP);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null != is) {
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
        return result;
    }

    /**
     * 将图片转换成Base64编码的字符串
     */
    public static String imageToBase64(Context context, String path) {
        if (TextUtils.isEmpty(path)) {
            return null;
        }
        String result = null;

        Uri uri = getImageContentUri(context, path);
        if (uri != null) {
            Bitmap bitmap = getBitmapFromUri(context, uri);
            if (bitmap != null) {
                result = bmpToBase64(bitmap);
            }
        }


        return result;
    }


    public static Uri getImageContentUri(Context context, String path) {
        Cursor cursor = context.getContentResolver().query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                new String[]{MediaStore.Images.Media._ID}, MediaStore.Images.Media.DATA + "=? ",
                new String[]{path}, null);
        if (cursor != null && cursor.moveToFirst()) {
            int id = cursor.getInt(cursor.getColumnIndex(MediaStore.MediaColumns._ID));
            Uri baseUri = Uri.parse("content://media/external/images/media");
            return Uri.withAppendedPath(baseUri, "" + id);
        } else {
            // 如果图片不在手机的共享图片数据库，就先把它插入。
            if (new File(path).exists()) {
                ContentValues values = new ContentValues();
                values.put(MediaStore.Images.Media.DATA, path);
                return context.getContentResolver().insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);
            } else {
                return null;
            }
        }
    }


    public static Bitmap getBitmapFromUri(Context context, Uri uri) {
        try {
            ParcelFileDescriptor parcelFileDescriptor =
                    context.getContentResolver().openFileDescriptor(uri, "r");
            FileDescriptor fileDescriptor = parcelFileDescriptor.getFileDescriptor();
            Bitmap image = BitmapFactory.decodeFileDescriptor(fileDescriptor);
            parcelFileDescriptor.close();
            return image;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;


    }

    //获取图片的旋转角度
    public static int readPictureDegree(String path) {
        int degree = 0;
        try {
            ExifInterface exifInterface = new ExifInterface(path);
            int orientation = exifInterface.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL);
            switch (orientation) {
                case ExifInterface.ORIENTATION_ROTATE_90:
                    degree = 90;
                    break;
                case ExifInterface.ORIENTATION_ROTATE_180:
                    degree = 180;
                    break;
                case ExifInterface.ORIENTATION_ROTATE_270:
                    degree = 270;
                    break;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return degree;
    }

    /**
     * 将本地图片转成Bitmap
     *
     * @param path 已有图片的路径
     * @return
     */
    public static Bitmap openImage(String path) {
        Bitmap bitmap = null;
        try {
            BufferedInputStream bis = new BufferedInputStream(new FileInputStream(path));
            bitmap = BitmapFactory.decodeStream(bis);
            bis.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return bitmap;
    }

    /**
     * 旋转图片
     *
     * @param angle
     * @param bitmap
     * @return Bitmap
     */
    public static Bitmap rotaingImageView(int angle, Bitmap bitmap) {
        //旋转图片 动作
        Matrix matrix = new Matrix();
        matrix.postRotate(angle);
        // 创建新的图片
        Bitmap resizedBitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.getWidth(), bitmap.getHeight(), matrix, true);
        return resizedBitmap;
    }

    // 根据路径获得图片并压缩，返回bitmap用于显示
    public static Bitmap getSmallBitmap(String filePath) {
        final BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(filePath, options);

        // Calculate inSampleSize
        options.inSampleSize = calculateInSampleSize(options, 480, 800);

        // Decode bitmap with inSampleSize set
        options.inJustDecodeBounds = false;

        return BitmapFactory.decodeFile(filePath, options);
    }

    //计算图片的缩放值
    public static int calculateInSampleSize(BitmapFactory.Options options, int reqWidth, int reqHeight) {
        final int height = options.outHeight;
        final int width = options.outWidth;
        int inSampleSize = 1;

        if (height > reqHeight || width > reqWidth) {
            final int heightRatio = Math.round((float) height / (float) reqHeight);
            final int widthRatio = Math.round((float) width / (float) reqWidth);
            inSampleSize = heightRatio < widthRatio ? heightRatio : widthRatio;
        }
        return inSampleSize;
    }

    //把bitmap转换成String
    public static String bitmapToString(String filePath) {
        Bitmap bm = getSmallBitmap(filePath);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        //1.5M的压缩后在100Kb以内，测试得值,压缩后的大小=94486字节,压缩后的大小=74473字节
        //这里的JPEG 如果换成PNG，那么压缩的就有600kB这样
        bm.compress(Bitmap.CompressFormat.JPEG, 40, baos);
        byte[] b = baos.toByteArray();
        Log.d("d", "压缩后的大小=" + b.length);
        return Base64.encodeToString(b, Base64.DEFAULT);
    }

    //把bitmap转换成String
    public static String bitmapCompressToString(String filePath) {
        Bitmap bm = openImage(filePath);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        //1.5M的压缩后在100Kb以内，测试得值,压缩后的大小=94486字节,压缩后的大小=74473字节
        //这里的JPEG 如果换成PNG，那么压缩的就有600kB这样
        bm.compress(Bitmap.CompressFormat.JPEG, 100, baos);
        Log.d("bitmapCompressToString", "压缩后的大小=" +  baos.toByteArray().length);
        int options = 100;
        while ( baos.toByteArray().length / 1024 / 1024 > 6) {    //循环判断如果压缩后图片是否大于6m,大于继续压缩
            baos.reset();//重置baos即清空baos
            options -= 10;//每次都减少10
            bm.compress(Bitmap.CompressFormat.JPEG, options, baos);//这里压缩options%，把压缩后的数据存放到baos中
            Log.d("bitmapCompressToString", options +" 压缩后的大小= " + baos.toByteArray().length);
        }

        return Base64.encodeToString(baos.toByteArray(), Base64.DEFAULT);
    }
}
