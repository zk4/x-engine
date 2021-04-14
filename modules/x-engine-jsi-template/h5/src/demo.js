
import xxxx from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_同步无返回 = () => {

  let val = xengine.api("com.zkty.jsi.xxxx", "simpleMethod");
  document.getElementById("debug_text").innerText = "无返回,查看原生控制台打印";
}
 document.getElementById("test_同步无返回").click()
      window.test_同步返回命名对象 = () => {

  let val = xengine.api("com.zkty.jsi.xxxx", "nestedNamedObject", {});
  document.getElementById("debug_text").innerText =typeof val + ":" + val.title + "," + val.titleSize;
}
 document.getElementById("test_同步返回命名对象").click()
      window.test_同步返回匿名嵌套对象 = () => {

  let val = xengine.api("com.zkty.jsi.xxxx", "nestedObject", {});
  document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;

}
 document.getElementById("test_同步返回匿名嵌套对象").click()
      window.test_异步返回命名对象 = () => {

  xengine.api("com.zkty.jsi.xxxx", "nestedNamedObject", {}, (val) => {
    document.getElementById("debug_text").innerText =
    typeof val + ":" + val.title + "," + val.titleSize;
  });
}
 document.getElementById("test_异步返回命名对象").click()
      window.test_异步返回命名对象 = () => {

  xengine.api("com.zkty.jsi.xxxx", "nestedNamedObject", {},
  (val)=>
  {
    document.getElementById("debug_text").innerText =
    typeof val + ":" + val.title + "," + val.titleSize;
  }
  );
}
 document.getElementById("test_异步返回命名对象").click()
      window.test_异步返回匿名嵌套对象 = () => {

  xengine.api("com.zkty.jsi.xxxx", "nestedObject", {},
  (val)=>
  {
    document.getElementById("debug_text").innerText =typeof val + ":" + val.a + "," + val.i.n1;
  }
  );
}
 document.getElementById("test_异步返回匿名嵌套对象").click()
      
    