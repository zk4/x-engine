package com.zkty.modules.engine.engine;

import android.Manifest;
import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.provider.ContactsContract;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import com.zkty.modules.engine.R;
import com.zkty.nativ.broadcast.IBroadcast;
import com.zkty.nativ.broadcast.NativeBroadcast;
import com.zkty.nativ.core.ActivityStackManager;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.PermissionsUtils;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.direct.DirectManager;
import com.zkty.nativ.jsi.view.MicroAppsInstall;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.scan.activity.ScanActivity;
import com.zkty.nativ.ui.view.dialog.CommonDialog;
import com.zkty.nativ.viewer.CallBack;
import com.zkty.nativ.viewer.Iviewer;
import com.zkty.nativ.viewer.Nativeviewer;

import java.util.HashMap;
import java.util.Map;

public class HomeActivity extends AppCompatActivity {

    private EditText et_content;
    private PermissionsUtils permissionsUtils = new PermissionsUtils();
    private String[] permissions = new String[]{

            Manifest.permission.READ_CONTACTS};

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        et_content = findViewById(R.id.et_content);


    }

    public void nextPage(View view) {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Iviewer.class);
        if (module instanceof Nativeviewer) {
            Nativeviewer iView = (Nativeviewer) module;
            iView.openFileReader("http://10.2.46.11:8080/Desktop/111.docx", "docx", "111", new CallBack() {
                @Override
                public void success(String dto) {

                }
            });

        }


    }


    public void scan(View view) {
        Intent intent = new Intent(this, ScanActivity.class);
        startActivityForResult(intent, 100);

        CommonDialog dialog = new CommonDialog(this);
        dialog.setContent("xxxxxxx");
        new Handler().postDelayed(() -> dialog.show(), 1000);

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK && requestCode == 100) {
            if (data.hasExtra("result")) {
                Map<String, String> params = new HashMap<>();
                params.put("hideNavbar", "true");
                DirectManager.push(data.getStringExtra("result"), params);

            }
        }
        if (resultCode == Activity.RESULT_OK && requestCode == 1) {
            if (data != null) {
                Uri uri = data.getData();
                String phoneNum = null;
                String contactName = null;
                // 创建内容解析者
                ContentResolver contentResolver = getContentResolver();
                Cursor cursor = null;
                if (uri != null) {
                    cursor = contentResolver.query(uri,
                            new String[]{"display_name","data1"}, null, null, null);
                }
                while (cursor.moveToNext()) {
                    contactName = cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME));
                    phoneNum = cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));
                }
                cursor.close();
                //  把电话号码中的  -  符号 替换成空格
                if (phoneNum != null) {
                    phoneNum = phoneNum.replaceAll("-", " ");
                    // 空格去掉  为什么不直接-替换成"" 因为测试的时候发现还是会有空格 只能这么处理
                    phoneNum= phoneNum.replaceAll(" ", "");
                }

               Log.d("xxxxx","联系人：=="+contactName+"name"+phoneNum);
                ToastUtils.showCenterToast("联系人：=="+contactName+"name"+phoneNum);
            }

        }

    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        permissionsUtils.onRequestPermissionsResult(this, requestCode, permissions, grantResults);
    }

    public void nextAct(View view) {
//        MicroAppsInstall.sharedInstance().init(XEngineApplication.getApplication());
        permissionsUtils.checkPermissions(this, permissions, new PermissionsUtils.IPermissionsResult() {
            @Override
            public void passPermissions() {
                Intent intent = new Intent();
                intent.setAction("android.intent.action.PICK");
                intent.addCategory("android.intent.category.DEFAULT");
                intent.setType("vnd.android.cursor.dir/phone_v2");
                startActivityForResult(intent, 1);

            }

            @Override
            public void forbidPermissions() {

            }
        });
    }

    public void download(View view) {
        MicroAppsInstall.sharedInstance().downloadMicroApp("http://10.2.128.10:8000/11.zip");
    }
}
