import XEngine from '@zkty-team/x-engine-core'

function intercept(VueRouter, scheme) {
    const originalRouterPush = VueRouter.prototype.push;
    VueRouter.prototype.push = function push(location) {
        if (XEngine.isHybrid()) {
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
}

export default intercept;