#!/bin/bash
docker push vynu/sample-node-ci-test

ssh vynu@54.186.127.230 << EOF
docker pull vynu/sample-node-ci-test:latest
docker stop web || true
docker rm web || true
docker rmi vynu/sample-node-ci-test:current || true
docker tag vynu/sample-node-ci-test:latest vynu/sample-node-ci-test:current
docker run -d --net app --restart always --name web -p 3000:3000 vynu/sample-node-ci-test:current
EOF
