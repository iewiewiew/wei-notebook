#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
测试Python文件
这是一个用于知识库测试的Python示例文件
"""

def hello_world():
    """打印Hello World"""
    print("Hello, World!")
    return "Hello, World!"

class TestClass:
    """测试类"""
    
    def __init__(self, name):
        self.name = name
    
    def greet(self):
        return f"Hello, {self.name}!"

if __name__ == "__main__":
    hello_world()
    test = TestClass("Gitee")
    print(test.greet())

