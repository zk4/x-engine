<template>
  <div style="marginTop:100px">
    <van-button type="primary" size="large" round @click="handlerNetwork">requestData</van-button>
    <van-button type="primary" size="large" round @click="postData">postData</van-button>
    <div>result:</div>
    <div>{{content}}</div>
    <form id="uploadForm" enctype="multipart/form-data" v-on:change="uploadFile">
      <input type="file" id="file" name="file" />
    </form>
    <van-button type="primary" size="large" round @click="uploadImg">uploadImg</van-button>
  </div>
</template>

<script>
import server from "../utils/ajax";
import axios from "axios";
export default {
  data() {
    return {
      content: "",
    };
  },
  mounted() {
    this.handlerNetwork();
  },
  methods: {
    toBase64(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = () => resolve(reader.result);
        reader.onerror = (error) => reject(error);
      });
    },
    async uploadImg() {
      var formData = new FormData();
      var imagefile = document.querySelector("#file");
      let base64img = await this.toBase64(imagefile.files[0])
      axios.post("upload_file",{"imagebase64": base64img} , {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });
      //formData.append("imagebase64", base64img);
      /*axios.post("upload_file", formData, {*/
        /*headers: {*/
          /*"Content-Type": "multipart/form-data",*/
        /*},*/
      /*});*/
    },
    postData() {
      server
        .post("/mock/871b3e736e653b99374b7713e4011f9f/boss/user/list", {
          helli: "world",
        })
        .then((res) => {
          this.content = res.data;
        });
    },
    handlerNetwork() {
      server
        .get("/mock/871b3e736e653b99374b7713e4011f9f/boss/user/list")
        .then((res) => {
          if (res.code == "0000") {
            this.content = res.data;
          } else {
            this.$message.error(res.msg);
          }
        });
    },
  },
};
</script>

<style>
.navHeader1-class {
  margin-top: 200px;
}
</style>
