[TOC]

---

<h1 align="center">MySQL 关系型数据库</h1>

> By：weimenghua  
> Date：2023.03.21  
> Descrition：MySQL



## 一、数据库基础
### 数据库连接
```
// mysql 驱动
jdbc.url=jdbc:mysql://127.0.0.1:3306/demo?characterEncoding=UTF-8&amp;autoReconnect=true&amp;failOverReadOnly=false&amp;zeroDateTimeBehavior=convertToNull
jdbc.driverClass=com.mysql.jdbc.Driver
jdbc.user=root
jdbc.password=root

// hive 驱动(下载地址：https://github.com/timveil/hive-jdbc-uber-jar/releases/download/v1.9-2.6.5/hive-jdbc-uber-2.6.5.0-292.jar)
jdbc.url=jdbc:hive2://{host}[:{port}][/{database}]
jdbc.driverClass=org.apache.hive.jdbc.HiveDriver
jdbc.user=root
jdbc.password=root
```

### count(1) and count(字段)的区别
1、count(1) 会统计表中的所有的记录数，包含字段为 null 的记录。  
2、count(字段) 会统计该字段在表中出现的次数，忽略字段为 null 的情况。即不统计字段为 null 的记录。  
在 InnoDB 中 COUNT(*)和 COUNT(1)实现上没有区别，而且效率一样。

### drop、truncate 和 delete 的区别
一、delete  
1、delete 是 DML，执行 delete 操作时，每次从表中删除一行，并且同时将该行的的删除操作记录在 redo 和 undo 表空间中以便进行回滚（rollback）和重做操作，但要注意表空间要足够大，需要手动提交（commit）操作才能生效，可以通过 rollback 撤消操作。  
2、delete 可根据条件删除表中满足条件的数据，如果不指定 where 子句，那么删除表中所有记录。  
3、delete 语句不影响表所占用的 extent，高水线(high watermark)保持原位置不变。

二、truncate  
1、truncate 是 DDL，会隐式提交，所以，不能回滚，不会触发触发器。  
2、truncate 会删除表中所有记录，并且将重新设置高水线和所有的索引，缺省情况下将空间释放到 minextents 个 extent，除非使用 reuse storage，。不会记录日志，所以执行速度很快，但不能通过 rollback 撤消操作（如果一不小心把一个表 truncate 掉，也是可以恢复的，只是不能通过 rollback 来恢复）。  
3、对于外键（foreignkey ）约束引用的表，不能使用 truncate table，而应使用不带 where 子句的 delete 语句。  
4、truncate table 不能用于参与了索引视图的表。

三、drop  
1、drop 是 DDL，会隐式提交，所以，不能回滚，不会触发触发器。  
2、drop 语句删除表结构及所有数据，并将表所占用的空间全部释放。  
3、drop 语句将删除表的结构所依赖的约束，触发器，索引，依赖于该表的存储过程/函数将保留,但是变为 invalid 状态。

四、总结  
1、在速度上，一般来说，drop> truncate > delete。  
2、在使用 drop 和 truncate 时一定要注意，虽然可以恢复，但为了减少麻烦，还是要慎重。  
3、如果想删除部分数据用 delete，注意带上 where 子句，回滚段要足够大；  
如果想删除表，当然用 drop；  
如果想保留表而将所有数据删除，如果和事务无关，用 truncate 即可；  
如果和事务有关，或者想触发 trigger，还是用 delete；  
如果是整理表内部的碎片，可以用 truncate 跟上 reuse stroage，再重新导入/插入数据。



## 二、sql 执行详解
### sql 执行过程
Step1：客户端向 Mysql 服务器发送 SQL 语句。  
Step2：服务器收到后先查询”查询缓存“，如果命中，从缓存中直接返回 sql 执行的结果集。否则，进入 Step3。  
Step3：服务器解析、预处理、优化 sql 执行计划，然后将处理好的 sql 放入查询的执行计划中。  
Step4：执行引擎通过调用”存储引擎”(如，innodb、myisam 等)提供的 API 去执行这个计划。  
Step5：服务器返回结果给客户端。  

### sql 执行顺序
（优化动作越靠前越好）
1. from
2. on
3. join
4. where
5. group by
6. avg\sum...
7. having
8. select
9. distinct
10. order by
11. limit            

### sql 编写顺序
编写顺序: select distinct from join on where group by having order by limit
```
SELECT DISTINCT < select_list >
FROM < left_table > < join_type >
JOIN < right_table >
ON < join_condition >
WHERE < where_condition >
GROUP BY < group_by_list >
HAVING < having_condition >
ORDER BY < order_by_condition >
LIMIT < limit_number >
```

