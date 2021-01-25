package com.zkty.engine.module.xxxx.network.networkframe.net.exception;

import android.os.Build;
import android.util.Log;

import com.zkty.engine.module.xxxx.network.Constants;
import com.zkty.engine.module.xxxx.network.utils.FraCommUtil;
import com.zkty.engine.module.xxxx.network.utils.MyDateUtils;
import com.zkty.engine.module.xxxx.network.utils.StreamUtil;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.Thread.UncaughtExceptionHandler;
import java.lang.reflect.Field;
import java.nio.charset.StandardCharsets;


/**
 * 未捕获异常的基本处理方式:将未捕获异常详细信息写入到本地，其他的处理方式需要重写onUncaughtException（String str）方法
 */
public abstract class BaseUncaughtExceptionHandler implements UncaughtExceptionHandler {


    @Override
    public void uncaughtException(Thread thread, Throwable ex) {

        StringWriter sw = new StringWriter();

        PrintWriter pw = new PrintWriter(sw);
        //将异常信息写入到打印流
        ex.printStackTrace(pw);
        FileOutputStream fos = null;
        try {
            StringBuilder sb = new StringBuilder();
            //获取所有关于手机信息的字段
            Field[] fields = Build.class.getFields();
            for (Field field : fields) {
                //遍历字段获取其值
                String value = field.get(null).toString();
                String name = field.getName();
                sb.append(name + ":" + value + "\n");
            }

            String errormsg = sw.toString();

            sb.append(errormsg);

            String error = sb.toString();

            Log.d(getClass().getSimpleName(), error);
            if (FraCommUtil.isSDcardExist()) {
                //如果SD卡存在
                File filePath = new File(FraCommUtil.getSDCard() + Constants.APP_ERROR_LOG);
                //判断文件是否存在
                if (!filePath.exists()) {
                    filePath.mkdirs();
                }
                //创建文件对象
                File file = new File(filePath, MyDateUtils.getCurrentStringDay(MyDateUtils.YYYYMMDDHHMMSS) + ".txt");
                fos = new FileOutputStream(file);
                fos.write(error.getBytes(StandardCharsets.UTF_8));


            }
            //未捕获异常的其他处理方式
            onUncaughtException(error);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            StreamUtil.close(fos);
        }

        android.os.Process.killProcess(android.os.Process.myPid());
        System.exit(1);
    }

    /**
     * 未捕获异常的其他处理方式(已经将错误日志写入到本地)
     *
     * @param str 错误信息（包括手机的所有信息）
     */
    public abstract void onUncaughtException(String str);

}
