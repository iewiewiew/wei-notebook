/**
 * 测试Java文件
 * 这是一个用于知识库测试的Java示例文件
 */
public class TestJava {
    private String name;
    
    public TestJava(String name) {
        this.name = name;
    }
    
    public void helloWorld() {
        System.out.println("Hello, World!");
    }
    
    public String greet() {
        return "Hello, " + name + "!";
    }
    
    public static void main(String[] args) {
        TestJava test = new TestJava("Gitee");
        test.helloWorld();
        System.out.println(test.greet());
    }
}

