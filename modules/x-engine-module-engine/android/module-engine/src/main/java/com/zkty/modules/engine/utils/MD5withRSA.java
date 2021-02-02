package com.zkty.modules.engine.utils;

import android.util.Base64;

import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.Cipher;

public class MD5withRSA {
    /**
     * RSA算法
     */
    public static final String RSA = "RSA";
    /**加密方式，android的*/
//  public static final String TRANSFORMATION = "RSA/None/NoPadding";
    /**
     * 加密方式，标准jdk的
     */
    public static final String TRANSFORMATION = "RSA/None/PKCS1Padding";

    /**
     * 使用公钥加密
     */
    public static String encryptByPublicKey(byte[] data, byte[] publicKey) {
        String result = null;
        try {

            // 得到公钥对象
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKey);
            KeyFactory keyFactory = KeyFactory.getInstance("RSA", "BC");
            PublicKey pubKey = keyFactory.generatePublic(keySpec);
            // 加密数据
            Cipher cp = Cipher.getInstance(TRANSFORMATION);
            cp.init(Cipher.DECRYPT_MODE, pubKey);
//            result = Base64.encodeToString(cp.doFinal(data), Base64.DEFAULT);
            result = new String(cp.doFinal(data));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 使用私钥解密
     */
    public static String decryptByPrivateKey(byte[] encrypted, byte[] privateKey) {
        String result = null;

        try {
            // 得到私钥对象
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKey);
            KeyFactory kf = KeyFactory.getInstance(RSA, "BC");
            PublicKey keyPrivate = kf.generatePublic(keySpec);
            // 解密数据
            Cipher cp = Cipher.getInstance(TRANSFORMATION);
            cp.init(Cipher.DECRYPT_MODE, keyPrivate);
            byte[] arr = cp.doFinal(encrypted);
            result = String.valueOf(arr);

        } catch (Exception e) {
            e.printStackTrace();
        }


        return result;
    }

    /**
     * 验签
     *
     * @param srcData   原始字符串
     * @param publicKey 公钥
     * @param sign      签名
     * @return 是否验签通过
     */
    public static boolean verifySign(String srcData, String publicKeyStr, String sign) {

        boolean result = false;
        try {
            PublicKey publicKey = getPublicKey(publicKeyStr);
            byte[] keyBytes = publicKey.getEncoded();
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(keyBytes);
            KeyFactory keyFactory = KeyFactory.getInstance("RSA", "BC");
            PublicKey key = keyFactory.generatePublic(keySpec);
            Signature signature = Signature.getInstance("MD5withRSA");
            signature.initVerify(key);
            signature.update(srcData.getBytes());
            result = signature.verify(Base64.decode(sign.getBytes(), Base64.DEFAULT));

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;


    }

    public static PublicKey getPublicKey(String publicKey) {
        try {
            KeyFactory keyFactory = KeyFactory.getInstance("RSA", "BC");
            byte[] decodedKey = Base64.decode(publicKey.getBytes(), Base64.DEFAULT);
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(decodedKey);
            return keyFactory.generatePublic(keySpec);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }

}
