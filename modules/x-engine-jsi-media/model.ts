// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.jsi.media";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};

// 预览图片
@sync
function previewImg(arg: {
  // 索引
  index: int;
  // 图片数组
  imgList: Array;
}) {
  xengine.api("com.zkty.jsi.media", "previewImg", {
    // 索引
    index: 0,
    // 图片数组
    imgList: [
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F-Po3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F4034970a304e251fae75ad03a786c9177e3e534e.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631950978&t=f96881f8b3efe3f4bffe9877ab942199",
      "https://upload-images.jianshu.io/upload_images/5809200-7fe8c323e533f656.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
      "https://upload-images.jianshu.io/upload_images/5809200-736bc3917fe92142.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
      "https://upload-images.jianshu.io/upload_images/5809200-a99419bb94924e6d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
    ],
  });
}

// 调用相机
@async
function openImagePicker(arg: {
  //是否允许编辑
  allowsEditing?: boolean;
  //是否保存图片到相册
  savePhotosAlbum?: boolean;
  //闪光灯模式(-1:关闭状态,0:自动开关状态,1:打开状态),默认:-1
  cameraFlashMode?: int;
  //设置前置或后置摄像头(front:前置,back:后置),默认:back
  cameraDevice?: string;
  //图片是否转为Base64,默认:true
  isbase64: boolean;
  //裁剪参数 width:裁剪宽度; height:裁剪高度; quality:压缩质量; bytes:压缩到多少kb以内;
  args?: Map<string, string>;
  // 图片选择张数
  photoCount?: int;
}): string {
  xengine.api(
    "com.zkty.jsi.media",
    "openImagePicker",
    {
      allowsEditing: true,
      savePhotosAlbum: false,
      cameraFlashMode: -1,
      cameraDevice: "back",
      photoCount: 5,
      args: { bytes: "100" },
      isbase64: true,
    },
    (res) => {
      let obj = JSON.parse(res);
      for (let photo of obj.data) {
        let base64 = "data:" + photo.type + ";base64,  " + photo.thumbnail;
        console.log(base64);
      }
    }
  );
}

// 保存到相册
@async
function saveImageToPhotoAlbum(arg: {
  //url或base64
  type: string;
  // 图片数据
  imageData: string;
}): string {
  // demo code
  xengine.api(
    "com.zkty.jsi.media",
    "saveImageToPhotoAlbum",
    {
      type: "url",
      imageData:
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201410%2F20%2F20141020162058_UrMNe.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1611307946&t=175b540644bac34ec738e48ff42f8034",
    },
    (res) => {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    }
  );
}


/*
{
  // 状态 0 上传成功
  //     -1 上传失败
  status: 0,
  // 上传的图片id
  id: 1，
  // 上传成功结果
  result:Map<string,string>
}
*/

// 上传图片
@async
function uploadImage(arg: {
  // 请求的url
  url: string;
  // 拍照或者选择相册后返回id
  ids: Array;
}): string {
  // demo code
  xengine.api(
    "com.zkty.jsi.media",
    "uploadImage",
    {
      url:"https://api-uat.lohashow.com/gm-nxcloud-resource/api/nxcloud/res/upload",
      "ids":['xxxx','xxxxx','xxxx', 'xxxx']
    },
    (res) => {
      console.log(JSON.stringify(res));
    }
  );
}

function test_placeholder() {}
function test_placeholder() {}
function test_placeholder() {}
// 打开picker选择相机和相册
function test_openImagePicker() {
  xengine.api(
    "com.zkty.jsi.media",
    "openImagePicker",
    {
      allowsEditing: true,
      savePhotosAlbum: false,
      cameraFlashMode: -1,
      cameraDevice: "back",
      photoCount: 5,
      args: { bytes: "100" },
      isbase64: true,
    },
    (res) => {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
      let obj = JSON.parse(res);
      for (let photo of obj.data) {
        const image = document.createElement("img");
        if (!photo.width || !photo.height) {
          alert("要返回width,与height", photo);
        }
        // image.src = "data:" + photo.contentType + ";base64,  " + photo.retImage;
        image.src = "data:" + photo.type + ";base64,  " + photo.thumbnail;
        image.style.cssText =
          "width:100px; height:100px; margin-right:10px; border-radius:10px;";
        document.body.appendChild(image);
      }
    }
  );
}

// 保存图片至相册
function test_saveImageToPhotoAlbum() {
  xengine.api(
    "com.zkty.jsi.media",
    "saveImageToPhotoAlbum",
    {
      type: "url",
      imageData:
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201410%2F20%2F20141020162058_UrMNe.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1611307946&t=175b540644bac34ec738e48ff42f8034",
    },
    (res) => {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    }
  );
}

// 预览图片
function test_previewImg(arg: {
  // 索引
  index: int;
  // 图片数组
  imgList: Array;
}) {
  xengine.api("com.zkty.jsi.media", "previewImg", {
    // 索引
    index: 0,
    // 图片数组
    imgList: [
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F-Po3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F4034970a304e251fae75ad03a786c9177e3e534e.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631950978&t=f96881f8b3efe3f4bffe9877ab942199",
      "https://upload-images.jianshu.io/upload_images/5809200-7fe8c323e533f656.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
      "https://upload-images.jianshu.io/upload_images/5809200-736bc3917fe92142.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
      "https://upload-images.jianshu.io/upload_images/5809200-a99419bb94924e6d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
    ],
  });
}

// 上传图片
@async
function test_uploadImage(arg: {
  // 请求的url
  url: string;
  // 拍照或者选择相册后返回id
  ids: Array;
}): string {
  // demo code
  xengine.api(
    "com.zkty.jsi.media",
    "uploadImage",
    {
      url:"https://api-uat.lohashow.com/gm-nxcloud-resource/api/nxcloud/res/upload",
      "ids":['xxxx','xxxxx','xxxx', 'xxxx']
    },
    (res) => {
      console.log(JSON.stringify(res));
    }
  );
}
