import { Component } from "react";
import { View } from "@tarojs/components";
import "./home.css";
import { doAction } from "../utils/vapi/vapiDispatcher";
import CustomSwiper from "../../components/Swiper/Swiper";
import CustomJingang from "../../components/Jingang/Jingang";

export default class Index extends Component {
  constructor() {
    super();
    this.state = {
      dataArr: [
        {
          id: 0,
          imgUrl:
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F010cdc595c811ea8012193a319c903.png%401280w_1l_2o_100sh.png&refer=http%3A%2F%2Fimg.zcool.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639815562&t=96912761e6ff2a2ce2fae31f12686f7f"
        },
        {
          id: 1,
          imgUrl:
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01d56b5542d8bc0000019ae98da289.jpg%401280w_1l_2o_100sh.png&refer=http%3A%2F%2Fimg.zcool.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639815563&t=049e794fa4b8a1972853b37524b5642d"
        },
        {
          id: 2,
          imgUrl:
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F014f2857fae155a84a0e282bc0e56f.jpg&refer=http%3A%2F%2Fimg.zcool.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639815562&t=cbbd889670ab6fdd2f2354097707c22d"
        },
        {
          id: 3,
          imgUrl:
            "https://img1.baidu.com/it/u=3383950214,1699480412&fm=26&fmt=auto"
        }
      ]
    };
  }

  pushPage() {
    doAction("navigateToOrderPage?id=2&name=test");
  }

  render() {
    const { dataArr } = this.state;
    return (
      <View className="home-container">
        <CustomSwiper dataArr={dataArr} />
        <CustomJingang />
      </View>
    );
  }
}

{
  /* <Button onClick={() => this.pushPage()}>jump</Button> */
}
