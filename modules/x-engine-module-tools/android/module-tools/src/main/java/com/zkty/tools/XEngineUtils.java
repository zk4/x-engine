package com.zkty.tools;

import android.text.TextUtils;
import android.util.Log;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

public class XEngineUtils {
    private static final String TAG = XEngineUtils.class.getSimpleName();


    /**
     * @param filepath 待解压缩的文件
     * @param outDir   压缩文件的解压缩的目录
     */
    public static boolean unzipFile(String filepath, String outDir) {
        boolean success = false;
        if (!TextUtils.isEmpty(filepath) && !TextUtils.isEmpty(outDir)) {
            File zipfile = new File(filepath);
            if (zipfile.exists()) {
                File unzipDir = new File(outDir);

                if (!unzipDir.exists()) {
                    unzipDir.mkdirs();
                }
                InputStream inputStream = null;
                FileOutputStream outputStream = null;
                try {
                    ZipFile zipFile = new ZipFile(zipfile);
                    if (zipFile != null) {
                        Log.d(TAG, "zip name:" + zipFile.getName());
                        Log.d(TAG, "zip entry size:" + zipFile.size());


                        Enumeration<? extends ZipEntry> enumeration = zipFile.entries();

                        while (enumeration.hasMoreElements()) {
                            ZipEntry zipEntry = enumeration.nextElement();
                            if (zipEntry.isDirectory()) {
                                Log.d(TAG, "dir:" + zipEntry.getName() + "---" + zipEntry.getCrc());

                                File f = new File(unzipDir, zipEntry.getName());
                                f.mkdirs();
                            } else {
                                Log.d(TAG, "file:" + zipEntry.getName() + "---" + zipEntry.getCrc());
                                File f = new File(unzipDir, zipEntry.getName());
                                f.createNewFile();

                                inputStream = zipFile.getInputStream(zipEntry);
                                outputStream = new FileOutputStream(f);
                                byte[] readed = new byte[1024];
                                int count;
                                while ((count = inputStream.read(readed)) != -1) {
                                    outputStream.write(readed, 0, count);
                                }
                            }
                        }
                        success = true;
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (inputStream != null) {
                            inputStream.close();
                        }
                        if (outputStream != null) {
                            outputStream.close();
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }

            }

        }
        return success;
    }


    /**
     * @param sourceFilePath 待压缩的文件目录
     * @param zipFilePath    压缩后的文件全路径
     */
    public static boolean zipFile(String sourceFilePath, String zipFilePath) {
        boolean success = false;
        if (!TextUtils.isEmpty(sourceFilePath) && !TextUtils.isEmpty(zipFilePath)) {
            File sourceFile = new File(sourceFilePath);

            File zipFile = new File(zipFilePath);
            if (!zipFile.getParentFile().exists()) {
                zipFile.mkdirs();
            }
            try (ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(zipFile))) {
                writeZip(sourceFile, "", zos);
                success = true;
//                boolean flag = deleteDir(sourceFile);       //文件压缩完成后，删除被压缩文件
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException(e.getMessage(), e.getCause());
            }
        }
        return success;
    }

    /**
     * 遍历所有文件，压缩
     *
     * @param file       源文件目录
     * @param parentPath 压缩文件目录
     * @param zos        文件流
     */
    private static void writeZip(File file, String parentPath, ZipOutputStream zos) {
        if (file.isDirectory()) {//目录
            parentPath += file.getName() + File.separator;
            File[] files = file.listFiles();
            for (File f : files) {
                writeZip(f, parentPath, zos);
            }
        } else {//文件
            try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file))) {    //指定zip文件夹
                ZipEntry zipEntry = new ZipEntry(parentPath + file.getName());
                zos.putNextEntry(zipEntry);
                int len;
                byte[] buffer = new byte[1024 * 10];
                while ((len = bis.read(buffer, 0, buffer.length)) != -1) {
                    zos.write(buffer, 0, len);
                    zos.flush();
                }
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException(e.getMessage(), e.getCause());
            }
        }
    }

    /**
     * 删除文件夹
     *
     * @param dir
     * @return
     */
    private static boolean deleteDir(File dir) {
        if (dir.isDirectory()) {
            String[] children = dir.list();
            for (int i = 0; i < children.length; i++) {
                boolean success = deleteDir(new File(dir, children[i]));
                if (!success) {
                    return false;
                }
            }
        }
        return dir.delete();    //删除空文件夹
    }


}
