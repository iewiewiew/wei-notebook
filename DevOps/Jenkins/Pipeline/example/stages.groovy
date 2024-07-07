stages {
    stage('Build') {
        steps {
            sh 'printenv'
            echo 'environment：设置环境变量'
        }
    }
}
