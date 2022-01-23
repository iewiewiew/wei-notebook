pipeline {

    agent {
        node {
            label 'jenkins-node1'
        }
    }

    options {
        timestamps()
        ansiColor('xterm')
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '30', numToKeepStr: '10')
        //保持构建的天数：30  保持构建的最大个数：10
        disableConcurrentBuilds()  //不允许并发构建
    }

    parameters {
        gitParameter branch: '', branchFilter: '.*', defaultValue: 'origin/master', description: '', name: 'branch',
                quickFilterEnabled: false, selectedValue: 'NONE', sortMode: 'NONE', tagFilter: '*', type: 'PT_BRANCH'
    }

    stages {
        stage("1、构建任务信息") {
            steps {
                echo "\033[44;37m 1、构建任务信息 \033[0m"
                script {
                    wrap([$class: 'BuildUser']) {
                        buildName "#${BUILD_NUMBER}-${BUILD_USER_ID}-${BRANCH}-${BUILD_TIMESTAMP}"
                        HTTPD_LOCATION = sh(returnStdout: true, script: 'git show -s  |grep -vE "commit|Date" |grep -v "^$"')
                        buildDescription "${HTTPD_LOCATION}"
                    }
                }
            }
        }
        stage('2、拉取代码') {
            steps {
                echo "\033[44;37m 2、拉取代码 \033[0m"
                checkout([$class      : 'GitSCM', branches: [[name: '$branch']], doGenerateSubmoduleConfigurations: false, extensions: [],
                          submoduleCfg: [], userRemoteConfigs: [[credentialsId: '4011353f-ead0-45a1-b621-ba3f1da06c04',
                                                                 url          : "https://github.com/WEIMHaaa/Learn-Java.git"]]])
            }
        }
        stage('3、打包+部署') {
            steps {
                echo "\033[44;37m 3、打包+部署 \033[0m"
                script {
                    sh 'sh build.sh'
                }
            }
        }
    }

    post {
        unsuccessful {
            emailext body: '$DEFAULT_CONTENT', postsendScript: '$DEFAULT_POSTSEND_SCRIPT', presendScript: '$DEFAULT_PRESEND_SCRIPT', recipientProviders: [requestor()], replyTo: '$DEFAULT_REPLYTO', subject: '$DEFAULT_SUBJECT', to: '$DEFAULT_RECIPIENTS'
        }
    }
}