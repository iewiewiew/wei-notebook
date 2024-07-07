# 测试Ruby文件
# 这是一个用于知识库测试的Ruby示例文件

class TestClass
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def hello_world
    puts "Hello, World!"
  end
  
  def greet
    "Hello, #{@name}!"
  end
end

# 使用示例
test = TestClass.new("Gitee")
test.hello_world
puts test.greet

