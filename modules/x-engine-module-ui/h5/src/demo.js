
import ui from './index.js'

  window.showToast = () => {
    ui
      .showToast()
      .then((res) => {
      });
  };

  window.hideToast = () => {
    ui
      .hideToast()
      .then((res) => {
      });
  };

  window.hiddenHudToast = () => {
    ui
      .hiddenHudToast()
      .then((res) => {
      });
  };

  window.showLoading = () => {
    ui
      .showLoading()
      .then((res) => {
      });
  };

  window.hideLoading = () => {
    ui
      .hideLoading()
      .then((res) => {
      });
  };

  window.showModal = () => {
    ui
      .showModal()
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

  window.showActionSheet = (...args) => {
    ui
      .showActionSheet({
        title: "hello",
        itemList: ["hello", "world", "he"],
        content: "content",
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

  window.showPickerView = (...args) => {
    ui
      .showPickerView({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {

        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };

    