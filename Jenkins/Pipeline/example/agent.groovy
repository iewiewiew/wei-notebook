/**
 * @author weimenghua*
 * @date 2020/11/22 11:40
 * agent 部分指定整个 Pipeline 或特定阶段将在 Jenkins 环境中执行的位置，具体取决于该 agent 部分的放置位置。该部分必须在 pipeline 块内的顶层定义 ，但阶段级使用是可选的。
 * agent 参数：any/none/label/node/docker/Dockerfile
 */

//1、any：在任何可用的机器上执行 pipeline
agent any

//2、node：当在 pipeline 顶层使用 none 时，将不会为整个 Pipeline 运行分配全局代理，每个 stage 需要指定相应的 agent
agent none

//3、label：指定 slave1的节点机器运行该 stage 或者 pipeline
agent {
    node { label "master" }
}
agent {
    label 'jenkins-node1'
}

//4、node：指定 slave1的节点机器运行该 stage 或者 pipeline
agent {
    node {
        label 'this is k8sapi-label'
        customWorkspace '/some/other/path'
    }
}

//5、docker：docker 执行 Pipeline，或阶段执行，用给定的容器将被动态地供应一个节点预先配置成接受基于 Docker-based Pipelines，或匹配的任选定义的节点上 label 的参数。
agent {
    docker {
        image 'maven:3-alpine'
        label 'my-defined-label'
        args '-v /deploy_demo:/deploy_demo'
    }
}