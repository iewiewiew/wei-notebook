[TOC]

<h1 align="center">SQLite</h1>

> By: weimenghua  
> Date: 2024.01.18  
> Description: 

**参考资料**  
[sqlite-tutorial](https://www.runoob.com/sqlite/sqlite-tutorial.html)



在终端执行 `sqlite3` 进入 sqlite 命令行页面

查询数据库文件的名称
`PRAGMA database_list;`

连接到数据库  
`.open database_name.db`

列出所有表
`.tables`

创建数据表
```
CREATE TABLE COMPANY(
ID INT PRIMARY KEY     NOT NULL,
NAME           TEXT    NOT NULL,
AGE            INT     NOT NULL,
ADDRESS        CHAR(50),
SALARY         REAL
);
```

插入表
```
INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (1, 'Paul', 32, 'California', 20000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (2, 'Allen', 25, 'Texas', 15000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (3, 'Teddy', 23, 'Norway', 20000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (4, 'Mark', 25, 'Rich-Mond ', 65000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (5, 'David', 27, 'Texas', 85000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (6, 'Kim', 22, 'South-Hall', 45000.00 );
```

查询表
`SELECT * FROM COMPANY;`

查看表信息
`.schema COMPANY`

退出数据库
```
.exit`
.quit
```

直接打开/创建 database_name
`sqlite3 database_name.db`
