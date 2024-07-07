/**
 * 测试JSX文件
 * 这是一个用于知识库测试的JSX示例文件
 */

import React, { useState } from 'react';

function TestComponent() {
    const [message, setMessage] = useState('Hello, Gitee!');
    
    const handleClick = () => {
        setMessage('Hello, World!');
    };
    
    return (
        <div className="container">
            <h1>测试JSX文件</h1>
            <p>这是一个用于知识库测试的JSX示例文件</p>
            <p>{message}</p>
            <button onClick={handleClick}>点击问候</button>
        </div>
    );
}

export default TestComponent;

