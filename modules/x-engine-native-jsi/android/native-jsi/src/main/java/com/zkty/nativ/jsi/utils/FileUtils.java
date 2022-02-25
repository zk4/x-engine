package com.zkty.nativ.jsi.utils;

import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.Log;

import com.zkty.nativ.core.XEngineApplication;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

public class FileUtils {
    private static final String TAG = FileUtils.class.getSimpleName();

    private static String[][] MIME_MapTable = {
            //{后缀名，MIME类型}
            {".3gp", "video/3gpp"},
            {".apk", "application/vnd.android.package-archive"},
            {".asf", "video/x-ms-asf"},
            {".avi", "video/x-msvideo"},
            {".bin", "application/octet-stream"},
            {".bmp", "image/bmp"},
            {".c", "text/plain"},
            {".class", "application/octet-stream"},
            {".conf", "text/plain"},
            {".cpp", "text/plain"},
            {".doc", "application/msword"},
            {".docx", "application/msword"},
           // {".docx", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"},
            {".xls", "application/vnd.ms-excel"},
            {".xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"},
            {".exe", "application/octet-stream"},
            {".gif", "image/gif"},
            {".gtar", "application/x-gtar"},
            {".gz", "application/x-gzip"},
            {".h", "text/plain"},
            {".htm", "text/html"},
            {".html", "text/html"},
            {".jar", "application/java-archive"},
            {".java", "text/plain"},
            {".jpeg", "image/jpeg"},
            {".jpg", "image/jpeg"},
            {".js", "application/x-javascript"},
            {".log", "text/plain"},
            {".m3u", "audio/x-mpegurl"},
            {".m4a", "audio/mp4a-latm"},
            {".m4b", "audio/mp4a-latm"},
            {".m4p", "audio/mp4a-latm"},
            {".m4u", "video/vnd.mpegurl"},
            {".m4v", "video/x-m4v"},
            {".mov", "video/quicktime"},
            {".mp2", "audio/x-mpeg"},
            {".mp3", "audio/x-mpeg"},
            {".mp4", "video/mp4"},
            {".mpc", "application/vnd.mpohun.certificate"},
            {".mpe", "video/mpeg"},
            {".mpeg", "video/mpeg"},
            {".mpg", "video/mpeg"},
            {".mpg4", "video/mp4"},
            {".mpga", "audio/mpeg"},
            {".msg", "application/vnd.ms-outlook"},
            {".ogg", "audio/ogg"},
            {".pdf", "application/pdf"},
            {".png", "image/png"},
            {".pps", "application/vnd.ms-powerpoint"},
            {".ppt", "application/vnd.ms-powerpoint"},
            {".pptx", "application/vnd.openxmlformats-officedocument.presentationml.presentation"},
            {".prop", "text/plain"},
            {".rc", "text/plain"},
            {".rmvb", "audio/x-pn-realaudio"},
            {".rtf", "application/rtf"},
            {".sh", "text/plain"},
            {".tar", "application/x-tar"},
            {".tgz", "application/x-compressed"},
            {".txt", "text/plain"},
            {".wav", "audio/x-wav"},
            {".wma", "audio/x-ms-wma"},
            {".wmv", "audio/x-ms-wmv"},
            {".wps", "application/vnd.ms-works"},
            {".xml", "text/plain"},
            {".z", "application/x-compress"},
            {".zip", "application/x-zip-compressed"},
            {"", "*/*"}
    };


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
     * @param source
     * @param out
     */
    public static boolean moveFile(File source, File out) {
        boolean success = false;
        if (source.exists()) {
            if (!out.exists()) {
                out.mkdirs();
            }


            FileInputStream fileInputStream = null;
            FileOutputStream fileOutputStream = null;

            if (out.exists()) {
                out.delete();
            }

            try {
                if (out.createNewFile()) {
                    fileInputStream = new FileInputStream(source);
                    fileOutputStream = new FileOutputStream(out);
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


    /**
     * 获取文件类型
     *
     * @param path
     * @return
     */
    public static String getFileType(String path) {
        //获取文件名称
        if (path.startsWith("http") && path.contains("?")) {
            path = path.substring(0, path.indexOf("?"));
        }
        String type = "";
        if (path.endsWith(".pdf")) {
            type = "pdf";
        } else if (path.endsWith(".ppt")) {
            type = "ppt";
        } else if (path.endsWith(".pptx")) {
            type = "pptx";
        } else if (path.endsWith(".doc")) {
            type = "doc";
        } else if (path.endsWith(".docx")) {
            type = "docx";
        } else if (path.endsWith(".xls")) {
            type = "xls";
        } else if (path.endsWith(".xlsx")) {
            type = "xlsx";
        } else if (path.endsWith(".txt")) {
            type = "txt";
        } else if (path.endsWith(".epub")) {
            type = "epub";
        }
        return type;
    }

    /**
     * 获取文件名吃
     *
     * @param urlname
     * @return
     */
    public static String getFileName(String urlname) {
        if (urlname.startsWith("http")) {
            //从下载连接中解析出文件名
            urlname = urlname.substring(0, urlname.indexOf("?"));
            int start = urlname.lastIndexOf("/");
            int end = urlname.length();
            if (start != -1 && end != -1) {
                return urlname.substring(start + 1, end);
            } else {
                return null;
            }
        } else {
            //从本地路径中解析出文件名
            File file = new File(urlname);
            String fileName = file.getName();
            return fileName;
        }
    }

    /**
     * 图片uri转换为file文件
     * 返回值为file类型
     *
     * @param uri
     * @return
     */
    public static File uri2File(Uri uri) {
        String img_path;
        String[] proj = {MediaStore.Images.Media.DATA};
        Cursor actualimagecursor = XEngineApplication.getCurrentActivity().managedQuery(uri, proj, null,
                null, null);
        if (actualimagecursor == null) {
            img_path = uri.getPath();
        } else {
            int actual_image_column_index = actualimagecursor
                    .getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
            actualimagecursor.moveToFirst();
            img_path = actualimagecursor
                    .getString(actual_image_column_index);
        }
        File file = new File(img_path);
        return file;
    }


    public static int copy(String fromFile, String toFile) {
        //要复制的文件目录
        File[] currentFiles;
        File root = new File(fromFile);
        //如同判断SD卡是否存在或者文件是否存在
        //如果不存在则 return出去
        if (!root.exists()) {
            return -1;
        }
        //如果存在则获取当前目录下的全部文件 填充数组
        currentFiles = root.listFiles();

        //目标目录
        File targetDir = new File(toFile);
        //创建目录
        if (!targetDir.exists()) {
            targetDir.mkdirs();
        }
        //遍历要复制该目录下的全部文件
        for (int i = 0; i < currentFiles.length; i++) {
            if (currentFiles[i].isDirectory())//如果当前项为子目录 进行递归
            {
                copy(currentFiles[i].getPath() + "/", toFile + currentFiles[i].getName() + "/");

            } else//如果当前项为文件则进行文件拷贝
            {
                CopySdcardFile(currentFiles[i].getPath(), toFile + currentFiles[i].getName());
            }
        }
        return 0;
    }


    //文件拷贝
    //要复制的目录下的所有非子目录(文件夹)文件拷贝
    public static int CopySdcardFile(String fromFile, String toFile) {

        try {
            InputStream fosfrom = new FileInputStream(fromFile);
            OutputStream fosto = new FileOutputStream(toFile);
            byte bt[] = new byte[1024];
            int c;
            while ((c = fosfrom.read(bt)) > 0) {
                fosto.write(bt, 0, c);
            }
            fosfrom.close();
            fosto.close();
            return 0;

        } catch (Exception ex) {
            return -1;
        }
    }

    public static String getMIMEType(File file) {

        String type = "*/*";
        String fName = file.getName();
        //获取后缀名前的分隔符"."在fName中的位置。
        int dotIndex = fName.lastIndexOf(".");
        if (dotIndex < 0) {
            return type;
        }
        /* 获取文件的后缀名*/
        String end = fName.substring(dotIndex, fName.length()).toLowerCase();
        if ("".equals(end)) return type;
        //在MIME和文件类型的匹配表中找到对应的MIME类型。
        for (int i = 0; i < MIME_MapTable.length; i++) {

            if (end.equals(MIME_MapTable[i][0]))
                type = MIME_MapTable[i][1];
        }
        return type;
    }


}
