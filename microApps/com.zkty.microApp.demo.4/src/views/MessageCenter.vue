<template>
  <div class="message-class">
    <van-list>
      <div class="list-class" v-for="item in list" :key="item.id" @click="clickItem">
        <span class="title-class">{{ item.title }}</span>
        <span class="radio-class"></span>
        <span class="content-class">尊敬的小区全体业主,根据相关法律法规的要求</span>
        <van-icon class="arrow-class" name="arrow" size="14px"/>
        <span class="time-class">{{ item.time }}</span>
        <span class="type-class">{{ item.type }}</span>
      </div>
    </van-list>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
export default {
  name: "MessageCenter",
  data() {
    return {
      list: [
        {
          id: 0,
          title: "召开业主大会1",
          time: "2020-08-08 20:01",
          type: "社区公告"
        },
        {
          id: 1,
          title: "召开业主大会2",
          time: "2020-09-10",
          type: "政府公告"
        },
        {
          id: 2,
          title: "召开业主大会3",
          time: "2020-06-31",
          type: "社区公告"
        }
      ]
    };
  },
  mounted() {
    nav.setNavTitle({
      title: "消息中心",
      titleColor: "#000000",
      titleSize: 18
    });
  },
  methods: {
    clickItem() {
      nav.navigatorPush({
        url: "/GonggaoDesc",
      });
    }
  },
};
</script>


<style lang="less" scoped>
.list-class {
  border-radius: 5px;
  background-color: #f7f7f7;
  position: relative;
  margin: 15px;
  border: 1px solid #eee;
  display: flex;
  flex-direction: column;
  height: 90px;
  font-size: 12px;
  .title-class {
    position: absolute;
    top: 10px;
    left: 10px;
    font-size: 15px;
  }
  .radio-class {
    top: 15px;
    right: 20px;
    width: 6px;
    height: 6px;
    border-radius: 10px;
    position: absolute;
    background-color: red; 
  }
  .content-class{
    position:absolute;
    top: 40px;
    left: 10px;
  }
  .arrow-class{
    position:absolute;
    top: 40px;
    right: 15px;
  }
  .time-class {
    position: absolute;
    bottom: 5px;
    left: 10px;
  }
  .type-class {
    color: blue;
    position: absolute;
    bottom: 5px;
    right: 10px;
  }
}
</style>
