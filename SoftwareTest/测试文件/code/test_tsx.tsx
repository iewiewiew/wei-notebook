/**
 * 测试TSX文件
 * 这是一个用于知识库测试的TSX示例文件
 */

import React, { useState } from 'react';

interface Props {
    name?: string;
}

const TestComponent: React.FC<Props> = ({ name = 'Gitee' }) => {
    const [message, setMessage] = useState<string>(`Hello, ${name}!`);
    
    const handleClick = (): void => {
        setMessage('Hello, World!');
    };
    
    return (
        <div className="container">
            <h1>测试TSX文件</h1>
            <p>这是一个用于知识库测试的TSX示例文件</p>
            <p>{message}</p>
            <button onClick={handleClick}>点击问候</button>
        </div>
    );
};

export default TestComponent;

