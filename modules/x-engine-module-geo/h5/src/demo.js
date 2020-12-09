
import geo from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


    window.coordinate = (...args) => {
    geo
      .coordinate(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "long,lat:"+res["longitude"]+res["latitude"];
      });
  };

    window.locate = (...args) => {
    geo
      .locate(...args)
      .then((res) => {
        document.getElementById("debug_text").innerText = "hello";
      });
  };

  window.locate__event__ = () => {
    geo
      .locate__event__({
          __event__:function(res){
        res = JSON.parse(res);
        document.getElementById("debug_text").innerText = "long,lat,locs:"+ res["longitude"]+res["latitude"]+res["locationString"];
        //document.getElementById("debug_text").innerText=res ;
        return res;
          }
        }
      )
  };

    