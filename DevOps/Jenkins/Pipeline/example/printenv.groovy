//通过执行 printenvshell 命令列出所有环境变量

pipeline {
    agent any

    environment {
        LS = "${sh(script:'ls -lah', returnStdout: true)}"
        FOO = "bar"
    }

    stages {
        stage("Env Variables") {
            steps {
                //sh "printenv"
                sh "printenv | sort"  //使用 printenv | sort 命令组合来获取环境变量的排序列表
            }
        }

        stage("Env Variables") {
            steps {
                echo "The build number is ${env.BUILD_NUMBER}"
                echo "You can also use \${BUILD_NUMBER} -> ${BUILD_NUMBER}"
                sh 'echo "I can access $BUILD_NUMBER in shell command as well."'
            }
        }

        stage("Env Variables") {
            steps {
                echo "LS = ${env.LS}"
            }
        }

        stage("Env Variables") {
            environment {
                NAME = "Alan"
            }
            steps {
                echo "FOO = ${env.FOO}"
                echo "NAME = ${env.NAME}"

                script {
                    env.TEST_VARIABLE = "some test value"
                }

                echo "TEST_VARIABLE = ${env.TEST_VARIABLE}"

                withEnv(["ANOTHER_ENV_VAR=here is some value"]) {
                    echo "ANOTHER_ENV_VAR = ${env.ANOTHER_ENV_VAR}"
                }
            }
        }

    }
}