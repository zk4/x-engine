
import geo from './index.js'
import xengine from "@zkty-team/x-engine-module-engine";


    window.coordinate = (...args) => {
    geo
      .coordinate(...args)
 
  };

  window.locate = () => {
    geo
      .locate({
          __event__:function(res){
        //GeoLocationResDTO
        res = JSON.parse(res);
        document.getElementById("debug_text").innerText = "long,lat,locs:"+ res["longitude"]+res["latitude"]+res["locationString"];
        return res;
          }
        }
      )
  };

    