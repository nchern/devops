FROM alpine:3.16

RUN apk add openssh

ADD add_users.generated.sh    /root/

RUN /root/add_users.generated.sh
