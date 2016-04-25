# shadowsocks-go
#

FROM ubuntu:latest
MAINTAINER Tao Peng <bergwolf@gmail.com>

#RUN apt-get update && \
RUN apt-get install -y wget tar sed git make uuid-runtime

# go and shadowsocks-go
RUN wget https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz -O /tmp/go.tgz
RUN tar xzf /tmp/go.tgz -C /
RUN rm -f /tmp/go.tgz

ENV GOROOT=/go
ENV GOPATH=/go/workplace
RUN mkdir -p ${GOPATH}
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin
RUN go get github.com/shadowsocks/shadowsocks-go/cmd/shadowsocks-server

# Sadly there is no multiline cat in Dockerfile yet
ADD entrypoint.sh /entrypoint.sh

# Configure container to run as an executable
ENTRYPOINT ["/entrypoint.sh"]
