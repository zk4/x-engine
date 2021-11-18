import Taro from "@tarojs/taro";
import xengine from "@zkty-team/x-engine-core";
import { scheme, flatParams, parseActionStr } from './vapiDispatcher.js'

export function doAction(actionStr) {
    let { action, argMap } = parseActionStr(actionStr);
    if ("navigateToOrderPage" === action) {
        let fragment = "/pages/testPage/testPage";
        if (xengine.isHybrid()) {
            if (xengine.platform.isAndroid || xengine.platform.isPhone) {
                xengine.api(
                    "com.zkty.jsi.direct",
                    "push", {
                        scheme: scheme,
                        pathname: "/",
                        fragment: fragment,
                        query: decodeURIComponent(argMap),
                        params: {
                            hideNavbar: true
                        }
                    },
                    function() {}
                );
            }
        } else {
            if (process.env.TARO_ENV === "weapp") {
                Taro.navigateTo({ url: fragment + decodeURIComponent(flatParams(argMap)) });
            } else if (process.env.TARO_ENV === "h5") {
                Taro.navigateTo({ url: fragment + decodeURIComponent(flatParams(argMap)) });
            }
        }
    }
}