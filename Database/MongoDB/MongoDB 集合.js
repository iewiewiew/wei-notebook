
-- 查看数据库
show dbs;

-- 进入某个数据库
use local;

-- 创建数据库, 如不存在则创建, 往数据库里面插入表才能查到数据库
use dbname;

-- 删除数据库
use dbname2;
db.dropDatabase();


-------------------------------------------------------------


-- 查看集合
show collections;

-- 创建集合
db.table_demo.insertOne({user_id: "abc123",age: 20,status: "A"});
db.table_demo2.insertOne({user_id: "abc1234",age: 20,status: "A"});
db.createCollection("table_demo3")

-- 删除集合
db.table_demo3.drop()


-------------------------------------


-- 插入数据
db.table_demo.create({'user_id':'zhangsan','age':18,'status':'A'});

-- 更新数据
db.table_demo.upadateMany({},{ $set:{ status:'D' }}); -- 更改全部 status: "D"
db.table_demo.upadateMany({ status: "C" },{ $set:{ status:'D' }}); -- 将 status: "C"的年龄更改为 20岁

-- 查询数据
db.getCollection('table_demo').find({});
db.getCollection('table_demo').find({"_id":1});

-- 查询所有
db.table_demo.find();
-- 返回指定字段
db.table_demo.find({},{ user_id: 1, status: 1 });
-- 不显示 id
db.table_demo.find({},{ _id: 0, user_id: 1, status: 1 });

-- 查询 status:"A"的所有
db.table_demo.find({ status: "A" });
-- 并返回指定的字段
db.table_demo.find({ status: "A" },{ _id: 0, user_id: 1, status: 1 });
-- 查询 status!= "A"的所有
db.table_demo.find({ status: { $ne: "A" } });

-- status="A" and age=50
db.table_demo.find({ status: "A" ,age: 55});
-- status="A" or age=50
db.table_demo.find({ $or:[{ status: "A" ,age: 55}] });

-- age>25
db.table_demo.find({ age: { $gt: 25 } });
-- age<25
db.table_demo.find({ age: { $lt: 25 } });
-- age>25 and age<=50
db.table_demo.find({ age: { $gt: 25, $lte: 50 } });

-- 模糊查询
db.table_demo.find({ user_id: /bc/ });
-- 模糊查询
db.table_demo.find({ user_id: { $regex: /bc/ } });
-- 模糊查询
db.table_demo.find({ user_id: /^bc/ });
-- 模糊查询
db.table_demo.find({ user_id: { $regex: /^bc/ } });


-- 1升序
db.table_demo.find( { status: "A" } ).sort( { user_id: 1 } );
-- -1降序
db.table_demo.find( { status: "A" } ).sort( { user_id: -1 } );


-- 统计
db.table_demo.count()
db.table_demo.find().count()

db.table_demo.count( { user_id: { $exists: true } } )-- 指定字段统计总数
db.table_demo.find( { user_id: { $exists: true } } ).count()


-- 去重
db.table_demo.aggregate( [ { $group : { _id : "$status" } } ] )
db.table_demo.distinct( "status" )


-- 获取指定条数
db.table_demo.findOne(); -- findOne 每次只能获取一条数据 
db.table_demo.find().limit(1); -- limit 可获取指定条数
db.table_demo.find().limit(5).skip(10); -- 从索引为5获取10条数据