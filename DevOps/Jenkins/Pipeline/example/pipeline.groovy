/**
 *pipeline 的代码定义了整个构建过程，通常包括构建应用程序，测试然后交付应用程序的阶段，下面是 pipeline 语法中的基本概念：
 *Stage 一个 pipeline 可以划分成若干个 stage，每个 stage 代表一组操作，例如 build、deploy。注意，stage 是一个逻辑分组的概念，可以跨多个 node 或agent
 *Node 一个 node 就是一个 jenkins 节点，或者是 master，或者是 agent，是执行 step 的具体运行环境
 *Stepstep 是最基本的操作单元，小到创建一个目录，大到构建一个 docker 镜像，由各类 jenkins plugin 提供，例如 sh make
 *
 *声明式 Pipeline 是Jenkins Pipeline 的一个相对较新的补充，它在 Pipeline 子系统之上提出了一种更为简化和有意义的语法，包括：
 *提供比 Scripted Pipeline 语法更丰富的语法功能
 *声明式 Pipeline 代码更容易编写和理解
 *所有有效的声明性 Pipeline 必须包含在一个 pipeline 块内，例如：
 */

pipeline {
    /* insert Declarative Pipeline here */
}