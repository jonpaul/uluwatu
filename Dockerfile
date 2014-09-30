FROM nginx
MAINTAINER SequenceIQ

ADD nginx.conf /etc/nginx/
ADD . /usr/local/nginx/html
ADD start.sh /

CMD /start.sh
