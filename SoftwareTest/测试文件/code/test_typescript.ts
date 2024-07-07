/**
 * 测试TypeScript文件
 * 这是一个用于知识库测试的TypeScript示例文件
 */

interface User {
    name: string;
    age: number;
}

class TestClass {
    private name: string;
    
    constructor(name: string) {
        this.name = name;
    }
    
    greet(): string {
        return `Hello, ${this.name}!`;
    }
}

function helloWorld(): void {
    console.log("Hello, World!");
}

const test: TestClass = new TestClass("Gitee");
helloWorld();
console.log(test.greet());

export { TestClass, helloWorld, User };

