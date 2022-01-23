#!/bin/bash



repository_url="https://administrator:admin123456@gitee.com/administrator/wei-demo-001.git"
num_iterations=5
previous_result=""

current_result=$(git ls-remote "$repository_url")
echo "ls-remote 结果: \n" $current_result

for ((i=1; i<=num_iterations; i++))
do
    # 运行 git ls-remote 并将结果保存到变量 current_result
    current_result=$(git ls-remote "$repository_url")

    # 比较当前结果与上一次结果是否一致
    if [ "$current_result" = "$previous_result" ]
    then
        echo "Iteration $i: Results are 一致"
    else
        echo "Iteration $i: Results are 不一致 (排除第 1 次不一致)"
    fi

    # 将当前结果保存为上一次结果
    previous_result="$current_result"
done
