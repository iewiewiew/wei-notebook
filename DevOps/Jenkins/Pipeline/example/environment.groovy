/**
 * 该 environment 指令指定一系列键值对，这些对值将被定义为所有步骤的环境变量或阶段特定步骤，具体取决于 environment 指令位于 pipeline 中的位置。
 */

pipeline {
    agent any

    environment {
        SONAR_SERVER = 'http://127.0.0.1:9000'
        JAVA_HOME = '/data/jdk'
        GIT_HASH = GIT_COMMIT.take(7) // 在变量中获取 git 短哈希
    }

    stages {
        stage('Build') {
            steps {
                sh 'printenv'
                echo 'environment：设置环境变量'
                echo '${GIT_HASH}'
            }
        }
    }
}