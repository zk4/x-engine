import xengine from '@zkty-team/x-engine-core'
const forEach = (obj, cb) => {
  Object.keys(obj).forEach(key => {
    cb(key, obj[key]);
  })
}

let Vue = null;
export function install(_Vue) {
  if (Vue !== _Vue) {
    Vue = _Vue
  }
  Vue.mixin({
    beforeCreate() {
      const options = this.$options;
      if (options.store) {
        this.$store = options.store;
      } else if (options.parent && options.parent.$store) {
        this.$store = options.parent.$store;
      }
    },
  })
}

/**
 * @explain { 安装模块 }
 *    @param { store }  整个store 
 *    @param { rootState }  当前的根状态
 *    @param { path }  为了递归来创建的
 *    @param { rootModule }  从根模块开始安装
 */

const installModule = (store, rootState, path, rootModule) => {
  if (path.length > 0) {
    // [a]
    // 是儿子,儿子要找到爸爸将自己的状态 放到上面去
    let parent = path.slice(0, -1).reduce((root, current) => {
      return root[current]
    }, rootState)
    // vue 不能在对象上增加不存在的属性 否则不会导致视图更新
    Vue.set(parent, path[path.length - 1], rootModule.state);
    // {age:1,a:{a:1}}
    // 实现了 查找挂在数据格式
  }
  // 以下代码都是在处理  模块中 getters actions mutation
  let getters = rootModule._rawModule.getters;
  if (getters) {
    forEach(getters, (getterName, fn) => {
      Object.defineProperty(store.getters, getterName, {
        get() {
          return fn(rootModule.state); // 让对应的函数执行
        }
      });
    })
  }
  let mutations = rootModule._rawModule.mutations;
  if (mutations) {
    forEach(mutations, (mutationName, fn) => {
      let mutations = store.mutations[mutationName] || [];
      mutations.push((payload) => {
        fn(rootModule.state, payload);
        // 发布 让所有的订阅依次执行
        store._subscribes.forEach(fn => fn({ type: mutationName, payload }, rootState));
      })
      store.mutations[mutationName] = mutations;
    })
  }
  let actions = rootModule._rawModule.actions;
  if (actions) {
    forEach(actions, (actionName, fn) => {
      let actions = store.actions[actionName] || [];
      actions.push((payload) => {
        fn(store, payload);
      })
      store.actions[actionName] = actions;
    })
  }
  // 挂载儿子
  forEach(rootModule._chidlren, (moduleName, module) => {
    installModule(store, rootState, path.concat(moduleName), module)
  })
}


class ModuleCollection { // 格式化
  constructor(options) {
    // 注册模块 将模块注册成树结构
    this.register([], options);
  }
  register(path, rootModule) {
    let module = { // 将模块格式化
      _rawModule: rootModule,
      _chidlren: {},
      state: rootModule.state
    }
    if (path.length == 0) {
      // 如果是根模块 将这个模块挂在到根实例上
      this.root = module;
    } else {
      // 递归都用reduce方法
      // 通过 _children 属性进行查找
      let parent = path.slice(0, -1).reduce((root, current) => {
        return root._chidlren[current]
      }, this.root)
      parent._chidlren[path[path.length - 1]] = module
    }
    // 看当前模块是否有modules , 如果有modules 开始重新再次注册
    if (rootModule.modules) {
      forEach(rootModule.modules, (moduleName, module) => {
        this.register(path.concat(moduleName), module)
      })
    }
  }
}


export class Store {
  constructor(options = {}) {
    let native_state = xengine.api('com.zkty.jsi.vuex','get','store');
    //  第一次初始化? 以 options.state 为准
    if(!native_state)
    {
      if(options.state)
      {
        xengine.api('com.zkty.jsi.vuex','set',{key:'store',val:JSON.stringify(options.state)});
      }
    }else{
      options.state = JSON.parse(native_state)
    }

    this.vm = new Vue({
      data(){
        return {
          state: options.state
        }
      }
    })
    
    this.getters = {};
    this.mutations = {};
    this.actions = {};
    this._subscribes = [];
    // 把数据格式化成一个 想要的树结构
    this._modules = new ModuleCollection(options);

    /**
     * @explain { 安装模块 }
     *    @param { this }  整个store 
     *    @param { this.state }  当前的根状态
     *    @param { [] }  为了递归来创建的
     *    @param { this._modules.root }  从根模块开始安装
     */
    installModule(this, this.state, [], this._modules.root);

    // 处理 插件
    (options.plugins || []).forEach(plugin => plugin(this));

    this._subscribes.push((mutation, state) => {
        // todo:  这个地方速度太慢了,每次都 set.
        // 应该在页面切到下一页的生命周期一次性将 state 刷到 native.
        xengine.api('com.zkty.jsi.vuex','set',{key:'store',val:JSON.stringify(state)});
    });
    xengine.broadcastOn((type,payload)=>{
      if(type === '@@VUEX_STORE_EVENT'){
        // bug, 只更新了界面绑定的 state. 但实际 state 并没更新 needfix
        this.vm.state=JSON.parse(payload)
      }
    });
  }

  subscribe(fn){
    this._subscribes.push(fn);
  }

  commit = (type, payload) => {
    this.mutations[type].forEach(cb => cb(payload))
  }

  dispatch = (type, payload) => {
    this.actions[type].forEach(cb => cb(payload))
  }

  get state() {
    return this.vm.state
  }

}

export default {
  install,
  Store,
}
