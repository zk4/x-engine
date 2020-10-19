
import lope from './index.js'

    window.openDoor = () => {
    lope
      .openDoor()
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res["title"];
      });
  };

  window.customOpenDoor = () => {
  lope
    .customOpenDoor()
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };


  window.lightLift = () => {
  lope
    .lightLift()
    .then((res) => {
      document.getElementById("debug_text").innerText = "ret:"+res;
    });
  };


    window.haveArgRetPrimitive = (...args) => {
    lope
      .haveArgRetPrimitive(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:"+res;
      });
  };

    