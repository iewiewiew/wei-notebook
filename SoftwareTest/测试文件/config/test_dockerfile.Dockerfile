# 测试Dockerfile文件
# 这是一个用于知识库测试的Dockerfile示例文件

FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]

