// 命名空间
const moduleID = "com.zkty.module.localstorage";

// dto set
interface StorageSetDTO {
  //存储设置key值
  key: string;
  //存储设置value值
  value: string;
  //是否数据共享
  isPublic: boolean;
}

// dto get
interface StorageGetDTO {
  //要获取的存储值的key值
  key: string;
  //要获取的存储值是否是共享数据
  isPublic: boolean;
}

// dto remove
interface StorageRemoveDTO {
  //要删除的存储值的key值
  key: string;
  //要删除的存储值是否是共享数据
  isPublic: boolean;
}

interface StorageRemoveAllDTO {
  isPublic: boolean;
}

interface StorageStatusDTO {
  //存储状态返回值
  result: string;
}

function set(
  storageSetDTO: StorageSetDTO = {
    key: "key",
    value: "value",
    isPublic: false,
  }
): StorageStatusDTO {
  window.set = () => {
    localstorage
      .set({
        key: "key",
        value: "value",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

function get(
  storageGetDTO: StorageGetDTO = {
    key: "key",
    isPublic: false,
  }
): StorageStatusDTO {
  window.get = () => {
    localstorage
      .get({
        key: "key",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

function remove(
  storageRemoveDTO: StorageRemoveDTO = {
    key: "key",
    isPublic: false,
  }
): StorageStatusDTO {
  window.remove = () => {
    localstorage
      .remove({
        key: "key",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

function removeAll(
  storageRemoveAllDTO: StorageRemoveAllDTO = {
    isPublic: false,
  }
): StorageStatusDTO {
  window.removeAll = () => {
    localstorage
      .removeAll({
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

function _testRemoveAllPublic(
  storageRemoveAllDTO: StorageRemoveAllDTO = {
    isPublic: true,
  }
): StorageStatusDTO {
  window._testRemoveAllPublic = () => {
    localstorage
      .removeAll({
        isPublic: true,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

function _testSetPublicStorage(storageSetDTO: StorageSetDTO): StorageStatusDTO {
  window._testSetPublicStorage = () => {
    localstorage
      .set({
        key: "key",
        value: "public value",
        isPublic: true,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

function _testGetPublicStorage(storageGetDTO: StorageGetDTO): StorageStatusDTO {
  window._testGetPublicStorage = () => {
    localstorage
      .get({
        key: "LLBOrigin",
        isPublic: true,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

function _testSetLocalStorage(storageSetDTO: StorageSetDTO): StorageStatusDTO {
  window._testSetLocalStorage = () => {
    localstorage
      .set({
        key: "key",
        value: "local value",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

function _testGetLocalStorage(storageGetDTO: StorageGetDTO): StorageStatusDTO {
  window._testGetLocalStorage = () => {
    localstorage
      .get({
        key: "key",
        isPublic: false,
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
