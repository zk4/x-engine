
import container from './index.js'

    window.push = (...args) => {
    container
      .push(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    