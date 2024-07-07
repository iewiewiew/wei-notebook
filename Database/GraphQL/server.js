const express = require('express');
const { graphqlHTTP } = require('express-graphql');
const { buildSchema } = require('graphql');

// 定义一个简单的 GraphQL schema
const schema = buildSchema(`
  type Query {
    hello: String
    user(id: Int!): User
  }

  type User {
    id: Int
    name: String
    age: Int
  }
`);

// 模拟用户数据
const users = [
  { id: 1, name: 'Alice', age: 28 },
  { id: 2, name: 'Bob', age: 34 },
];

// 定义 resolver
const root = {
  hello: () => 'Hello, world!',
  user: ({ id }) => users.find(user => user.id === id),
};

// 创建 Express 应用
const app = express();

// 设置 GraphQL HTTP 路由
app.use('/graphql', graphqlHTTP({
  schema: schema,
  rootValue: root,
  graphiql: true, // 启用 GraphiQL 界面
}));

// 启动服务器
app.listen(4000, () => {
  console.log('Server is running on http://localhost:4000/graphql');
});