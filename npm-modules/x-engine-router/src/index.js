import XEngine from '@zkty-team/x-engine-core'
let vue
function intercept(VueRouter, scheme) {
    const originalRouterPush = VueRouter.prototype.push;
    VueRouter.prototype.push = function push (location) {
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
    // xengine.broadcastOn((type, payload) => {
    //     if (type === '@@VUEX_STORE_EVENT') {
    //       let state = JSON.parse(payload)
    //         rawRouter._route.params = state;
    //     }
    //   });
    
}
let installed = false
function install (Vue, VueRouter) {
    if (installed) return
    vue = Vue || window.Vue
    installed = true
    if (process.env.NODE_ENV == 'development') {
        intercept(VueRouter, 'omp');
    } else {
        intercept(VueRouter, 'microapp');
    }
    Vue.mixin({
        beforeCreate () {
            if (XEngine.isHybrid()) {
                let val = XEngine.api("com.zkty.jsi.secret", "get", 'nativeParams');
                console.log('val: ', val);
                
                const data = JSON.parse(val)
                // console.log('data',  data)
                Vue.util.defineReactive(this.$route, 'params', data)
            }
        },
    }) 
}
export default {
    intercept, install
};