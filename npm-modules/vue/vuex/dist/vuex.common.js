function t(t){return t&&"object"==typeof t&&"default"in t?t:{default:t}}var e=t(require("@zkty-team/x-engine-core"));function n(t,e){for(var n=0;n<e.length;n++){var r=e[n];r.enumerable=r.enumerable||!1,r.configurable=!0,"value"in r&&(r.writable=!0),Object.defineProperty(t,r.key,r)}}function r(t,e,r){return e&&n(t.prototype,e),r&&n(t,r),t}function o(){return(o=Object.assign||function(t){for(var e=1;e<arguments.length;e++){var n=arguments[e];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(t[r]=n[r])}return t}).apply(this,arguments)}var i=("undefined"!=typeof window?window:"undefined"!=typeof global?global:{}).__VUE_DEVTOOLS_GLOBAL_HOOK__;function a(t,e){if(void 0===e&&(e=[]),null===t||"object"!=typeof t)return t;var n=e.filter(function(e){return e.original===t})[0];if(n)return n.copy;var r=Array.isArray(t)?[]:{};return e.push({original:t,copy:r}),Object.keys(t).forEach(function(n){r[n]=a(t[n],e)}),r}function s(t,e){Object.keys(t).forEach(function(n){return e(t[n],n)})}function c(t){return null!==t&&"object"==typeof t}function u(t,e){if(!t)throw new Error("[vuex] "+e)}var l="production"!==process.env.NODE_ENV,f=function(){function t(t,e){this.runtime=e,this._children=Object.create(null),this._rawModule=t;var n=t.state;this.state=("function"==typeof n?n():n)||{}}var e=t.prototype;return e.addChild=function(t,e){this._children[t]=e},e.removeChild=function(t){delete this._children[t]},e.getChild=function(t){return this._children[t]},e.hasChild=function(t){return t in this._children},e.update=function(t){this._rawModule.namespaced=t.namespaced,t.actions&&(this._rawModule.actions=t.actions),t.mutations&&(this._rawModule.mutations=t.mutations),t.getters&&(this._rawModule.getters=t.getters)},e.forEachChild=function(t){s(this._children,t)},e.forEachGetter=function(t){this._rawModule.getters&&s(this._rawModule.getters,t)},e.forEachAction=function(t){this._rawModule.actions&&s(this._rawModule.actions,t)},e.forEachMutation=function(t){this._rawModule.mutations&&s(this._rawModule.mutations,t)},r(t,[{key:"namespaced",get:function(){return!!this._rawModule.namespaced}}]),t}(),h=function(){function t(t){this.register([],t,!1)}var e=t.prototype;return e.get=function(t){return console.log("this.root",this),t.reduce(function(t,e){return t.getChild(e)},this.root)},e.getNamespace=function(t){var e=this.root;return t.reduce(function(t,n){return t+((e=e.getChild(n)).namespaced?n+"/":"")},"")},e.update=function(t){p([],this.root,t)},e.register=function(t,e,n){var r=this;void 0===n&&(n=!0),l&&g(t,e);var o=new f(e,n);0===t.length?this.root=o:this.get(t.slice(0,-1)).addChild(t[t.length-1],o),e.modules&&s(e.modules,function(e,o){r.register(t.concat(o),e,n)})},e.unregister=function(t){var e=this.get(t.slice(0,-1)),n=t[t.length-1],r=e.getChild(n);r?r.runtime&&e.removeChild(n):l&&console.warn("[vuex] trying to unregister module '"+n+"', which is not registered")},e.isRegistered=function(t){var e=this.get(t.slice(0,-1));return!!e&&e.hasChild(t[t.length-1])},t}();function p(t,e,n){if(l&&g(t,n),e.update(n),n.modules)for(var r in n.modules){if(!e.getChild(r))return void(l&&console.warn("[vuex] trying to add a new module '"+r+"' on hot reloading, manual reload is needed"));p(t.concat(r),e.getChild(r),n.modules[r])}}var d,m={assert:function(t){return"function"==typeof t},expected:"function"},v={getters:m,mutations:m,actions:{assert:function(t){return"function"==typeof t||"object"==typeof t&&"function"==typeof t.handler},expected:'function or object with "handler" function'}};function g(t,e){Object.keys(v).forEach(function(n){if(e[n]){var r=v[n];s(e[n],function(e,o){u(r.assert(e),function(t,e,n,r,o){var i=e+" should be "+o+' but "'+e+"."+n+'"';return t.length>0&&(i+=' in module "'+t.join(".")+'"'),i+" is "+JSON.stringify(r)+"."}(t,n,o,e,r.expected))})}})}var y=function(){function t(n){var r=this;void 0===n&&(n={}),!d&&"undefined"!=typeof window&&window.Vue&&E(window.Vue),l&&(u(d,"must call Vue.use(Vuex) before creating a store instance."),u("undefined"!=typeof Promise,"vuex requires a Promise polyfill in this browser."),u(this instanceof t,"store must be called with the new operator."));var a=n.plugins,s=void 0===a?[]:a,c=n.strict,f=void 0!==c&&c,p=e.default.api("com.zkty.jsi.vuex","get","store");if(p&&"modules"in n){var m=JSON.parse(p);Object.keys(n.modules).forEach(function(t){n.modules[t].state=o({},n.modules[t].state,m[t])})}this._committing=!1,this._actions=Object.create(null),this._actionSubscribers=[],this._mutations=Object.create(null),this._wrappedGetters=Object.create(null),this._modules=new h(n),this._modulesNamespaceMap=Object.create(null),this._subscribers=[],this._watcherVM=new d,this._makeLocalGettersCache=Object.create(null);var v=this,g=this.dispatch,y=this.commit;this.dispatch=function(t,e){return g.call(v,t,e)},this.commit=function(t,e,n){return y.call(v,t,e,n)},this.strict=f;var b=this._modules.root.state;p?b=JSON.parse(p):b&&e.default.api("com.zkty.jsi.vuex","set",{key:"store",val:JSON.stringify(b)}),x(this,b,[],this._modules.root),w(this,b),s.forEach(function(t){return t(r)}),e.default.platform.isPc||(this._subscribers.push(function(t,n){e.default.api("com.zkty.jsi.vuex","set",{key:"store",val:JSON.stringify(n)})}),e.default.broadcastOn(function(t,e){if("@@VUEX_STORE_EVENT"===t){var n=JSON.parse(e);Object.keys(r._vm._data.$$state).forEach(function(t){r._vm._data.$$state[t]=n[t]})}})),(void 0!==n.devtools?n.devtools:d.config.devtools)&&function(t){i&&(t._devtoolHook=i,i.emit("vuex:init",t),i.on("vuex:travel-to-state",function(e){t.replaceState(e)}),t.subscribe(function(t,e){i.emit("vuex:mutation",t,e)},{prepend:!0}),t.subscribeAction(function(t,e){i.emit("vuex:action",t,e)},{prepend:!0}))}(this)}var n=t.prototype;return n.commit=function(t,e,n){var r=this,o=j(t,e,n),i=o.type,a=o.payload,s=o.options,c={type:i,payload:a},u=this._mutations[i];u?(this._withCommit(function(){u.forEach(function(t){t(a)})}),this._subscribers.slice().forEach(function(t){return t(c,r.state)}),l&&s&&s.silent&&console.warn("[vuex] mutation type: "+i+". Silent option has been removed. Use the filter functionality in the vue-devtools")):l&&console.error("[vuex] unknown mutation type: "+i)},n.dispatch=function(t,e){var n=this,r=j(t,e),o=r.type,i=r.payload,a={type:o,payload:i},s=this._actions[o];if(s){try{this._actionSubscribers.slice().filter(function(t){return t.before}).forEach(function(t){return t.before(a,n.state)})}catch(t){l&&(console.warn("[vuex] error in before action subscribers: "),console.error(t))}var c=s.length>1?Promise.all(s.map(function(t){return t(i)})):s[0](i);return new Promise(function(t,e){c.then(function(e){try{n._actionSubscribers.filter(function(t){return t.after}).forEach(function(t){return t.after(a,n.state)})}catch(t){l&&(console.warn("[vuex] error in after action subscribers: "),console.error(t))}t(e)},function(t){try{n._actionSubscribers.filter(function(t){return t.error}).forEach(function(e){return e.error(a,n.state,t)})}catch(t){l&&(console.warn("[vuex] error in error action subscribers: "),console.error(t))}e(t)})})}l&&console.error("[vuex] unknown action type: "+o)},n.subscribe=function(t,e){return b(t,this._subscribers,e)},n.subscribeAction=function(t,e){return b("function"==typeof t?{before:t}:t,this._actionSubscribers,e)},n.watch=function(t,e,n){var r=this;return l&&u("function"==typeof t,"store.watch only accepts a function."),this._watcherVM.$watch(function(){return t(r.state,r.getters)},e,n)},n.replaceState=function(t){var e=this;this._withCommit(function(){e._vm._data.$$state=t})},n.registerModule=function(t,e,n){void 0===n&&(n={}),"string"==typeof t&&(t=[t]),l&&(u(Array.isArray(t),"module path must be a string or an Array."),u(t.length>0,"cannot register the root module by using registerModule.")),this._modules.register(t,e),x(this,this.state,t,this._modules.get(t),n.preserveState),w(this,this.state)},n.unregisterModule=function(t){var e=this;"string"==typeof t&&(t=[t]),l&&u(Array.isArray(t),"module path must be a string or an Array."),this._modules.unregister(t),this._withCommit(function(){var n=O(e.state,t.slice(0,-1));d.delete(n,t[t.length-1])}),_(this)},n.hasModule=function(t){return"string"==typeof t&&(t=[t]),l&&u(Array.isArray(t),"module path must be a string or an Array."),this._modules.isRegistered(t)},n.hotUpdate=function(t){this._modules.update(t),_(this,!0)},n._withCommit=function(t){var e=this._committing;this._committing=!0,t(),this._committing=e},r(t,[{key:"state",get:function(){return this._vm._data.$$state},set:function(t){l&&u(!1,"use store.replaceState() to explicit replace store state.")}}]),t}();function b(t,e,n){return e.indexOf(t)<0&&(n&&n.prepend?e.unshift(t):e.push(t)),function(){var n=e.indexOf(t);n>-1&&e.splice(n,1)}}function _(t,e){t._actions=Object.create(null),t._mutations=Object.create(null),t._wrappedGetters=Object.create(null),t._modulesNamespaceMap=Object.create(null);var n=t.state;x(t,n,[],t._modules.root,!0),w(t,n,e)}function w(t,e,n){var r=t._vm;t.getters={},t._makeLocalGettersCache=Object.create(null);var o={};s(t._wrappedGetters,function(e,n){o[n]=function(t,e){return function(){return t(e)}}(e,t),Object.defineProperty(t.getters,n,{get:function(){return t._vm[n]},enumerable:!0})});var i=d.config.silent;d.config.silent=!0,t._vm=new d({data:{$$state:e},computed:o}),d.config.silent=i,t.strict&&function(t){t._vm.$watch(function(){return this._data.$$state},function(){l&&u(t._committing,"do not mutate vuex store state outside mutation handlers.")},{deep:!0,sync:!0})}(t),r&&(n&&t._withCommit(function(){r._data.$$state=null}),d.nextTick(function(){return r.$destroy()}))}function x(t,e,n,r,o){var i=!n.length,a=t._modules.getNamespace(n);if(r.namespaced&&(t._modulesNamespaceMap[a]&&l&&console.error("[vuex] duplicate namespace "+a+" for the namespaced module "+n.join("/")),t._modulesNamespaceMap[a]=r),!i&&!o){var s=O(e,n.slice(0,-1)),c=n[n.length-1];t._withCommit(function(){l&&c in s&&console.warn('[vuex] state field "'+c+'" was overridden by a module with the same name at "'+n.join(".")+'"'),d.set(s,c,r.state)})}var u=r.context=function(t,e,n){var r=""===e,o={dispatch:r?t.dispatch:function(n,r,o){var i=j(n,r,o),a=i.options,s=i.type;if(a&&a.root||(s=e+s,!l||t._actions[s]))return t.dispatch(s,i.payload);console.error("[vuex] unknown local action type: "+i.type+", global type: "+s)},commit:r?t.commit:function(n,r,o){var i=j(n,r,o),a=i.options,s=i.type;a&&a.root||(s=e+s,!l||t._mutations[s])?t.commit(s,i.payload,a):console.error("[vuex] unknown local mutation type: "+i.type+", global type: "+s)}};return Object.defineProperties(o,{getters:{get:r?function(){return t.getters}:function(){return function(t,e){if(!t._makeLocalGettersCache[e]){var n={},r=e.length;Object.keys(t.getters).forEach(function(o){if(o.slice(0,r)===e){var i=o.slice(r);Object.defineProperty(n,i,{get:function(){return t.getters[o]},enumerable:!0})}}),t._makeLocalGettersCache[e]=n}return t._makeLocalGettersCache[e]}(t,e)}},state:{get:function(){return O(t.state,n)}}}),o}(t,a,n);r.forEachMutation(function(e,n){!function(t,e,n,r){(t._mutations[e]||(t._mutations[e]=[])).push(function(e){n.call(t,r.state,e)})}(t,a+n,e,u)}),r.forEachAction(function(e,n){!function(t,e,n,r){(t._actions[e]||(t._actions[e]=[])).push(function(e){var o,i=n.call(t,{dispatch:r.dispatch,commit:r.commit,getters:r.getters,state:r.state,rootGetters:t.getters,rootState:t.state},e);return(o=i)&&"function"==typeof o.then||(i=Promise.resolve(i)),t._devtoolHook?i.catch(function(e){throw t._devtoolHook.emit("vuex:error",e),e}):i})}(t,e.root?n:a+n,e.handler||e,u)}),r.forEachGetter(function(e,n){!function(t,e,n,r){t._wrappedGetters[e]?l&&console.error("[vuex] duplicate getter key: "+e):t._wrappedGetters[e]=function(t){return n(r.state,r.getters,t.state,t.getters)}}(t,a+n,e,u)}),r.forEachChild(function(r,i){x(t,e,n.concat(i),r,o)})}function O(t,e){return e.reduce(function(t,e){return t[e]},t)}function j(t,e,n){return c(t)&&t.type&&(n=e,e=t,t=t.type),l&&u("string"==typeof t,"expects string as the type, but found "+typeof t+"."),{type:t,payload:e,options:n}}function E(t){d&&t===d?l&&console.error("[vuex] already installed. Vue.use(Vuex) should be called only once."):function(t){if(Number(t.version.split(".")[0])>=2)t.mixin({beforeCreate:n});else{var e=t.prototype._init;t.prototype._init=function(t){void 0===t&&(t={}),t.init=t.init?[n].concat(t.init):n,e.call(this,t)}}function n(){var t=this.$options;t.store?this.$store="function"==typeof t.store?t.store():t.store:t.parent&&t.parent.$store&&(this.$store=t.parent.$store)}}(d=t)}var k=G(function(t,e){var n={};return l&&!N(e)&&console.error("[vuex] mapState: mapper parameter must be either an Array or an Object"),C(e).forEach(function(e){var r=e.key,o=e.val;n[r]=function(){var e=this.$store.state,n=this.$store.getters;if(t){var r=V(this.$store,"mapState",t);if(!r)return;e=r.context.state,n=r.context.getters}return"function"==typeof o?o.call(this,e,n):e[o]},n[r].vuex=!0}),n}),A=G(function(t,e){var n={};return l&&!N(e)&&console.error("[vuex] mapMutations: mapper parameter must be either an Array or an Object"),C(e).forEach(function(e){var r=e.val;n[e.key]=function(){var e=[].slice.call(arguments),n=this.$store.commit;if(t){var o=V(this.$store,"mapMutations",t);if(!o)return;n=o.context.commit}return"function"==typeof r?r.apply(this,[n].concat(e)):n.apply(this.$store,[r].concat(e))}}),n}),$=G(function(t,e){var n={};return l&&!N(e)&&console.error("[vuex] mapGetters: mapper parameter must be either an Array or an Object"),C(e).forEach(function(e){var r=e.key,o=e.val;o=t+o,n[r]=function(){if(!t||V(this.$store,"mapGetters",t)){if(!l||o in this.$store.getters)return this.$store.getters[o];console.error("[vuex] unknown getter: "+o)}},n[r].vuex=!0}),n}),M=G(function(t,e){var n={};return l&&!N(e)&&console.error("[vuex] mapActions: mapper parameter must be either an Array or an Object"),C(e).forEach(function(e){var r=e.val;n[e.key]=function(){var e=[].slice.call(arguments),n=this.$store.dispatch;if(t){var o=V(this.$store,"mapActions",t);if(!o)return;n=o.context.dispatch}return"function"==typeof r?r.apply(this,[n].concat(e)):n.apply(this.$store,[r].concat(e))}}),n}),S=function(t){return{mapState:k.bind(null,t),mapGetters:$.bind(null,t),mapMutations:A.bind(null,t),mapActions:M.bind(null,t)}};function C(t){return N(t)?Array.isArray(t)?t.map(function(t){return{key:t,val:t}}):Object.keys(t).map(function(e){return{key:e,val:t[e]}}):[]}function N(t){return Array.isArray(t)||c(t)}function G(t){return function(e,n){return"string"!=typeof e?(n=e,e=""):"/"!==e.charAt(e.length-1)&&(e+="/"),t(e,n)}}function V(t,e,n){var r=t._modulesNamespaceMap[n];return l&&!r&&console.error("[vuex] module namespace not found in "+e+"(): "+n),r}function P(t){var e=void 0===t?{}:t,n=e.collapsed,r=void 0===n||n,o=e.filter,i=void 0===o?function(t,e,n){return!0}:o,s=e.transformer,c=void 0===s?function(t){return t}:s,u=e.mutationTransformer,l=void 0===u?function(t){return t}:u,f=e.actionFilter,h=void 0===f?function(t,e){return!0}:f,p=e.actionTransformer,d=void 0===p?function(t){return t}:p,m=e.logMutations,v=void 0===m||m,g=e.logActions,y=void 0===g||g,b=e.logger,_=void 0===b?console:b;return function(t){var e=a(t.state);void 0!==_&&(v&&t.subscribe(function(t,n){var o=a(n);if(i(t,e,o)){var s=J(),u=l(t);L(_,"mutation "+t.type+s,r),_.log("%c prev state","color: #9E9E9E; font-weight: bold",c(e)),_.log("%c mutation","color: #03A9F4; font-weight: bold",u),_.log("%c next state","color: #4CAF50; font-weight: bold",c(o)),H(_)}e=o}),y&&t.subscribeAction(function(t,e){if(h(t,e)){var n=J(),o=d(t);L(_,"action "+t.type+n,r),_.log("%c action","color: #03A9F4; font-weight: bold",o),H(_)}}))}}function L(t,e,n){var r=n?t.groupCollapsed:t.group;try{r.call(t,e)}catch(n){t.log(e)}}function H(t){try{t.groupEnd()}catch(e){t.log("—— log end ——")}}function J(){var t=new Date;return" @ "+T(t.getHours(),2)+":"+T(t.getMinutes(),2)+":"+T(t.getSeconds(),2)+"."+T(t.getMilliseconds(),3)}function T(t,e){return n=e-t.toString().length,new Array(n+1).join("0")+t;var n}var z={Store:y,install:E,version:"__VERSION__",mapState:k,mapMutations:A,mapGetters:$,mapActions:M,createNamespacedHelpers:S,createLogger:P};exports.Store=y,exports.createLogger=P,exports.createNamespacedHelpers=S,exports.default=z,exports.install=E,exports.mapActions=M,exports.mapGetters=$,exports.mapMutations=A,exports.mapState=k;
