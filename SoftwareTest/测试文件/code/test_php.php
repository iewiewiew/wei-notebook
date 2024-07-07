<?php
/**
 * 测试PHP文件
 * 这是一个用于知识库测试的PHP示例文件
 */

class TestClass {
    private $name;
    
    public function __construct($name) {
        $this->name = $name;
    }
    
    public function helloWorld() {
        echo "Hello, World!\n";
    }
    
    public function greet() {
        return "Hello, " . $this->name . "!";
    }
}

// 使用示例
$test = new TestClass("Gitee");
$test->helloWorld();
echo $test->greet() . "\n";
?>

