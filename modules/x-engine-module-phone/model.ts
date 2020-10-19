// 命名空间
const moduleID = "com.zkty.module.phone";

interface ZKTYCallDTO {
  phonenumber string;
}
interface ZKTYCallDTO {
  phonenumber string;
  msg string;
}

// have args ret Object
function phoneCall(arg:ZKTYCallDTO={phonenumber:"15010111335"}):void {
    window.phoneCall = (...args) => {
    phone
      .phoneCall(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };
}


