<template>
  <div class="property_notice_detail">
    <ul style="padding:16px;">
      <li v-for="(item, index) in list" :key="index">
        <div class="beida" v-show="item.namer || item.listed">
          <div class="topb">{{ item.name }}</div>
          <div class="bottenb" v-show="item.namer">
            <table
              border=""
              cellspacing=""
              cellpadding=""
              frame="void"
              rules="none"
            >
              <tr>
                <td rowspan="2">
                  <div class="basicInfo-left">
                    <img
                      class="imangetu"
                      src="@/assets/title.png"
                      style="width: 40px; height: 40px;margin-right:9px;"
                    />
                  </div>
                </td>
                <td class="dpname">{{ item.namer }}</td>
              </tr>
              <tr>
                <td class="dpnum" v-show="item.number">
                  +86 {{ item.number }}
                </td>
              </tr>
            </table>
            <div class="arrowder" @click="tza" v-show="item.namer">
              <van-icon name="arrow" />
            </div>
            <!-- <van-cell class="arrowder" @click="tza" v-show="item.namer" is-link /> -->
          </div>
          <ul>
            <li v-for="(item, index) in item.listed" :key="index">
              <div class="bottenb">
                <table
                  border=""
                  cellspacing=""
                  cellpadding=""
                  frame="void"
                  rules="none"
                >
                  <tr>
                    <td rowspan="2"></td>
                    <td class="dpname">{{ item.namer }}</td>
                  </tr>
                  <tr>
                    <td class="dpnum">+86 {{ item.number }}</td>
                  </tr>
                </table>
                <div class="arrow" @click="shanchu"></div>
              </div>
            </li>
          </ul>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
import { Dialog } from "vant";
import api from "@/api";
export default {
  inject: ["reload"],
  name: "PropertyNoticeDetail",
  props: ["active1"],
  components: {},
  data() {
    return {
      show: false,
      actions: [
        { name: "确定要删除次成员吗？", disabled: true, color: "#333" },
      ],
      loading: true,
      active: 0,
      list: [
        {
          name: "业主",
          img: "",
          namer: "张张张",
          number: "12345678912",
        },
        // {"listd":[
        {
          name: "家人",
          listed: [
            {
              namer: "张张张",
              number: "12345678912",
            },
            {
              namer: "术后第",
              number: "1561123123456",
            },
          ],
        },
        // ]
        // },
        {
          name: "朋友",
          id: "1期",
        },
        {
          name: "租户",
          id: "1期",
        },
      ],
    };
  },

  created() {
    console.log(this.$route.query.idr);
    const open = {
      personTypes: (1, 2, 3, 4),
      roomId: this.$route.query.idr,
    };
    api.housecust(open).then((res) => {
      console.log(res);
    });
  },
  mounted() {
    this.loading = false;
  },
  methods: {
    tza() {
      console.log(123);
    },
    shanchu() {
      this.show = true;
      Dialog.confirm({
        title: "提示",
        message: "确定删除此成员吗？",
        theme: "round-button",
        confirmButtonColor: "red",
        cancelButtonColor: "#fff",
      })
        .then(() => {
          console.log(this.active1);
          this.$emit("hellobe", this.active1);
          //参数客户id：custId,房屋id:roomId
          const parameter = {
            custId: 0,
            roomId: 0,
          };
          api.housetomer(parameter).then((res) => {
            console.log(res);
            this.reload();
          });
        })
        .catch(() => {
          // on cancel
        });
    },
    onlpg() {
      this.show = false;
    },
    iosh() {
      this.show = false;
      console.log(this.active1);
      this.$emit("hellobe", this.active1);
      this.reload();
    },
  },
};
</script>


<style lang="less" scope>
.van-dialog--round-button .van-dialog__footer {
  padding: 0;
}
.van-button__content {
  font-size: 18px;
  font-family: PingFangSC-Medium, PingFang SC;
  font-weight: 500;
  color: #ffffff;
  line-height: 18px;
}
.van-dialog__header {
  padding-top: 0;
  text-align: center;
  font-size: 20px;
  font-family: PingFangSC-Medium, PingFang SC;
  font-weight: 500;
  color: #121212;
  line-height: 28px;
}
.van-dialog--round-button .van-dialog__message {
  padding-bottom: 0.8rem;
  font-size: 18px;
  font-family: PingFangSC-Regular, PingFang SC;
  font-weight: 400;
  color: #121212;
  line-height: 20px;
}
.van-dialog--round-button .van-dialog__cancel {
  border-radius: 8px;
  margin-right: 5px;
  .van-button__content {
    color: #121212;
  }
}
.van-dialog__message--has-title {
  padding-top: 34px;
}
.van-dialog--round-button .van-dialog__message {
  padding-bottom: 40px;
}
.van-dialog {
  padding: 26px 28px 30px 28px;
}
.van-dialog .van-button {
  border: 1px solid #d8d8d8 !important;
  border-radius: 8px;
  margin: 0 7.5px;
}
.imangetu {
  width: 32px;
}
.van-action-sheet {
  padding: 0 16px 16px 16px;
}
.property_notice_detail {
  width: 100%;
  height: auto;
  // padding: 29px 16px 20px 16px;
  .beida {
    flex-direction: column;
    background: #ffffff;
    box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
    padding: 19px;
    margin-bottom: 10px;
    .topb {
      font-size: 18px;
      font-family: PingFangSC-Medium, PingFang SC;
      font-weight: 500;
      color: #121212;
      line-height: 20px;
      padding: 0 0 11px 19px;
      border-bottom: 1px dashed #c1c1ca;
    }
    .bottenb {
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      align-items: center;
      padding: 16px 0 0 16px;
      .dpname {
        font-size: 18px;
        font-family: PingFangSC-Medium, PingFang SC;
        font-weight: 500;
        color: #121212;
        line-height: 20px;
      }
      .dpnum {
        font-size: 13px;
        font-family: PingFangSC-Regular, PingFang SC;
        font-weight: 400;
        color: #666666;
        line-height: 18px;
        padding-top: 7px;
      }
      .arrow {
        display: flex;
        align-items: center;
        width: 16px;
        height: 16px;
        background-image: url("../assets/img/bianzu.png");
        background-repeat: no-repeat;
        background-position: center center;
        background-size: 16px 16px;
      }
      .arrowder {
        display: flex;
        align-items: center;
      }
    }
  }
  .content {
    display: flex;
  }
  .oderk {
    padding: 15px;
    flex: 1;
    display: flex;
    justify-content: center; /* 水平居中 */
    align-items: center; /* 垂直居中 */
    border: 1px solid #d8d8d8;
    border-radius: 7%;
    font-size: 18px;
    font-family: PingFangSC-Regular, PingFang SC;
    font-weight: 400;
    color: #121212;
    line-height: 18px;
  }
  .oderg {
    flex: 1;
  }
  .oderl {
    padding: 15px;
    flex: 1;
    display: flex;
    justify-content: center; /* 水平居中 */
    align-items: center; /* 垂直居中 */
    border: 1px solid #d8d8d8;
    border-radius: 7%;
    font-size: 18px;
    font-family: PingFangSC-Regular, PingFang SC;
    font-weight: 400;
    color: #fff;
    background-color: red;
    line-height: 18px;
  }
}
</style>