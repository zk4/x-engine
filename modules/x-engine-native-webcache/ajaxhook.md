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
    "url": "./a.json"
  }
  ```
  
  如果是常规的json传输,native可能得到这样一组数据:
  ```json
    {
      "data": "{\"a\":1}",
      "header": {
        "Accept": "application/json, text/plain, */*",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      "method": "POST",
      "url": "a.json"
    }
  ```


