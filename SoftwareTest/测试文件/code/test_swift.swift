// 测试Swift文件
// 这是一个用于知识库测试的Swift示例文件

class TestClass {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func helloWorld() {
        print("Hello, World!")
    }
    
    func greet() -> String {
        return "Hello, \(name)!"
    }
}

// 使用示例
let test = TestClass(name: "Gitee")
test.helloWorld()
print(test.greet())

