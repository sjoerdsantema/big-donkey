#!/bin/bash
echo syncing s3, perform cfn update and push to git repo
aws s3 sync . s3://big-donkey --exclude '*' --include '*.yaml' &&
aws cloudformation update-stack --stack-name 'Big-Donkey' --template-url 'https://s3.us-east-2.amazonaws.com/big-donkey/parent-stack.yaml' --capabilities CAPABILITY_IAM
git add *
git commit * -m "scripted commit"
git push origin master
