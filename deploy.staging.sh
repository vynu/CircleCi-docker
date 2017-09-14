#!/bin/bash
docker push vynu/sample-node-multi-env:staging

ssh vynu@138.197.212.54 << EOF
docker pull vynu/sample-node-ci-multi-env:staging
docker stop web || true
docker rm web || true
docker rmi vynu/sample-node-ci-multi-env:current || true
docker tag vynu/sample-node-ci-multi-env:staging vynu/sample-node-ci-multi-env:current
docker run -d --net app --restart always --name web -p 3000:3000 vynu/sample-node-ci-multi-env:current
EOF
