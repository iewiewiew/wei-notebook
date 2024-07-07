/**
 * 测试Dart文件
 * 这是一个用于知识库测试的Dart示例文件
 */

class TestClass {
  final String name;
  
  TestClass(this.name);
  
  void helloWorld() {
    print('Hello, World!');
  }
  
  String greet() {
    return 'Hello, $name!';
  }
}

void main() {
  final test = TestClass('Gitee');
  test.helloWorld();
  print(test.greet());
}