### sql 解析顺序
解析顺序: from on join where group by having select distinct order by limit
```
FROM <left_table>
ON <join_condition> <join_type> 
JOIN <right_table>
WHERE <where_condition>
GROUP BY <group_by_list>
HAVING <having_condition>
SELECT 
DISTINCT <select_list>
ORDER BY <order_by_condition>
LIMIT <limit_number>
```

### sql 执行关键字解释
1. Distinct(去重)：用于返回唯一不同的值
2. where 子句用于提取那些满足指定条件的记录
3. AND：如果第一个条件和第二个条件都成立，则 AND 运算符显示一条记录
4. OR：如果第一条和第二个条件中只要有一个条件成立，则 OR 运算符显示一条记录
5. ORDER BY：用于对结果集按照一个列过分多个列进行排序，默认升序，可以使用 DESC 改为降序(desc 只对紧跟着的第一个列名有效，其他不受影响)
6. LIMIT：选取指定的条数数据，分页查询
7. LIKE：用于在 where 子句中搜索列中的指定模式，也可以匹配字符串
8. IN：允许在 where 子句中规定多个值
9. BETWEEN 用于选取介于两个值之间的数据范围内的值
10. JOIN：用来将两个或者多个表的行连接起来，基于这些表之间的共同字段
11. UNION：合并两个或者多个 select 语句的结果,如果允许重复的值使用 UNION ALL
12. SELECT INTO：从一个表复制数据，然后将数据插入到另一个新表中
13. 子查询：出现在其他语句内部的 select 语句，称为子查询或者内查询，内部嵌套其他 select 语句的查询，称为外查询或主查，子查询的执行优先于主查询的执行，主查询的条件用到了子查询的结果

### sql 执行计划 explain
通过 explain 这个命令来查看一个这些 SQL 语句的执行计划。查看该 SQL 语句有没有使用上了索引，有没有做全表扫描，这都可以通过 explain 命令来查看。
![avater](img/sql 执行计划 explain.png)

概要描述  
1. id：选择标识符
2. select_type：表示查询的类型。
3. table：输出结果集的表
4. partitions：匹配的分区
5. type：表示表的连接类型
6. possible_keys：表示查询时，可能使用的索引
7. key：表示实际使用的索引
8. key_len：索引字段的长度
9. ref：列与索引的比较
10. rows：扫描出的行数(估算的行数)
11. filtered：按表条件过滤的行百分比
12. Extra：执行情况的描述和说明

重点描述  
select_type：表示查询中每个 select 子句的类型
- SIMPLE(简单 SELECT，不使用 UNION 或子查询等)
- PRIMARY(子查询中最外层查询，查询中若包含任何复杂的子部分，最外层的 select 被标记为 PRIMARY)
- UNION(UNION 中的第二个或后面的 SELECT 语句)
- DEPENDENT UNION(UNION 中的第二个或后面的 SELECT 语句，取决于外面的查询)
- UNION RESULT(UNION 的结果，union 语句中第二个 select 开始后面所有 select)
- SUBQUERY(子查询中的第一个 SELECT，结果不依赖于外部查询)
- DEPENDENT SUBQUERY(子查询中的第一个 SELECT，依赖于外部查询)
- DERIVED(派生表的 SELECT, FROM 子句的子查询)
- UNCACHEABLE SUBQUERY(一个子查询的结果不能被缓存，必须重新评估外链接的第一行)

type：对表访问方式，表示 MySQL 在表中找到所需行的方式，又称“访问类型”
- type=ALL，全表扫描，MySQL 遍历全表来找到匹配行
- type=index，索引全扫描
- type=range，索引范围扫描
- type=eq_ref，唯一索引
- type=NULL，MySQL 不用访问表或者索引，直接就能够得到结果（性能最好）


## 三、数据库索引
### 索引基数
基数是数据列所包含的不同值的数量。  
例如，某个数据列包含值1、3、7、4、7、3，那么它的基数就是4。索引的基数相对于数据表行数较高（也就是说，列中包含很多不同的值，重复的值很少）的时候，它的工作效果最好。如果某数据列含有很多不同的年龄，索引会很快地分辨数据行。如果某个数据列用于记录性别（只有"M"和"F"两种值），那么索引的用处就不大。如果值出现的几率几乎相等，那么无论搜索哪个值都可能得到一半的数据行。在这些情况下，最好根本不要使用索引，因为查询优化器发现某个值出现在表的数据行中的百分比很高的时候，它一般会忽略索引，进行全表扫描。惯用的百分比界线是"30%"。

