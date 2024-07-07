//当至少一个嵌套条件为真时执行舞台。必须至少包含一个条
when {
    anyOf {
        environment name: 'Target', value: 'aaa'
        environment name: 'Target', value: 'bbb'
    }
}

//当所有嵌套条件都为真时，执行舞台。必须至少包含一个条件
when {
    allOf {
        branch 'master';
        environment name: 'DEPLOY_TO', value: 'production'
    }
}

//当是 master 的时候，才执行某些事情
when {
    branch 'master'
}
//当嵌套条件为 false 时执行 stage。必须包含一个条件
when {
    not {
        branch 'master'
    }
}

//当指定的 Groovy 表达式求值为 true 时执行
when {
    expression {
        return params.DEBUG_BUILD
    }
}