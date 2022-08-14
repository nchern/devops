FROM alpine:3.16

RUN apk add openssh

ADD add_users.sh    /root/
ADD users.conf      /root/

Workdir /root
RUN     ./add_users.sh
