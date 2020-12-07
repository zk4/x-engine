
import share from './index.js'

    window.share = (...args) => {
    share
      .share({
        ...args,
        title:"这是一个测试 title",
        desc:"this is desc",
        link: "https://www.baidu.com"
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["code"];
      });
  };

    