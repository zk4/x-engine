import e from"@zkty-team/x-engine-core";let o;function n(n){o!==n&&(o=n),o.mixin({mounted(){let o=this;(o.onNativeShow||o.onNativeHide||o.onWebviewShow||o.onNativeDestroyed)&&e.onLifecycle((e,n)=>{console.log(e,n),"onNativeShow"==e?null==o.onNativeShow||o.onNativeShow():"onNativeHide"==e?null==o.onNativeHide||o.onNativeHide():"onWebviewShow"==e?null==o.onWebviewShow||o.onWebviewShow():"onNativeDestroyed"==e&&(null==o.onNativeDestroyed||o.onNativeDestroyed())})}})}var i={install:n};export{i as default,n as install};
