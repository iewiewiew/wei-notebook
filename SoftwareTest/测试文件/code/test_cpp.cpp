#include <iostream>
#include <string>

/**
 * 测试C++文件
 * 这是一个用于知识库测试的C++示例文件
 */

class TestClass {
private:
    std::string name;
    
public:
    TestClass(const std::string& name) : name(name) {}
    
    std::string greet() const {
        return "Hello, " + name + "!";
    }
};

void helloWorld() {
    std::cout << "Hello, World!" << std::endl;
}

int main() {
    helloWorld();
    TestClass test("Gitee");
    std::cout << test.greet() << std::endl;
    return 0;
}

