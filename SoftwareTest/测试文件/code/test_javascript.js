/**
 * 测试JavaScript文件
 * 这是一个用于知识库测试的JavaScript示例文件
 */

function helloWorld() {
    console.log("Hello, World!");
    return "Hello, World!";
}

class TestClass {
    constructor(name) {
        this.name = name;
    }
    
    greet() {
        return `Hello, ${this.name}!`;
    }
}

// 使用示例
const test = new TestClass("Gitee");
helloWorld();
console.log(test.greet());

// 导出模块
module.exports = { helloWorld, TestClass };

