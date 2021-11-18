import Taro from "@tarojs/taro";
import { flatParams, parseActionStr } from "./vapiDispatcher.js";

export function doAction(actionStr) {
    let { action, argMap } = parseActionStr(actionStr);
    if ("navigateToOrderPage" === action) {
        let fragment = "/pages/testPage/testPage";
        Taro.navigateTo({
            url: fragment + decodeURIComponent(flatParams(argMap))
        });
    }
}