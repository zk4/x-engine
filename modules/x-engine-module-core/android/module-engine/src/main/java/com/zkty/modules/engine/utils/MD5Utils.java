package com.zkty.modules.engine.utils;

import android.text.TextUtils;
import android.util.Log;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * md5工具类
 */
public class MD5Utils {
    private static final String TAG = "MD5";
    private final static char[] HEX_CHARS = "0123456789abcdef".toCharArray();


    public static boolean checkMD5(String md5, File updateFile) {
        if (TextUtils.isEmpty(md5) || !updateFile.exists()) {
            Log.d(TAG, "MD5 string empty or updateFile null");
            return false;
        }
        String calculatedDigest = calculateMD5(updateFile);
        if (calculatedDigest == null) {
            Log.e(TAG, "calculatedDigest null");
            return false;
        }
        Log.d(TAG, "Calculated digest: " + calculatedDigest);
        Log.d(TAG, "Provided digest: " + md5);
        return calculatedDigest.equalsIgnoreCase(md5);
    }


    /**
     * @param updateFile
     * @return
     */
    public static String calculateMD5(File updateFile) {
        String temp = "";
        if (updateFile.exists() && !updateFile.isDirectory()) {         //存在且是文件
            InputStream inputStream = null;
            try {
                inputStream = new FileInputStream(updateFile);
                temp = calculateMD5(inputStream);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } finally {
                if (inputStream != null) {
                    try {
                        inputStream.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return temp;
    }

    public static String calculateMD5(InputStream is) {
        MessageDigest digest;
        try {
            digest = MessageDigest.getInstance("MD5");
            byte[] buffer = new byte[8192];
            int read;
            try {
                while ((read = is.read(buffer)) > 0) {
                    digest.update(buffer, 0, read);
                }
                byte[] md5sum = digest.digest();
                BigInteger bigInt = new BigInteger(1, md5sum);
                String output = bigInt.toString(16);
                // Fill to 32 chars
                output = String.format("%32s", output).replace(' ', '0');
                return output;
            } catch (IOException e) {
                Log.d(TAG, "Unable to process file for MD5", e);
                return "";
            } finally {
                try {
                    is.close();
                } catch (IOException e) {
                    Log.d(TAG, "Exception on closing MD5 input stream", e);
                }
            }
        } catch (NoSuchAlgorithmException e) {
            Log.d(TAG, "Exception while getting digest", e);
            return "";
        }
    }

    /**
     * 计算一个字符串的MD5值
     */
    public static String getMD5(String str) {
        try {
            // 生成一个MD5加密计算摘要
            MessageDigest md = MessageDigest.getInstance("MD5");
            // 计算md5函数
            md.update(str.getBytes());
            // digest()最后确定返回md5 hash值，返回值为8为字符串。因为md5 hash值是16位的hex值，实际上就是8位的字符
            // BigInteger函数则将8位的字符串转换成16位hex值，用字符串来表示；得到字符串形式的hash值
            return bytesToHex(md.digest());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 将bytes数组转化为16进制
     */
    private static String bytesToHex(byte[] bytes) {
        char[] hexChars = new char[bytes.length * 2];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 0xFF;
            hexChars[j * 2] = HEX_CHARS[v >>> 4];
            hexChars[j * 2 + 1] = HEX_CHARS[v & 0x0F];
        }
        return new String(hexChars);
    }
}
