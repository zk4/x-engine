import Taro from '@tarojs/taro'
export default function setTitle(title) {
    Taro.setNavigationBarTitle({
        title
    })
}