### 索引的建立
1. 根据业务经常查询的语句建立索引；
2. 尽量选择区分度高的列作为索引，区分度的公式是 COUNT(DISTINCT col) / COUNT(*)，表示字段不重复的比率，比率越大扫描的记录数就越少；
3. 如果业务中唯一特性最好建立唯一键，一方面可以保证数据的正确性，另一方面索引的效率能大大提高；

### 索引的分类
索引分类：1、普通索引  2、唯一索引  3、主键索引  4、组合索引  5、联合索引
#### 1、普通索引
创建索引：create index 索引的名字 on 表名(列名)   eg. create index empnoIndex on emp_copy(empno)  
删除索引：drop index 索引的名字 on 表名   eg. drop index empnoIndex on emp_copy  
查看索引：show index from 表名  eg. show index from emp_copy  
修改索引：
先删除 ALTER TABLE table_name DROP INDEX index_name     
再以修改后的内容创建同名索引  CREATE INDEX index_name ON table_name

#### 2、唯一索引
唯一索引有两个功能：加速查找和唯一约束（可含 null）
创建索引：create unique index 索引名 on 表名(列名)  
删除索引：drop index 索引的名字 on 表名  eg. drop index empnoIndex on emp_copy

#### 3、主键索引
主键索引有两个功能：加速查找和唯一约束（不含 null）  
主键索引：alter table 表名 add primary key(列名);  eg.alter table emp_copy add primary key(deptno)  
删除主键索引：alter table 表名 drop primary key;   alter table 表名 modify 列名 int, drop primary key;

#### 4、组合索引
组合索引是将 n 个列组合成一个索引,其应用场景为：频繁的同时使用 n 列来进行查询，如：where name = 'alex' and email = 'alex@qq.com'。
create index 索引名 on 表名(列名1,列名2)   eg. create index enameIndex on emp_copy(ename,mgr)

#### 5、联合索引
首先介绍一下联合索引（复合索引）。联合索引其实很简单，相对于一般索引只有一个字段，联合索引可以为多个字段创建一个索引。它的原理也很简单，比如，我们在（a,b,c）字段上创建一个联合索引，则索引记录会首先按照 A 字段排序，然后再按照 B 字段排序然后再是 C 字段，因此，联合索引的特点就是：  
第一个字段一定是有序的，当第一个字段值相等的时候，第二个字段又是有序的，比如下表中当 A=2时所有 B 的值是有序排列的，依次类推，当同一个 B 值得所有 C 字段是有序排列的；
其实联合索引的查找就跟查字典是一样的，先根据第一个字母查，然后再根据第二个字母查，或者只根据第一个字母查，但是不能跳过第一个字母从第二个字母开始查。这就是所谓的最左前缀原理。

### 索引的优缺点
索引就是一个数据结构，我们把表中的记录用一个适合高效查找的数据结构来表示，目的就是让查询变得更高效。

**1、优点**

创建唯一性索引，保证数据库表中每一行数据的唯一性；    
加速表和表之间的连接；

**2、缺点**

索引需要占物理空间；  
当对表中的数据进行增加、删除和修改的时候，索引也要动态的维护，降低了数据的维护速度；  
增加了插入和删除的操作时间，一个表拥有的索引越多，插入和删除的速度越慢。如要求快速录入的系统不宜建过多索引；

### 索引失效原因
1. 对索引列运算，运算包括`（+、-、*、/. ！、<>、%、like'%_'（%放在前面）`；
2. 类型错误，如字段类型为 varchar，where 条件用 number；
3. 对索引应用内部函数，这种情况下应该建立基于函数的索引如 select * from template t where ROUND(t.logicdb_id) = 1此时应该建 ROUND(t.logicdb_id)为索引，mysql8.0开始支持函数索引，5.7可以通过虚拟列的方式来支持，之前只能新建一个 ROUND(t.logicdb_id)列然后去维护；
4. 如果条件有 or，即使其中有条件带索引也不会使用（这也是为什么建议少使用 or 的原因），如果想使用 or，又想索引有效，只能将 or 条件中的每个列加上索引；
5. 如果列类型是字符串，那一定要在条件中数据使用引号，否则不使用索引；
6. B-tree 索引 is null 不会走，is not null 会走，位图索引 is null，is not null 都会走；
7. 组合索引遵循最左原则；

