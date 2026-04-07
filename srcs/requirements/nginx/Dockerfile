FROM alpine:3.22
ENV TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN apk add curl
RUN apk add nginx
EXPOSE 80
# RUN mkdir -p /var/run/nginx
# RUN mkdir -p /etc/nginx/
RUN rm -f /etc/nginx/nginx.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY site/ /etc/site
RUN mkdir -p /var/www/html
COPY site/index.html /var/www/html
CMD [ "nginx", "-g", "daemon off;" ]
