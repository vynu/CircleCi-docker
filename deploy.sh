#!/bin/bash
docker build -t vynu/sample-node-ci-test .
docker push willrstern/sample-node-ci-test

ssh vynu@aws.fedora << EOF
docker pull vynu/sample-node-ci-test:latest
docker stop web || true
docker rm web || true
docker rmi vynu/sample-node-ci-test:current || true
docker tag vynu/sample-node-ci-test:latest vynu/sample-node-ci-test:current
docker run -d --net app --restart always --name web -p 3000:3000 vynu/sample-node-ci-test:current
EOF
