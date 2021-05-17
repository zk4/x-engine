
import share from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_同步无返回 = () => {

  let val = xengine.api("com.zkty.jsi.share", "simpleMethod");
  document.getElementById("debug_text").innerText = "无返回,查看原生控制台打印";
}
 document.getElementById("test_同步无返回").click()
      window.test_同步简单参数 = () => {

  let val = xengine.api("com.zkty.jsi.share", "simpleArgMethod","hello,from js");
  document.getElementById("debug_text").innerText =val;
}
 document.getElementById("test_同步简单参数").click()
      window.test_同步返回命名对象 = () => {

  let val = xengine.api("com.zkty.jsi.share", "namedObject", {});
  document.getElementById("debug_text").innerText =typeof val + ":" + val.title + "," + val.titleSize;
}
 document.getElementById("test_同步返回命名对象").click()
      window.test_同步返回匿名嵌套对象 = () => {

  let val = xengine.api("com.zkty.jsi.share", "nestedAnonymousObject", {});
  document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;

}
 document.getElementById("test_同步返回匿名嵌套对象").click()
      window.test_异步返回命名对象 = () => {

  xengine.api("com.zkty.jsi.share", "namedObject", {}, (val) => {
    document.getElementById("debug_text").innerText =
    typeof val + ":" + val.title + "," + val.titleSize;
  });
}
 document.getElementById("test_异步返回命名对象").click()
      window.test_异步简单参数 = () => {

  xengine.api("com.zkty.jsi.share", "simpleArgMethod","hello,from js", (val) => {
    document.getElementById("debug_text").innerText = val
  });
}
 document.getElementById("test_异步简单参数").click()
      window.test_异步返回命名对象 = () => {

  xengine.api("com.zkty.jsi.share", "namedObject", {},
  (val)=>
  {
    document.getElementById("debug_text").innerText =
    typeof val + ":" + val.title + "," + val.titleSize;
  }
  );
}
 document.getElementById("test_异步返回命名对象").click()
      window.test_异步返回匿名嵌套对象 = () => {

  xengine.api("com.zkty.jsi.share", "nestedAnonymousObject", {},
  (val)=>
  {
    document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;
  }
  );
}
 document.getElementById("test_异步返回匿名嵌套对象").click()
      
    