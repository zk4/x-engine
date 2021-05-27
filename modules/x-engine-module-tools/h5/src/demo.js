
import tools from './index.js'

  
  window.unZipFile = () => {
    tools
      .unZipFile()
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:" + res;
      });
  };

  window.zipFile = () => {
    tools
      .zipFile()
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:" + res;
      });
  };

    