//自定义变量（局部）
def username = 'jenkins'
echo "hello Mr.${username}"

//环境变量
withEnv(['JAVA_HOME=/data/jdk']) {
    sh '$JAVA_HOME/bin/start.sh'
}

//环境变量（全局）
environment {
    JAVA_HOME='/data/jdk'
}
echo "java path $JAVA_HOME"

//参数化构建（全局）
parameters  {
    string(name: 'GIT_BRANCH', defaultValue: 'master', description: 'default build branch')
}
echo  "${params.name}"