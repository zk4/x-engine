
import secrect from './index.js'
 {
  window.get = () => {
    secrect
      .get({
        key: "key"
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
    