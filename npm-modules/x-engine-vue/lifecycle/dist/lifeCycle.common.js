function e(e){return e&&"object"==typeof e&&"default"in e?e:{default:e}}var t,n=e(require("@zkty-team/x-engine-core"));function o(e){t!==e&&(t=e),t.mixin({beforeCreate:function(){var e=this;n.default.onLifecycle(function(t,n){"onNativeShow"==t||"onWebviewShow"==t?null==e.onNativeShow||e.onNativeShow():"onNativeHide"==t?null==e.onNativeHide||e.onNativeHide():"onNativeDestroyed"==t&&(null==e.onNativeDestroyed||e.onNativeDestroyed())})}})}exports.default={install:o},exports.install=o;
//# sourceMappingURL=lifeCycle.common.js.map