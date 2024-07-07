<template>
  <div class="container">
    <h1>测试Vue文件</h1>
    <p>这是一个用于知识库测试的Vue示例文件</p>
    <p>{{ message }}</p>
    <button @click="greet">点击问候</button>
  </div>
</template>

<script>
export default {
  name: 'TestVue',
  data() {
    return {
      message: 'Hello, Gitee!'
    }
  },
  methods: {
    greet() {
      alert('Hello, World!')
    }
  }
}
</script>

<style scoped>
.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

h1 {
  color: #42b983;
}
</style>

