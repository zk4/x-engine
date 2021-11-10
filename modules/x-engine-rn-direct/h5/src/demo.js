
import rn_direct from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_同步无返回 = () => {

  let val = xengine.api("com.zkty.jsi.rn_direct", "simpleMethod");
  document.getElementById("debug_text").innerText = "无返回,查看原生控制台打印";
}
window.test_同步简单参数 = () => {

  let val = xengine.api(
    "com.zkty.jsi.rn_direct",
    "simpleArgMethod",
    "hello,from js"
  );
  document.getElementById("debug_text").innerText = val;
}
window.test_同步简单数字参数 = () => {

  let val = xengine.api("com.zkty.jsi.rn_direct", "simpleArgNumberMethod", 1000);
  document.getElementById("debug_text").innerText = val;
}
window.test_同步返回命名对象 = () => {

  let val = xengine.api("com.zkty.jsi.rn_direct", "namedObject", {});
  document.getElementById("debug_text").innerText =
    typeof val + ":" + val.title + "," + val.titleSize;
}
window.test_同步返回匿名嵌套对象 = () => {

  let val = xengine.api("com.zkty.jsi.rn_direct", "nestedAnonymousObject", {});
  document.getElementById("debug_text").innerText =
    typeof val + ":" + val.a + "," + val.i.n1;
}
window.test_异步返回命名对象 = () => {

  xengine.api("com.zkty.jsi.rn_direct", "namedObject", {}, (val) => {
    document.getElementById("debug_text").innerText =
      typeof val + ":" + val.title + "," + val.titleSize;
  });
}
window.test_异步简单参数 = () => {

  xengine.api(
    "com.zkty.jsi.rn_direct",
    "simpleArgMethod",
    "hello,from js",
    (val) => {
      document.getElementById("debug_text").innerText = val;
    }
  );
}
window.test_异步简单数字参数 = () => {

  xengine.api("com.zkty.jsi.rn_direct", "simpleArgNumberMethod", 1000, (val) => {
    document.getElementById("debug_text").innerText = val;
  });
}
window.test_异步返回命名对象 = () => {

  xengine.api("com.zkty.jsi.rn_direct", "namedObject", {}, (val) => {
    document.getElementById("debug_text").innerText =
      typeof val + ":" + val.title + "," + val.titleSize;
  });
}
window.test_异步返回匿名嵌套对象 = () => {

  xengine.api("com.zkty.jsi.rn_direct", "nestedAnonymousObject", {}, (val) => {
    document.getElementById("debug_text").innerText =
      typeof val + ":" + val.a + "," + val.i.n1;
  });
}
window.test_complex_async = () => {

  xengine.api(
    "com.zkty.jsi.rn_direct",
    "complexAnoymousRetWithAnoymousArgs",
    {
      name: "zk",
      age: 12,
      houses: [
        {
          address: "address",
          longtitude: "longtitude",
          latitude: "latitude",
          dealer: {
            name: "name_of_dealer",
            age: 13,
          },
        },
      ],
    },
    (val) => {
      document.getElementById("debug_text").innerText = JSON.stringify(val);
    }
  );
}
window.test_complex_sync = () => {

  val = xengine.api("com.zkty.jsi.rn_direct", "complexAnoymousRetWithAnoymousArgs", {
    name: "zk",
    age: 12,
    houses: [
      {
        address: "address",
        longtitude: "longtitude",
        latitude: "latitude",
        dealer: {
          name: "name_of_dealer",
          age: 13,
        },
      },
    ],
  });
  document.getElementById("debug_text").innerText = JSON.stringify(val);
}

    