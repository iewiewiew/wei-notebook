# 配置 http 协议所使用的访问地址,不加端口号默认为80
external_url 'http://127.0.0.1'
# 配置 ssh 协议所使用的访问地址和端口
gitlab_rails['gitlab_ssh_host'] = '127.0.0.1'
#配置超时设置
gitlab_rails['webhook_timeout'] = 90
gitlab_rails['git_timeout']=90