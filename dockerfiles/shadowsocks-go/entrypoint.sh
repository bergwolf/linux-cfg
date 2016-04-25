#!/bin/bash
set -e

SS_PASSWORD=${SS_PASSWORD-$(uuidgen)}

cat > /ss.config << EOF
{
	"server_port":8888,
	"password":"$SS_PASSWORD",
	"timeout":600,
	"method":"aes-256-cfb"
}
EOF

export GOROOT=/go
export GOPATH=/go/workplace
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

shadowsocks-server -c /ss.config
