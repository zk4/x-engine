
import nav from './index.js'

  window.setNavTitle = () => {
    nav.setNavTitle().then((res) => {});
  };

  window.setNavLeftBtn = () => {
    nav.setNavLeftBtn().then((res) => {});
  };

  window.setNavRightBtn = () => {
    nav
      .setNavRightBtn({
        title: "right",
        titleColor: "#000000",
        titleSize: 16,
        icon: "",
        iconSize: ["20", "20"],
        __event__: () => {
          document.getElementById("debug_text").innerText = "ret: click right";
        },
      })
      .then((res) => {});
  };

  window.setNavRightMenuBtn = () => {
    nav
      .setNavRightMenuBtn({
        title: "menu",
        titleColor: "#000000",
        titleSize: 16,
        icon: "",
        iconSize: ["20", "20"],
        popWidth: "200",
        showMenuImg: "false",
        popList: [
          { icon: "", iconSize: "20", title: "1" },
          { icon: "", iconSize: "20", title: "2" },
          { icon: "", iconSize: "20", title: "3" },
        ],
        __event__: (r) => {
          document.getElementById("debug_text").innerText =
            "ret: click setNavRightMenuBtn: " + r;
        },
      })
      .then((res) => {});
  };

  window.setNavRightMoreBtn = () => {
    nav.setNavRightMoreBtn().then((res) => {});
  };

  window.navigatorPush = () => {
    nav.navigatorPush().then((res) => {});
  };

  window.navigatorBack = () => {
    nav.navigatorBack().then((res) => {});
  };

  window.navigatorRouter = () => {
    nav.navigatorRouter().then((res) => {});
  };

  window.setNavSearchBar = () => {
    nav
      .setNavSearchBar({
        cornerRadius: 5,
        backgroundColor: "#FF0000",
        iconSearch: "",
        iconSearchSize: [20, 20],
        iconClear: "",
        iconClearSize: [20, 20],
        textColor: "#000000",
        fontSize: 16,
        placeHolder: "默认文字",
        placeHolderFontSize: 16,
        isInput: true,
        becomeFirstResponder: false,
        __event__: () => {
          document.getElementById("debug_text").innerText =
            "ret: click searchBar";
        },
      })
      .then((res) => {});
  };

  window.setSearchBarHidden = () => {
    nav
      .setHidden({
        isHidden: true,
        isAnimation: true,
      })
      .then((res) => {});
  };

  window.setNavBarHidden = () => {
    nav
      .setHidden({
        isHidden: true,
        isAnimation: true,
      })
      .then((res) => {});
  };

  window.testSetHidden = () => {
    nav
      .setHidden({
        isHidden: false,
        isAnimation: false,
      })
      .then((res) => {});
  };

    