#!/bin/sh

#组可写
umask 0002

#java 目录
export JAVA_HOME="/usr/java/jdk1.7.0_80"
export PATH="/usr/java/jdk1.7.0_80/bin:$PATH"

#tomcat 目录
export CATALINA_HOME="/usr/local/tomcat"
export CATALINA_TMPDIR="/usr/local/tomcat/temp"
export CATALINA_OUT="/usr/local/tomcat/logs/catalina.out"
export CATALINA_PID="/usr/local/tomcat/pid/tomcat.pid"
export DISCONF_PATH="/usr/local/tomcat/conf/disconf.properties"

#可选
export CATALINA_OPTS="-Xms256m -Xmx256m -XX:PermSize=64m -XX:MaxPermSize=64m -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=2222,server=y,suspend=n "

#启动 tomcat
echo "Start Tomcat"
$CATALINA_HOME/bin/catalina.sh start
tail -f /dev/null
