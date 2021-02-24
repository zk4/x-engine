// model.ts 解析版本
const parserVersion = "1.0.0";

// 命名空间
const moduleID = "com.zkty.module.secrect";
// JS模块名称
const JSModule = "@zkty-team/x-engine-module-secrect";

const conf = {
  args: {},
  permissions: {
    X_USER_INFO: "READ",
    X_LBS: "READ_WRITE",
    X_PHOTO: "READ",
  },
};


// dto get
interface SecretGetDTO {
  //要获取的存储值的key值
  key: string;
 
}

interface SecretDTO {
  //返回值
  result: string;
}


function get(
  secretGetDTO: SecretGetDTO 
): SecretDTO {
  window.get = () => {
    secrect
      .get({
        key: "key"
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

}
