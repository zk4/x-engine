### 环境准备

````
```
mac一台
iPhone手机一部
```
复制代码
````

### 步骤

#### iPhone设置

- 打开设置-->Safari浏览器-->高级-->开启JavaScript和web检查器

  ![img](https://resource.shangmayuan.com/droxy-blog/2019/11/08/f6ca6f9310d843dea4622f583b2cf234-1.jpg)

iphone端的操做所有操做完成ios

#### Chrome 浏览器

没有安装HomeBrew的小伙伴，先安装HomeBrew，不了解HomeBrew的同窗能够在 [这里](https://www.caniuse.com/) 查看web

- 安装完成后,依次执行下面代码

```
brew unlink libimobiledevice ios-webkit-debug-proxy usbmuxd
brew uninstall --force libimobiledevice ios-webkit-debug-proxy usbmuxd
brew install --HEAD usbmuxd
brew install --HEAD libimobiledevice
brew install --HEAD ios-webkit-debug-proxy
复制代码
```

- 安装最新版本的adapter,

```
npm install remotedebug-ios-webkit-adapter -g
复制代码
```

到这一步，mac端的操做就已经完成了，而后再看iphone的设置chrome

mac上打开终端，执行命令，开启adapter，设置监听端口为9000npm

```
remotedebug_ios_webkit_adapter --port=9000
复制代码
```

Chrome中打开chrome://inspect/#devices，在configure中添加localhost:9000,能够看到设备出如今列表中。iphone的Safari中的页面，就能够在这里看到，点击inspect，就能够和PC端同样，进行调试啦 浏览器

![img](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/5f3d6b0aaad74604a9f376e7601a2d9c-1.jpg)



#### Safari浏览器

Safari浏览器中相对就比较简单啦，iphone端的操做彻底同样，打开Safari浏览器，选中系统偏好设置-->高级,勾选在菜单中打开“开发”菜单 bash

![img](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/587a11350b6a4b39a19af8a2faae3867-1.jpg)

链接手机，打开Safari浏览器，选择开发，选中设备，可看到移动端Safari浏览器中打开的网址，点击，就能打开Safari浏览器的开发者工具了。如图所示：

![img](https://zk4bucket.oss-cn-beijing.aliyuncs.com/img/75524221bfd64b938693dad73c1ddd25-1.jpg)



 