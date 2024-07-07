FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/library/nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf
COPY html/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
