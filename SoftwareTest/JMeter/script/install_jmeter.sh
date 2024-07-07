#!/bin/zsh


##############################################
# 说明: 一键搭建 JMeter 环境
##############################################


# 当前目录
CURRENT_DIR=`pwd`
# 时间
TIME=$(date +%Y-%m-%d_%H:%M:%S)


function log() {
  echo -e "\033[32m${TIME} $1 \033[0m"
}


function jdk() {
  log "安装 JDK"
  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz"
  tar -zxvf jdk-8u141-linux-x64.tar.gz
}


function ant() {
  log "安装 Ant"
  wget --no-check-certificate https://dlcdn.apache.org//ant/binaries/apache-ant-1.9.16-bin.tar.gz
  tar -zxvf apache-ant-1.9.16-bin.tar.gz
}


function jmeter() {
  log "安装 JMeter"
  wget --no-check-certificate https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.5.tgz
  tar -zxvf apache-jmeter-5.5.tgz
}


function conf() {
  log "配置环境变量"
  if cat '/etc/profile' | grep -E "JAVA_HOME|JMETER_HOME" > /dev/null
  then
      log "/etc/profile 已存在 JAVA_HOME|JMETER_HOME, 请查看: cat /etc/profile"
      continue
  else
      log "/etc/profile 不存在 JAVA_HOME|JMETER_HOME, 写入配置文件, 请查看: cat /etc/profile"

# 前面得加一个空行
cat >> /etc/profile << EOF

export JAVA_HOME=${CURRENT_DIR}/jdk1.8.0_141
export ANT_HOME=${CURRENT_DIR}/apache-ant-1.9.16
export JMETER_HOME=${CURRENT_DIR}/apache-jmeter-5.5
export PATH=\$JAVA_HOME/bin:\$JMETER_HOME/bin:\$ANT_HOME/bin:\$PATH
export CLASSPATH=.:\$JAVA_HOME/jre/lib/rt.jar:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar:\$JMETER_HOME/lib/ext/ApacheJMeter_core.jar:\$JMETER_HOME/lib/jorphan.jar
EOF
fi

  source /etc/profile
  echo "java -version"
  echo "ant -version"
  echo "jmeter -v"
}


function jmeter_and_ant() {
  cp ${CURRENT_DIR}/apache-jmeter-5.5/extras/ant-jmeter-1.1.1.jar ${CURRENT_DIR}/apache-ant-1.9.16/lib/
  cp ${CURRENT_DIR}/apache-jmeter-5.5/lib/serializer-2.7.2.jar ${CURRENT_DIR}/apache-ant-1.9.16/lib/
  cp ${CURRENT_DIR}/apache-jmeter-5.5/lib/xalan-2.7.2.jar ${CURRENT_DIR}/apache-ant-1.9.16/lib/
}


function del_conf() {
  echo "删除配置文件"
  sed -i '/JAVA_HOME/d' /etc/profile
  sed -i '/ANT_HOME/d' /etc/profile
  sed -i '/JMETER_HOME/d' /etc/profile
}

function rm_pack() {
  echo "删除安装包"
  rm -rf jdk*
  rm -rf apache-ant*
  rm -rf apache-jmeter*
}


function install() {
  dir
  jdk
  ant
  jmeter
  conf
}


function uninstall() {
  del_conf
  rm_pack
}


case $1 in
"install")
install
;;
"uninstall")
uninstall
;;
*)
log "安装 JMeter 环境：sh install_jmeter.sh install
    卸载 JMeter 环境：sh install_jmeter.sh uninstall"
;;
esac
