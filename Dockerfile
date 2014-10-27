FROM nginx
MAINTAINER SequenceIQ

ADD . /usr/share/nginx/html
ADD start.sh /

CMD /start.sh
