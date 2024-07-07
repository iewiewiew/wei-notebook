% 测试MATLAB文件
% 这是一个用于知识库测试的MATLAB示例文件

function hello_world()
    fprintf('Hello, World!\n');
end

function result = greet(name)
    result = sprintf('Hello, %s!', name);
end

% 使用示例
hello_world();
fprintf('%s\n', greet('Gitee'));

