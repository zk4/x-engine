package com.zkty.engine.module.network.net;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.network.net.myinterface.Inetwork;

public class NetWorkManager {


    /**
     * 网络请求模块
     * @return
     */
    private static Inetwork iNetwork = null;
    public static Inetwork getiNetwork() {
        if(iNetwork == null){
            synchronized (Inetwork.class){
                if(iNetwork == null){
                    NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Inetwork.class);
                    if (module instanceof Inetwork)
                        iNetwork = (Inetwork) module;
                }
            }
        }
        return iNetwork;
    }




}
