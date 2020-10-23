
import lope from './index.js'

  window.openDoor = (...args) => {
  lope
    .openDoor(...args)
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };


  window.customOpenDoor = (...args) => {
  lope
    .customOpenDoor(...args)
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };


  window.lightLift = (...args) => {
  lope
    .lightLift(...args)
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };


    