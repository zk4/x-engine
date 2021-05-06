# 前端 Service 细节技术手册

## 网络优化

### 合并请求

示例代码

``` html

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>JS Axios Demo</title>
  </head>
  <body>
    hello
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script>
      // 用来缓存Promise对象的数组 { key: url+param, value: promise }
      let promiseList = [];

      // 每隔5分钟清空一下promise列表，防止内存溢出
      setInterval(() => {
        promiseList = [];
      }, 300000);

      // 检查
      function checkPromise(url, param) {
        let key = url + JSON.stringify(param);
        // 看看有没有相同 Promise
        let res = promiseList.filter((item) => item.key === key);
        // 如果有相同的进行中的promise，直接返回
        if (res.length > 0) {
          console.log("存在并发请求");
          return res[0].value;
          // 如果没有相同的则需要存入当前的Promise并返回
        } else {
          return false;
        }
      }

      // 使用的时候多传一个参数merge 表示是否使用并发合并的功能
      function zGet(url, param, merge = true) {
        // 检查是否命中缓存中的promise如果有返回命中，不再发出请求
        let cachePromise = checkPromise(url, param);
        if (merge && cachePromise) {
          return cachePromise;
        }

        let promise = axios.get(url, { params: param });
        promiseList.push({
          key: url + JSON.stringify(param),
          value: promise,
        });
        return promise;
      }

      let url = "http://localhost:5000/data.json";
      zGet(url).then((res) => {
        console.log(res);
      });
      zGet(url).then((res) => {
        console.log(res);
      });
      setTimeout(() => {
        zGet(url).then((res) => {
          console.log(res);
        });
      }, 1000);
    </script>
  </body>
</html>



```



## 数据结构

### Entity/Model

实体业务模型, 通常带业务唯一 id. 如订单,商品等.

### 匿名结构

常用在返回筛选数据,字典.

## Mock

## 注解

https://juejin.cn/post/6844904167262126093

