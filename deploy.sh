#!/bin/bash
docker push vynu/sample-node-ci-multi-env

ssh vynu@54.186.127.230 << EOF
docker pull vynu/sample-node-ci-multi-env:latest
docker stop web || true
docker rm web || true
docker rmi vynu/sample-node-ci-multi-env:current || true
docker tag vynu/sample-node-ci-multi-env:latest vynu/sample-node-ci-multi-env:current
docker run -d --net app --restart always --name web -p 3000:3000 vynu/sample-node-ci-multi-env:current
EOF
