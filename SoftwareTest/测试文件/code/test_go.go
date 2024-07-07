package main

import "fmt"

// TestStruct 测试结构体
type TestStruct struct {
	Name string
}

// Greet 问候方法
func (t *TestStruct) Greet() string {
	return fmt.Sprintf("Hello, %s!", t.Name)
}

// HelloWorld 打印Hello World
func HelloWorld() {
	fmt.Println("Hello, World!")
}

func main() {
	HelloWorld()
	test := &TestStruct{Name: "Gitee"}
	fmt.Println(test.Greet())
}

