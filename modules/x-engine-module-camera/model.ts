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
  //返回获取图片的地址
  __event__: (string)=>void;
  
}
interface CameraRetDTO {
  retImage: string;
}

function openImagePicker(
  cameraDTO: CameraDTO = {
    allowsEditing: true,
    savePhotosAlbum: false,
    cameraFlashMode: -1,
    cameraDevice:'back',
    isbase64:true,
    args:{width:'200',height:'100',quality:'0.5',bytes:'1024'},
    __event__:(string)=>{}
  }
):CameraRetDTO {
  window.openImagePicker = () => {
    camera
      .openImagePicker({
        __event__: (res) => {
          //如果获取链接，可以拼接参数，例：'?w=200&h=100&q=0.5&bytes=1024'

          var tag = document.getElementsByClassName('photo')[0];
          if(tag){
            // tag.setAttribute('src', res+'?w=200&h=100&q=0.5&bytes=1024');
            tag.setAttribute('src', res);
          }else{
            // document.body.innerHTML += "<img class='photo' style='width: 100%' "+"src="+res+'?w=200&h=100&q=0.5&bytes=1024'+">";
            document.body.innerHTML += "<img class='photo' style='width: 100%' "+"src="+"'"+res+"'"+">";
          }
        },
      })
      .then((res) => {
        // document.getElementById("debug_text").innerText = res;
      });
  };
}


