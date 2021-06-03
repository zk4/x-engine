!function(t,e){"object"==typeof exports&&"undefined"!=typeof module?e(exports,require("@zkty-team/x-engine-core")):"function"==typeof define&&define.amd?define(["exports","@zkty-team/x-engine-core"],e):e((t||self).vuex={},t.xengine)}(this,function(t,e){function n(t){return t&&"object"==typeof t&&"default"in t?t:{default:t}}var r=n(e);function o(t,e){for(var n=0;n<e.length;n++){var r=e[n];r.enumerable=r.enumerable||!1,r.configurable=!0,"value"in r&&(r.writable=!0),Object.defineProperty(t,r.key,r)}}function i(t,e,n){return e&&o(t.prototype,e),n&&o(t,n),t}function a(){return(a=Object.assign||function(t){for(var e=1;e<arguments.length;e++){var n=arguments[e];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(t[r]=n[r])}return t}).apply(this,arguments)}var s=("undefined"!=typeof window?window:"undefined"!=typeof global?global:{}).__VUE_DEVTOOLS_GLOBAL_HOOK__;function c(t,e){if(void 0===e&&(e=[]),null===t||"object"!=typeof t)return t;var n=e.filter(function(e){return e.original===t})[0];if(n)return n.copy;var r=Array.isArray(t)?[]:{};return e.push({original:t,copy:r}),Object.keys(t).forEach(function(n){r[n]=c(t[n],e)}),r}function u(t,e){Object.keys(t).forEach(function(n){return e(t[n],n)})}function l(t){return null!==t&&"object"==typeof t}function f(t,e){if(!t)throw new Error("[vuex] "+e)}var h="production"!==process.env.NODE_ENV,d=function(){function t(t,e){this.runtime=e,this._children=Object.create(null),this._rawModule=t;var n=t.state;this.state=("function"==typeof n?n():n)||{}}var e=t.prototype;return e.addChild=function(t,e){this._children[t]=e},e.removeChild=function(t){delete this._children[t]},e.getChild=function(t){return this._children[t]},e.hasChild=function(t){return t in this._children},e.update=function(t){this._rawModule.namespaced=t.namespaced,t.actions&&(this._rawModule.actions=t.actions),t.mutations&&(this._rawModule.mutations=t.mutations),t.getters&&(this._rawModule.getters=t.getters)},e.forEachChild=function(t){u(this._children,t)},e.forEachGetter=function(t){this._rawModule.getters&&u(this._rawModule.getters,t)},e.forEachAction=function(t){this._rawModule.actions&&u(this._rawModule.actions,t)},e.forEachMutation=function(t){this._rawModule.mutations&&u(this._rawModule.mutations,t)},i(t,[{key:"namespaced",get:function(){return!!this._rawModule.namespaced}}]),t}(),p=function(){function t(t){this.register([],t,!1)}var e=t.prototype;return e.get=function(t){return console.log("this.root",this),t.reduce(function(t,e){return t.getChild(e)},this.root)},e.getNamespace=function(t){var e=this.root;return t.reduce(function(t,n){return t+((e=e.getChild(n)).namespaced?n+"/":"")},"")},e.update=function(t){m([],this.root,t)},e.register=function(t,e,n){var r=this;void 0===n&&(n=!0),h&&b(t,e);var o=new d(e,n);0===t.length?this.root=o:this.get(t.slice(0,-1)).addChild(t[t.length-1],o),e.modules&&u(e.modules,function(e,o){r.register(t.concat(o),e,n)})},e.unregister=function(t){var e=this.get(t.slice(0,-1)),n=t[t.length-1],r=e.getChild(n);r?r.runtime&&e.removeChild(n):h&&console.warn("[vuex] trying to unregister module '"+n+"', which is not registered")},e.isRegistered=function(t){var e=this.get(t.slice(0,-1));return!!e&&e.hasChild(t[t.length-1])},t}();function m(t,e,n){if(h&&b(t,n),e.update(n),n.modules)for(var r in n.modules){if(!e.getChild(r))return void(h&&console.warn("[vuex] trying to add a new module '"+r+"' on hot reloading, manual reload is needed"));m(t.concat(r),e.getChild(r),n.modules[r])}}var v,g={assert:function(t){return"function"==typeof t},expected:"function"},y={getters:g,mutations:g,actions:{assert:function(t){return"function"==typeof t||"object"==typeof t&&"function"==typeof t.handler},expected:'function or object with "handler" function'}};function b(t,e){Object.keys(y).forEach(function(n){if(e[n]){var r=y[n];u(e[n],function(e,o){f(r.assert(e),function(t,e,n,r,o){var i=e+" should be "+o+' but "'+e+"."+n+'"';return t.length>0&&(i+=' in module "'+t.join(".")+'"'),i+" is "+JSON.stringify(r)+"."}(t,n,o,e,r.expected))})}})}var _=function(){function t(e){var n=this;void 0===e&&(e={}),!v&&"undefined"!=typeof window&&window.Vue&&A(window.Vue),h&&(f(v,"must call Vue.use(Vuex) before creating a store instance."),f("undefined"!=typeof Promise,"vuex requires a Promise polyfill in this browser."),f(this instanceof t,"store must be called with the new operator."));var o=e.plugins,i=void 0===o?[]:o,c=e.strict,u=void 0!==c&&c,l=r.default.api("com.zkty.jsi.vuex","get","store");if(l&&"modules"in e){var d=JSON.parse(l);Object.keys(e.modules).forEach(function(t){e.modules[t].state=a({},e.modules[t].state,d[t])})}this._committing=!1,this._actions=Object.create(null),this._actionSubscribers=[],this._mutations=Object.create(null),this._wrappedGetters=Object.create(null),this._modules=new p(e),this._modulesNamespaceMap=Object.create(null),this._subscribers=[],this._watcherVM=new v,this._makeLocalGettersCache=Object.create(null);var m=this,g=this.dispatch,y=this.commit;this.dispatch=function(t,e){return g.call(m,t,e)},this.commit=function(t,e,n){return y.call(m,t,e,n)},this.strict=u;var b=this._modules.root.state;l?b=JSON.parse(l):b&&r.default.api("com.zkty.jsi.vuex","set",{key:"store",val:JSON.stringify(b)}),j(this,b,[],this._modules.root),O(this,b),i.forEach(function(t){return t(n)}),r.default.platform.isPc||(this._subscribers.push(function(t,e){r.default.api("com.zkty.jsi.vuex","set",{key:"store",val:JSON.stringify(e)})}),r.default.broadcastOn(function(t,e){if("@@VUEX_STORE_EVENT"===t){var r=JSON.parse(e);Object.keys(n._vm._data.$$state).forEach(function(t){n._vm._data.$$state[t]=r[t]})}})),(void 0!==e.devtools?e.devtools:v.config.devtools)&&function(t){s&&(t._devtoolHook=s,s.emit("vuex:init",t),s.on("vuex:travel-to-state",function(e){t.replaceState(e)}),t.subscribe(function(t,e){s.emit("vuex:mutation",t,e)},{prepend:!0}),t.subscribeAction(function(t,e){s.emit("vuex:action",t,e)},{prepend:!0}))}(this)}var e=t.prototype;return e.commit=function(t,e,n){var r=this,o=E(t,e,n),i=o.type,a=o.payload,s=o.options,c={type:i,payload:a},u=this._mutations[i];u?(this._withCommit(function(){u.forEach(function(t){t(a)})}),this._subscribers.slice().forEach(function(t){return t(c,r.state)}),h&&s&&s.silent&&console.warn("[vuex] mutation type: "+i+". Silent option has been removed. Use the filter functionality in the vue-devtools")):h&&console.error("[vuex] unknown mutation type: "+i)},e.dispatch=function(t,e){var n=this,r=E(t,e),o=r.type,i=r.payload,a={type:o,payload:i},s=this._actions[o];if(s){try{this._actionSubscribers.slice().filter(function(t){return t.before}).forEach(function(t){return t.before(a,n.state)})}catch(t){h&&(console.warn("[vuex] error in before action subscribers: "),console.error(t))}var c=s.length>1?Promise.all(s.map(function(t){return t(i)})):s[0](i);return new Promise(function(t,e){c.then(function(e){try{n._actionSubscribers.filter(function(t){return t.after}).forEach(function(t){return t.after(a,n.state)})}catch(t){h&&(console.warn("[vuex] error in after action subscribers: "),console.error(t))}t(e)},function(t){try{n._actionSubscribers.filter(function(t){return t.error}).forEach(function(e){return e.error(a,n.state,t)})}catch(t){h&&(console.warn("[vuex] error in error action subscribers: "),console.error(t))}e(t)})})}h&&console.error("[vuex] unknown action type: "+o)},e.subscribe=function(t,e){return w(t,this._subscribers,e)},e.subscribeAction=function(t,e){return w("function"==typeof t?{before:t}:t,this._actionSubscribers,e)},e.watch=function(t,e,n){var r=this;return h&&f("function"==typeof t,"store.watch only accepts a function."),this._watcherVM.$watch(function(){return t(r.state,r.getters)},e,n)},e.replaceState=function(t){var e=this;this._withCommit(function(){e._vm._data.$$state=t})},e.registerModule=function(t,e,n){void 0===n&&(n={}),"string"==typeof t&&(t=[t]),h&&(f(Array.isArray(t),"module path must be a string or an Array."),f(t.length>0,"cannot register the root module by using registerModule.")),this._modules.register(t,e),j(this,this.state,t,this._modules.get(t),n.preserveState),O(this,this.state)},e.unregisterModule=function(t){var e=this;"string"==typeof t&&(t=[t]),h&&f(Array.isArray(t),"module path must be a string or an Array."),this._modules.unregister(t),this._withCommit(function(){var n=k(e.state,t.slice(0,-1));v.delete(n,t[t.length-1])}),x(this)},e.hasModule=function(t){return"string"==typeof t&&(t=[t]),h&&f(Array.isArray(t),"module path must be a string or an Array."),this._modules.isRegistered(t)},e.hotUpdate=function(t){this._modules.update(t),x(this,!0)},e._withCommit=function(t){var e=this._committing;this._committing=!0,t(),this._committing=e},i(t,[{key:"state",get:function(){return this._vm._data.$$state},set:function(t){h&&f(!1,"use store.replaceState() to explicit replace store state.")}}]),t}();function w(t,e,n){return e.indexOf(t)<0&&(n&&n.prepend?e.unshift(t):e.push(t)),function(){var n=e.indexOf(t);n>-1&&e.splice(n,1)}}function x(t,e){t._actions=Object.create(null),t._mutations=Object.create(null),t._wrappedGetters=Object.create(null),t._modulesNamespaceMap=Object.create(null);var n=t.state;j(t,n,[],t._modules.root,!0),O(t,n,e)}function O(t,e,n){var r=t._vm;t.getters={},t._makeLocalGettersCache=Object.create(null);var o={};u(t._wrappedGetters,function(e,n){o[n]=function(t,e){return function(){return t(e)}}(e,t),Object.defineProperty(t.getters,n,{get:function(){return t._vm[n]},enumerable:!0})});var i=v.config.silent;v.config.silent=!0,t._vm=new v({data:{$$state:e},computed:o}),v.config.silent=i,t.strict&&function(t){t._vm.$watch(function(){return this._data.$$state},function(){h&&f(t._committing,"do not mutate vuex store state outside mutation handlers.")},{deep:!0,sync:!0})}(t),r&&(n&&t._withCommit(function(){r._data.$$state=null}),v.nextTick(function(){return r.$destroy()}))}function j(t,e,n,r,o){var i=!n.length,a=t._modules.getNamespace(n);if(r.namespaced&&(t._modulesNamespaceMap[a]&&h&&console.error("[vuex] duplicate namespace "+a+" for the namespaced module "+n.join("/")),t._modulesNamespaceMap[a]=r),!i&&!o){var s=k(e,n.slice(0,-1)),c=n[n.length-1];t._withCommit(function(){h&&c in s&&console.warn('[vuex] state field "'+c+'" was overridden by a module with the same name at "'+n.join(".")+'"'),v.set(s,c,r.state)})}var u=r.context=function(t,e,n){var r=""===e,o={dispatch:r?t.dispatch:function(n,r,o){var i=E(n,r,o),a=i.options,s=i.type;if(a&&a.root||(s=e+s,!h||t._actions[s]))return t.dispatch(s,i.payload);console.error("[vuex] unknown local action type: "+i.type+", global type: "+s)},commit:r?t.commit:function(n,r,o){var i=E(n,r,o),a=i.options,s=i.type;a&&a.root||(s=e+s,!h||t._mutations[s])?t.commit(s,i.payload,a):console.error("[vuex] unknown local mutation type: "+i.type+", global type: "+s)}};return Object.defineProperties(o,{getters:{get:r?function(){return t.getters}:function(){return function(t,e){if(!t._makeLocalGettersCache[e]){var n={},r=e.length;Object.keys(t.getters).forEach(function(o){if(o.slice(0,r)===e){var i=o.slice(r);Object.defineProperty(n,i,{get:function(){return t.getters[o]},enumerable:!0})}}),t._makeLocalGettersCache[e]=n}return t._makeLocalGettersCache[e]}(t,e)}},state:{get:function(){return k(t.state,n)}}}),o}(t,a,n);r.forEachMutation(function(e,n){!function(t,e,n,r){(t._mutations[e]||(t._mutations[e]=[])).push(function(e){n.call(t,r.state,e)})}(t,a+n,e,u)}),r.forEachAction(function(e,n){!function(t,e,n,r){(t._actions[e]||(t._actions[e]=[])).push(function(e){var o,i=n.call(t,{dispatch:r.dispatch,commit:r.commit,getters:r.getters,state:r.state,rootGetters:t.getters,rootState:t.state},e);return(o=i)&&"function"==typeof o.then||(i=Promise.resolve(i)),t._devtoolHook?i.catch(function(e){throw t._devtoolHook.emit("vuex:error",e),e}):i})}(t,e.root?n:a+n,e.handler||e,u)}),r.forEachGetter(function(e,n){!function(t,e,n,r){t._wrappedGetters[e]?h&&console.error("[vuex] duplicate getter key: "+e):t._wrappedGetters[e]=function(t){return n(r.state,r.getters,t.state,t.getters)}}(t,a+n,e,u)}),r.forEachChild(function(r,i){j(t,e,n.concat(i),r,o)})}function k(t,e){return e.reduce(function(t,e){return t[e]},t)}function E(t,e,n){return l(t)&&t.type&&(n=e,e=t,t=t.type),h&&f("string"==typeof t,"expects string as the type, but found "+typeof t+"."),{type:t,payload:e,options:n}}function A(t){v&&t===v?h&&console.error("[vuex] already installed. Vue.use(Vuex) should be called only once."):function(t){if(Number(t.version.split(".")[0])>=2)t.mixin({beforeCreate:n});else{var e=t.prototype._init;t.prototype._init=function(t){void 0===t&&(t={}),t.init=t.init?[n].concat(t.init):n,e.call(this,t)}}function n(){var t=this.$options;t.store?this.$store="function"==typeof t.store?t.store():t.store:t.parent&&t.parent.$store&&(this.$store=t.parent.$store)}}(v=t)}var $=P(function(t,e){var n={};return h&&!V(e)&&console.error("[vuex] mapState: mapper parameter must be either an Array or an Object"),G(e).forEach(function(e){var r=e.key,o=e.val;n[r]=function(){var e=this.$store.state,n=this.$store.getters;if(t){var r=L(this.$store,"mapState",t);if(!r)return;e=r.context.state,n=r.context.getters}return"function"==typeof o?o.call(this,e,n):e[o]},n[r].vuex=!0}),n}),M=P(function(t,e){var n={};return h&&!V(e)&&console.error("[vuex] mapMutations: mapper parameter must be either an Array or an Object"),G(e).forEach(function(e){var r=e.val;n[e.key]=function(){var e=[].slice.call(arguments),n=this.$store.commit;if(t){var o=L(this.$store,"mapMutations",t);if(!o)return;n=o.context.commit}return"function"==typeof r?r.apply(this,[n].concat(e)):n.apply(this.$store,[r].concat(e))}}),n}),S=P(function(t,e){var n={};return h&&!V(e)&&console.error("[vuex] mapGetters: mapper parameter must be either an Array or an Object"),G(e).forEach(function(e){var r=e.key,o=e.val;o=t+o,n[r]=function(){if(!t||L(this.$store,"mapGetters",t)){if(!h||o in this.$store.getters)return this.$store.getters[o];console.error("[vuex] unknown getter: "+o)}},n[r].vuex=!0}),n}),C=P(function(t,e){var n={};return h&&!V(e)&&console.error("[vuex] mapActions: mapper parameter must be either an Array or an Object"),G(e).forEach(function(e){var r=e.val;n[e.key]=function(){var e=[].slice.call(arguments),n=this.$store.dispatch;if(t){var o=L(this.$store,"mapActions",t);if(!o)return;n=o.context.dispatch}return"function"==typeof r?r.apply(this,[n].concat(e)):n.apply(this.$store,[r].concat(e))}}),n}),N=function(t){return{mapState:$.bind(null,t),mapGetters:S.bind(null,t),mapMutations:M.bind(null,t),mapActions:C.bind(null,t)}};function G(t){return V(t)?Array.isArray(t)?t.map(function(t){return{key:t,val:t}}):Object.keys(t).map(function(e){return{key:e,val:t[e]}}):[]}function V(t){return Array.isArray(t)||l(t)}function P(t){return function(e,n){return"string"!=typeof e?(n=e,e=""):"/"!==e.charAt(e.length-1)&&(e+="/"),t(e,n)}}function L(t,e,n){var r=t._modulesNamespaceMap[n];return h&&!r&&console.error("[vuex] module namespace not found in "+e+"(): "+n),r}function T(t){var e=void 0===t?{}:t,n=e.collapsed,r=void 0===n||n,o=e.filter,i=void 0===o?function(t,e,n){return!0}:o,a=e.transformer,s=void 0===a?function(t){return t}:a,u=e.mutationTransformer,l=void 0===u?function(t){return t}:u,f=e.actionFilter,h=void 0===f?function(t,e){return!0}:f,d=e.actionTransformer,p=void 0===d?function(t){return t}:d,m=e.logMutations,v=void 0===m||m,g=e.logActions,y=void 0===g||g,b=e.logger,_=void 0===b?console:b;return function(t){var e=c(t.state);void 0!==_&&(v&&t.subscribe(function(t,n){var o=c(n);if(i(t,e,o)){var a=z(),u=l(t);H(_,"mutation "+t.type+a,r),_.log("%c prev state","color: #9E9E9E; font-weight: bold",s(e)),_.log("%c mutation","color: #03A9F4; font-weight: bold",u),_.log("%c next state","color: #4CAF50; font-weight: bold",s(o)),J(_)}e=o}),y&&t.subscribeAction(function(t,e){if(h(t,e)){var n=z(),o=p(t);H(_,"action "+t.type+n,r),_.log("%c action","color: #03A9F4; font-weight: bold",o),J(_)}}))}}function H(t,e,n){var r=n?t.groupCollapsed:t.group;try{r.call(t,e)}catch(n){t.log(e)}}function J(t){try{t.groupEnd()}catch(e){t.log("—— log end ——")}}function z(){var t=new Date;return" @ "+F(t.getHours(),2)+":"+F(t.getMinutes(),2)+":"+F(t.getSeconds(),2)+"."+F(t.getMilliseconds(),3)}function F(t,e){return n=e-t.toString().length,new Array(n+1).join("0")+t;var n}var R={Store:_,install:A,version:"__VERSION__",mapState:$,mapMutations:M,mapGetters:S,mapActions:C,createNamespacedHelpers:N,createLogger:T};t.Store=_,t.createLogger=T,t.createNamespacedHelpers=N,t.default=R,t.install=A,t.mapActions=C,t.mapGetters=S,t.mapMutations=M,t.mapState=$});
//# sourceMappingURL=vuex.common.umd.js.map