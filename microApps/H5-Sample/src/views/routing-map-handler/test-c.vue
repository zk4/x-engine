<template>
  <div>
    <button
      v-for='tab in tabs'
      v-bind:key='tab'
      v-bind:class="['tab-button', { active: currentTab === tab }]"
      v-on:click='currentTab = tab'
    >{{ tab }}</button>

    <!-- <keep-alive> -->
      <component v-bind:is='currentTabComponent' class='tab'></component>
    <!-- </keep-alive> -->
  </div>
</template>

<script>
import c1 from './c1.vue'
import c2 from './c2.vue'
export default {
  components: {
    'tab-posts': c1,
    'tab-archive': c2
  },
  data() {
    return {
      currentTab: "Posts",
      tabs: ["Posts", "Archive"],
    };
  },
  computed: {
    currentTabComponent: function () {
      return "tab-" + this.currentTab.toLowerCase();
    },
  },
};
</script>

<style>
</style>