!function(e,n){"object"==typeof exports&&"undefined"!=typeof module?n(exports,require("@zkty-team/x-engine-core")):"function"==typeof define&&define.amd?define(["exports","@zkty-team/x-engine-core"],n):n((e||self).xEngineLifecycle={},e.xengine)}(this,function(e,n){function t(e){return e&&"object"==typeof e&&"default"in e?e:{default:e}}var i,o=t(n);function f(e){i!==e&&(i=e),i.mixin({beforeCreate:function(){var e=this;o.default.onLifecycle(function(n,t){"onNativeShow"==n||"onWebviewShow"==n?null==e.onNativeShow||e.onNativeShow():"onNativeHide"==n?null==e.onNativeHide||e.onNativeHide():"onNativeDestroyed"==n&&(null==e.onNativeDestroyed||e.onNativeDestroyed())})}})}e.default={install:f},e.install=f});
//# sourceMappingURL=lifeCycle.common.umd.js.map
