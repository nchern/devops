FROM alpine:3.20

RUN apk add openssh rsync

ADD add_users.generated.sh    /root/
RUN /root/add_users.generated.sh

# make remote scp to work properly
RUN mkdir -p /usr/lib/openssh
RUN ln -s /usr/lib/ssh/sftp-server /usr/lib/openssh/sftp-server
