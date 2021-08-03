

  如果h5 是以formdata格式传输
  例如:

  ```javascript
  const data = new FormData()
  data.append('a', File) // 某个文件(.jpeg)
  data.append('b', 'a')
  data.append('c', JSON.stringify{d: 1})
  data.append('f', 1)

  ajax(data)

  function ajax(data) {
    var xhr = new XMLHttpRequest();
    xhr.open('post', './a.json')
    xhr.setRequestHeader('Content-Type', 'multipart/form-data')
    xhr.send(data)
    xhr.onreadystatechange = () => {
      if(xhr.DONE) {
        console.log(xhr.responseText)
      }
    }
  }
  ```

  以上面的ajax为例那么 h5会传递给native一个json对象 形如:
  ```json
  {
    "data": {
      "a": {  
        "type": "image/jpeg",
        "name": "a.jpeg",
        "content": "/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAoHBwgHBgoICAg..." //一个base64字符串
      },
      "b": "a",
      "c": "{\"d\":1}",
      "f": "1"
    },
    "header": {
      "Content-Type": "multipart/form-data"
    },
    "method": "POST",
    "url": "/a.json"
  }
  ```
  
  如果是常规的json传输,native可能得到这样一组数据:
  ```json
    {
      "data": "{a:1}" ,// (| null)
      "header": {
        "Accept": "application/json, text/plain, */*",
        "Content-Type": "application/json;charset=UTF-8"
      },
      "method": "POST",
      "url": "/a.json"
    }
  ```





## 参考

[**网易云音乐大前端团队** WKWebView 请求拦截探索与实践](https://juejin.cn/post/6922625242796032007 )

[WKURLSchemeHandler 的能与不能](https://www.jianshu.com/p/6bae04c91297)

https://juejin.cn/post/6861778055178747911

https://juejin.cn/post/6844904153810993165#heading-34

https://github.com/lilidan/SSWKURL

