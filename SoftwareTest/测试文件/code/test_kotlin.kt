/**
 * 测试Kotlin文件
 * 这是一个用于知识库测试的Kotlin示例文件
 */

class TestClass(private val name: String) {
    fun helloWorld() {
        println("Hello, World!")
    }
    
    fun greet(): String {
        return "Hello, $name!"
    }
}

fun main() {
    val test = TestClass("Gitee")
    test.helloWorld()
    println(test.greet())
}

