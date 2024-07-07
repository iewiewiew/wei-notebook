
网页注册：https://www.npmjs.com/

查看当前源
npm config get registry

如果不是官方源，切回官方源再注册
npm config set registry https://registry.npmjs.org/

登录
npm login

登录成功查看当前账号
npm whoami

发布包，包名以 `@用户名/包名`，默认是**私有包**，免费账号不能直接发布私有包，需要加参数发布成公开包
npm publish
npm publish --access public

切回国内镜像
npm config set registry https://registry.npmmirror.com
