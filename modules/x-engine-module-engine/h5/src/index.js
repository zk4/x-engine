import dsbridge from "./dsbridge";
const module_names = new Set([]);
const patch = {}

function isFunction(functionToCheck) {
 return functionToCheck && {}.toString.call(functionToCheck) === '[object Function]';
}

function isObject(val) {
    if (val === null) { return false;}
    return ( (typeof val === 'function') || (typeof val === 'object') );
}

function isString(x) {
  return Object.prototype.toString.call(x) === "[object String]"
}

function isHybrid(){
  return window && window._dswk===true;
}
let xengine = {
  patch   : patch,
  platfrom: platform(),
  hybrid  : true,
  bridge  : dsbridge,
  use     : use
};

function use(ns,funcs){
    if(module_names.has(ns)){
      throw(ns+ ',注册无效,模块已存在,xengine.use("'+ns+'") 只允许调用一次;')
    }
    module_names.add(ns)
    console.log(ns+ ',注册成功')

    let _call = function(funcname,args){
      if (args.hasOwnProperty('__event__')){
         let eventcb = args['__event__'];
         if(!isFunction(eventcb)) throw('__event__ 必须为函数');
         args['__event__']  = ns+"."+funcname+'.__event__'
          xengine.bridge.register(args['__event__'], (res) => {
              return eventcb(res);
          })
      }
      
      if(funcname.startsWith('sync')){
        return xengine.bridge.call(ns+"."+funcname,args);
      }
      else{
        let p =new Promise((resolve,reject)=>{
          const warning_msg = "x-engine 0.1.0 将不再支持 promise,改用参数里的　__ret__做为异步返回值,以支持多次返回.或者直接调用函数同步返回";
          console.error(warning_msg);
          xengine.bridge.call(ns+"."+funcname, args, function (res) {
            // only resolve once
            resolve(res);
            if(args['__ret__']){
              return args['__ret__'](res)
            }
          })
        });
        return p;
      }
    };

    return funcs.reduce((acc,cur,i)=>{
      if(isObject(cur)){
        acc[cur.name] = args => _call(cur.name,{...cur.default_args,...args});
      }else if(isString(cur)){
        acc[cur] = args => _call(cur,args);
      }else{
        throw("仅支持 string 与 {name:xxx, default_args:{...}}")
      }
      return acc;
    },{})
}

Object.defineProperty(xengine, "bridge", {
  get(){
    return dsbridge;
  },
  set: function () {
    throw('dsbridge不能被修改')
  }
});

function platform() {
     var ua = navigator.userAgent,
     isWindowsPhone = /(?:Windows Phone)/.test(ua),
     isSymbian = /(?:SymbianOS)/.test(ua) || isWindowsPhone, 
     isAndroid = /(?:Android)/.test(ua), 
     isFireFox = /(?:Firefox)/.test(ua), 
     isChrome = /(?:Chrome|CriOS)/.test(ua),
     isTablet = /(?:iPad|PlayBook)/.test(ua) || (isAndroid && !/(?:Mobile)/.test(ua)) || (isFireFox && /(?:Tablet)/.test(ua)),
     isPhone = /(?:iPhone)/.test(ua) && !isTablet,
     isPc = !isPhone && !isAndroid && !isSymbian;
     return {
          isTablet: isTablet,
          isPhone: isPhone,
          isAndroid : isAndroid,
          isPc : isPc
     };
};


// 监听输入框的软键盘弹起和收起事件
function listenKeybord($input) {
  if (judgeDeviceType.isIOS) {
    // IOS 键盘弹起：IOS 和 Android 输入框获取焦点键盘弹起
    $input.addEventListener(
      "focus",
      function () {
        console.log("IOS 键盘弹起啦！");
        // IOS 键盘弹起后操作
      },
      false
    );

    // IOS 键盘收起：IOS 点击输入框以外区域或点击收起按钮，输入框都会失去焦点，键盘会收起，
    $input.addEventListener("blur", () => {
      console.log("IOS 键盘收起啦！");
      // IOS 键盘收起后操作
    });
  }

  // Andriod 键盘收起：Andriod 键盘弹起或收起页面高度会发生变化，以此为依据获知键盘收起
  if (judgeDeviceType.isAndroid) {
    var originHeight =
      document.documentElement.clientHeight || document.body.clientHeight;

    window.addEventListener(
      "resize",
      function () {
        var resizeHeight =
          document.documentElement.clientHeight || document.body.clientHeight;
        if (originHeight < resizeHeight) {
          console.log("Android 键盘收起啦！");
          // Android 键盘收起后操作
        } else {
          console.log("Android 键盘弹起啦！");
          // Android 键盘弹起后操作
        }

        originHeight = resizeHeight;
      },
      false
    );
  }
}

var $inputs = document.querySelectorAll(".input");

for (var i = 0; i < $inputs.length; i++) {
  listenKeybord($inputs[i]);
}
 
patch.disableDoubleTapScroll=function(ms){
  ms = ms || 500;
  console.log("禁用双击滑动,两次点击冷却时间为"+ms+" ms")
   //禁止双击时, webview 自动上移
   //不是个好方案, 会导致快速点击按钮失效
  var agent = navigator.userAgent.toLowerCase();
  var iLastTouch = null;
  if (agent.indexOf("iphone") >= 0 || agent.indexOf("ipad") >= 0) {
    document.body.addEventListener(
      "touchend",
      function (event) {
        var a = new Date().getTime();
        iLastTouch = iLastTouch || a + 1;
        var c = a - iLastTouch;
        if (c < ms && c > 0) {
          event.preventDefault();
          return false;
        }
        iLastTouch = a;
      },
      false
    );
  }
}
export default xengine;
