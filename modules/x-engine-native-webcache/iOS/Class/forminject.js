
(function () {
    // 拦截 webview 直接提交的 form.
    function getOuterForm(node) {
      let parentNode = node.parentNode;
      if (parentNode.nodeName == "FORM") {
        return parentNode;
      } else {
        return getOuterForm(parentNode);
      }
    }
    document.body.addEventListener("click", function(event) {
      if (event.target.type == "submit") {
        event.preventDefault();
        let form = getOuterForm(event.target);
        let formData = new FormData(form);
        let xmlHttp = new XMLHttpRequest();
          xmlHttp.onreadystatechange = function()
          {
              if(xmlHttp.readyState == 4)
              {
                  console.warn("注意,在 x-engine 里, 原生 form 提交已全局拦截, 将不再支持页面跳转! 若有兼容问题, 请修改业务代码.")
    //                  console.log(xmlHttp.responseText);
              }
          }
          xmlHttp.open(form.method, form.action);
          xmlHttp.send(formData);
      }
    });
})()

