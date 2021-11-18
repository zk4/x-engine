### 环境搭建
- 详细 请参考官网
> React Native 官网: https://reactnative.dev/
>
> React Native 中文网: https://reactnative.cn/

---


## 配置ReactNative项目

### 准备ReactNative 

- 项目创建后在根目录会有package.json文件

    ```javascript
    1. 执行`yarn` 或 `npm install` 来安装相关依赖
    2. 执行`yarn start`启动服务
    3. 项目启动后可以通过生成的地址来看到生成的js文件(该地址作为链接的地址)
    	3.1 - 如`http://localhost:8081/index.bundle?platform=ios`
    4. 注意: ReactNative的入口moduleName为`App`
    ```


### 准备Taro/ReactNative
- 项目创建后在根目录会有package.json文件

    ```javascript
    1. 执行`yarn` 或 `npm install`来安装相关依赖
    2. 执行`yarn dev:rn`启动服务
    3. 项目启动后可以通过你本机的ip地址拼接上项目的入口文件路径来作为原生的链接地址
    	3.1 - 如`http://192.168.0.1:10086/#/pages/index/index`
    4. 注意: Taro/ReactNative的入口moduleName为`taroDemo`
    ```
---



## iOS:

### 配置iOS项目

- 将前端项目的`package.json` copy到项目根目录的的上一层后 执行`yarn`或`npm install`

- 执行完后进入项目根目录 创建`Podfile`文件 将以下内容写入Podfile文件中

- 为了给React Native项目带来更好的原生体验, x-engine制作了相关的React Native模块来负责路由以及模块的调用

    ```javascript
    require_relative '../node_modules/react-native/scripts/react_native_pods.rb'
    require_relative '../node_modules/@react-native-community/cli-platform-ios/native_modules'
    
    platform :ios, '11.0'
    
    source 'https://github.com/CocoaPods/Specs.git'
    
    def shared_pods
      config = use_native_modules!
      use_react_native!(
        :path => config[:reactNativePath],
        # to enable hermes on iOS, change `false` to `true` and then install pods
        :hermes_enabled => false
      )
      inherit! :complete
      use_flipper!()
      
      pod 'x-engine-native-react_native', :path =>'你电脑上的包路径/x-engine-native-react_native'
      pod 'x-engine-native-direct_orn', :path =>'你电脑上的包路径/x-engine-native-direct_orn'
      pod 'x-engine-native-direct_orns', :path =>'你电脑上的包路径/x-engine-native-direct_orns'
      pod 'x-engine-native-direct_lrn', :path =>'你电脑上的包路径/x-engine-native-direct_lrn'
      pod 'x-engine-rn-direct', :path =>'你电脑上的包路径/x-engine-rn-direct'
    end
    
    target 'ModuleApp' do
      shared_pods
    end
    ```
    
- 执行
  
  ```ruby
  pod install
  ```
  
- 此时iOS和前端项目所引用的依赖会相同

  

### 启动  

为了方便ReactNative的调用,我们针对不同环境制作了入口的调用.

> orn    ==>  http的rn地址
> 
> orns  ==>  https的rn地址
> 
> lrn     ==>  localhost 的 bundle




```javascript
// ReactNative
[XENP(iDirectManager) push:@"orn://localhost:8081/index.bundle?platform=ios"  params:@{@"hideNavbar":@TRUE,@"__RN__":@{@"moduleName":@"App"}} frame:[UIScreen mainScreen].bounds];
    
// Taro-ReactNartive(注意moduleName的区别 您也可以将前端项目的入口改成App)
[XENP(iDirectManager) push:@"orn://localhost:8081/index.bundle?platform=ios"  params:@{@"hideNavbar":@TRUE,@"__RN__":@{@"moduleName":@"taroDemo"}} frame:[UIScreen mainScreen].bounds];

// 打包后的bundle的加载
[XENP(iDirectManager) push:@"lrn://bundle/index.jsbundle"  params:@{@"hideNavbar":@TRUE,@"__RN__":@{@"moduleName":@"App"}} frame:[UIScreen mainScreen].bounds];
```

- 启动项目 

    ```javascript
    command + r 	
    ```




## android:

### 配置android项目

### 启动



## 使用第三方模块

- 我们拿`react-native-picker`模块来举例

- 前端 `yarn add react-native-picker`后 将模块名称和版本号同步给`native developer`

- `native developer`将模块名称和版本号写入`iOS`或`android`的`package.json`中 执行`pod install`或build 该项目

- 前端调用

    ```javascript
    import Picker from 'react-native-picker';
    
    const picker = () => {
      let data = [];
      for(var i=0;i<100;i++){
          data.push(i);
      }
    
      Picker.init({
          pickerData: data,
          selectedValue: [59],
          onPickerConfirm: data => {
              console.log(data);
              Picker.hide()
          },
          onPickerCancel: data => {
              console.log(data);
              Picker.hide()
          },
          onPickerSelect: data => {
              console.log(data);
              Picker.hide()
          }
      });
      Picker.show();
    }
    ```

    - 即可看到显示效果



## 使用x-engine模块

- 我们拿direct来举例

- ReactNative

```javascript
需在Native端提前安装`x-engine-rn-direct`模块

import { NativeModules } from "react-native";
NativeModules.RN_direct.push({
   scheme:"omp",
   host:"www.baidu.com",
   pathname:"",
   fragment:"",
   query:{},
   params:{},  
});
```

- Taro-ReactNative

```javascript
需在前端提前安装`@zkty-team/x-engine-core`模块

xengine.api("com.zkty.jsi.direct","push", {
    scheme: "omp",
    pathname: "www.baidu.com",
    fragment: "",
    query: ""
    params: {
        hideNavbar: true
    }
},
function() {}
```

