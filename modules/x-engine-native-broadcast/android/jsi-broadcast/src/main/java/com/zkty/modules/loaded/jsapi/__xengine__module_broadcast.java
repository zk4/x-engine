package com.zkty.modules.loaded.jsapi;


import android.util.Log;

import androidx.annotation.Nullable;

import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.dsbridge.OnReturnValue;
import com.zkty.modules.engine.utils.XEngineMessage;

import org.greenrobot.eventbus.EventBus;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;


public class __xengine__module_broadcast extends xengine__module_broadcast {
    @Override
    public void onAllModulesInited() {

        Log.d("__xengine__module_broadcast", "onAllModulesInited()");
    }

    @Override
    public void _broadcastOn(CompletionHandler<Nullable> handler) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<String> msg = new ArrayList<>();
        msg.add("_broadcastOn:" + df.format(new Date()));
        EventBus.getDefault().post(new XEngineMessage(XEngineMessage.MSG_TYPE_ON, msg));


    }

    @Override
    public void _broadcastOff(CompletionHandler<Nullable> handler) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<String> msg = new ArrayList<>();
        msg.add("_broadcastOff:" + df.format(new Date()));
        EventBus.getDefault().post(new XEngineMessage(XEngineMessage.MSG_TYPE_OFF, msg));

    }

    @Override
    public void _triggerNativeBroadCast(CompletionHandler<Nullable> handler) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<String> msg = new ArrayList<>();
        msg.add("_broadcast:" + df.format(new Date()));
        EventBus.getDefault().post(new XEngineMessage(XEngineMessage.MSG_TYPE_SCOPE, msg));

    }

    @Override
    public void _repeatReturn__ret__(ContinousDTO dto, CompletionHandler<String> handler) {

        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            private int counter = 10;

            public void run() {
                if (counter > 0) {
                    handler.setProgressData(String.valueOf(counter));
                } else {
                    timer.cancel();
                    handler.complete();
                }
                counter--;

            }
        };
        timer.schedule(task, 0L, 1000L);


    }

    @Override
    public void _repeatReturn__event__(ContinousDTO dto, CompletionHandler<String> handler) {

        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            private int counter = 10;

            public void run() {
                if (counter > 0) {
                    mXEngineWebView.callHandler(dto.__event__, new Object[]{counter}, new OnReturnValue<Object>() {
                        @Override
                        public void onValue(Object retValue) {

                        }
                    });
                } else {
                    timer.cancel();
                    handler.complete();
                }

                counter--;

            }
        };
        timer.schedule(task, 0L, 1000L);


    }

    @Override
    public void _ReturnInPromiseThen(ContinousDTO dto, CompletionHandler<String> handler) {

    }

    @Override
    public void _noArgNoRet(CompletionHandler<Nullable> handler) {

    }

    @Override
    public void _noArgRetPrimitive(CompletionHandler<String> handler) {

    }

    @Override
    public void _noArgRetSheetDTO(CompletionHandler<SheetDTO> handler) {

    }

    @Override
    public void _haveArgNoRet(SheetDTO dto, CompletionHandler<Nullable> handler) {

    }

    @Override
    public void _haveArgRetPrimitive(SheetDTO dto, CompletionHandler<String> handler) {

    }

    @Override
    public void _haveArgRetSheetDTO(SheetDTO dto, CompletionHandler<SheetDTO> handler) {

    }

}
