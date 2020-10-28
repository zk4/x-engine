package com.zkty.engine.module.tzcash;

import android.os.Build;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import pay.PayUtils;


public class MainActivity extends AppCompatActivity {


//    业务系统客户号：184733123333123
//    业务系统订单号：184733123333123
//    平台订单号：8460354065212117067
//    商户号：8377631273379692750

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        findViewById(R.id.pay).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                PayUtils.Pay(MainActivity.this, "184733123333123", "184733123333123", "8377631273379692750", "", new PayUtils.PayResultListener() {
                    @Override
                    public void onPayResultListener(String result) {

                    }
                });
            }
        });

    }
}
