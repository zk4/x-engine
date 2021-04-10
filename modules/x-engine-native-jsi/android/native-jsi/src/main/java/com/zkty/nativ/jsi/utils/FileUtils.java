package com.zkty.nativ.jsi.utils;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

public class FileUtils {
    private static final String TAG = FileUtils.class.getSimpleName();


    public static boolean createDir(File root, String dir) {
        boolean success = false;
        File file = new File(root, dir);
        if (!file.exists()) {
            success = file.mkdirs();
        } else {
            success = true;
        }
        return success;
    }

    public static boolean createFile(File dir, String name) {
        boolean success = false;
        File file = new File(dir, name);
        if (file.exists()) {
            file.delete();
        }
        try {
            success = file.createNewFile();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return success;
    }

    public static boolean deleteFile(File file) {
        boolean success = false;
        if (file.exists()) {
            if (file.isDirectory()) {
                File[] children = file.listFiles();
                for (int i = 0; i < children.length; i++) {
                    deleteFile(children[i]);
                }
            }
            success = file.delete();
        } else {
            success = true;
        }
        return success;
    }


    /**
     * @param dir
     * @param name
     * @param out
     */
    public static boolean moveFile(File dir, String name, File out) {
        boolean success = false;
        if (dir.exists() && TextUtils.isEmpty(name)) {
            if (!out.exists()) {
                out.mkdirs();
            }

            File source = new File(dir, name);

            File file = new File(out, name);
            FileInputStream fileInputStream = null;
            FileOutputStream fileOutputStream = null;

            if (file.exists()) {
                file.delete();
            }

            try {
                if (file.createNewFile()) {
                    fileInputStream = new FileInputStream(source);
                    fileOutputStream = new FileOutputStream(file);
                    byte[] temp = new byte[1024];
                    int count = 0;

                    while (true) {
                        count = fileInputStream.read(temp);
                        if (count == -1) {
                            break;
                        } else {
                            fileOutputStream.write(temp, 0, count);
                        }
                    }
                    if (source.delete()) {             //删除原文件
                        success = true;
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (fileInputStream != null) {
                        fileInputStream.close();
                    }
                    if (fileOutputStream != null) {
                        fileOutputStream.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } else {
            Log.d(TAG, "dir or filename is invalid!");
        }
        return success;
    }

    /**
     * @param dir
     * @param name
     * @param out
     * @return
     */
    public static boolean copyFile(File dir, String name, File out) {
        return copyFile(dir, name, out, name);
    }


    /**
     * @param sourceDir
     * @param filename
     * @param destDir
     * @param rename    if null we use the filename
     * @return
     */
    public static boolean copyFile(File sourceDir, String filename, File destDir, String rename) {
        boolean success = false;
        if (sourceDir.exists() && !TextUtils.isEmpty(filename)) {
            if (!destDir.exists()) {
                destDir.mkdirs();
            }

            String name = filename;
            if (!TextUtils.isEmpty(rename)) {
                name = rename;
            }
            File dest = new File(destDir, name);

            if (dest.exists()) {
                dest.delete();
            }

            try {
                if (dest.createNewFile()) {
                    InputStream inputStream = null;
                    FileOutputStream outputStream = null;
                    try {
                        inputStream = new FileInputStream(new File(sourceDir, filename));
                        outputStream = new FileOutputStream(new File(destDir, name));
                        byte[] b = new byte[1024];
                        int a;
                        while (true) {
                            a = inputStream.read(b);
                            if (a == -1) {
                                success = true;
                                break;
                            } else {
                                outputStream.write(b, 0, a);
                            }
                        }
                    } catch (FileNotFoundException e) {
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
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        return success;
    }

    /**
     * @param file
     * @return
     */
    public static String readFile(File file) {
        String content = null;
        if (file.exists() && !file.isDirectory()) {
            InputStream inputStream = null;
            try {
                inputStream = new FileInputStream(file);

                StringBuilder sb = new StringBuilder();
                String line = "";

                BufferedReader br = new BufferedReader(new InputStreamReader(inputStream));
                while (true) {
                    try {
                        if (!((line = br.readLine()) != null))
                            break;
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    sb.append(line);
                }
                content = sb.toString();
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
        return content;
    }

    /**
     * @param inputStream
     * @return
     */
    public static String readInputSteam(InputStream inputStream) {
        String content = null;
        if (inputStream != null) {
            StringBuilder sb = new StringBuilder();
            String line = "";
            BufferedReader br = new BufferedReader(new InputStreamReader(inputStream));
            while (true) {
                try {
                    if (!((line = br.readLine()) != null))
                        break;
                } catch (IOException e) {
                    e.printStackTrace();
                }
                sb.append(line);
            }
            content = sb.toString();
        }
        return content;
    }


    /**
     * 保存文件
     *
     * @param inputStream
     * @param dir         文件目录
     * @param filename    文件名字
     * @return
     */
    public static String saveFile(InputStream inputStream, File dir, String filename) {
        String path = null;
        if (inputStream != null) {
            if (!dir.exists()) {
                dir.mkdirs();
            }
            File outFile = new File(dir, filename);
            if (outFile.exists()) {                 //删除旧文件
                outFile.delete();
            }
            FileOutputStream fileOutputStream = null;
            try {
                if (outFile.createNewFile()) {
                    fileOutputStream = new FileOutputStream(outFile);
                    byte[] b = new byte[1024];
                    int a;
                    while (true) {
                        a = inputStream.read(b);
                        if (a == -1) {      //读取结束
                            path = outFile.getPath();
                            break;
                        } else {        //
                            fileOutputStream.write(b, 0, a);
                        }
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (fileOutputStream != null) {
                    try {
                        fileOutputStream.flush();
                        fileOutputStream.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
            try {
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return path;
    }


    /**
     * 解压源目录的文件到指定目录
     *
     * @param sdir
     * @param sfname 压缩文件
     * @param ddir
     * @return
     */
    public static String unZipFile(File sdir, String sfname, File ddir) {
        String path = null;
        if (!sdir.exists() || !sdir.isDirectory() || TextUtils.isEmpty(sfname) || !sfname.endsWith(".zip")) {
            Log.d(TAG, "zip dir or zip file error!");
            return path;
        }

        File dir = sdir;
        if (!sdir.getPath().equals(ddir.getPath())) {      //压缩文件的目录和待解压的目录不同[先将压缩文件拷贝到指定目录下]
            Log.d(TAG, "need move zip!");
            if (copyFile(sdir, sfname, ddir, sfname)) {
                Log.d(TAG, "move zip file success!");
                dir = ddir;
            } else {
                Log.d(TAG, "move zip file failed!");
            }
        }

        Log.d(TAG, "start do unzip !");
        if (doUnzip(dir, sfname)) {
            Log.d(TAG, "unzip success!");
            path = ddir.getPath();
        } else {
            Log.d(TAG, "unzip failed!");
        }
        return path;
    }

    /**
     * 直接在dir目录中解压文件
     *
     * @param dir
     * @param zipfileName
     * @return
     */
    public static boolean doUnzip(File dir, String zipfileName) {
        boolean success = false;

        if (!dir.exists() || TextUtils.isEmpty(zipfileName) || !zipfileName.endsWith(".zip")) {
            Log.d(TAG, "zip dir or zip file error!");
            return success;
        }

        ZipFile zip = null;
        try {
            zip = new ZipFile(new File(dir, zipfileName));
            String name = zip.getName().substring(zip.getName().lastIndexOf('\\') + 1, zip.getName().lastIndexOf('.'));

            name = new File(name).getParentFile().getPath();

            //name = name + zipfileName.substring(0, zipfileName.lastIndexOf("."));
            name = new File(name, zipfileName.substring(0, zipfileName.lastIndexOf("."))).getPath();

            Log.d(TAG, "name:" + name);

            for (Enumeration<? extends ZipEntry> entries = zip.entries(); entries.hasMoreElements(); ) {
                ZipEntry entry = (ZipEntry) entries.nextElement();
                String zipEntryName = entry.getName();
                InputStream in = zip.getInputStream(entry);

                Log.d(TAG, "entryName:" + zipEntryName);

                String outPath = "";

                File temp = new File(name);
                Log.d(TAG, "parent:" + temp.getParent() + "--sub:" + temp.getName());
                if (zipEntryName.startsWith(temp.getName())) {
                    outPath = (name.replace(temp.getName(), "") + "/" + zipEntryName).replaceAll("\\*", "/");
                } else {
                    outPath = (name + "/" + zipEntryName).replaceAll("\\*", "/");
                }

                // 判断路径是否存在,不存在则创建文件路径
                File file = new File(outPath.substring(0, outPath.lastIndexOf('/')));
                if (!file.exists()) {
                    file.mkdirs();
                }
                // 判断文件全路径是否为文件夹,如果是上面已经上传,不需要解压
                if (new File(outPath).isDirectory()) {
                    continue;
                }
                FileOutputStream out = new FileOutputStream(outPath);
                byte[] buf1 = new byte[1024];
                int len;
                while ((len = in.read(buf1)) > 0) {
                    out.write(buf1, 0, len);
                }
                in.close();
                out.close();
            }
            success = true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return success;
    }

    /**
     * 方式一
     * 复制单个文件到sd卡内存
     *
     * @param outPath  String 输出文件路径 如：data/user/0/com.test/files
     * @param fileName String 要复制的文件名 如：abc.txt
     * @return <code>true</code> if and only if the file was copied; <code>false</code> otherwise
     */
    public static String copyAssetsSingleFile(Context context, String outPath, String fileName) {
        File file = new File(outPath);
        if (!file.exists()) {
            if (!file.mkdirs()) {
                Log.e("this", "copyAssetsSingleFile:不能创建目录");
            }
        }
        try {
            InputStream inputStream = context.getResources().getAssets().open(fileName);  //输入流  可以把数据从硬盘，读取到Java的虚拟中来，也就是读取到内存中
            File outFile = new File(file, fileName);
            FileOutputStream fileOutputStream = new FileOutputStream(outFile); //文件输出流  写入到文件中
            //将字节从inputStream传输到fileOutputStream
            byte[] buffer = new byte[1024];//创建字节数组，其长度设置为1024
            int byteRead;
            while (-1 != (byteRead = inputStream.read(buffer))) {//以字节流的形式读取文件中的内容
                fileOutputStream.write(buffer, 0, byteRead);//写入到转存文件中
            }
            Log.d(TAG, fileName + "文件复制完成");

            inputStream.close();
            fileOutputStream.flush();
            fileOutputStream.close();
            return String.format("%s/%s", outPath, fileName);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


}
