var bridge = {
default:
    this,

    // js调用Native方法
    call: function(functionName, args, callback) {
        // 如果是无参数的方法  function(functionName,callback)
        "function" == typeof args && (callback = args, args = {});
        
        //参数对象 {data: args/null}
        // void 0 解释 https://stackoverflow.com/questions/7452341/what-does-void-0-mean
        args = { data: void 0 === args ? null : args};
        
        // 如果是异步并且要接收返回值的
        if ("function" == typeof callback) {
            // callback标识,计数器
            var tag = "dscb" + window.dscb++;
            // 保存回调   window[dscbX] = callback Function
            window[tag] = callback;
            // args = {data: args/null,_dscbstud:tag}
            args._dscbstub = tag
        }
        // 将参数转成Json字符串
        args = JSON.stringify(args);
        
        var ret = "";
        // 这里不会走到,目前从源里没有看到有什么地方注入了_dsbridge
        if (window._dsbridge) {
            ret = _dsbridge.call(functionName, args);
        }
        
        // 客户端会走到这里, webView初始化的时候会给window注入_dswk=true
        else if (window._dswk || -1 != navigator.userAgent.indexOf("_dsbridge")) {
            ret = prompt("_dsbridge=" + functionName, args);
        }
        return JSON.parse(ret || "{}").data
    },
    
    // js注册供Native调用的方法,如果传入callback,则为异步方法
    register: function(jsFunctionName, receiveParamsFunction, callback) {
        
        // 判断是同步还是异步  callback = { _obs:{} };
        callback = callback ? window._dsaf : window._dsf;
        
        //只执行一次,为了调用一次native的dsinit方法
        window._dsInit || (window._dsInit = !0, setTimeout(function() {
            bridge.call("_dsb.dsinit")
        }, 0));
        
        //将call保存在对应的数据结构中, callback = { jsFunctionName : receiveParamsFunction: , _obs:{} };
        "object" == typeof receiveParamsFunction ? callback._obs[jsFunctionName] = receiveParamsFunction : callback[jsFunctionName] = receiveParamsFunction
    },
    
    // js注册供Native调用的异步方法
    registerAsyn: function(b, a) {
        this.register(b, a, !0)
    },
    
    // 是否有Native方法
    hasNativeMethod: function(b, a) {
        return this.call("_dsb.hasNativeMethod", {
            name: b,
            type: a || "all"
        })
    },
    
    // 禁用Dialog
    disableJavascriptDialogBlock: function(b) {
        this.call("_dsb.disableJavascriptDialogBlock", {
            disable: !1 !== b
        })
    }
};


// https://www.cnblogs.com/binbin001/p/11393040.html
// 立即执行一段代码 ,函数表达示后面跟 `()` 可以立即执行
// function(){}()
(function(){
    
    // js对象动态添加属性
    // obj[property] = xxx. not obj.property = xxx
    
    // 1. 如果Window已经添加了 `_dsf` 属性直接返回
    if(window._dsf) return;

    // 2. Window添加一个 `_dsf` 对象属性, 保存同步方法
    window["_dsf"] = { _obs:{} };
    // 3. Window添加一个 `_dsaf` 对象属性, 保存异步方法
    window["_dsaf"] = { _obs:{} };
    // 4. Window添加一个callback计数唯一标识
    window["dscb"] = 0;
    // 5. Window添加一个 bridge属性
    window["dsBridge"] =  bridge;
     //6. Window添加一个界面关闭方法
    window["close"] = function(){
        bridge.call("_dsb.closePage");
    };
    // 7. Window添加统一处理Native方法的函数
    //a = { "callbackId":id, "method":name, "data":[x,y,z,..]}
    window["_handleMessageFromNative"] = function(a){
        // 调用方法的参数数组
        var e = JSON.parse(a.data),
        
        // 临时对象
        b = {
            id: a.callbackId,
            complete: !0
        },
        // 同步方法
        c = this._dsf[a.method],
        // 异步方法
        d = this._dsaf[a.method],
        
        
        h = function (a, c){
           b.data = a.apply(c, e);
           bridge.call("_dsb.returnValue", b);
        },

        k = function (a, c){
            e.push(function (a, c){
                b.data = a;
                b.complete = !1 !== c;
                bridge.call("_dsb.returnValue", b)
            });
            a.apply(c, e);
        };

        if(c) h(c, this._dsf);
        else if(d) k(d, this._dsaf);
        else if(c = a.method.split("."), !(2 > c.length)){
            a = c.pop();
            var c = c.join("."),
                d = this._dsf._obs,
                d = d[c] ||
                {},
                f = d[a];
            f && "function" == typeof f ? h(f, d) : (d = this._dsaf._obs, d = d[c] ||
            {}, (f = d[a]) && "function" == typeof f && k(f, d))
        }
    };
    
    bridge.register("_hasJavascriptMethod", function(a, b) {
        b = a.split(".");
        if (2 > b.length) return !(!_dsf[b] && !_dsaf[b]);
        a = b.pop();
        b = b.join(".");
        return (b = _dsf._obs[b] || _dsaf._obs[b]) && !! b[a]
    });
    
})();
export default bridge;

