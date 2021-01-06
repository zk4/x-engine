// 命名空间
const moduleID = "com.zkty.module.camera";

// dto
interface CameraDTO {
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
  args:Map<string,string>;
  // 图片选择张数
  photoCount?: int;
  //返回获取图片的地址
  __event__: (string)=>void;
  
}
interface CameraRetDTO {
  retImage: string;
  fileName:string;
  contentType:string;
  width: string;
  height: string;
}

interface SaveImageDTO {
  //url或base64
  type:string;
  imageData: string;
}

/*
  返回数据有做调整, 0.58 后在反序列字符串后会得到一个对象,对象里的 data 有一个数组.里面保存了图片的的json对象序列.
  ``` json
  data:{
    [
      retImage: string;
      fileName:string;
      contentType:string;
      width: string;
      height: string;
    ]
  }
  ```
  见 demo
*/
function openImagePicker(
  cameraDTO: CameraDTO = {
    allowsEditing: true,
    savePhotosAlbum: false,
    cameraFlashMode: -1,
    cameraDevice:'back',
    photoCount: 1,
    __event__:(string)=>{}
  }
):CameraRetDTO {
  window.openImagePicker = () => {
    camera
      .openImagePicker({
        allowsEditing: true,
        savePhotosAlbum: false,
        cameraFlashMode: -1,
        cameraDevice:'back',
        photoCount: 5,
        isbase64:true,
        args:{width:'200',quality:'0.5'},
        __event__: (res) => {
            let jres = JSON.parse(res);
            for(let photo of jres.data){
            const image         = document.createElement('img')

            if(!photo.width || !photo.height){
              alert('要返回width,与height',photo);
            }

            image.src           = "data:image/png;base64,  " + photo.retImage;
            image.style.cssText = 'width:100%';
            document.body.appendChild(image);
            }

        }
      })
  };
}

//保存到相册
function saveImageToAlbum(
  args: SaveImageDTO={
    type:'url',
    
  }){
  window.saveImageToAlbum = () => {
    camera
      .saveImageToAlbum({
        imageData:'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201410%2F20%2F20141020162058_UrMNe.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1611307946&t=175b540644bac34ec738e48ff42f8034'
      });
  };
}
