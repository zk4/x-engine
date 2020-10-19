// 命名空间
const moduleID = "com.zkty.module.tools";

// dto
interface XEZipDTO {
  //文件路径
  filePath: string;
  //压缩到 路径
  toZipPath?: string;
  //解压缩进度
  __event__?: string;
}

interface XEUnZipDTO {
  //文件路径
  filePath: string;
  //解压到 路径
  unZipPath?: string;
  //压缩进度
  __event__?: string;
}

interface XEInsertDTO {

  appid: string;
  version: string;
  filePath: string;
}

function unZipFile(args: XEUnZipDTO = { filePath: "", unZipPath: "" }): string {
  
  window.unZipFile = () => {
    tools
      .unZipFile()
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:" + res;
      });
  };
}


function zipFile(args: XEZipDTO = { filePath: "", toZipPath: "" }): string {
  window.zipFile = () => {
    tools
      .zipFile()
      .then((res) => {
        document.getElementById("debug_text").innerText = "ret:" + res;
      });
  };
}