### 索引建立规则
1. 表的主键. 外键必须有索引；
2. 数据量超过300的表应该有索引；
3. 经常与其他表进行连接的表，在连接字段上应该建立索引；
4. 经常出现在 Where 子句中的字段，特别是大表的字段，应该建立索引；
5. 索引应该建在选择性高的字段上；
6. 索引应该建在小字段上，对于大的文本字段甚至超长字段，不要建索引；
7. 复合索引的建立需要进行仔细分析；尽量考虑用单字段索引代替：
   A、正确选择复合索引中的主列字段，一般是选择性较好的字段；  
   B、复合索引的几个字段是否经常同时以 AND 方式出现在 Where 子句中？单字段查询是否极少甚至没有？如果是，则可以建立复合索引；否则考虑单字段索引；  
   C、如果复合索引中包含的字段经常单独出现在 Where 子句中，则分解为多个单字段索引；  
   D、如果既有单字段索引，又有这几个字段上的复合索引，一般可以删除复合索引；
8. 频繁进行数据操作的表，不要建立太多的索引；
9. 删除无用的索引，避免对执行计划造成负面影响；

### 主键、外键和索引的区别
比如，A 表中的一个字段，是 B 表的主键，就可以是 A 表的外键。

| 主键               | 外键                         | 索引              |
|------------------|----------------------------|-----------------|
| 唯一标识一条记录，不能有重复的，不允许为空 | 表的外键是另一表的主键, 外键可以有重复的, 可以是空值 | 该字段没有重复值，但可以有一个空值 |
| 用来保证数据完整性        | 用来和其他表建立联系用的               | 提高查询排序的速度       | 
| 主键只能有一个          | 一个表可以有多个外键                 | 一个表可以有多个唯一索引    |


### 唯一约束和唯一索引的区别

约束 ：全称完整性约束，它是关系数据库中的对象，用来存放插入到一个表中一列数据的规则，用来确保数据的准确性和一致性。  
索引：数据库中用的最频繁的操作是数据查询，索引就是为了加速表中数据行的检索而创建的一种分散的数据结构。可以把索引类比成书的目录，有目录的肯定比没有目录的书，更方便查找。  
唯一约束：保证在一个字段或者一组字段里的数据都与表中其它行的对应数据不同。和主键约束不同，唯一约束允许为 NULL，只是只能有一行。  
唯一索引：不允许具有索引值相同的行，从而禁止重复的索引或键值。  
唯一约束和唯一索引都是为了保证表中被限制的字段不允许有重复的值，看起来功能是一样的，那为什么要设计这样两种一样的功能呢？  
唯一约束和唯一索引在 MySQL 数据库里区别了：
概念上不同，约束是为了保证数据的完整性，索引是为了辅助查询；创建唯一约束时，会自动的创建唯一索引；在理论上，不一样，在实际使用时，基本没有区别。  
关于第二条，MySQL 中唯一约束是通过唯一索引实现的，为了保证没有重复值，在插入新记录时会再检索一遍，怎样检索快，当然是建索引了，所以，在创建唯一约束的时候就创建了唯一索引。



## 四、综合信息

### VIP 漂移

**什么是 VIP 漂移**

MySQL 三主部署，但在实际使用中，应用服务不能同时配置三个数据库源，通过 Keepalived 软件可以对外提供一个 VIP，当 VIP 所在服务丢失，VIP 可以漂移到其他正常服务器上并继续提供服务，对于用户此切换过程时间很短，几乎无感知。

**VIP 漂移的两种方式**

1、通过 keepalived 的方式
2、使用 MHA 自带的脚本

### 重置 MySQL 密码

```
cd /usr/local/mysql/bin
sudo su
./mysqld_safe --skip-grant-tables &
./mysql

use myst;
update user set password=password("root") where user="root";
flush privileges;

sudo /usr/local/mysql/support-files/mysql.server restart
/usr/local/mysql/bin/mysql -uroot -proot
```

### MySQL 打满连接数

