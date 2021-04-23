

**基座扫描测试**
<div id='modulename' style='display:none'>localstorage</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>



# JS


JSI Id: com.zkty.jsi.localstorage

version: 0.1.13



## set
`sync`

**demo**
``` js

    let val = xengine.api("com.zkty.jsi.localstorage", "set",{
    key:'your_key',
    val:'your_val'
  });


``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| key | string | 必填 |  |  |
| val | string | 必填 |  |  |
**无返回值**



## get
`sync`

**demo**
``` js

  let val = xengine.api("com.zkty.jsi.localstorage", "get",
    'your_key',
  );
  console.log(val); // your_val


``` 

**无参数**

**返回值**
``` js
string
``` 


    

# iOS


# android


