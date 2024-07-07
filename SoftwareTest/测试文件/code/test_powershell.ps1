# 测试PowerShell文件
# 这是一个用于知识库测试的PowerShell示例文件

function Hello-World {
    Write-Host "Hello, World!"
}

function Get-Greet {
    param(
        [string]$Name
    )
    return "Hello, $Name!"
}

# 使用示例
Hello-World
Get-Greet -Name "Gitee"

