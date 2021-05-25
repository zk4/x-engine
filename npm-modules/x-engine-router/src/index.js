import XEngine from '@zkty-team/x-engine-core'
let vue
function intercept(VueRouter, scheme) {
    const originalRouterPush = VueRouter.prototype.push;
    VueRouter.prototype.push = function push(location) {
        if (XEngine.isHybrid()) {
            XEngine.api('com.zkty.jsi.direct', 'push', {
                scheme: scheme,
                pathname: '',
                fragment: location.path || location.name,
                query: location.query,
                params: {
                    hideNavbar: true,
                    nativeParams: location.params,
                }
            }, function (res) {
                console.log('res :>> ', res);
            })
        } else {
            //  为了适配android
            if (XEngine.platform.isAndroid) {
                XEngine.api('com.zkty.jsi.direct', 'push', {
                    scheme: scheme,
                    pathname: '',
                    fragment: location.path,
                    query: location.query,
                    params: {
                        hideNavbar: true
                    }
                }, function (res) {
                    console.log('res :>> ', res);
                })
            } else {
                return originalRouterPush.call(this, location);
            }
        }
    }

    const originalRouterGo = VueRouter.prototype.go;
    VueRouter.prototype.go = function go(location) {
        if (XEngine.isHybrid()) {
            XEngine.api('com.zkty.jsi.direct', 'back', {
                scheme: scheme,
                pathname: '',
                fragment: location + "",
                params: {
                    hideNavbar: true
                }
            }, function (res) {
                console.log('res :>> ', res);
            })
        } else {
            //  为了适配android
            if (XEngine.platform.isAndroid) {
                XEngine.api('com.zkty.jsi.direct', 'back', {
                    scheme: scheme,
                    pathname: '',
                    fragment: location + "",
                    params: {
                        hideNavbar: true
                    }
                }, function (res) {
                    console.log('res :>> ', res);
                })
            } else {
                return originalRouterGo.call(this, location);
            }
        }
    }
    const rawRouter = VueRouter
    const paramsObj = Object.create(null)
    console.log('rawRouter', rawRouter)
    let val = JSON.parse(XEngine.api("com.zkty.jsi.secret", "get", 'nativeParams',));
    console.log(val);
    // xengine.broadcastOn((type, payload) => {
    //     if (type === '@@VUEX_STORE_EVENT') {
    //       let state = JSON.parse(payload)
    //         rawRouter._route.params = state;
    //     }
    //   });
    // Object.defineProperty(rawRouter._route, 'params', {
    //     value: {},
    //     get () {
    //         return paramsObj
    //     },
    //     set (newValue) {
    //         paramsObj = newValue
    //     }
    // })
}
let installed = false
function install (Vue) {
    vue = Vue || window.Vue
    if (vue) {
        installed = true
    }
    if (process.env.NODE_ENV == 'development') {
        XEngineRouter(VueRouter, 'omp');
    } else {
        XEngineRouter(VueRouter, 'microapp');
    }

}
export default {
    intercept, install
};