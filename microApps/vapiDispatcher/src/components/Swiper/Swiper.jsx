import React from "react";
import { View, Swiper, SwiperItem } from "@tarojs/components";

class CustomSwiper extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      dataArr: this.props.dataArr
    };
  }
  render() {
    return (
      <Swiper
        className="swiper-class"
        indicatorColor="#999"
        indicatorActiveColor="#333"
        circular
        indicatorDots
        autoplay
        interval={1500}
      >
        {this.state.dataArr.map(item => (
          <SwiperItem key={item.id}>
            <View className="img-class">
              <img src={item.imgUrl} />
            </View>
          </SwiperItem>
        ))}
      </Swiper>
    );
  }
}

export default CustomSwiper;
