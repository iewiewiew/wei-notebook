// 测试Rust文件
// 这是一个用于知识库测试的Rust示例文件

struct TestStruct {
    name: String,
}

impl TestStruct {
    fn new(name: &str) -> Self {
        TestStruct {
            name: name.to_string(),
        }
    }
    
    fn greet(&self) -> String {
        format!("Hello, {}!", self.name)
    }
}

fn hello_world() {
    println!("Hello, World!");
}

fn main() {
    hello_world();
    let test = TestStruct::new("Gitee");
    println!("{}", test.greet());
}

