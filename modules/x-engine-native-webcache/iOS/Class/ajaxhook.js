 
;
(function() {
    // https://github.com/niklasvh/base64-arraybuffer/blob/master/lib/base64-arraybuffer.js
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    // Use a lookup table to find the index.
    var lookup = new Uint8Array(256);
    for (var i = 0; i < chars.length; i++) {
      lookup[chars.charCodeAt(i)] = i;
    }

    encode = function(arraybuffer) {
      var bytes = new Uint8Array(arraybuffer),
      i, len = bytes.length, base64 = "";

      for (i = 0; i < len; i+=3) {
        base64 += chars[bytes[i] >> 2];
        base64 += chars[((bytes[i] & 3) << 4) | (bytes[i + 1] >> 4)];
        base64 += chars[((bytes[i + 1] & 15) << 2) | (bytes[i + 2] >> 6)];
        base64 += chars[bytes[i + 2] & 63];
      }

      if ((len % 3) === 2) {
        base64 = base64.substring(0, base64.length - 1) + "=";
      } else if (len % 3 === 1) {
        base64 = base64.substring(0, base64.length - 2) + "==";
      }

      return base64;
    };

    let decode =  function(base64) {
      var bufferLength = base64.length * 0.75,
      len = base64.length, i, p = 0,
      encoded1, encoded2, encoded3, encoded4;

      if (base64[base64.length - 1] === "=") {
        bufferLength--;
        if (base64[base64.length - 2] === "=") {
          bufferLength--;
        }
      }

      var arraybuffer = new ArrayBuffer(bufferLength),
      bytes = new Uint8Array(arraybuffer);

      for (i = 0; i < len; i+=4) {
        encoded1 = lookup[base64.charCodeAt(i)];
        encoded2 = lookup[base64.charCodeAt(i+1)];
        encoded3 = lookup[base64.charCodeAt(i+2)];
        encoded4 = lookup[base64.charCodeAt(i+3)];

        bytes[p++] = (encoded1 << 2) | (encoded2 >> 4);
        bytes[p++] = ((encoded2 & 15) << 4) | (encoded3 >> 2);
        bytes[p++] = ((encoded3 & 3) << 6) | (encoded4 & 63);
      }
    }
 ////////////////////////////////////////////////////////////////////////////////
    window.xengine_Ajax = {
        hookedXHR: {},
        hookAjax: hookAjax,
        nativeRequest: nativeRequest,
        nativeCallback: nativeCallback
    };
    function formData2Json(formData){
        let object = {};
        formData.forEach((value, key) => {
            if(key === 'image'){
                let base64Img = encode(value.arrayBuffer());
                console.log(base64Img);
                
                value.arrayBuffer().then(data=>{
                    let base64Img = encode(data);
                    console.log(base64Img);
                    
                });
                return;
            }
            // Reflect.has in favor of: object.hasOwnProperty(key)
            if(!Reflect.has(object, key)){
                object[key] = value;
                return;
            }
            if(!Array.isArray(object[key])){
                object[key] = [object[key]];
            }
            object[key].push(value);
        });
        let json = JSON.stringify(object);
        return json;
    }

    function nativeRequest(xhrId, params) {
        if(FormData.prototype.isPrototypeOf(params.data)){
            let data = formData2Json(params.data);
            params.data = data;
        }
        //  请求 native
        params.xhrId = xhrId;
        if(window.dsBridge) {
            window.dsBridge.call("com.zkty.jsi.webcache.xhrRequest", params,function(data) {
                data = JSON.parse(data)
                console.log(data)

                var xhrId = data["xhrId"];
                var statusCode = 1*data["statusCode"];
                var responseText = data["responseText"];
                var responseHeaders = data["responseHeaders"];
                var error = data["error"];

                window.xengine_Ajax.nativeCallback(xhrId, statusCode, responseText, responseHeaders, error);
            });
        }
    }

    function nativeCallback(xhrId, statusCode, responseText, responseHeaders, error) {
        var xhr = window.xengine_Ajax.hookedXHR[xhrId];

        if(xhr.isAborted) { // 如果该请求已经手动取消了
            return;
        }

        if(error) {
            xhr.readyState = 1;
            if(xhr.onerror) {
                xhr.onerror();
            }
        } else {
            xhr.status = statusCode;
            xhr.responseText = responseText;
            xhr.readyState = 4;

            xhr.omtResponseHeaders = responseHeaders;

            if(xhr.onreadystatechange) {
                xhr.onreadystatechange();
            }
            if(xhr.onload) {
                xhr.onload();
            }
        }
    }

    // hook ajax send 方法
    window.xengine_Ajax.hookAjax({
        setRequestHeader: function (arg, xhr) {
            if(!this.omtHeaders) {
                this.omtHeaders = {};
            }
            this.omtHeaders[arg[0]] = arg[1];
        },
        getAllResponseHeaders: function (arg, xhr) {
            var headers = this.omtResponseHeaders;
            if(headers) {
                if(typeof(headers) === 'object') {
                    var result = '';
                    for(var key in headers) {
                        result = result + key + ':' + headers[key] + '\r\n'
                    }
                    return result;
                }
                return headers;
            }
        },
        getResponseHeader: function (arg, xhr) {
            if(this.omtResponseHeaders && this.omtResponseHeaders(arg[0])) {
                return this.omtResponseHeaders(arg[0]);
            }
        },
        open: function (arg, xhr) {
            this.omtOpenArg = arg;
        },
        send: function (arg, xhr) {
            this.isAborted = false;
                var params = {};
                params.data = arg[0];
                params.method = this.omtOpenArg[0];
                params.header = this.omtHeaders;

                var url = this.omtOpenArg[1];
                var location = window.location;
                if(location.protocol !== "file:" && !url.startsWith(location.protocol)) {
                    url = location.origin + url;
                }
                params.url = url;


                var xhrId = 'xhrId' + (new Date()).getTime();
                window.xengine_Ajax.hookedXHR[xhrId] = this;
                window.xengine_Ajax.nativeRequest(xhrId, params);

                // 通过 return true 可以阻止默认 Ajax 请求，不返回则会继续原来的请求
                return true;
        },
        abort: function (arg, xhr) {
                if(xhr.onabort) {
                    xhr.onabort()
                }
                return true;
        }

    });

    function hookAjax(proxy) {
        // 保存真正的XMLHttpRequest对象
        window._ahrealxhr = window._ahrealxhr || XMLHttpRequest;
        XMLHttpRequest = function() {
            var xhr = new window._ahrealxhr;
            // 直接在一个对象上定义一个新属性，或者修改一个对象的现有属性， 并返回这个对象
            Object.defineProperty(this, 'xhr', {
                value: xhr
            })
        };

        // 获取 XMLHttpRequest 对象的属性
        var prototype = window._ahrealxhr.prototype;
        for (var attr in prototype) {
            var type = "";
            try {
                type = typeof prototype[attr]
            } catch (e) {}
            if (type === "function") {
                XMLHttpRequest.prototype[attr] = hookfunc(attr);
            } else {
                // 给属性提供 getter、setter 方法
                Object.defineProperty(XMLHttpRequest.prototype, attr, {
                    get: getFactory(attr),
                    set: setFactory(attr),
                    enumerable: true
                })
            }
        }

        function getFactory(attr) {
            return function() {
                // 判断对象是否包含特定的自身（非继承）属性
                var v = this.hasOwnProperty(attr + "_") ? this[attr + "_"] : this.xhr[attr];
                var attrGetterHook = (proxy[attr] || {})["getter"];
                return attrGetterHook && attrGetterHook(v, this) || v
            }
        }

        function setFactory(attr) {
            return function(v) {
                var xhr = this.xhr;
                var that = this;
                var hook = proxy[attr];
                if (typeof hook === "function") {  // 回调属性 onreadystatechange 等
                    xhr[attr] = function() {
                        hook.call(that, xhr) || v.apply(xhr, arguments); // 修改 3
                    }
                } else {
                    //If the attribute isn't writeable, generate proxy attribute
                    var attrSetterHook = (hook || {})["setter"];
                    v = attrSetterHook && attrSetterHook(v, that) || v;

                    // 修改 1
                    xhr[attr] = v;
                    this[attr + "_"] = v;
                }
            }
        }

        function hookfunc(func) {
            return function() {
                var args = [].slice.call(arguments);
                if (proxy[func]) {
                    var result = proxy[func].call(this, args, this.xhr);
                    if(result) {
                        return result;
                    }
                }
                return this.xhr[func].apply(this.xhr, args);
            }
        }
        return window._ahrealxhr;
    }



})();
