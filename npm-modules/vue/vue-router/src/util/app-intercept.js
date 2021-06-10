import VueRouter from '../index'
import XEngine from '@zkty-team/x-engine-core'

export function intercept (scheme) {
  const originalRouterPush = VueRouter.prototype.push
  VueRouter.prototype.push = function push (location) {
    if (XEngine.isHybrid()) {
      if (XEngine.platform.isAndroid || XEngine.platform.isPhone) {
        XEngine.api('com.zkty.jsi.direct', 'push', {
          scheme: scheme,
          pathname: '',
          fragment: location.path || '/' + location.name,
          query: location.query,
          params: {
            hideNavbar: true,
            nativeParams: location.params
          }
        }, function (res) {
          console.log('res :>> ', res)
        })
      }
    } else {
      return originalRouterPush.call(this, location)
    }
  }

  const originalRouterGo = VueRouter.prototype.go
  VueRouter.prototype.go = function go (location) {
    if (XEngine.isHybrid()) {
      if (XEngine.platform.isAndroid || XEngine.platform.isPhone) {
        XEngine.api('com.zkty.jsi.direct', 'back', {
          scheme: scheme,
          pathname: '',
          fragment: location + '',
          params: {
            hideNavbar: true
          }
        }, function (res) {
          console.log('res :>> ', res)
        })
      }
    } else {
      return originalRouterGo.call(this, location)
    }
  }
}


export function checkProtocol () {
  const protocol = window.location.protocol
  if (/^file/.test(protocol)) {
    return 'microapp'
  } else if (/^http/.test(protocol)) {
    return 'omp'
  } else {
    return false
  }
}