```
-- 查询最大连接数，默认的最大连接数都是151，上限为：100000
show variables like '%max_connections%'; 
show variables like 'max_connections';
select @@max_connections;

-- 查看实时连接数
show status like 'Threads_connected';  

-- 查看服务器响应的最大连接数
show global status like 'Max_used_connections';

-- 设置连接数
set global max_connections = 3; 

-- 查看 mysql 文件路径
show variables like '%datadir%'; 
-- vim /etc/my.cnf，添加：max_connections=1，重启 MySQl

-- 通过 JMeter 建立 JDBC 连接，设置10个并发请求
-- 第4个连接报错：Cannot create PoolableConnectionFactory (Data source rejected establishment of connection,  message from server: "Too many connections")

-- 查看进程
-- Threads_connected： 连接数.
-- Threads_running： 激活的连接数，这个数值一般远低于 connected 数值.
-- Threads_connected：跟 show processlist 结果相同，表示当前连接数。准确的来说，
-- Threads_running：代表当前并发数
show status like 'Threads%'

-- 查看 ibd 文件，文件路径：/var/lib/mysql/mysql，如果启动 docker 遇到文件冲突的错误，来此目录将冲突文件删除
SELECT TABLESPACE_NAME,FILE_ID,FILE_NAME FROM INFORMATION_SCHEMA.FILES;
```

### 查看 MySQL 主节点

查看 MySQL 服务器上所有的从节点：SHOW SLAVE HOSTS;
如果是 Master 节点，展示 slave 节点信息
Server_id | Host | Port | Master_id | Slave_UUID                           |
+-----------+------+------+-----------+--------------------------------------+
|       696 |      | 3306 |       438 | 3a214c04-4ebc-11ed-9a25-xxxxx |
|       214 |      | 3306 |       438 | 2446e2f9-4ebc-11ed-94d3-xxxxx
如果是 Slave 节点，返回：Empty set (0.00 sec)

在 Master 节点执行：SHOW MASTER STATUS;
在 Slave 节点执行：SHOW SLAVE STATUS\G;

查看日志文件路径：SHOW VARIABLES LIKE 'general_log_file';

### 锁表

迁移锁表

迁移锁表通常是指在数据库系统中进行数据迁移或者数据库迁移时，为了避免在迁移过程中产生数据不一致或丢失等问题，需要对表进行加锁，以保证迁移过程中的数据完整性。

在 MySQL 中，可以使用锁来保证并发访问数据库时数据的一致性。对于整张表的锁定，可以使用以下方式来锁定表：

1. 共享锁（Shared Lock）：该锁定方式被称为读锁，它允许多个事务同时读取同一张表，但是不允许任何事务对表进行写操作。可以使用以下语句来获取共享锁：
```
LOCK TABLES table_name READ;
```

2. 排它锁（Exclusive Lock）：该锁定方式被称为写锁，它只允许一个事务对表进行写操作，其他事务无法读取或写入该表。可以使用以下语句来获取排它锁：
```
LOCK TABLES table_name WRITE;
```
释放锁定
```
UNLOCK TABLES;
```

当前被锁定的表

```
SHOW OPEN TABLES WHERE In_use > 0;
```

这条语句会显示当前所有被锁定的表和锁定方式。其中，In_use 表示该表当前被使用的连接数，如果该值大于0，表示该表被锁定了



### 零散记录

MySQL 的 `sql_mode` 是一个系统变量，用于控制 MySQL 数据库服务器的行为和执行结果。`sql_mode` 决定了 MySQL 是否执行严格模式、是否忽略非法日期和时间值、是否允许空值、是否区分大小写、是否允许自动转换数据类型等。

```
查看 sql_mode
SELECT @@sql_mode;

清空 sql_mode
SET sql_mode = '';

在 MySQL 5.7 版本及以上，如果没有显式设置 sql_mode，则默认值为：
ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
```


这个默认值包含了以下几个参数：

- `ONLY_FULL_GROUP_BY`：在使用 `GROUP BY` 时，要求所有的被选中的列都出现在 `GROUP BY` 子句中。
- `STRICT_TRANS_TABLES`：在插入、更新数据时，如果存在任何警告或错误，都会中止操作并回滚之前的操作。
- `NO_ZERO_IN_DATE`：禁止日期和时间值中出现 '0000-00-00' 的情况。
- `NO_ZERO_DATE`：禁止日期和时间值为 '0000-00-00'。
- `ERROR_FOR_DIVISION_BY_ZERO`：当除数为零时，抛出错误。
- `NO_ENGINE_SUBSTITUTION`：如果使用的存储引擎不可用，则不会使用其他存储引擎代替。


大小写敏感

```
`demo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '示例'
```
demo 列的 CHARACTER SET 和 COLLATE 分别指定为 utf8 和 utf8_bin，这意味着该列使用 utf8 字符集，排序规则为二进制排序（binary collation），并且是大小写敏感的。

