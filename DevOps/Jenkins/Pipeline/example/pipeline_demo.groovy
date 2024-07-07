pipeline {
    agent any
    environment {
        CRDE_EAMIL='xxx@163.com'
    }
    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
        choice(name: 'server', choices: '192.168.1.1,22,vito,vito111', description: '测试服务器列表选择（IP,SshPort,Name,Passwd）')
        booleanParam(name: 'isCommit', description: '是否邮件通知部署人员', defaultValue: false)
    }
    stages {
        stage('Example') {
            steps {
                echo "Hello ${params.PERSON}"
                script {
                    def split = ${params.server.split(",")}
                    serverIP = split[0]
                    sshport = split[1]
                    username = split[2]
                    password = split[3]
                    echo "serverIP:${serverIP},sshport:${sshport},username:${username},password:${password}"
                }
            }
        }
        stage('通知人工验收') {
            steps {
                script {
                    wrap([$class: 'BuildUser']) {
                        if(params.isCommit==false){
                            echo "不需要通知部署人员人工验收"
                        }
                        else{
                            //邮件通知测试人员人工验收
                            mail to: "${CRDE_EAMIL}",
                                    subject: "Pipeline '${JOB_NAME}' (${BUILD_NUMBER})人工验收通知",
                                    body: "${BUILD_USER}提交的 PineLine '${JOB_NAME}' (${BUILD_NUMBER})进入人工验收环节\\n 请及时前往${env.BUILD_URL}进行测试验收"
                        }
                    }
                }
            }
        }
    }
}
