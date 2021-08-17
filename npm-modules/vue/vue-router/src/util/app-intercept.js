/* @flow */

import XEngine from '@zkty-team/x-engine-core'

export function native_push (location, scheme) {
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

export function native_go (location, scheme) {
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
// 判断是否到原生
export function is_native () {
  return XEngine.isHybrid() && (XEngine.platform.isAndroid || XEngine.platform.isPhone)
}

export function is_native_location (location, isSLR) {
  if (!location) return
  if (is_native()) {
    if (isSLR) return false
    // const { path } = location
    // // 如果是 / 走原生路由
    // if (path === '/') return true
    // // 如果给的路由是多级路由 走vue-router 
    // if (typeof path === 'string' && path.match(/\//g).length > 1) return false
    // // 如果是 /test /test1   这样的路由走原生
    return true
  }
  // 如果没有在app中 走原生vue-router
  return false
}


export function isSameLavelRoute (currentRoute, target) {
  if (!currentRoute || !target) return
  const { path } = currentRoute
  return equalPath(path, target.path)
}


export const checkScheme = (): scheme => {
  const protocol = window.location.protocol
  if (/^(http|https):/.test(protocol)) return 'omp'
  return 'microapp'
}


function equalPath (currentPath, targetPath) {
  const reg = /(?:\/).*(?=\/)/
  const cur = reg.exec(currentPath) && reg.exec(currentPath)[0]
  const target = reg.exec(targetPath) && reg.exec(targetPath)[0]
  return cur === target
}
