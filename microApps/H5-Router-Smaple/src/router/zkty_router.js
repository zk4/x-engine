function zktyRouter(VueRouter, XEngine, scheme) {
    const originalRouterPush = VueRouter.prototype.push;
    VueRouter.prototype.push = function push(location) {
        if (XEngine.isHybrid()) {
            XEngine.bridge.call('com.zkty.jsi.direct.push', {
                scheme: scheme,
                pathname: location.path,
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

    const originalRouterGo = VueRouter.prototype.go;
    VueRouter.prototype.go = function go(location) {
        if (XEngine.isHybrid()) {
            XEngine.bridge.call('com.zkty.jsi.direct.back', {
                scheme: scheme,
                pathname: '' + location,
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

module.exports = {
    zktyRouter
}