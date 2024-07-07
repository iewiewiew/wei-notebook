[TOC]

<h1 align="center">Redis</h1>

> By：weimenghua  
> Date：2022.08.10  
> Description：Redis 非关系型数据库

**参考资料**  
[从0到1构建一个稳定、高性能Redis集群](https://mp.weixin.qq.com/s/5BwWCekb_wIu6LrCdmoGCQ)



## 1. Redis 简介

### 1.1 Redis 简介

Redis 是完全开源免费的，遵守 BSD 协议，是一个高性能的 key-value 数据库。
Redis 与其他 key - value 缓存产品有以下三个特点：
Redis 支持数据的持久化，可以将内存中的数据保持在磁盘中，重启的时候可以再次加载进行使用。
Redis 不仅仅支持简单的 key-value 类型的数据，同时还提供 list，set，zset，hash 等数据结构的存储。
Redis 支持数据的备份，即 master-slave 模式的数据备份。

### 1.2 Redis 优势

性能极高 – Redis 能读的速度是110000次/s,写的速度是81000次/s 。
丰富的数据类型 – Redis 支持二进制案例的 Strings, Lists, Hashes, Sets 及 Ordered Sets 数据类型操作。
原子 – Redis 的所有操作都是原子性的，同时 Redis 还支持对几个操作全并后的原子性执行。
丰富的特性 – Redis 还支持 publish/subscribe, 通知, key 过期等等特性。

**Redis 与其他 key-value 存储有什么不同**
Redis 有着更为复杂的数据结构并且提供对他们的原子性操作，这是一个不同于其他数据库的进化路径。Redis 的数据类型都是基于基本数据结构的同时对程序员透明，无需进行额外的抽象。
Redis 运行在内存中但是可以持久化到磁盘，所以在对不同数据集进行高速读写时需要权衡内存，应为数据量不能大于硬件内存。在内存数据库方面的另一个优点是， 相比在磁盘上相同的复杂的数据结构，在内存中操作起来非常简单，这样 Redis 可以做很多内部复杂性很强的事情。 同时，在磁盘格式方面他们是紧凑的以追加的方式产生的，因为他们并不需要进行随机访问。

Redis 默认提供了16个数据库. 每个数据库都有一个 id, 从 0 开始, [0,15]。 不同的数据库中数据隔离保存。我们可以通过修改 redis 的配置文件进行修改数据库的数量。
修改 redis.windows.conf 的 databases 16配置可修改 redis 数据库。
`使用 select <ID> 可以切换数据库。`
select 1



## 2. Redis 数据类型

Redis 支持五种数据类型：string（字符串），hash（哈希），list（列表），set（集合），zset(有序集合)。

### 2.1 String（字符串）

string 是 Redis 最基本的类型，一个 key 对应一个 value。string 类型的值最大能存储 512MB。 
```
设置指定 key 的值  
set key1 redis

获取指定 key 的值  
get key1

删除指定 key  
del key1
```

### 2.2 Hash（哈希）

Redis hash 是一个 string 类型的 field（字段） 和 value（值） 的映射表，hash 特别适合用于存储对象。 Redis 中每个 hash 可以存储 232的平方 - 1 键值对（40多亿）。 
```
同时将多个 field-value (域-值)对设置到哈希表 key 中  
hmset key2 name "guagua" age 18 sex "男"

获取在哈希表中指定 key 的所有字段和值  
hgetall key2

获取存储在哈希表中指定字段的值  
hget key2 name

获取所有哈希表中的字段  
hkeys key2

获取哈希中所有值的列表
havls <key>

获取哈希中字段的数量
hlen <key>

删除一个或多个哈希表字段  
hdel key2 name
```

### 2.3 List（列表）

Redis 列表是简单的字符串列表，按照插入顺序排序。你可以添加一个元素到列表的头部（左边）或者尾部（右边）。 一个列表最多可以包含 232的平方 - 1 个元素 (4294967295, 每个列表超过40亿个元素)。  
```
将一个或多个值插入到列表头部  
lpush key3 my  
lpush key3 name  
lpush key3 is guagua  

获取列表指定范围内的元素  
lrange key3 0 10
```

### 2.4 Set（集合）

Redis 的 Set 是 string 类型的无序集合。集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是 O(1)。  
```
add key4 my  
add key4 name  
add key4 is

获取集合中的所有成员
smembers key4  

检查指定成员是否存在于集合中
SISMEMBER <key> <member>

获取集合中的成员数量
SCARD <key>

向集合中添加一个或多个成员
SADD <key> <member1> [member2 ...]
```

### 2.5 zset（sorted set：有序集合）

Redis zset 和 set 一样也是 string 类型元素的集合，且不允许重复的成员。不同的是每个元素都会关联一个 double 类型的分数。redis 正是通过分数来为集合中的成员进行从小到大的排序。 zset 的成员是唯一的，但分数(score)却可以重复。  
```
zadd key5 1 my  
zadd key5 2 name  
zadd key5 2 is
zrange key5 0 10  
```



## 3. Redis 持久化

### 3.1 Redis 为什么需要持久化

由于 Redis 的数据都存放在内存中，如果没有配置持久化，Redis 重启后数据就全丢失了，于是需要开启 Redis 的持久化功能，将数据保存到磁盘上，当 Redis 重启后，可以从磁盘中恢复数据。

### 3.2 Redis 提供两种方式进行持久化

**3.2.1 RDB（Redis DataBase）持久化**
原理是将 Reids 在内存中的数据库记录定时 dump 到磁盘上的 RDB 持久化。  
RDB 方式生成 dump.rdb 文件。dump.rdb 是由 Redis 服务器自动生成的。默认情况下 每隔一段时间 Redis 服务器程序会自动对数据库做一次遍历，把内存快照写在一个叫做“dump.rdb”的文件里，这个持久化机制叫做 SNAPSHOT。有了 SNAPSHOT 后，如果服务器宕机，重新启动 Redis 服务器程序时 Redis 会自动加载 dump.rdb，将数据库状态恢复到上一次做 SNAPSHOT 时的状态。至于多久做一次 SNAPSHOT，SNAPSHOT 文件的路径和文件名，你可以在 Redis 的 conf 文件里指定。

**3.2.2 AOF（Append Only File）持久化**
原理是将 Reids 的操作日志以追加的方式写入文件。
以日志的形式来记录每个写操作，将 Redis 执行过的所有写指令记录下来(读操作不记录)，只许追加文件但不可以改写文件，redis 启动之初会读取该文件重新构建数据，换言之，Redis 重启的话就根据日志文件的内容将写指令从前到后执行一次以完成数据的恢复工作

### 3.3 RDB 和 AOF 二者的区别

**3.3.1 RDB 持久化**
RDB 持久化是指在指定的时间间隔内将内存中的数据集快照写入磁盘，实际操作过程是 fork 一个子进程，先将数据集写入临时文件，写入成功后，再替换之前的文件，用二进制压缩存储。

- 优势
适合大规模的数据恢复；  
对数据完整性和一致性要求不高。
- 劣势
在一定间隔时间做一次备份，所以如果 redis 意外 down 掉的话，就会丢失最后一次快照后的所有修改；
fork 的时候，内存中的数据被克隆了一份，大致2倍的膨胀性需要考虑。

**3.3.2 AOF 持久化**
AOF 持久化以日志的形式记录服务器所处理的每一个写、删除操作，查询操作不会记录，以文本的方式记录，可以打开文件看到详细的操作记录。

- 优势
appendfsync always   同步持久化 每次发生数据变更会被立即记录到磁盘  性能较差但数据完整性比较好；  
appendfsync everysec    异步操作，每秒记录，如果一秒内宕机，有数据丢失；  
appendfsync no   从不同步。
- 劣势
相同数据集的数据而言 aof 文件要远大于 rdb 文件，恢复速度慢于 rdb；  
aof 运行效率要慢于 rdb,每秒同步策略效率较好，不同步效率和 rdb 相同。



## 4. 其它

### 4.1 Redis  Hotkey BigKey

**参考资料**
[深度干货｜一文详解 Redis 中 BigKey、HotKey 的发现与处理](https://developer.aliyun.com/article/788845)

**简介**

在 Redis 的使用过程中，我们经常会遇到 BigKey（下文将其称为“大 key”）及 HotKey（下文将其称为“热 key”）。大 Key 与热 Key 如果未能及时发现并进行处理，很可能会使服务性能下降、用户体验变差，甚至引发大面积故障。

**大 key 定义**

- 一个 STRING 类型的 Key，它的值为5MB（数据过大）
- 一个 LIST 类型的 Key，它的列表数量为20000个（列表数量过多）
- 一个 ZSET 类型的 Key，它的成员数量为10000个（成员数量过多）
- 一个 HASH 格式的 Key，它的成员数量虽然只有1000个但这些成员的 value 总大小为100MB（成员体积过大）

**热 key 定义**

- 某 Redis 实例的每秒总访问量为10000，而其中一个 Key 的每秒访问量达到了7000（访问次数显著高于其它 Key）
- 对一个拥有上千个成员且总大小为1MB 的 HASH Key 每秒发送大量的 HGETALL（带宽占用显著高于其它 Key）
- 对一个拥有数万个成员的 ZSET Key 每秒发送大量的 ZRANGE（CPU 时间占用显著高于其它 Key）

**找到 大 key 和 热 key 的 方式**

- 通过 Redis 内置命令对目标 Key 进行分析
- 通过 Redis 官方客户端 redis-cli 的 bigkeys 参数发现大 Key
- 通过 Redis 官方客户端 redis-cli 的 hotkeys 参数发现热 Key
- 使用 monitor 命令在紧急情况时找出热 Key

### 4.2 Redis 连接数

```
# 启动 Redis 客户端
redis-server

# 启动 Redis 客户端
redis-cli

# 查看信息
info clients

# 查看最大链接数
config get maxclients
 
# 修改最大链接数
# 方式一
CONFIG set maxclients 10

# 方式二
# 在 redis.conf 修改

# 显示所有客户端连接
client list

# redis-benchmark 是官方自带的 Redis 性能测试工具，用来测试 Redis 在当前环境下的读写性能。
# 模拟打满连接数
命令：redis-benchmark -h <redis-host> -p <redis-port> -c <max-connections>
举例：redis-benchmark -h 127.0.0.1 -p 6379 -c 100    # 模拟100连接

# 释放 Redis 连接
# 方式一
CLIENT KILL TYPE normal

# 方式二 未实践成功
命令：CLIENT KILL ADDR <ip-address>:<port>
举例：CLIENT KILL ADDR 127.0.0.1:6379
```

### 4.3 查看 Redis 主从

```
kubectl -n <namespace> exec -it pod/redis-master-0 -- redis-cli  info Replication | grep role
```

### 4.4 查看 Redis 使用情况
在 Redis server 上测试实例的响应延迟情况
`redis-cli -h 127.0.0.1 -p 6379 --intrinsic-latency 60`

查看一段时间内 Redis 的最小、最大、平均访问延迟
```
redis-cli -h 127.0.0.1 -p 6379 --latency-history -i 1
redis-cli -h 127.0.0.1 -p 6379 --bigkeys -i 0.01
```

吞吐量  
`info stats`

```
从Rdis上一次启动以来总计处理的命令数
total_commands_processed:2255

当前Redis实例的OPS，redis内部较实时的每秒执行的命令数
instantaneous_ops_per_sec:12

网络总入量
total_net_input_bytes:34312

网络总出量
total_net_output_bytes:78215

每秒输入量，单位是kb/s
instantaneous_input_kbps:1.20

每秒输出量，单位是kb/s
instantaneous_output_kbps:2.62
```

其它

```
info Replication

info cpu

info memory
used_memory_rss_human：表示目前的内存实际占用——表示当前的内存情况。
used_memory_peak_human：表示内存峰值占用——表示曾经的内存情况（主要是用来抓不到现场的时候查问题用的）。

info clients

查询所有 key
keys * 

模糊查询 key
keys *tmp*

查看 key 类型
type <key_name>
```

[Redis 连接工具 Tiny RDM](https://github.com/tiny-craft/tiny-rdm/releases)
```
sudo xattr -d com.apple.quarantine /Applications/Tiny\ RDM.app
```