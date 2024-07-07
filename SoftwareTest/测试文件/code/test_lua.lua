-- 测试Lua文件
-- 这是一个用于知识库测试的Lua示例文件

TestClass = {}
TestClass.__index = TestClass

function TestClass:new(name)
    local obj = {}
    setmetatable(obj, TestClass)
    obj.name = name
    return obj
end

function TestClass:helloWorld()
    print("Hello, World!")
end

function TestClass:greet()
    return "Hello, " .. self.name .. "!"
end

-- 使用示例
local test = TestClass:new("Gitee")
test:helloWorld()
print(test:greet())

