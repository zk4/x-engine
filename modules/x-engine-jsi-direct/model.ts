// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.direct";


interface DirectPushDTO {
  // scheme 类型：由原生类实现
  // 当前可用:
  // 1. omp 使用 http 协议，webview 带原生 api 功能
  // 2. omps 使用 https 协议，webview 带原生 api 功能
  // 3. http 普通 webview
  // 4. https 普通 webview
  // 5. microapp 使用 file 协议，打开本地微应用文件
  scheme: string;
  // 形如  192.168.1.15:8080 
  // 要注意：
  // 1. 不需要协议名。 
  // 2. 如果有特殊端口，也必须带上
  host?: string;
  pathname: string;
  
  // 要注意：
  // 一定要以 / 开头
  fragment: string;
  // query 参数
  query?:Map<string, string>;

  // 其他参数（做兼容用）
  //\_\_deleteHistory\_\_: -1   在push　到下一页之前，　删除掉当前页
  //\_\_deleteHistory\_\_: -2   在push　到下一页之前，　删除掉当前两页
  //历史不足时，到 tab 历史为止。
  params?:Map<string, string>;
}

interface DirectBackDTO {
  // scheme 类型：由原生类实现
  // 当前可用:
  // 1. omp 使用 http 协议，webview 带原生 api 功能
  // 2. omps 使用 https 协议，webview 带原生 api 功能
  // 3. http 普通 webview
  // 4. https 普通 webview
  // 5. microapp 使用 file 协议，打开本地微应用文件
  scheme: string;
  // 要注意：
  // / 回到当前应用的首页
  // 标准路由一定要以 / 开头
  // 一些特殊字段：
  // -1 回上一页
  // 0  回到 tab 页
  fragment: string;
}


function push(arg: DirectPushDTO = {scheme:'omp',fragment:'/',params:{'hideNavbar':true}}) {
  // 跳转omp
  engine.api('com.zkty.jsi.direct', 'push',{
    scheme: 'omp',
    host: "10.2.128.80:8082",
    pathname:'',
    fragment:''
  })

  // 跳转microapp
  engine.api('com.zkty.jsi.direct', 'push', {
    scheme: "microapp",
    host: "com.gm.microapp.mine",
    pathname: "",
    fragment: "",
  })
  
  // 跳转并删除当前页
  engine.api('com.zkty.jsi.direct', 'push', {
    scheme: "microapp",
    host: "com.gm.microapp.mine",
    pathname: "",
    fragment: "",
    params:{
      __deleteHistory__:1
    }
  })

  // 跳转http
  engine.api('com.zkty.jsi.direct', 'push', {  
    scheme: "http",  
    host: "www.baidu.com",  
    fragment: "/",  
    pathname: "",  
  })

  // 跳转https
  engine.api('com.zkty.jsi.direct', 'push', {  
    scheme: "https",  
    host: "www.youtube.com",  
    fragment: "",  
    pathname: "",  
  })  
}


function back(arg: DirectBackDTO) {
    engine.api('com.zkty.jsi.direct','back',{
     scheme: 'omp',
     fragment:'-1'
   }
}
 
