stage('parallel') {
    parallel {
        stage('Run1') {
            steps {
                echo '并行1'
            }
        }
        stage('Run2') {
            steps {
                echo '并行2'
            }
        }
    }
}

