options {
    timestamps() //输入时间
    ansiColor('xterm') //输入颜色
    timeout(time: 1, unit: 'HOURS') //构建超过1小时后自动终止
}
