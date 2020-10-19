// 命名空间
const moduleID = "com.zkty.module.localstorage";

// dto set
interface StorageSetDTO {
  key: string;
  value: string;
  isPublic: boolean;
}

// dto get
interface StorageGetDTO {
  key: string;
  isPublic: boolean;
}

// dto remove
interface StorageRemoveDTO {
  key: string;
  isPublic: boolean;
}

interface StorageStatusDTO {
  result: string;
  isPublic: boolean;
}

// set
function setLocalStorage(
  storageSetDTO: StorageSetDTO = {
    key: "key",
    value: "value",
    isPublic: false,
  }
): StorageStatusDTO {
  window.setLocalStorage = () => {
    localstorage.setLocalStorage({
      key: "key",
      value: "value"
    })
      .then((res) => {
        document.getElementById("debug_text").innerText = res.result;
      });
  };
}

// get
function getLocalStorage(
  storageGetDTO: StorageGetDTO = {
    key: "key",
    isPublic: false,
  }
): StorageStatusDTO {
  window.getLocalStorage = () => {
    localstorage.getLocalStorage({
      key: "key",
      isPublic: false,
    })
      .then((res) => {
        document.getElementById("debug_text").innerText = res.result;
      });
  };
}

// remoteItem
function removeLocalStorageItem(
  storageRemoveDTO: StorageRemoveDTO = {
    key: "item",
    isPublic: false,
  }
): StorageStatusDTO {
  window.removeLocalStorageItem = () => {
    localstorage.removeLocalStorageItem({
      key: "item",
    })
      .then((res) => {
        document.getElementById("debug_text").innerText = res.result;
      });
  };
}

// remoteAll
function removeLocalStorageAll(
  storageRemoveDTO: StorageRemoveDTO = {
    key: "all",
    isPublic: false,
  }
): StorageStatusDTO {
  window.removeLocalStorageAll = () => {
    localstorage.removeLocalStorageAll({
      key: "all",
    }).then((res) => {
      document.getElementById("debug_text").innerText = res.result;
    });
  };
}



// set
function _testSetOtherIDLocalStorage(
  storageSetDTO: StorageSetDTO = {
    key: "key",
    value: "value",
    isPublic: false,
  }
): StorageStatusDTO {
  window._testSetOtherIDLocalStorage = () => {
    localstorage._testSetOtherIDLocalStorage({
      key: "key",
      value: "value2222",
      isPublic: false,
    })
      .then((res) => {
        document.getElementById("debug_text").innerText = res.result;
      });
  };
}

// get
function _testGetOtherIDLocalStorage(
  storageGetDTO: StorageGetDTO = {
    key: "key",
    isPublic: false,
  }
): StorageStatusDTO {
  window._testGetOtherIDLocalStorage = () => {
    localstorage._testGetOtherIDLocalStorage({
      key: "key",
      isPublic: false,
    })
      .then((res) => {
        document.getElementById("debug_text").innerText = res.result;
      });
  };
}