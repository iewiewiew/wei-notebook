[TOC]

<h1 align="center">JaCoCo</h1>

> By：weimenghua  
> Date：2023.06.03  
> Description：JaCoCo 单元覆盖率统计  

**参考资料**  
[Jacoco 官网](https://www.eclemma.org/jacoco/)  
[Jacoco 源码](https://github.com/jacoco/jacoco)

## 1. 代码覆盖率

代码覆盖（Code coverage）是软件测试中的一种度量，描述程序中源代码被测试的比例和程度，所得比例称为代码覆盖率。

添加依赖后，执行：mvn clean test。

```text
<dependency>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.8.7</version>
</dependency>
```

```xml
<build>
        <plugins>
            <plugin>
                <groupId>org.jacoco</groupId>
                <artifactId>jacoco-maven-plugin</artifactId>
                <version>0.8.7</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>prepare-agent</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>report</id>
                        <phase>test</phase>
                        <goals>
                            <goal>report</goal>
                        </goals>
                        <configuration>
                            <!--定义输出的文件夹-->
                            <outputDirectory>target/jacoco-report</outputDirectory>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
```
