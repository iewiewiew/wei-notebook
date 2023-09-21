// 注：定义变量先注释构建一次拿到变量，再把注释取消重新构建，重新构建之后才能拿到 git_url
def git_url
switch(comp){
    case 'demo':
        switch(app){
            case 'demo1':
            case 'demo2':
                git_url = 'git@git.xxx.com:${git_group}/xx-${app}.git'
                break;
            default:
                git_url = 'git@git.xxx.com:${git_group}/${app}.git'
        }
        break;
    default:
        git_url = 'git@git.xxx.com:${git_group}/${app}.git'
}


pipeline {

    agent {
        node{
            label 'jenkins-node1'
        }
    }

    tools {
        //工具名称必须在 Jenkins 管理 Jenkins → 全局工具配置中预配置。
        jdk 'JDK_1.7.0_79'
    }

    environment {
        BUILD_USER_ID = "定时任务"
    }

    options {
        timestamps()
        ansiColor('xterm')
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '30', numToKeepStr: '10') //保持构建的天数：30  保持构建的最大个数：10
        disableConcurrentBuilds()  //不允许并发构建
    }

    triggers {
        cron('0 8 * * 1-5')
    }

    parameters {
        string(name: 'git_group', defaultValue: 'xxx', description: '')
        string(name: 'comp', defaultValue: 'xxx', description: '')
        string(name: 'app', defaultValue: 'xxx', description: '')
        gitParameter branch: '', branchFilter: '.*', defaultValue: 'origin/master', description: '', name: 'branch',
                quickFilterEnabled: false, selectedValue: 'NONE', sortMode: 'NONE', tagFilter: '*', type: 'PT_BRANCH'}

    stages {
        stage("1、构建任务信息"){
            steps {
                echo "\033[44;37m 1、构建任务信息 \033[0m"
                script {
                    wrap([$class: 'BuildUser']) {
                        //BUILD_USER_ID：需在 environment 定义该变量,否则自动触发时会报错
                        buildName "#${BUILD_NUMBER}-${BUILD_USER_ID}-${BRANCH}-${BUILD_TIMESTAMP}"
                        /* 注：如果复制 job 配置,下面这段代码会报错
                        HTTPD_LOCATION = sh(returnStdout: true, script: 'git show -s  |grep -vE "commit|Date" |grep -v "^$"')
                        buildDescription "${HTTPD_LOCATION}"*/
                    }
                }
            }
        }
        stage('2、拉取代码') {
            steps {
                echo "\033[44;37m 2、拉取代码 \033[0m"
                checkout([$class: 'GitSCM', branches: [[name: '$branch']], doGenerateSubmoduleConfigurations: false, extensions: [],
                          submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'xxxx-xxxx-xxxx-xxxx',
                                               url: "${git_url}"]]])
            }
        }
        stage('3、sonar 扫描') {
            steps{
                echo "\033[44;37m 3、sonar 扫描 \033[0m"
                withSonarQubeEnv('Sonar') {
                    script{
                        switch (app) {
                            case 'demo':
                                sh 'printenv'
                                echo "\033[44;37m 跳过 sonar 扫描\033[0m"
                                break;
                            default:
                                echo "\033[44;37m sh 'mvn clean compile -U $SONAR_MAVEN_GOAL' \033[0m"
                                sh 'mvn clean compile -U $SONAR_MAVEN_GOAL'
                        }
                    }
                }
            }
        }
    }

    post {
        unsuccessful   {
            emailext body: '$DEFAULT_CONTENT', postsendScript: '$DEFAULT_POSTSEND_SCRIPT', presendScript: '$DEFAULT_PRESEND_SCRIPT', recipientProviders: [requestor()], replyTo: '$DEFAULT_REPLYTO', subject: '$DEFAULT_SUBJECT', to: '$DEFAULT_RECIPIENTS'
        }
    }
}