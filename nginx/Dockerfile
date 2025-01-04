FROM nginx:1.26.2-alpine

COPY ./myconfig.conf /etc/nginx/conf.d/myconfig.conf

# 리눅스의 경우, 기본적으로 생성된 설정 파일이 있기 때문에 삭제해줘야 함 
RUN rm /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]